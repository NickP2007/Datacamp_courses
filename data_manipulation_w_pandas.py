# AGGREGATING DATAFRAMES
Instructions: Mean and Median
# Explore your new DataFrame first by printing the first few rows of the sales DataFrame.
# Print information about the columns in sales.
# Print the mean of the weekly_sales column.
# Print the median of the weekly_sales column.

# Print the head of the sales DataFrame
print(sales.head())

# Print the info about the sales DataFrame
print(sales.info())

# Print the mean of weekly_sales
print(sales['weekly_sales'].mean())

# Print the median of weekly_sales
print(sales['weekly_sales'].median())


Instructions: Summarizing Dates
# Print the maximum of the date column.
# Print the minimum of the date column.

# Print the maximum of the date column
print(sales['date'].max())

# Print the minimum of the date column
print(sales['date'].min())


Instructions: Effecient Summaries
# 1/3
# Use the custom iqr function defined for you along with .agg() to print the IQR of the temperature_c column of sales.

# A custom IQR function
def iqr(column):
    return column.quantile(0.75) - column.quantile(0.25)
    
# Print IQR of the temperature_c column
print(sales['temperature_c'].agg(iqr))

# 2/3
# Update the column selection to use the custom iqr function with .agg() to print the IQR of temperature_c, fuel_price_usd_per_l, and unemployment, in that order.
# Update to print IQR of temperature_c, fuel_price_usd_per_l, & unemployment
print(sales[["temperature_c", 'fuel_price_usd_per_l', 'unemployment']].agg(iqr))

# 3/3 
# Update the aggregation functions called by .agg(): include iqr and np.median in that order.
import numpy as np
# Update to print IQR and median of temperature_c, fuel_price_usd_per_l, & unemployment
print(sales[["temperature_c", "fuel_price_usd_per_l", "unemployment"]].agg([iqr, np.median]))


Instructions: Cumulative Statistics
# Sort the rows of sales_1_1 by the date column in ascending order.
# Get the cumulative sum of weekly_sales and add it as a new column of sales_1_1 called cum_weekly_sales.
# Get the cumulative maximum of weekly_sales, and add it as a column called cum_max_sales.
# Print the date, weekly_sales, cum_weekly_sales, and cum_max_sales columns.

# Sort sales_1_1 by date
sales_1_1 = sales_1_1.sort_values('date', ascending=True)

# Get the cumulative sum of weekly_sales, add as cum_weekly_sales col
sales_1_1['cum_weekly_sales'] = sales_1_1['weekly_sales'].cumsum()

# Get the cumulative max of weekly_sales, add as cum_max_sales col
sales_1_1['cum_max_sales'] = sales_1_1['weekly_sales'].cummax() 

# See the columns you calculated
print(sales_1_1[['date', 'weekly_sales', 'cum_weekly_sales', 'cum_max_sales']])


Instructions: Dropping Duplicates
# Remove rows of sales with duplicate pairs of store and type and save as store_types and print the head.
# Remove rows of sales with duplicate pairs of store and department and save as store_depts and print the head.
# Subset the rows that are holiday weeks using the is_holiday column, and drop the duplicate dates, saving as holiday_dates.
# Select the date column of holiday_dates, and print.

 # Drop duplicate store/type combinations
store_types = sales.drop_duplicates(subset=['store','type'])
print(store_types.head())

# Drop duplicate store/department combinations
store_depts = sales.drop_duplicates(subset=['store','department'])
print(store_depts.head())

# Subset the rows where is_holiday is True and drop duplicate dates
holiday_dates = sales[sales['is_holiday']].drop_duplicates('date')

# Print date col of holiday_dates
print(holiday_dates['date'])


Instructions: Counting Categorical Variables
# Count the number of stores of each store type in store_types.
# Count the proportion of stores of each store type in store_types.
# Count the number of different departments in store_depts, sorting the counts in descending order.
# Count the proportion of different departments in store_depts, sorting the proportions in descending order.

# Count the number of stores of each type
store_counts = store_types['type'].value_counts()
print(store_counts)


# Get the proportion of stores of each type
store_props = store_types['type'].value_counts(normalize=True)
print(store_props)


# Count the number of each department number and sort
dept_counts_sorted = store_depts['department'].value_counts(sort = True)
print(dept_counts_sorted)

# Get the proportion of departments of each number and sort
dept_props_sorted = store_depts['department'].value_counts(sort=True, normalize=True)
print(dept_props_sorted)


Instructions: What percent of sales occurred at each store type?
# Calculate the total weekly_sales over the whole dataset.
# Subset for type "A" stores, and calculate their total weekly sales.
# Do the same for type "B" and type "C" stores.
# Combine the A/B/C results into a list, and divide by sales_all to get the proportion of sales by type.

# Calc total weekly sales
sales_all = sales["weekly_sales"].sum()

# Subset for type A stores, calc total weekly sales
sales_A = sales[sales["type"] == "A"]["weekly_sales"].sum()

# Subset for type B stores, calc total weekly sales
sales_B = sales[sales["type"] == "B"]["weekly_sales"].sum()

# Subset for type C stores, calc total weekly sales
sales_C = sales[sales["type"] == "C"]["weekly_sales"].sum()

# Get proportion for each type
sales_propn_by_type = [sales_A, sales_B, sales_C] / (sales_A+sales_B+sales_C)
print(sales_propn_by_type)


Instrtuctions: Calculations with .groupby()
# 1/2
# Group sales by "type", take the sum of "weekly_sales", and store as sales_by_type.
# Calculate the proportion of sales at each store type by dividing by the sum of sales_by_type. Assign to sales_propn_by_type.

# Group by type; calc total weekly sales
sales_by_type = sales.groupby("type")["weekly_sales"].sum()

# Get proportion for each type
sales_propn_by_type = sales_by_type / sum(sales_by_type)
print(sales_propn_by_type)

# 2/2
# Group by type and is_holiday; calc total weekly sales
sales_by_type_is_holiday = sales.groupby("type","is_holiay")["weekly_sales"].sum()
print(sales_by_type_is_holiday)


Instructions: Multiple Grouped Summaries
# Import numpy with the alias np.
# Get the min, max, mean, and median of weekly_sales for each store type using .groupby() and .agg(). Store this as sales_stats. Make sure to use numpy functions!
# Get the min, max, mean, and median of unemployment and fuel_price_usd_per_l for each store type. Store this as unemp_fuel_stats.

# Import numpy with the alias np
import numpy as np

# For each store type, aggregate weekly_sales: get min, max, mean, and median
sales_stats = sales.groupby("type")["weekly_sales"].agg([np.min, np.max, np.mean, np.median])

# Print sales_stats
print(sales_stats)

# For each store type, aggregate unemployment and fuel_price_usd_per_l: get min, max, mean, and median
unemp_fuel_stats = sales.groupby("type")[["unemployment","fuel_price_usd_per_l"]].agg([np.min,np.max,np.mean,np.median])

# Print unemp_fuel_stats
print(unemp_fuel_stats)


Instructions: Pivoting on One Variable
# 1/3
# Get the mean weekly_sales by type using .pivot_table() and store as mean_sales_by_type.

# Pivot for mean weekly_sales for each store type
mean_sales_by_type = sales.pivot_table(values = "weekly_sales", index = "type")

# Print mean_sales_by_type
print(mean_sales_by_type)

# 2/3
# Get the mean and median (using NumPy functions) of weekly_sales by type using .pivot_table() and store as mean_med_sales_by_type.

# Import NumPy as np
import numpy as np

# Pivot for mean and median weekly_sales for each store type
mean_med_sales_by_type = sales.pivot_table(index = "type", values = "weekly_sales", aggfunc=[np.mean,np.median])

# Print mean_med_sales_by_type
print(mean_med_sales_by_type)

# 3/3
# Get the mean of weekly_sales by type and is_holiday using .pivot_table() and store as mean_sales_by_type_holiday.

# Pivot for mean weekly_sales by store type and holiday 
mean_sales_by_type_holiday = sales.pivot_table(index = 'type', columns = 'is_holiday', values = 'weekly_sales')

# Print mean_sales_by_type_holiday
print(mean_sales_by_type_holiday)


Instructions: Fill in Missing Values and Sum Values with Pivot Tables
# 1/2
# Print the mean weekly_sales by department and type, filling in any missing values with 0.

# Print mean weekly_sales by department and type; fill missing values with 0
print(sales.pivot_table(values = 'weekly_sales', index = 'type', columns = 'department', fill_value = 0))

# 2/2
# Print the mean weekly_sales by department and type, filling in any missing values with 0 and summing all rows and columns.
# Print the mean weekly_sales by department and type; fill missing values with 0s; sum all rows and cols
print(sales.pivot_table(values="weekly_sales", index="department", columns="type", fill_value = 0, margins = True))


Instructions: Setting and Removing Indexes
# Look at temperatures.
# Set the index of temperatures to "city", assigning to temperatures_ind.
# Look at temperatures_ind. How is it different from temperatures?
# Reset the index of temperatures_ind, keeping its contents.
# Reset the index of temperatures_ind, dropping its contents.

# Look at temperatures
print(temperatures)

# Set the index of temperatures to city
temperatures_ind = temperatures.set_index('city')

# Look at temperatures_ind
print(temperatures_ind)

# Reset the temperatures_ind index, keeping its contents
print(temperatures_ind.reset_index())

# Reset the temperatures_ind index, dropping its contents
print(temperatures_ind.reset_index(drop = True))

Instructions: Subsetting with .loc
# Create a list called cities that contains "Moscow" and "Saint Petersburg".
# Use [] subsetting to filter temperatures for rows where the city column takes a value in the cities list.
# Use .loc[] subsetting to filter temperatures_ind for rows where the city is in the cities list.

# Make a list of cities to subset on
cities = ["Moscow", "Saint Petersburg"]

# Subset temperatures using square brackets
print(temperatures[temperatures['city'].isin(cities)])

# Subset temperatures_ind using .loc[]
print(temperatures_ind.loc[cities])

Instructions: Setting Multi-Levl Indexes
# Set the index of temperatures to the "country" and "city" columns, and assign this to temperatures_ind.
# Specify two country/city pairs to keep: "Brazil"/"Rio De Janeiro" and "Pakistan"/"Lahore", assigning to rows_to_keep.
# Print and subset temperatures_ind for rows_to_keep using .loc[].

# Index temperatures by country & city
temperatures_ind = temperatures.set_index(['country','city'])

# List of tuples: Brazil, Rio De Janeiro & Pakistan, Lahore
rows_to_keep = [('Brazil','Rio De Janeiro'),('Pakistan','Lahore')]

# Subset for rows to keep
print(temperatures_ind.loc[rows_to_keep])


Instructions: Sorting by Index Values 
# Sort temperatures_ind by the index values.
# Sort temperatures_ind by the index values at the "city" level.
# Sort temperatures_ind by ascending country then descending city.

# Sort temperatures_ind by index values
print(temperatures_ind.sort_index())

# Sort temperatures_ind by index values at the city level
print(temperatures_ind.sort_index(level = 'city'))

# Sort temperatures_ind by country then descending city
print(temperatures_ind.sort_index(level = ['country', 'city'],ascending = [True, False]))


Instructions: Slicing Index Values
# Sort the index of temperatures_ind.
# Use slicing with .loc[] to get these subsets:
    # from Pakistan to Russia.
    # from Lahore to Moscow. (This will return nonsense.)
    # from Pakistan, Lahore to Russia, Moscow.

# Sort the index of temperatures_ind
temperatures_srt = temperatures_ind.sort_index()

# Subset rows from Pakistan to Russia
print(temperatures_srt.loc['Pakistan':'Russia'])

# Try to subset rows from Lahore to Moscow
print(temperatures_srt.loc['Lahore':'Moscow'])

# Subset rows from Pakistan, Lahore to Russia, Moscow
print(temperatures_srt.loc[('Pakistan','Lahore'):('Russia','Moscow')])


Instructions: Slicing in Both Directions
# Use .loc[] slicing to subset rows from India, Hyderabad to Iraq, Baghdad.
# Use .loc[] slicing to subset columns from date to avg_temp_c.
# Slice in both directions at once from Hyderabad to Baghdad, and date to avg_temp_c.

# Subset rows from India, Hyderabad to Iraq, Baghdad
print(temperatures_srt.loc[('India','Hyderabad'):('Iraq','Baghdad')])

# Subset columns from date to avg_temp_c
print(temperatures_srt.loc[:,'date':'avg_temp_c'])

# Subset in both directions at once
print(temperatures_srt.loc[('India','Hyderabad'):('Iraq','Baghdad'),'date':'avg_temp_c'])


Instructions: Slicing Time Series
# Use Boolean conditions, not .isin() or .loc[], and the full date "yyyy-mm-dd", to subset temperatures for rows in 2010 and 2011 and print the results.
# Set the index of temperatures to the date column and sort it.
# Use .loc[] to subset temperatures_ind for rows in 2010 and 2011.
# Use .loc[] to subset temperatures_ind for rows from Aug 2010 to Feb 2011.

# Use Boolean conditions to subset temperatures for rows in 2010 and 2011
temperatures_bool = temperatures[(temperatures['date'] >= '2010-01-01') & (temperatures['date'] <= '2011-12-31')]
print(temperatures_bool)

# Set date as the index and sort the index
temperatures_ind = temperatures.set_index('date').sort_index()

# Use .loc[] to subset temperatures_ind for rows in 2010 and 2011
print(temperatures_ind.loc['2010-01-01':'2011-12-31'])

# Use .loc[] to subset temperatures_ind for rows from Aug 2010 to Feb 2011
print(temperatures_ind.loc['2010-08-01':'2011-02-31'])


Instructions: Subsetting by Row/Column Number
# Use .iloc[] on temperatures to take subsets.
    # Get the 23rd row, 2nd column (index positions 22 and 1).
    # Get the first 5 rows (index positions 0 to 5).
    # Get all rows, columns 3 and 4 (index positions 2 to 4).
    # Get the first 5 rows, columns 3 and 4.

# Get 23rd row, 2nd column (index 22, 1)
print(temperatures.iloc[22,2])

# Use slicing to get the first 5 rows
print(temperatures.iloc[0:5])

# Use slicing to get columns 3 to 4
print(temperatures.iloc[:,2:4])

# Use slicing in both directions at once
print(temperatures.iloc[0:5,2:4])


Instructions: Pivot Temperature by City and Year
# Add a year column to temperatures, from the year component of the date column.
# Make a pivot table of the avg_temp_c column, with country and city as rows, and year as columns. Assign to temp_by_country_city_vs_year, and look at the result.

# Add a year column to temperatures
temperatures['year'] = temperatures['date'].dt.year

# Pivot avg_temp_c by country and city vs year
temp_by_country_city_vs_year = temperatures.pivot_table('avg_temp_c', index = ['country','city'], columns = 'year')

# See the result
print(temp_by_country_city_vs_year)


Instructions: Subsetting Pivot Tables
# Use .loc[] on temp_by_country_city_vs_year to take subsets.
    # From Egypt to India.
    # From Egypt, Cairo to India, Delhi.
    # From Egypt, Cairo to India, Delhi, and 2005 to 2010.

# Subset for Egypt to India
temp_by_country_city_vs_year.loc['Egypt':'India']

# Subset for Egypt, Cairo to India, Delhi
temp_by_country_city_vs_year.loc[('Egypt','Cairo'):('India','Delhi')]

# Subset for Egypt, Cairo to India, Delhi, and 2005 to 2010
temp_by_country_city_vs_year.loc[('Egypt','Cairo'):('India','Delhi'), '2005':'2010']


Instructions: Calculating on a Pivot Table
# Calculate the mean temperature for each year, assigning to mean_temp_by_year.
# Filter mean_temp_by_year for the year that had the highest mean temperature.
# Calculate the mean temperature for each city (across columns), assigning to mean_temp_by_city.
# Filter mean_temp_by_city for the city that had the lowest mean temperature.

# Get the worldwide mean temp by year
mean_temp_by_year = temp_by_country_city_vs_year.mean()

# Filter for the year that had the highest mean temp
print(mean_temp_by_year[mean_temp_by_year==mean_temp_by_year.max()])

# Get the mean temp by city
mean_temp_by_city = temp_by_country_city_vs_year.mean(axis='columns')

# Filter for the city that had the lowest mean temp
print(mean_temp_by_city[mean_temp_by_city==mean_temp_by_city.min()])
