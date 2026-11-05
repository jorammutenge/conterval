# Tranforming timeseries data with group by and group by dynamic in polars

Author

Joram Mutenge

Published

2025-01-06

![](image.jpg)

a brand of yogurt

Polars has become my go-to library for data analysis. Each client project brings new insights into the powerful functionality Polars offers. Recently, I worked on a project for a supermarket that required processing data related to yogurt stock quantities.

## The problem

The supermarket’s data included multiple quantity entries for the same yogurt brand within a single month. The goal was to aggregate these quantities into a single value per month and standardize the date to the first day of that month.

For example, the data for a yogurt brand like Chobani in February might look like this:

- Feb-02-2025 = 30 units\
- Feb-08-2025 = 20 units\
- Feb-15-2025 = 50 units

The desired output for February would aggregate these values into:

- Feb-01-2025 = 100 units

This aggregation needed to be repeated for every yogurt brand sold by the supermarket.

## The dataset

To demonstrate how I solved this problem, I’ll use a representative dataset (not the actual client data).

shape: (49, 3)

| Date       | Yogurt            | Quantity |
|------------|-------------------|----------|
| date       | str               | i64      |
| 2025-02-05 | "Yoplait"         | 54       |
| 2025-02-11 | "Yoplait"         | 54       |
| 2025-02-14 | "Yoplait"         | 54       |
| 2025-02-19 | "Yoplait"         | 54       |
| 2025-02-26 | "Yoplait"         | 54       |
| …          | …                 | …        |
| 2025-06-03 | "Wallaby Organic" | 48       |
| 2025-06-03 | "Yoplait"         | 54       |
| 2025-06-03 | "Chobani"         | 120      |
| 2025-06-23 | "Dannon"          | 12       |
| 2025-06-24 | "Chobani"         | 120      |

## The solution

I’ll show two approaches to solving this problem. The first method uses `group_by`, while the second uses `group_by_dynamic`. Afterward, I’ll verify that both methods produce identical results. More importantly, I’ll compare their performance by using the `%%timeit` cell magic command to identify the faster solution.

### Solution with group by dynamic

When resampling time series data, `group_by_dynamic` simplifies selecting a specific time period (e.g., weekly, monthly, quarterly) and resampling the data to perform aggregations based on the chosen interval. However, `group_by_dynamic` does not support grouping by multiple columns. While this limitation may make it unsuitable for addressing the client’s problem directly, a workaround is available.

Let’s process the data for a single yogurt brand, Yoplait to see if the solution is working the way we expect it. Then we’ll repeat the process for all yogurt brands. Here’s is the unprocessed data for Yoplait yogurt.

``` python
data.filter(pl.col('Yogurt') == "Yoplait")
```

shape: (18, 3)

| Date       | Yogurt    | Quantity |
|------------|-----------|----------|
| date       | str       | i64      |
| 2025-02-05 | "Yoplait" | 54       |
| 2025-02-11 | "Yoplait" | 54       |
| 2025-02-14 | "Yoplait" | 54       |
| 2025-02-19 | "Yoplait" | 54       |
| 2025-02-26 | "Yoplait" | 54       |
| …          | …         | …        |
| 2025-04-30 | "Yoplait" | 54       |
| 2025-05-09 | "Yoplait" | 54       |
| 2025-05-16 | "Yoplait" | 54       |
| 2025-05-26 | "Yoplait" | 54       |
| 2025-06-03 | "Yoplait" | 54       |

Here is the processed data for Yoplait yogurt. The aggregations have been completed, resulting in a reduced number of rows in the dataframe.

``` python
(data
 .filter(pl.col('Yogurt') == "Yoplait")
 .group_by_dynamic('Date', every='1mo')
 .agg(pl.sum('Quantity'), pl.first('Yogurt'))
)
```

shape: (5, 3)

| Date       | Quantity | Yogurt    |
|------------|----------|-----------|
| date       | i64      | str       |
| 2025-02-01 | 270      | "Yoplait" |
| 2025-03-01 | 270      | "Yoplait" |
| 2025-04-01 | 216      | "Yoplait" |
| 2025-05-01 | 162      | "Yoplait" |
| 2025-06-01 | 54       | "Yoplait" |

\
Notice that I have selected a 1-month time period for the `every` parameter. However, there is an unresolved issue in our solution: we have multiple dates instead of a single date representing the first day of each month. To address this, I will introduce another parameter, `start_by`, and set its value to `"window"`. This ensures that all dates are converted to the first day of their respective months.

``` python
(data
 .filter(pl.col('Yogurt') == "Yoplait")
 .group_by_dynamic('Date', every='1mo', start_by='window')
 .agg(pl.sum('Quantity'), pl.first('Yogurt'))
)
```

shape: (5, 3)

| Date       | Quantity | Yogurt    |
|------------|----------|-----------|
| date       | i64      | str       |
| 2025-02-01 | 270      | "Yoplait" |
| 2025-03-01 | 270      | "Yoplait" |
| 2025-04-01 | 216      | "Yoplait" |
| 2025-05-01 | 162      | "Yoplait" |
| 2025-06-01 | 54       | "Yoplait" |

\
Having achieved the desired results for Yoplait yogurt, I can now process the data for the other brands. Instead of processing each brand individually, I will use a `for` loop to automate the task.

First, I’ll create a list of all the yogurt brands contained in the dataset.

``` python
yogurt_list = data['Yogurt'].unique().to_list()
yogurt_list
```

    ['Dannon',
     'Activia',
     'Stonyfield Organic',
     "Siggi's",
     'Wallaby Organic',
     'Noosa',
     'Oikos',
     'Yoplait',
     'Chobani',
     'Brown Cow',
     'Fage']

And now here’s the code that implements the `for` loop.

``` python
dfs = []
for item in yogurt_list:
    df = (data
    .filter(pl.col('Yogurt') == item)
    .group_by_dynamic('Date', every='1mo', start_by='window')
    .agg(pl.sum('Quantity'), pl.first('Yogurt'))
    )
    dfs.append(df)
df_1 = pl.concat(dfs)
df_1
```

shape: (23, 3)

| Date       | Quantity | Yogurt               |
|------------|----------|----------------------|
| date       | i64      | str                  |
| 2025-06-01 | 12       | "Dannon"             |
| 2025-05-01 | 504      | "Activia"            |
| 2025-04-01 | 60       | "Stonyfield Organic" |
| 2025-04-01 | 6        | "Siggi's"            |
| 2025-04-01 | 96       | "Wallaby Organic"    |
| …          | …        | …                    |
| 2025-04-01 | 240      | "Chobani"            |
| 2025-05-01 | 408      | "Chobani"            |
| 2025-06-01 | 240      | "Chobani"            |
| 2025-04-01 | 6        | "Brown Cow"          |
| 2025-05-01 | 24       | "Fage"               |

To verify that the above code worked correctly, let display the results for Yoplait yogurt.

``` python
df_1.filter(pl.col('Yogurt') == "Yoplait")
```

shape: (5, 3)

| Date       | Quantity | Yogurt    |
|------------|----------|-----------|
| date       | i64      | str       |
| 2025-02-01 | 270      | "Yoplait" |
| 2025-03-01 | 270      | "Yoplait" |
| 2025-04-01 | 216      | "Yoplait" |
| 2025-05-01 | 162      | "Yoplait" |
| 2025-06-01 | 54       | "Yoplait" |

Great! The results are what we expected.

### Solution with group by

Fortunately, with `group_by`, it is possible to aggregate data across multiple columns. This allows me to process the data for all yogurt brands without using a `for` loop. However, I first need to create a new column, *Month*, to use as one of the grouping columns in `group_by`. As before, I will start by processing the data for a single yogurt brand, Yoplait.

``` python
(data
 .filter(pl.col('Yogurt') == "Yoplait")
 .with_columns(Month=pl.col('Date').dt.month())
 .group_by('Yogurt','Month')
 .agg(pl.sum('Quantity'),
       pl.first('Date'))
 .drop('Month')
 .with_columns(pl.col("Date").dt.truncate("1mo"))
 )
```

shape: (5, 3)

| Yogurt    | Quantity | Date       |
|-----------|----------|------------|
| str       | i64      | date       |
| "Yoplait" | 216      | 2025-04-01 |
| "Yoplait" | 162      | 2025-05-01 |
| "Yoplait" | 54       | 2025-06-01 |
| "Yoplait" | 270      | 2025-03-01 |
| "Yoplait" | 270      | 2025-02-01 |

Notice that I have used two columns, *Yogurt* and *Month*, in `group_by` to aggregate quantities based on this two-column combination. Since *Month* has served its purpose, I can drop it as it is no longer needed. However, the date values are not in the expected format. To resolve this issue, I will use `truncate` and set the value to `"1mo"` to adjust the values in the *Date* column by one month.

``` python
(data
 .filter(pl.col('Yogurt') == "Yoplait")
 .with_columns(Month=pl.col('Date').dt.month())
 .group_by('Yogurt','Month')
 .agg(pl.sum('Quantity'),
       pl.first('Date'))
 .drop('Month')
 .with_columns(pl.col("Date").dt.truncate("1mo"))
 )
```

shape: (5, 3)

| Yogurt    | Quantity | Date       |
|-----------|----------|------------|
| str       | i64      | date       |
| "Yoplait" | 270      | 2025-02-01 |
| "Yoplait" | 162      | 2025-05-01 |
| "Yoplait" | 270      | 2025-03-01 |
| "Yoplait" | 54       | 2025-06-01 |
| "Yoplait" | 216      | 2025-04-01 |

Now that we have the expected results, all that’s left to process the data for all yogurt brands is to remove the line of code containing `filter`.

``` python
df_2 = (data
 .with_columns(Month=pl.col('Date').dt.month())
 .group_by('Yogurt','Month')
 .agg(pl.sum('Quantity'),
       pl.first('Date'))
 .drop('Month')
 .with_columns(pl.col("Date").dt.truncate("1mo"))
 )
df_2
```

shape: (23, 3)

| Yogurt               | Quantity | Date       |
|----------------------|----------|------------|
| str                  | i64      | date       |
| "Wallaby Organic"    | 96       | 2025-04-01 |
| "Dannon"             | 12       | 2025-06-01 |
| "Siggi's"            | 6        | 2025-04-01 |
| "Yoplait"            | 54       | 2025-06-01 |
| "Chobani"            | 240      | 2025-06-01 |
| …                    | …        | …          |
| "Noosa"              | 12       | 2025-05-01 |
| "Activia"            | 504      | 2025-05-01 |
| "Chobani"            | 444      | 2025-03-01 |
| "Stonyfield Organic" | 60       | 2025-04-01 |
| "Yoplait"            | 162      | 2025-05-01 |

## Comparing the two methods

Multiple factors can be used to determine which code is better, such as ease of writing. However, I will focus on determining which code processes the data faster. Let’s test which approach performs better.

**With group by dynamic**

``` python
%%timeit

dfs = []
for item in yogurt_list:
    df = (data
    .filter(pl.col('Yogurt') == item)
    .group_by_dynamic('Date', every='1mo', start_by='window')
    .agg(pl.sum('Quantity'), pl.first('Yogurt'))
    )
    dfs.append(df)
df_1 = pl.concat(dfs)
```

    1.19 ms ± 7.59 μs per loop (mean ± std. dev. of 7 runs, 1,000 loops each)

**With group by**

``` python
%%timeit

(data
 .with_columns(Month=pl.col('Date').dt.month())
 .group_by('Yogurt','Month')
 .agg(pl.sum('Quantity'),
       pl.first('Date'))
 .drop('Month')
 .with_columns(pl.col("Date").dt.truncate("1mo"))
 )
```

    286 μs ± 765 ns per loop (mean ± std. dev. of 7 runs, 1,000 loops each)

You can see that `group_by` processes the data faster, making it the better method. This isn’t surprising, actually, because it doesn’t involve using a `for` loop. It’s always better to avoid loops when working with dataframes, as this allows your code to be executed in Rust, the language in which Polars was written. When you use `for` loops, your code is executed in Python, which is slower than Rust.

Check out the new [Polars for Finance course](https://www.udemy.com/course/getting-started-with-polars-for-finance/) we published to learn how to process and analyze stock data.
