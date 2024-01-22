import pandas as pd

# Load the data from the Excel file
df = pd.read_excel("Train_weather.xlsx")

# Define temperature buckets
temperature_bins = [-15, 0, 10, 20, 30]
temperature_labels = ['Very Cold', 'Cold', 'Moderate', 'Warm']

# Create a new column 'Temperature Bucket' based on temperature bins
df['Temperature Bucket'] = pd.cut(df['tempm'], bins=temperature_bins, labels=temperature_labels, include_lowest=True)

# Group by temperature bucket and count the number of rows for each group
rides_by_temperature = df.groupby('Temperature Bucket').size()

# Display the result
print(rides_by_temperature)
