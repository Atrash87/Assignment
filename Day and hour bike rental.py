import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load the data from the Excel file
df = pd.read_excel("Train_weather.xlsx")

# Convert 'start_time' to datetime format
df['start_time'] = pd.to_datetime(df['start_time'])

# Extract day of the week and hour from the 'start_time' column
df['Day of Week'] = df['start_time'].dt.day_name()
df['Hour'] = df['start_time'].dt.hour

# Create a new column 'Bike Rides' with constant values (1 for each row)
df['Bike Rides'] = 1

# Sort the days of the week in the correct order
days_order = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
df['Day of Week'] = pd.Categorical(df['Day of Week'], categories=days_order, ordered=True)

# Sort the DataFrame by the ordered 'Day of Week' column
df = df.sort_values(by='Day of Week')

# Create a heatmap
plt.figure(figsize=(12, 8))
heatmap_data = df.pivot_table(index='Day of Week', columns='Hour', values='Bike Rides', aggfunc='sum', fill_value=0)
sns.heatmap(heatmap_data, cmap='YlGnBu', annot=True, fmt="g", cbar_kws={'label': 'Number of Bike Rides'})
plt.title('Heatmap of Bike Rides by Day of Week and Hour')
plt.xlabel('Hour of the Day')
plt.ylabel('Day of the Week')
plt.show()


# Save the pivot table data to a CSV file
heatmap_data.to_csv('heatmap_data.csv')

# Display the pivot table
print(heatmap_data)