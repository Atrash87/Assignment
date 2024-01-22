import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Read the data from the Excel file
df = pd.read_excel('temp_hum_weather_month.xlsx')

# Calculate the correlation matrix
correlation_matrix = df.corr()

# Extract the correlation values for 'rental_count'
rental_correlation = correlation_matrix[['rental_count']].drop(['rental_count', 'rental_month'])

# Plot the column heatmap for 'rental_count' with color map bar
plt.figure(figsize=(3, 5))
sns.heatmap(rental_correlation.sort_values(by='rental_count').T, linewidths=1, annot=True, cmap='Blues', cbar=True)
plt.title('Correlation with Rental Count')
plt.show()
