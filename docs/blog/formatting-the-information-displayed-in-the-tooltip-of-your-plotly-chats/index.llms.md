# Formatting the information displayed in the tooltip of your plotly chats

Enter hovertemplate and customdata

visualization

Author

Joram Mutenge

Published

August 6, 2024

My data visualization journey started with *ggplot*, followed by a brief stint with *seaborn*. After that, I fell in love with *matplotlib* and used it for a long time. But now my new love is *plotly* because of the ease with which you can make interactive charts.

One of my favorite interactive features on plotly charts is the tooltip. The tool tip is a pop-up that displays additional information when you hover over a specific part of the chart like a bar on the bar chart or a section in the pie chart.

While plotly provides tooltip information by default, most people don’t know that you can modify the tooltip by formatting the text or adding more information. The feature that allows you to do this is a parameter in `update_traces` called `hovertemplate`.

### Loading the data

I’ll be using the sales dataset for companies in the USA, categorized by segment. I’ll group the data by segment to get the total sales for each segment and the percentage of sales.

``` python
from pathlib import Path
import polars as pl
pl.Config.set_tbl_rows(6)
import plotly.express as px

df = (pl.read_parquet(f"{Path('../../')}/datasets/regional_sales.parquet")
      .rename(lambda col: col.replace(' ','_'))
      .with_columns(Sale_Pct=pl.col('Sales_In_Dollars') / pl.col('Sales_In_Dollars').sum())
      .fill_null('Other')
      )
df
```

shape: (20, 6)

| Customer_ID | Customer_Name | Region_Name | Segment | Sales_In_Dollars | Sale_Pct |
|----|----|----|----|----|----|
| i64 | str | str | str | i32 | f64 |
| 740150 | "Barton LLC" | "US" | "Gold" | 215000 | 0.026875 |
| 714466 | "Trantow-Barrows" | "EMEA" | "Silver" | 430000 | 0.05375 |
| 218895 | "Kulas Inc" | "EMEA" | "Platinum" | 410000 | 0.05125 |
| … | … | … | … | … | … |
| 257198 | "Cronin, Oberbrunner and Spence… | "US" | "Platinum" | 425000 | 0.053125 |
| 604255 | "Halvorson, Crona and Champlin" | "US" | "Other" | 430000 | 0.05375 |
| 163416 | "Purdy-Kunde" | "APAC" | "Silver" | 410000 | 0.05125 |

### Creating the pie chart

Let’s create a pie chart to display each segment’s percentage share of the sales dollars. We won’t modify the information displayed in the tooltip.

``` python
fig = px.pie(data_frame=df, names='Segment',values='Sales_In_Dollars')
fig.show(renderer="iframe")
```

If you hover over any section of the pie chart above, a tooltip shows the segment for that section and the dollar amount for the sales. That is useful information, but it doesn’t look pretty, i.e. it’s not properly formatted.

In the chart below, I’ll use hovertemplate to make the formatting of the text pretty, and therefore easily understandable.

``` python
hover_string = "<b>Segment: </b> %{label} <br>"
hover_string += "<b>Sales: </b> $%{value}"

fig = px.pie(data_frame=df, names='Segment',values='Sales_In_Dollars')
fig.update_traces(hovertemplate=hover_string)
fig.show(renderer="iframe")
```

The string `%{label}` displays the segment value like “Gold” while the string `%{value}` displays the sales dollar amount. I’ve also included the dollar sign “\$” to the left of the sales figure to show the currency of the numerical value. The `<b>` tag makes the text bold and the `<br>` tag creates a new line so that the next piece of information is displayed on the second line.

### Creating the bar chart

In addition to formatting the text inside the tooltip, we can also add more information to show in the tooltip. First, let’s plot the bar chart with the default tooltip information.

``` python
hovertemp = "<b>Segment: </b> %{x} <br>"
hovertemp += "<b>Sales: </b> $%{y}"

fig = px.bar(data_frame=df, x='Segment',y='Sales_In_Dollars', barmode='relative')
fig.update_traces(hovertemplate=hovertemp)
fig.show(renderer="iframe")
```

The string `%{x}` displays the segment value like “Gold” while the string `%{y}` displays the sales dollar amount.

### Add more information to the tooltip

In the bar chart below, I’ll use custom_data to include sales percentages in the tooltip information. The string `%{customdata[0]}` represents the percentage of the total sales for that section.

Since I already have the Sale_Pct column, I can simply parse that column in `custom_data`. This is where `hovertemplate` comes in.

``` python
hover_string = "<b>Segment: </b> %{x} <br>"
hover_string += "<b>Sales: </b> $%{y} <br>"
hover_string += "<b>Percentage: </b> %{customdata[0]}"

fig = px.bar(data_frame=df, x='Segment',
             y='Sales_In_Dollars',
             custom_data=['Sale_Pct'],
             barmode='group')
fig.update_traces(hovertemplate=hover_string)
fig.show(renderer="iframe")
```

We’ve successfully added an extra piece of information to the tooltip. However, astute readers will notice that the percentage value displayed on a single bar is inconsistent. That’s because the value value comes from a single row of data instead of the group-by-section value like the way the bars are displayed. Let’s fix that!

I’ll prepare the data which will be used to create the bar chart we expect to see.

``` python
grouped = (df
 .group_by('Segment')
 .agg(pl.sum('Sale_Pct').mul(100),
      pl.sum('Sales_In_Dollars'))
 )
grouped
```

shape: (4, 3)

| Segment    | Sale_Pct | Sales_In_Dollars |
|------------|----------|------------------|
| str        | f64      | i32              |
| "Silver"   | 26.25    | 2100000          |
| "Gold"     | 29.05    | 2324000          |
| "Platinum" | 32.4375  | 2595000          |
| "Other"    | 12.2625  | 981000           |

I’ve grouped the data by segment and summed the percentage and the sales. I’ve also multiplied the percentage by 100 to make the numbers easily understandable in the tooltip.

In the bar chart below, I use `grouped` as my `data_frame` value. I also added `:,.2f` to `customdata[0]` to round the values to the nearest 2 decimal places and added the “%” symbol at the end to show that it’s a percentage value.

``` python
hover_string = "<b>Segment: </b> %{x} <br>"
hover_string += "<b>Sales: </b> $%{y} <br>"
hover_string += "<b>Percentage: </b> %{customdata[0]:,.2f}%"

fig = px.bar(data_frame=grouped, x='Segment',
             y='Sales_In_Dollars',
             custom_data=['Sale_Pct'],
             barmode='group')
fig.update_traces(hovertemplate=hover_string)
fig.show(renderer="iframe")
```

And that’s how you make your tooltips look pretty and informative in plotly.

My [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) will teach you how to analyze and manipulate data.
