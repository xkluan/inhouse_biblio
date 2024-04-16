import pandas as pd
from collections import Counter

# 假设您已经加载了数据到dataframe 'data'中，并且它包含'Abstract', 'Title', 'Author Keywords'这三列

# 定义一个包含算法名称的列表
ml_dl_algorithms = [
    'Linear Regression', 'Logistic Regression', 'Decision Tree', 'SVM', 'Naive Bayes',
    'KNN', 'K-Means', 'Random Forest', 'Dimensionality Reduction', 'Gradient Boosting',
    'Neural Networks', 'Deep Learning', 'Convolutional Neural Network', 'CNN', 
    'Recurrent Neural Network', 'RNN', 'Long Short Term Memory', 'LSTM', 'GAN', 
    'Reinforcement Learning', 'Transfer Learning', 'Autoencoder', 'XGBoost', 'AdaBoost',
    'Support Vector Machine'
]

# 初始化一个计数器
algorithm_counts = Counter({algorithm: 0 for algorithm in ml_dl_algorithms})

# 定义一个函数来统计文本中算法的提及次数
def count_algorithms(text, algorithm_counts):
    for algorithm in algorithm_counts.keys():
        if algorithm.lower() in text.lower():
            algorithm_counts[algorithm] += 1
# 统计结束后合并同义词的计数
algorithm_counts['Support Vector Machine'] += algorithm_counts['SVM']
del algorithm_counts['SVM']  # 删除"SVM"条目，因为它已被合并

algorithm_counts['Convolutional Neural Network'] += algorithm_counts['CNN']
del algorithm_counts['CNN']  # 删除"CNN"条目，因为它已被合并

algorithm_counts['Recurrent Neural Network'] += algorithm_counts['RNN']
del algorithm_counts['RNN']  # 删除"RNN"条目，因为它已被合并

algorithm_counts['Long Short Term Memory'] += algorithm_counts['LSTM']
del algorithm_counts['LSTM']  # 删除"LSTM"条目，因为它已被合并

# 现在algorithm_counts包含了合并同义词后的统计结果
print(algorithm_counts)

# 遍历数据集的每一行，统计算法提及次数
for index, row in data.iterrows():
    text = f"{row['Abstract']} {row['Title']} {row['Author Keywords']}".lower()
    count_algorithms(text, algorithm_counts)

# 输出结果
print(algorithm_counts)

