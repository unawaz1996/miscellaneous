import seaborn as sns
import matplotlib.pyplot as plt 
import pandas as pd 
import numpy as np 


sns.set()
flights = sns.load_dataset("flights")
flights

flights = flights.pivot("month", "year", "passengers")
g = sns.clustermap(flights)

from matplotlib.patches import Rectangle
ax = g.ax_heatmap
ax = ax.add_patch(Rectangle((3, 4), 1, 1, fill=False, edgecolor='blue', lw=3))
plt.show(a x)


##### Load the logFC file 
logFC_df = pd.read_csv("combined_logFC.csv", index_col=[0])

logFC_df
logFC_df = logFC_df.set_index([])
logFC_df.columns = ['genes']

g = sns.clustermap(logFC_df)
