import pandas as pd
import numpy as np

# 读取数据
data = pd.DataFrame({
    # '搜索设备': ['水下摄像头', '侧扫声纳', '水上无人机', 'GPS定位仪', 'AUV', 'ROV', '激光测距仪', '卫星通讯设备'],
    # '成本': [460, 4800, 3000, 980, 431000, 819000, 7800, 5100],
    # '使用寿命': [4, 7.5, 3.5, 7.5, 10, 7.5, 7.5, 10],
    # '操作难度': [2, 3, 3, 1, 4, 3.5, 2.5, 2]
    '搜索设备': ['医疗急救箱', '救生衣', '救生圈', 'AED', '橡皮艇'],
    '成本': [],
    '使用寿命': [7.5,10,7.5,10,6],
    '操作难度': [3,2,1,4,3]
})

# 将成本和操作难度取倒数
data['成本'] = 1 / data['成本']
data['操作难度'] = 1 / data['操作难度']

# 对每个指标进行标准化
normalized_data = (data.iloc[:, 1:] - data.iloc[:, 1:].min()) / (data.iloc[:, 1:].max() - data.iloc[:, 1:].min())

# 计算每个指标的信息熵
entropy = -normalized_data * np.log2(normalized_data)
entropy = entropy.sum(axis=0)

# 计算每个指标的权重，权重与信息熵成反比
weights = 1 / entropy

# 对权重进行归一化
weights /= weights.sum()

print("指标权重:")
print(weights)