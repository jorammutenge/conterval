# Creating a pareto chart with plotly

How to use data to grow your business

visualization

Author

Joram Mutenge

Published

August 13, 2024

### The business scenario

Picture yourself in the 1980s. You own a software store where you sell software in disks by the unit.

After doing business for a few years, you decide to increase your sales to pocket more money. However, increasing sales will mean spending more time on your business. After all, nothing comes for free.

If you sell 8 pieces of software in your store, which pieces of software should you spend more time on to get the best bang for your buck? Put another way, which pieces of software should you increase the stock to sell more?

This is a common problem most businesses face. Luckily, you can solve it by using a Pareto chart.

### What is a Pareto chart?

A Pareto chart is both a bar and a line chart. It has two y-axes; on the left is the frequency and on the right is the percentage. The x-axis shows the categories involved. The inventor of the Pareto chart is Joseph M. Juran.

The Pareto chart is influenced by the *Pareto Principle*, which derives its name from the Italian economist Wilfred Perito. It’s the idea that with everything we are trying to improve, 80% of the problem or opportunity lies with 20% of the reasons (or the *80/20 rule* as it is popularly known).

### The dataset

Let’s create a dataframe showing the 8 pieces of software sold in the store.

``` python
import polars as pl

data = pl.DataFrame({
    'Software': ['Lotus-123', 'WordStar', 'dBase III', 'VisiCalc', 
                 'WinZip', 'MS-DOS', 'HyperCard', 'WordPerfect'],
    'Units_Sold': [10000, 4500, 2500, 3000, 1800, 17000, 2200, 1900]
})
data
```

shape: (8, 2)

| Software      | Units_Sold |
|---------------|------------|
| str           | i64        |
| "Lotus-123"   | 10000      |
| "WordStar"    | 4500       |
| "dBase III"   | 2500       |
| "VisiCalc"    | 3000       |
| "WinZip"      | 1800       |
| "MS-DOS"      | 17000      |
| "HyperCard"   | 2200       |
| "WordPerfect" | 1900       |

Then I’ll add 2 columns to the dataframe. One for the cumulative sum and the other for the cumulative percentage.

``` python
df = (data
 .sort('Units_Sold', descending=True)     
 .with_columns(Cum_Sum=pl.col('Units_Sold').cum_sum())
 .with_columns(Cum_Pct=pl.col('Cum_Sum').truediv(pl.col('Units_Sold').sum()))
 )
df
```

shape: (8, 4)

| Software      | Units_Sold | Cum_Sum | Cum_Pct  |
|---------------|------------|---------|----------|
| str           | i64        | i64     | f64      |
| "MS-DOS"      | 17000      | 17000   | 0.39627  |
| "Lotus-123"   | 10000      | 27000   | 0.629371 |
| "WordStar"    | 4500       | 31500   | 0.734266 |
| "VisiCalc"    | 3000       | 34500   | 0.804196 |
| "dBase III"   | 2500       | 37000   | 0.862471 |
| "HyperCard"   | 2200       | 39200   | 0.913753 |
| "WordPerfect" | 1900       | 41100   | 0.958042 |
| "WinZip"      | 1800       | 42900   | 1.0      |

> **NOTE:**
>
> Sorting on the `Units_Sold` is required to have a meaningful Pareto chart.

### Create the Pareto chart

My graphing library of choice to create the Pareto chart will be plotly.

``` python
import plotly.graph_objects as go

# Create the bar chart
fig = go.Figure()

# Add bar chart for Units Sold
fig.add_trace(go.Bar(
    x=df['Software'],
    y=df['Units_Sold'],
    name='Units sold',
    marker_color='#008B8B',
    customdata=df['Cum_Pct'],  # Pass Cum_Pct as customdata
))

# Add Pareto line for Cumulative Percentage
fig.add_trace(go.Scatter(
    x=df['Software'],
    y=df['Cum_Pct'],
    name='Cumulative Percentage',
    mode='lines+markers',
    marker_color='#ffffff',
    yaxis='y2'
))

# Update hover template to include Cum_Pct for the bar chart
hover_string_bar = '<b>Units Sold: </b> %{y:,} <br>'
hover_string_bar += '<b>Cum percent: </b> %{customdata:.2%}'
fig.update_traces(hovertemplate=hover_string_bar, selector=dict(type='bar'))

# Update hover template to show percentage for the scatter plot
hover_string_scatter = '<b>Software: </b> %{x}<br>'
hover_string_scatter += '<b>Cum percent: </b> %{y:.2%}'
fig.update_traces(hovertemplate=hover_string_scatter, selector=dict(type='scatter'))

# Update layout to have dual y-axes
fig.update_layout(
    title=dict(text='<b>Software units sold</b><br><b>Pareto chart</b>', font_size=22),
    yaxis=dict(
        title='<b>Units sold<b>',
        showgrid=False,  # Remove major and minor grid lines on the first y-axis
        tickformat=',',  # Format numbers with comma as thousand separator
    ),
    yaxis2=dict(
        title='<b>Cumulative percentage<b>',
        overlaying='y',
        color='#613583',
        side='right',
        tickformat='.0%',  # Round to the nearest whole
        showgrid=False  # Remove major and minor grid lines on the second y-axis
    ),
    xaxis=dict(
        showgrid=False  # Remove major and minor grid lines on the x-axis
    ),
    plot_bgcolor='#FFE4B5',
    paper_bgcolor='#FFE4B5',
    bargap=0.1,
    legend=dict(x=.25, y=0.98, orientation='h'),  # Change padding of legend with y
    margin={'t': 100} #increase padding between title text and edge of figure (top)
)

fig.show(renderer="iframe", height=450)
```

> **TIP:**
>
> 1.  The frequency bars (green bars) must have the highest values on the left and decrease accordingly as you move to the right.
> 2.  The percentage line (white line) must increase to 100% as you continue to the right.

In the above chart, there are two Y-axes. The first one (on the left) has the frequency (how many units were sold), and the other Y-axis (on the right) shows the relative frequency a.k.a. the percentage of the occurrence. This percentage represents the share of the sales of one piece of software compared to the total units sold. For example, the total number of units sold is 42,900. Out of those units, MS-DOS sold 17,000 units which represents 39.63% of the total units sold.

So as a store owner to get the best bang for your buck, you must focus on the following four pieces of software in your store, MS-DOS, Lotus-123, WordStar, and VisiCalc. Why? Because 80% of sales come from those four pieces of software.

You may think that since you sell 8 pieces of software in your store, focusing on four will only increase your sales by 50% but it’s actually more than that. A Pareto chart allows you to know this useful piece of information. It highlights where you should spend your time and resources to get the most out of your effort.

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn how you can leverage data to grow your business.
