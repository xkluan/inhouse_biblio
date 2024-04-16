
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.decomposition import LatentDirichletAllocation
from collections import Counter

# Load the data
data = pd.read_csv('path/to/your/data.csv')

# Preprocessing the text data
data['combined_text'] = data[['Abstract', 'Title', 'Author Keywords']].apply(lambda x: ' '.join(x.dropna()), axis=1)

# Initialize CountVectorizer
vectorizer = CountVectorizer(stop_words='english', max_features=1000)

# Convert text data to numerical data
text_data = vectorizer.fit_transform(data['combined_text'])

# Define and fit LDA model
lda_model = LatentDirichletAllocation(n_components=8, random_state=0)
lda_topics = lda_model.fit_transform(text_data)

# Sort the documents by their most likely topic
doc_topic_counts = np.argmax(lda_topics, axis=1)
sorted_doc_indices = np.argsort(doc_topic_counts)
sorted_lda_topics = lda_topics[sorted_doc_indices]

# Create and save the heatmap
plt.figure(figsize=(12, 8))
sns.heatmap(sorted_lda_topics, cmap="YlGnBu", yticklabels=False)
plt.title('Sorted Document-Topic Distribution Heatmap')
plt.xlabel('Topics')
plt.ylabel('Sorted Documents')
plt.savefig('sorted_document_topic_heatmap.pdf')
