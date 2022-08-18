## https://datalore.jetbrains.com/view/notebook/yEaO6KokmFXUlEmaW5OeDL

# import data
##import matplotlib.pyplot as plt (install when module 'pandas' has no attribute 'core')
import pandas as pd
import numpy as np
df = pd.read_csv("sample-store.csv")

# preview top 5 rows
df.head()

# shape of dataframe
df.shape

# see data frame information using .info()
df.info()

# example of pd.to_datetime() function
pd.to_datetime(df['Order Date'].head(), format='%m/%d/%Y')

# convert order date and ship date to datetime in the original dataframe
df["Order Date"] = pd.to_datetime(df["Order Date"], format="%m/%d/%Y")
df["Ship Date"] = pd.to_datetime(df["Ship Date"], format="%m/%d/%Y")
df.info()

# count nan in postal code column
df['Postal Code'].isna().sum()

# filter rows with missing values
df[df['Postal Code'].isna()]

# Which category is the most delivered and by which ship mode?
result = df[['Category','Ship Mode']].value_counts().reset_index()

# Which segment has the most sales?
df.groupby('Segment')['Sales'].sum()

# How many columns, rows in this dataset
df.shape

# Is there any missing values?, if there is, which colunm? how many nan values?
df.isna().sum().reset_index()

# Your friend ask for `California` data, filter it and export csv for him
California_df = df[df['State'] == 'California']
California_df.to_csv('California_data.csv')

# Your friend ask for all order data in `California` and `Texas` in 2017 (look at Order Date), send him csv file
df_Cali_and_texas = df.query(' State == "California" | State == "Texas" ') 
df_Cali_and_texas_2017 = df_Cali_and_texas[df_Cali_and_texas['Order Date'].dt.strftime('%Y') == '2017']
df_Cali_and_texas_2017.to_csv('df_Cali_and_texas_2017.csv')

# How much total sales, average sales, and standard deviation of sales your company make in 2017
df_sales_2017 = df[df['Order Date'].dt.strftime('%Y') == '2017']
df_sales_2017['Sales'].agg(['sum','mean','std'])

# Which Segment has the highest profit in 2018
df_sales_2018 = df[df['Order Date'].dt.strftime('%Y') == '2018']
df_sales_2018.groupby('Segment')['Sales'].sum().reset_index()

# Which top 5 States have the least total sales between 15 April 2019 - 31 December 2019
df_filter_date = df[(df['Order Date'] >= "2019-04-15") & (df['Order Date'] <= "2019-12-31")]
df_filter_date.groupby('State')['Sales'].sum().sort_values(ascending=True).head(5).reset_index()

# What is the proportion of total sales (%) in West + Central in 2019 e.g. 25% 
df_sales_2019 = df[df['Order Date'].dt.strftime('%Y') == '2019']
total_2019= df_sales_2019['Sales'].sum()
total_west_cen_2019 = df_sales_2019.query('Region == "West" | Region == "Central"')['Sales'].sum()
proportion = (total_west_cen_2019/total_2019)*100
print(f"The proportion of total sales in West&Central 2019 = {proportion} %")

# Find top 10 popular products in terms of number of orders vs. total sales during 2019-2020
df_2019_2020 = df[(df['Order Date'] >= '2019-01-01')  & (df['Order Date'] <= "2020-12-31")]
top_10_product_n_order = df['Product Name'].value_counts().sort_values(ascending=False).head(10).reset_index()
top_10_product_sales = df_2019_2020.groupby('Product Name')['Sales'].sum().sort_values(ascending=False).head(10).reset_index()

# Compare Segment with plot
plot_segment = df['Segment'].value_counts().plot(kind='bar',color=['salmon','orange', 'gold'])

# Compare total sales from region 
plot_region_Profit = df.groupby('Region')['Sales'].sum().sort_values(ascending=True).plot(kind='barh',color=['yellow','orange', 'pink', 'red'])

#profit 2020
df_2020 = df[df['Order Date'].dt.strftime('%Y') == '2020']
plot_profit_2020 = df_2020.plot.line(x='Order Date', y='Profit', color='orange')

# Find Lost profit in Status Profit 2017 - 2020
df_2017_to_2020 = df[(df['Order Date'].dt.strftime('%Y') >= '2017') | (df['Order Date'].dt.strftime('%Y') == '2020')]
df_2017_to_2020['Status Profit'] = np.where(df_2017_to_2020['Profit'] > 0 ,'Profit','Lost')
lost_profit_2017_to_2020 = df_2017_to_2020[df_2017_to_2020['Status Profit'] =='Lost']
lost_profit_2017_to_2020[ ['Order ID','Order Date','Category','Discount', 'Profit' ,'Status Profit'] ]


