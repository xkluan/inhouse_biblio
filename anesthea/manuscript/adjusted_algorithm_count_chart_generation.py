
import matplotlib.pyplot as plt

# The adjusted counts of machine learning and deep learning algorithms
adjusted_counts = {
    'Deep Learning': 274,
    'Logistic Regression': 134,
    'Random Forest': 132,
    'Support Vector Machine': 90 + 40,  # SVM + Support Vector Machine
    'Convolutional Neural Network': 80 + 40,  # CNN + Convolutional Neural Network
    'GAN': 79,
    'Neural Networks': 75,
    'Gradient Boosting': 65,
    'Decision Tree': 35,
    'XGBoost': 33,
    'Reinforcement Learning': 23,
    'Linear Regression': 20,
    'LSTM': 19 + 0,  # LSTM + Long Short Term Memory
    'KNN': 10,
    'AdaBoost': 10,
    'Recurrent Neural Network': 9 + 7,  # RNN + Recurrent Neural Network
    'Autoencoder': 9,
    'K-Means': 8,
    'Transfer Learning': 8,
    'Naive Bayes': 5,
    'Dimensionality Reduction': 4,
}

# Sorting the adjusted counts
sorted_adjusted_counts = sorted(adjusted_counts.items(), key=lambda x: x[1], reverse=True)
adjusted_algorithms, adjusted_counts = zip(*sorted_adjusted_counts)

# Creating the adjusted bar chart
plt.figure(figsize=(10, 8))
plt.barh(adjusted_algorithms, adjusted_counts, color='skyblue')
plt.xlabel('Count')
plt.ylabel('Algorithm')
plt.title('Frequency of Machine Learning and Deep Learning Algorithms (Adjusted for Synonyms)')
plt.gca().invert_yaxis()  # To display the highest count at the top
plt.savefig('adjusted_ml_dl_algorithms_frequency.pdf')
