import pandas as pd
import numpy as np

# Read the CSV file
df = pd.read_csv("grid_map_experiment.csv")  #

# Group by number of nodes and compute statistics
summary = df.groupby('nodes').agg(
    mean_time=('time', 'mean'),
    std_time=('time', 'std')
).reset_index()

# Compute median ± std
summary['mean_plus_std'] = summary['mean_time'] + summary['std_time']
summary['mean_minus_std'] = summary['mean_time'] - summary['std_time']

# Save the processed data
summary.to_csv("grid_map_experiment_processed.csv", index=False)

