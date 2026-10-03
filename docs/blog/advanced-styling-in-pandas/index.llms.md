# Advanced styling in pandas

How to make your dataframes look pretty!

visualization

Author

Joram Mutenge

Published

July 30, 2024

I am a sucker for visually appealing things, and I try as much as I can to embody that in my data analysis work. In this article, I’ll show you how you can style your pandas dataframes to make them look pretty and enhance their message.

![](image.png)

A highly styled dataframe

### Why care about styling?

Styling allows you to change the look of the data in your dataframe columns while maintaining the data types. This enables you to perform mathematical operations on columns that may otherwise contain strings-like symbols like % and \$.

The most common and straightforward example of styling is using currency symbols when working with monetary values. For instance, when you have 95.05, you likely won’t immediately understand it as a monetary amount. By contrast, when you see it as \$95.05, the first thing that will come to your mind is that this is a monetary amount.

Percentages are another example of numbers whose message is enhanced when styling is used. Interpreting 7 percent is easier when it’s written as 7% than when it’s written as 0.07.

Pandas styling enhances the message of the values in your dataframe, making it easier for your audience to understand the message of those values. More importantly, it doesn’t change the data types of those values allowing you to perform mathematical operations on them.

### The dataset

The dataset for this task will be the 2018 sales data for various companies in the United States.

``` python
import pandas as pd
from pathlib import Path

df = (pd.read_parquet(f"{Path('../../')}/datasets/sales_total_2018.parquet")
 .rename(columns=lambda col: col.replace(' ', '_'))
 )
df.sample(6)
```

|  | account_number | name | sku | quantity | unit_price | ext_price | date |
|----|----|----|----|----|----|----|----|
| 491 | 257198 | Cronin, Oberbrunner and Spencer | B1-38851 | 19 | 79.410004 | 1508.790039 | 2018-04-25 18:57:16 |
| 577 | 527099 | Sanford and Sons | B1-69924 | 24 | 42.930000 | 1030.319946 | 2018-05-15 20:23:35 |
| 962 | 383080 | Will LLC | B1-53102 | 6 | 42.340000 | 254.039993 | 2018-08-14 22:21:23 |
| 1434 | 218895 | Kulas Inc | B1-20000 | 12 | 44.900002 | 538.799988 | 2018-12-13 16:18:23 |
| 880 | 239344 | Stokes LLC | S1-82801 | 5 | 87.059998 | 435.299988 | 2018-07-25 08:37:59 |
| 565 | 218895 | Kulas Inc | S2-00301 | 24 | 36.299999 | 871.200012 | 2018-05-12 06:28:18 |

Let’s extract summary statistics like the mean (average) and sum of the price data for the six random companies in our dataset. I’ll usegroupbyand agg methods to achieve this.

``` python
(df
 .groupby('name')
 .ext_price
 .agg({'mean','sum'})
 .sample(6)
 )
```

|                                 | mean        | sum           |
|---------------------------------|-------------|---------------|
| name                            |             |               |
| Cronin, Oberbrunner and Spencer | 1339.321655 | 89734.546875  |
| Kiehn-Spinka                    | 1260.870605 | 99608.773438  |
| Kulas Inc                       | 1461.191040 | 137351.953125 |
| Halvorson, Crona and Champlin   | 1206.971680 | 70004.359375  |
| Kassulke, Ondricka and Metz     | 1350.797974 | 86451.070312  |
| Fritsch, Russel and Anderson    | 1385.366821 | 112214.710938 |

### Styling the dataframe

When you look at the data in the above dataframe, you notice that the summed values are significantly larger, and the averaged values have 6 decimal points. This makes it harder to understand the scale of the numbers, and the table isn’t aesthetically pleasing.

To solve these problems, we turn to `style` which converts the table from a pandas dataframe to a style object. The style object is not as rigid as a pandas dataframe, in that you can use `format` to change the look of its values.

I’ll use Python’s f-strings to convert the data into currency values and round them to 2 decimal places. If I wanted to round to a whole number (0 decimal places), I would’ve used this f-string `${0:,.0f}`.

``` python
(df
 .groupby('name')
 .ext_price
 .agg({'mean','sum'})
 .sample(6)
 .style
 .format('${0:,.2f}')
 )
```

|                              | mean       | sum          |
|------------------------------|------------|--------------|
| name                         |            |              |
| Barton LLC                   | \$1,334.62 | \$109,438.50 |
| White-Trantow                | \$1,579.56 | \$135,841.98 |
| Kiehn-Spinka                 | \$1,260.87 | \$99,608.77  |
| Keeling LLC                  | \$1,363.98 | \$100,934.30 |
| Kuhn-Gusikowski              | \$1,247.87 | \$91,094.28  |
| Fritsch, Russel and Anderson | \$1,385.37 | \$112,214.71 |

### More styling

Let’s take our styling up a notch and deal with dates. I’ll use `pd.Grouper` to get the total sales for each month. Then I’ll calculate how much each month is as a percentage of the total annual sales.

``` python
(df
 .groupby(pd.Grouper(key='date', freq='ME'))
 .ext_price
 .agg('sum')
 .to_frame()
 .assign(pct_total=lambda df_: df_.ext_price / df_.ext_price.sum())
 .rename(columns={'ext_price':'sum'})
 )
```

|            | sum           | pct_total |
|------------|---------------|-----------|
| date       |               |           |
| 2018-01-31 | 185361.656250 | 0.091818  |
| 2018-02-28 | 146211.625000 | 0.072426  |
| 2018-03-31 | 203921.375000 | 0.101012  |
| 2018-04-30 | 174574.109375 | 0.086475  |
| 2018-05-31 | 165418.546875 | 0.081940  |
| 2018-06-30 | 174089.328125 | 0.086235  |
| 2018-07-31 | 191662.109375 | 0.094939  |
| 2018-08-31 | 153778.593750 | 0.076174  |
| 2018-09-30 | 168443.171875 | 0.083438  |
| 2018-10-31 | 171495.312500 | 0.084950  |
| 2018-11-30 | 119961.218750 | 0.059423  |
| 2018-12-31 | 163867.265625 | 0.081171  |

I’m not interested in showing the date in its full format. Once again, I’ll use f-strings to display the date like “Jan-2018” instead of “2018-01-31”. I’ll also add the % symbol to the values in percentage total column. Now, let’s style the date to get the desired dataframe.

``` python
(df
 .groupby(pd.Grouper(key='date', freq='ME'))
 .ext_price
 .agg('sum')
 .to_frame()
 .assign(pct_total=lambda df_: df_.ext_price / df_.ext_price.sum())
 .rename(columns={'ext_price':'sum'})
 .reset_index()
 .style
 .format({'date':'{:%b-%Y}','sum':'${0:,.0f}','pct_total':'{:.2%}'})
 .hide()
 )
```

| date     | sum       | pct_total |
|----------|-----------|-----------|
| Jan-2018 | \$185,362 | 9.18%     |
| Feb-2018 | \$146,212 | 7.24%     |
| Mar-2018 | \$203,921 | 10.10%    |
| Apr-2018 | \$174,574 | 8.65%     |
| May-2018 | \$165,419 | 8.19%     |
| Jun-2018 | \$174,089 | 8.62%     |
| Jul-2018 | \$191,662 | 9.49%     |
| Aug-2018 | \$153,779 | 7.62%     |
| Sep-2018 | \$168,443 | 8.34%     |
| Oct-2018 | \$171,495 | 8.49%     |
| Nov-2018 | \$119,961 | 5.94%     |
| Dec-2018 | \$163,867 | 8.12%     |

By the way in addition to using `pd.Grouper` we can use `resample` on timeseries data to get an identical dataframe to the one above.

``` python
(df
 .set_index('date')
 .resample('ME')
 [['ext_price']]
 .sum()
 .assign(pct_total=lambda df_: df_.ext_price / df_.ext_price.sum())
 .rename(columns={'ext_price':'sum'})
 .reset_index()
 .style
 .format({'date':'{:%b-%Y}','sum':'${0:,.0f}','pct_total':'{:.2%}'})
 .hide()
 )
```

| date     | sum       | pct_total |
|----------|-----------|-----------|
| Jan-2018 | \$185,362 | 9.18%     |
| Feb-2018 | \$146,212 | 7.24%     |
| Mar-2018 | \$203,921 | 10.10%    |
| Apr-2018 | \$174,574 | 8.65%     |
| May-2018 | \$165,419 | 8.19%     |
| Jun-2018 | \$174,089 | 8.62%     |
| Jul-2018 | \$191,662 | 9.49%     |
| Aug-2018 | \$153,779 | 7.62%     |
| Sep-2018 | \$168,443 | 8.34%     |
| Oct-2018 | \$171,495 | 8.49%     |
| Nov-2018 | \$119,961 | 5.94%     |
| Dec-2018 | \$163,867 | 8.12%     |

> **NOTE:**
>
> To use `resample` you must set the date column as the index of your dataframe.

If you have an observant eye, you’ll notice that the above dataframe doesn’t have an index. That’s because use used the `hide` method. It suppresses the index.

Manipulating the look of your dataframe is useful when developing final output reports. Usually, the index of the dataframe serves no purpose in the final report.

Colors can be useful when directing attention to specific parts of the report like the lowest or highest sales values. Let me highlight the highest and lowest values to see which months had the highest and lowest sales. I’ll use red for the lowest and green for the highest.

``` python
(df
 .set_index('date')
 .resample('ME')
 [['ext_price']]
 .sum()
 .assign(pct_total=lambda df_: df_.ext_price / df_.ext_price.sum())
 .rename(columns={'ext_price':'sum'})
 .reset_index()
 .style
 .format({'date':'{:%b-%Y}','sum':'${0:,.0f}','pct_total':'{:.2%}'})
 .hide()
 .highlight_max(color='darkgreen', subset=['sum','pct_total'])
 .highlight_min(color='red', subset=['sum','pct_total'])
 )
```

| date     | sum       | pct_total |
|----------|-----------|-----------|
| Jan-2018 | \$185,362 | 9.18%     |
| Feb-2018 | \$146,212 | 7.24%     |
| Mar-2018 | \$203,921 | 10.10%    |
| Apr-2018 | \$174,574 | 8.65%     |
| May-2018 | \$165,419 | 8.19%     |
| Jun-2018 | \$174,089 | 8.62%     |
| Jul-2018 | \$191,662 | 9.49%     |
| Aug-2018 | \$153,779 | 7.62%     |
| Sep-2018 | \$168,443 | 8.34%     |
| Oct-2018 | \$171,495 | 8.49%     |
| Nov-2018 | \$119,961 | 5.94%     |
| Dec-2018 | \$163,867 | 8.12%     |

You can also use `background_gradient` to highlight the range of values in a column. Let’s do it for the sum column. I’ll use `subset` to pick the column and `cmap` to choose a color palette for the gradient.

``` python
(df
 .set_index('date')
 .resample('ME')
 [['ext_price']]
 .sum()
 .assign(pct_total=lambda df_: df_.ext_price / df_.ext_price.sum())
 .rename(columns={'ext_price':'sum'})
 .reset_index()
 .style
 .format({'date':'{:%b-%Y}','sum':'${0:,.0f}','pct_total':'{:.2%}'})
 .hide()
 .background_gradient(cmap='BuGn', subset='sum')
 )
```

| date     | sum       | pct_total |
|----------|-----------|-----------|
| Jan-2018 | \$185,362 | 9.18%     |
| Feb-2018 | \$146,212 | 7.24%     |
| Mar-2018 | \$203,921 | 10.10%    |
| Apr-2018 | \$174,574 | 8.65%     |
| May-2018 | \$165,419 | 8.19%     |
| Jun-2018 | \$174,089 | 8.62%     |
| Jul-2018 | \$191,662 | 9.49%     |
| Aug-2018 | \$153,779 | 7.62%     |
| Sep-2018 | \$168,443 | 8.34%     |
| Oct-2018 | \$171,495 | 8.49%     |
| Nov-2018 | \$119,961 | 5.94%     |
| Dec-2018 | \$163,867 | 8.12%     |

Another cool thing you can do with styling is draw bar charts within the columns to represent the values.

``` python
(df
 .set_index('date')
 .resample('ME')
 [['ext_price']]
 .sum()
 .assign(pct_total=lambda df_: df_.ext_price / df_.ext_price.sum())
 .rename(columns={'ext_price':'sum'})
 .reset_index()
 .style
 .format({'date':'{:%b-%Y}','sum':'${0:,.0f}','pct_total':'{:.2%}'})
 .hide()
 .bar(color='#ffa348', vmin=100_000, subset=['sum'], align='zero')
 .bar(color='#c061cb', vmin=0, subset=['pct_total'], align='zero')
 .set_caption('Sales performance (2018)')
 )
```

| date     | sum       | pct_total |
|----------|-----------|-----------|
| Jan-2018 | \$185,362 | 9.18%     |
| Feb-2018 | \$146,212 | 7.24%     |
| Mar-2018 | \$203,921 | 10.10%    |
| Apr-2018 | \$174,574 | 8.65%     |
| May-2018 | \$165,419 | 8.19%     |
| Jun-2018 | \$174,089 | 8.62%     |
| Jul-2018 | \$191,662 | 9.49%     |
| Aug-2018 | \$153,779 | 7.62%     |
| Sep-2018 | \$168,443 | 8.34%     |
| Oct-2018 | \$171,495 | 8.49%     |
| Nov-2018 | \$119,961 | 5.94%     |
| Dec-2018 | \$163,867 | 8.12%     |

Table 1: Sales performance (2018)

In the code above I use `bar` and some parameters to configure the display of the bars in the columns. Using `set_caption` allows me to add a title to the table.

### Advanced styling

All the styling we’ve done thus far can be exported to Excel and the styling will be reflected in the Excel file. Unfortunately, the advanced styling we’ll do from here won’t be maintained when the file is exported to Excel. Since the styling will involve HTML and CSS features, you can export it as an HTML file and the styling will be maintained.

Let’s create a table that shows the top 10 companies by sales value. Then we’ll get the average and median of their `quantity`; and average, median, and sum of their `ext_price`.

To create sparklines, I’ll use the library `sparklines` and `numpy`.

``` python
from sparklines import sparklines
import numpy as np

# function to create sparklines
def sparkline(x):
    bins=np.histogram(x)[0]
    sl = ''.join(sparklines(bins))
    return sl
sparkline.sparklines = 'sparkline'

# apply the function to modify the dataframe
data = (df
 .groupby('name')
 .agg({'quantity': ['mean', 'median', sparkline], 'ext_price': ['mean', 'median', 'sum', sparkline]})
 .head(10)
 )
data.columns.names=['','Stats']

# mapping for renaming
rename_mapping = {
    'quantity': 'Quantity',
    'ext_price': 'Price'
}

# renaming the levels
data.columns = data.columns.set_levels(
    [rename_mapping.get(item, item) for item in data.columns.levels[0]], level=0
)

data
```

|  | Quantity |  |  | Price |  |  |  |
|----|----|----|----|----|----|----|----|
| Stats | mean | median | sparkline | mean | median | sum | sparkline |
| name |  |  |  |  |  |  |  |
| Barton LLC | 24.890244 | 28.0 | ▄▄▃▂▃▆▄█▁▄ | 1334.615845 | 1280.640015 | 109438.500000 | █▄▃▆▄▄▁▁▁▁ |
| Cronin, Oberbrunner and Spencer | 24.970149 | 28.0 | █▄▁▄▄▇▅▁▄▄ | 1339.321655 | 1123.500000 | 89734.546875 | █▅▅▃▃▃▂▂▁▁ |
| Frami, Hills and Schmidt | 26.430556 | 28.0 | ▄▄▁▂▇█▂▂▅▅ | 1438.466553 | 1509.689941 | 103569.593750 | █▅▄▇▅▃▄▁▁▁ |
| Fritsch, Russel and Anderson | 26.074074 | 27.0 | ▁▄▇▃▂▂█▃▄▄ | 1385.366821 | 1050.119995 | 112214.710938 | ▇█▃▄▂▂▁▂▁▁ |
| Halvorson, Crona and Champlin | 22.137931 | 19.5 | ▇▆▆▇█▁▄▂▄▃ | 1206.971680 | 925.434998 | 70004.359375 | ██▆▅▁▃▂▂▂▂ |
| Herman LLC | 24.806452 | 25.0 | ▄▃▅▁▆▄▂▆▃█ | 1336.532227 | 1095.489990 | 82865.000000 | █▅▇▄▅▄▁▃▂▂ |
| Jerde-Hilpert | 22.460674 | 23.0 | ▄▄█▁▂▅▃▂▄▃ | 1265.072266 | 906.359985 | 112591.429688 | █▄▅▂▁▂▃▂▂▁ |
| Kassulke, Ondricka and Metz | 25.734375 | 27.5 | ▂▂▁▁▂▂▁▅▄█ | 1350.797974 | 951.164978 | 86451.070312 | █▆▆▄▄▃▂▁▁▂ |
| Keeling LLC | 24.405405 | 24.5 | ▁▄▇▃▅█▃▄▃▆ | 1363.976929 | 979.824951 | 100934.296875 | ▅█▆▃▄▂▂▁▁▁ |
| Kiehn-Spinka | 22.227848 | 21.0 | ▃▂█▂▃▅▄▁▄▁ | 1260.870605 | 894.960022 | 99608.773438 | █▇▄▃▃▂▁▂▁▁ |

You’ll notice that the table above is multi-column i.e., there are two levels of columns. I’ll add sparklines to the second level of columns. These will be under both quantity and price. I’ll also rename the top columns as `Quantity` and `Price` . Then I’ll add a label `Stats` to show what the second level of columns mean.

Let’s add some HTML and CSS styling to make our table more stunning. I’ll format all the numbers to 2 decimal places. The background color for the header will be purple and I’ll increase the font size for the names of the top columns.

``` python
# set the HTML and CSS styles
cell_hover = {  # for row hover use <tr> instead of <td>
    'selector': 'td:hover',
    'props': [('background-color', '#ffffb3')]
}
index_names = {
    'selector': '.index_name',
    'props': 'font-style: italic; color: darkgrey; font-weight:normal;'
}
headers = {
    'selector': 'th:not(.index_name)',
    'props': 'background-color: #813d9c; color: white;'
}

# apply the HTML and CSS styling
(data
 .style
 .format({('Quantity', 'mean'): "{:.2f}",
          ('Quantity', 'median'): "{:.2f}",
          ('Price', 'mean'): "{:.2f}",
          ('Price', 'median'): "{:.2f}",
          ('Price', 'sum'): "{:.2f}"})
 .set_table_styles([cell_hover, index_names, headers])
 .set_table_styles([{'selector': 'th.col_heading', 'props': 'text-align: center;'},
                    {'selector': 'th.col_heading.level0', 'props': 'font-size: 2em;'},
                    {'selector': 'td', 'props': 'text-align: center; font-weight: bold;'}], overwrite=False)
 )
```

|  | Quantity |  |  | Price |  |  |  |
|----|----|----|----|----|----|----|----|
| Stats | mean | median | sparkline | mean | median | sum | sparkline |
| name |   |   |   |   |   |   |   |
| Barton LLC | 24.89 | 28.00 | ▄▄▃▂▃▆▄█▁▄ | 1334.62 | 1280.64 | 109438.50 | █▄▃▆▄▄▁▁▁▁ |
| Cronin, Oberbrunner and Spencer | 24.97 | 28.00 | █▄▁▄▄▇▅▁▄▄ | 1339.32 | 1123.50 | 89734.55 | █▅▅▃▃▃▂▂▁▁ |
| Frami, Hills and Schmidt | 26.43 | 28.00 | ▄▄▁▂▇█▂▂▅▅ | 1438.47 | 1509.69 | 103569.59 | █▅▄▇▅▃▄▁▁▁ |
| Fritsch, Russel and Anderson | 26.07 | 27.00 | ▁▄▇▃▂▂█▃▄▄ | 1385.37 | 1050.12 | 112214.71 | ▇█▃▄▂▂▁▂▁▁ |
| Halvorson, Crona and Champlin | 22.14 | 19.50 | ▇▆▆▇█▁▄▂▄▃ | 1206.97 | 925.43 | 70004.36 | ██▆▅▁▃▂▂▂▂ |
| Herman LLC | 24.81 | 25.00 | ▄▃▅▁▆▄▂▆▃█ | 1336.53 | 1095.49 | 82865.00 | █▅▇▄▅▄▁▃▂▂ |
| Jerde-Hilpert | 22.46 | 23.00 | ▄▄█▁▂▅▃▂▄▃ | 1265.07 | 906.36 | 112591.43 | █▄▅▂▁▂▃▂▂▁ |
| Kassulke, Ondricka and Metz | 25.73 | 27.50 | ▂▂▁▁▂▂▁▅▄█ | 1350.80 | 951.16 | 86451.07 | █▆▆▄▄▃▂▁▁▂ |
| Keeling LLC | 24.41 | 24.50 | ▁▄▇▃▅█▃▄▃▆ | 1363.98 | 979.82 | 100934.30 | ▅█▆▃▄▂▂▁▁▁ |
| Kiehn-Spinka | 22.23 | 21.00 | ▃▂█▂▃▅▄▁▄▁ | 1260.87 | 894.96 | 99608.77 | █▇▄▃▃▂▁▂▁▁ |

This is the type of table you would want to display on your website. What’s more, it has cell highlighting when you hover over a cell.

Styling this final table required a lot of work, but I’m sure you’ll agree that it’s nothing short of beautiful. You almost can’t stop looking at it.
