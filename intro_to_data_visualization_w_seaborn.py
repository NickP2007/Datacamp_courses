# MAKING A SCATTER PLOT WITH LISTS
# Import Matplotlib and Seaborn
import matplotlib.pyplot as plt
import seaborn as sns

# Change this scatter plot to have percent literate on the y-axis
sns.scatterplot(x=gdp, y=phones)

# Show plot
plt.show()

# Import Matplotlib and Seaborn
import matplotlib.pyplot as plt
import seaborn as sns

# Change this scatter plot to have percent literate on the y-axis
sns.scatterplot(x=gdp, y=percent_literate)

# Show plot
plt.show()

# MAKING A COUNT PLOT WITH A LIST
# Import Matplotlib and Seaborn
import matplotlib.pyplot as plt 
import seaborn as sns


# Create count plot with region on the y-axis
sns.countplot(y=region)

# Show plot
plt.show()

# TIDY vs. UNTIDY DATA
# Import pandas
import pandas as pd

# Create a DataFrame from csv file
df = pd.read_csv(csv_filepath)

# Print the head of df
print(df.head())

# MAKING A COUNT PLOT WITH A DATAFRAME
# Import Matplotlib, pandas, and Seaborn
import matplotlib.pyplot as plt 
import pandas  as pd 
import seaborn as sns

# Create a DataFrame from csv file
df = pd.read_csv(csv_filepath)

# Create a count plot with "Spiders" on the x-axis
sns.countplot(x='Spiders', data=df)

# Display the plot
plt.show()

# HUE AND SCATTER PLOTS
# Import Matplotlib and Seaborn
import matplotlib.pyplot as plt
import seaborn as sns

# Change the legend order in the scatter plot
sns.scatterplot(x="absences", y="G3", 
                data=student_data, 
                hue="location",
                hue_order=['Rural','Urban'])

# Show plot
plt.show()

# HUE AND COUNT PLOTS
# Import Matplotlib and Seaborn
import matplotlib.pyplot as plt
import seaborn as sns

# Create a dictionary mapping subgroup values to colors
palette_colors = {'Rural': "green", 'Urban': "blue"}

# Create a count plot of school with location subgroups
sns.countplot(x='school',data=student_data,hue='location',palette=palette_colors)



# Display plot
plt.show()

# CREATING SUBPLOTS WITH COL AND ROW
# Change this scatter plot to arrange the plots in rows instead of columns
sns.relplot(x="absences", y="G3", 
            data=student_data,
            kind="scatter", 
            row='study_time')

# Show plot
plt.show()

# CREATING TWO-FACTOR SUBPLOTS
# Adjust further to add subplots based on family support
sns.relplot(x="G1", y="G3", 
            data=student_data,
            kind="scatter", 
            col='schoolsup',
            col_order=["yes", "no"],
            row="famsup",
            row_order=['yes','no']
            )

# Show plot
plt.show()

# CHANGING THE SIZE OF SCATTER PLOT POINTS
# Import Matplotlib and Seaborn
import matplotlib.pyplot as plt
import seaborn as sns

# Create scatter plot of horsepower vs. mpg
sns.relplot(x="horsepower", y="mpg", 
            data=mpg, kind="scatter", 
            size="cylinders",hue='cylinders')

# Show plot
plt.show()

# CHANGING THE STYLE OF SCATTER PLOT POINTS
# Import Matplotlib and Seaborn
import matplotlib.pyplot as plt
import seaborn as sns

# Create a scatter plot of acceleration vs. mpg
sns.relplot(x='acceleration',y='mpg',data=mpg,kind='scatter',hue='origin',size='origin',style='origin')



# Show plot
plt.show()

# VISUALIZING STANDARD DEVIATION WITH LINE PLOTS
# Make the shaded area show the standard deviation
sns.relplot(x="model_year", y="mpg",
            data=mpg, kind="line",ci='sd')

# Show plot
plt.show()

# PLOTTING SUBGROUPS IN LINE PLOTS
# Import Matplotlib and Seaborn
import matplotlib.pyplot as plt
import seaborn as sns

# Add markers and make each line have the same style
sns.relplot(x="model_year", y="horsepower", 
            data=mpg, kind="line", 
            ci=None, style="origin", 
            hue="origin",dashes=False,markers=True)

# Show plot
plt.show()

