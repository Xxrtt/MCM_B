import numpy as np

# data = np.array([3,2,1,4,3])
#
#
# min_value = np.min(data)
# max_value = np.max(data)
# normalized_data = (data - min_value) / (max_value - min_value)
# normalized_data *= 0.378574
# print("Min-Max 归一化结果:")
# print(normalized_data)

cost=np.array([0.00307784,0.00230838,0,0.378574,0.00769459])
life=np.array([0.14196525,0.378574,0.14196525,0.378574,0])
diff=np.array([0.25238267,0.12619133,0,0.378574,0.25238267])
res=0.278223*cost+0.333913*diff-0.387864*life
print(res)