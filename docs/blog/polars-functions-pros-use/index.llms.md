# Ten polars functions that pros use and amateurs don’t

Author

Joram Mutenge

Published

2025-01-13

Polars is increasingly becoming a popular data analysis library, and my prediction is that more new data scientists and analysts will be starting with Polars rather than Pandas as their tool of choice for manipulating data. After all, the syntax for Polars is easier to learn and harder to forget. That’s why this tweet couldn’t be more true.

![](image.png)

tweet by yours truly

However, because Polars is new, most of the code out there looks amateurish. Here are 10 functions you should use that will instantly make you look like a pro at Polars.

## 1. Scan CSV

When working with large datasets, loading them can take a long time. This is where `scan_csv` becomes useful. Instead of fully reading the dataset, `scan_csv` scans its contents, allowing you to quickly preview the file and select only the columns you need. By loading just a subset of the data, you can significantly reduce the loading time. For example, consider a dataset containing information about counties in the USA. import polars as pl

``` python
pl.read_csv(counties_in_the_usa)
```

shape: (3_143, 7)

| region | population | county.fips.character | county.name | state.name | state.fips.character | state.abb |
|----|----|----|----|----|----|----|
| i64 | i64 | i64 | str | str | i64 | str |
| 1001 | 54590 | 1001 | "autauga" | "alabama" | 1 | "AL" |
| 1003 | 183226 | 1003 | "baldwin" | "alabama" | 1 | "AL" |
| 1005 | 27469 | 1005 | "barbour" | "alabama" | 1 | "AL" |
| 1007 | 22769 | 1007 | "bibb" | "alabama" | 1 | "AL" |
| 1009 | 57466 | 1009 | "blount" | "alabama" | 1 | "AL" |
| … | … | … | … | … | … | … |
| 56037 | 43890 | 56037 | "sweetwater" | "wyoming" | 56 | "WY" |
| 56039 | 21326 | 56039 | "teton" | "wyoming" | 56 | "WY" |
| 56041 | 20942 | 56041 | "uinta" | "wyoming" | 56 | "WY" |
| 56043 | 8425 | 56043 | "washakie" | "wyoming" | 56 | "WY" |
| 56045 | 7152 | 56045 | "weston" | "wyoming" | 56 | "WY" |

Suppose you only want to display the county name and population. Here’s how you can use `scan_csv` to achieve that:

``` python
(pl.scan_csv(counties_in_the_usa)
 .select('state.name','population')
 .collect()
 )
```

shape: (3_143, 2)

| state.name | population |
|------------|------------|
| str        | i64        |
| "alabama"  | 54590      |
| "alabama"  | 183226     |
| "alabama"  | 27469      |
| "alabama"  | 22769      |
| "alabama"  | 57466      |
| …          | …          |
| "wyoming"  | 43890      |
| "wyoming"  | 21326      |
| "wyoming"  | 20942      |
| "wyoming"  | 8425       |
| "wyoming"  | 7152       |

Notice that I used `collect` because `scan_csv` produces a lazy frame. This means that whenever you use `scan_csv`, you need to include `collect` at the end to get your results.

If you’re skeptical that `scan_csv` is a better approach, let’s compare the time it takes for `scan_csv` and `read_csv` to load the data.

``` python
%%timeit
pl.read_csv(counties_in_the_usa)
```

    106 ms ± 33.2 ms per loop (mean ± std. dev. of 7 runs, 10 loops each)

``` python
%%timeit
pl.scan_csv(counties_in_the_usa)
```

    5.67 μs ± 16.1 ns per loop (mean ± std. dev. of 7 runs, 100,000 loops each)

I’m sure you believe me now.

## 2. Sum horizontal

Adding values in a single column is easy. All you need is `sum`. This is called column-wise and dataframes shine at performing column-wise mathematical operations. However, there comes a time when you need to perform row-wise calculations. This is where `sum_horizontal` comes in. Unfortunately, most Polars users are not aware of this function. Let’s say you had this dataframe for Apple stock data.

shape: (6_953, 7)

| Date       | Open   | High   | Low    | Close  | Volume   | Adj Close |
|------------|--------|--------|--------|--------|----------|-----------|
| date       | f64    | f64    | f64    | f64    | i64      | f64       |
| 2012-03-30 | 608.77 | 610.56 | 597.94 | 599.55 | 26050900 | 599.55    |
| 2012-03-29 | 612.78 | 616.56 | 607.23 | 609.86 | 21668300 | 609.86    |
| 2012-03-28 | 618.38 | 621.45 | 610.31 | 617.62 | 23385200 | 617.62    |
| 2012-03-27 | 606.18 | 616.28 | 606.06 | 614.48 | 21628200 | 614.48    |
| 2012-03-26 | 599.79 | 607.15 | 595.26 | 606.98 | 21259900 | 606.98    |
| …          | …      | …      | …      | …      | …        | …         |
| 1984-09-13 | 27.5   | 27.62  | 27.5   | 27.5   | 7429600  | 3.14      |
| 1984-09-12 | 26.87  | 27.0   | 26.12  | 26.12  | 4773600  | 2.98      |
| 1984-09-11 | 26.62  | 27.37  | 26.62  | 26.87  | 5444000  | 3.07      |
| 1984-09-10 | 26.5   | 26.62  | 25.87  | 26.37  | 2346400  | 3.01      |
| 1984-09-07 | 26.5   | 26.87  | 26.25  | 26.5   | 2981600  | 3.02      |

Lets also say that you wanted to create a new column called *sum_OHLC* adds the values in every row for *Open*, *High*, *Low*, *Close* columns. Most amateur Polars users would write the following code:

``` python
(apple_stock
 .with_columns(sum_OHLC=pl.col('Open') + pl.col('High') + pl.col('Low') + pl.col('Close'))
 )
```

The way to write the above code like a pro is using `sum_horizontal` like this:

``` python
(apple_stock
 .with_columns(sum_OHLC=pl.sum_horizontal('Open', 'High', 'Low', 'Close'))
 )
```

shape: (6_953, 8)

| Date       | Open   | High   | Low    | Close  | Volume   | Adj Close | sum_OHLC |
|------------|--------|--------|--------|--------|----------|-----------|----------|
| date       | f64    | f64    | f64    | f64    | i64      | f64       | f64      |
| 2012-03-30 | 608.77 | 610.56 | 597.94 | 599.55 | 26050900 | 599.55    | 2416.82  |
| 2012-03-29 | 612.78 | 616.56 | 607.23 | 609.86 | 21668300 | 609.86    | 2446.43  |
| 2012-03-28 | 618.38 | 621.45 | 610.31 | 617.62 | 23385200 | 617.62    | 2467.76  |
| 2012-03-27 | 606.18 | 616.28 | 606.06 | 614.48 | 21628200 | 614.48    | 2443.0   |
| 2012-03-26 | 599.79 | 607.15 | 595.26 | 606.98 | 21259900 | 606.98    | 2409.18  |
| …          | …      | …      | …      | …      | …        | …         | …        |
| 1984-09-13 | 27.5   | 27.62  | 27.5   | 27.5   | 7429600  | 3.14      | 110.12   |
| 1984-09-12 | 26.87  | 27.0   | 26.12  | 26.12  | 4773600  | 2.98      | 106.11   |
| 1984-09-11 | 26.62  | 27.37  | 26.62  | 26.87  | 5444000  | 3.07      | 107.48   |
| 1984-09-10 | 26.5   | 26.62  | 25.87  | 26.37  | 2346400  | 3.01      | 105.36   |
| 1984-09-07 | 26.5   | 26.87  | 26.25  | 26.5   | 2981600  | 3.02      | 106.12   |

You not only write shorter code with `sum_horizontal` but you can also use other variations of it like `mean_horizontal` to get the average values of the four numbers and `min_horizontal` to get the smallest number.

## 3. Group by dynamic

When working with timeseries data, you may need to resample it based on specific time intervals and perform aggregations. Polars provides a convenient function, `group_by_dynamic`, to handle such tasks efficiently. For example, if you want to calculate the average *Close* values for Apple stock for each quarter, you can do it as follows:

``` python
(apple_stock
 .sort('Date')
 .group_by_dynamic('Date', every='1q')
 .agg(pl.mean('Close'))
 )
```

shape: (111, 2)

| Date       | Close      |
|------------|------------|
| date       | f64        |
| 1984-07-01 | 26.73875   |
| 1984-10-01 | 25.288594  |
| 1985-01-01 | 26.690968  |
| 1985-04-01 | 19.212063  |
| 1985-07-01 | 16.015937  |
| …          | …          |
| 2011-01-01 | 345.683226 |
| 2011-04-01 | 337.612381 |
| 2011-07-01 | 380.510312 |
| 2011-10-01 | 391.658571 |
| 2012-01-01 | 503.679839 |

> **NOTE:**
>
> Before using `group_by_dynamic` you must sort the the data on the *Date* column.\
> Even though my data was already sorted, I still used `sort` to make that explicit.

The beauty of `group_by_dynamic` is that it can handle highly granular time intervals. Using the `every` parameter, you can specify intervals such as `"17d"` to resample every 17 days, `"2w"` for 2 weeks, or even `"3s"` for 3-second intervals if your date values include seconds.

## 4. Exclude

In most cases, you won’t want to display all the columns in your final dataframe—just the ones you’re interested in. To achieve this, you need to remove the unnecessary columns. Many beginners might choose to drop the columns they don’t need, but I strongly recommend using `exclude` instead.

What’s the difference between excluding columns and dropping them? Dropping a column requires loading it into memory first, which can be time-consuming, especially with large datasets. On the other hand, excluding a column tells Polars’ query engine to skip loading it entirely. This approach is much faster, as Polars only loads the columns you actually need.

Here’s how you can use `exclude`. Suppose you don’t want to load the *Volume* and *Adj Close* columns from the Apple stock dataset. One option is to explicitly select the columns you want to keep, but that would require typing out the names of all five desired columns. Instead, you can use `exclude` to specify just the two columns you don’t want displayed, saving both time and effort.

shape: (6_953, 5)

| Date         | Open   | High   | Low    | Close  |
|--------------|--------|--------|--------|--------|
| str          | f64    | f64    | f64    | f64    |
| "2012-03-30" | 608.77 | 610.56 | 597.94 | 599.55 |
| "2012-03-29" | 612.78 | 616.56 | 607.23 | 609.86 |
| "2012-03-28" | 618.38 | 621.45 | 610.31 | 617.62 |
| "2012-03-27" | 606.18 | 616.28 | 606.06 | 614.48 |
| "2012-03-26" | 599.79 | 607.15 | 595.26 | 606.98 |
| …            | …      | …      | …      | …      |
| "1984-09-13" | 27.5   | 27.62  | 27.5   | 27.5   |
| "1984-09-12" | 26.87  | 27.0   | 26.12  | 26.12  |
| "1984-09-11" | 26.62  | 27.37  | 26.62  | 26.87  |
| "1984-09-10" | 26.5   | 26.62  | 25.87  | 26.37  |
| "1984-09-07" | 26.5   | 26.87  | 26.25  | 26.5   |

Now I’ve loaded into memory only the columns I’m interested in.

## 5. Explode

Imagine you have a dataframe that tracks your weekly grocery purchases, with items listed as comma-separated strings in a single row. If you want to identify the items you buy most frequently, this format poses a challenge. Since Polars is a columnar-based framework, working with such data in its current form can make achieving this goal a bit tricky.

``` python
groceries
```

shape: (4, 2)

| Date       | Groceries                        |
|------------|----------------------------------|
| date       | str                              |
| 2024-12-02 | "Milk, Eggs, Corn Flakes, Bacon… |
| 2024-12-09 | "Bread, Butter, Apples, Oranges… |
| 2024-12-16 | "Rice, Beans, Chicken, Shampoo,… |
| 2024-12-23 | "Milk, Eggs, Bananas, Yogurt, S… |

This is where `explode` comes in. We’ll create a new column *Item* that will contain a single item as a value for each row. Here’s how it works. First we split the data on `", "` (comma and space) to convert the string value in *Groceries* into a list.

``` python
(groceries
 .with_columns(pl.col('Groceries').str.split(', '))
 )
```

shape: (4, 2)

| Date       | Groceries                        |
|------------|----------------------------------|
| date       | list\[str\]                      |
| 2024-12-02 | \["Milk", "Eggs", … "Bread"\]    |
| 2024-12-09 | \["Bread", "Butter", … "Bacon"\] |
| 2024-12-16 | \["Rice", "Beans", … "Bacon"\]   |
| 2024-12-23 | \["Milk", "Eggs", … "Bread"\]    |

Then we’ll explode the items in each list into individual items by exploding the *Groceries* column.

This new format makes it easier to determine the most bought items by counting how many times each item appears in *Groceries*.

``` python
(groceries
 .with_columns(pl.col('Groceries').str.split(', '))
 .explode('Groceries')
 )
```

shape: (27, 2)

| Date       | Groceries     |
|------------|---------------|
| date       | str           |
| 2024-12-02 | "Milk"        |
| 2024-12-02 | "Eggs"        |
| 2024-12-02 | "Corn Flakes" |
| 2024-12-02 | "Bacon"       |
| 2024-12-02 | "Toothpaste"  |
| …          | …             |
| 2024-12-23 | "Yogurt"      |
| 2024-12-23 | "Soap"        |
| 2024-12-23 | "Bacon"       |
| 2024-12-23 | "Apples"      |
| 2024-12-23 | "Bread"       |

## 6. Top / Bottom K

Knowing the top 10 or 5 highest values or lowest values in your dataset is a very common operation. Polars has two handy functions that you can use to easily display that with `top_k` and `bottom_k`. If you wanted to see the top 5 counties in the USA with the highest population, you can use `top_k` see those counties.

``` python
(pl.read_csv(counties_in_the_usa)
 .select('county.name','population')
 .top_k(5, by='population')
 )
```

shape: (5, 2)

| county.name   | population |
|---------------|------------|
| str           | i64        |
| "los angeles" | 9840024    |
| "cook"        | 5197677    |
| "harris"      | 4101752    |
| "maricopa"    | 3841819    |
| "san diego"   | 3100500    |

The `top_k` function accepts two parameters: a numerical value specifying the number of rows to display and the column to base the sorting on. For instance, in the example above, we used it to find the top 5 largest counties by population. To find the smallest counties by population, you can simply use the `bottom_k` function instead.

## 7. Sample

We live in a world of big data and analyzing large datasets can be time-consuming. A smarter approach is to work with a subset of the data, develop and refine your analysis code through experimentation, and then apply the finalized code to the full dataset. But how can you ensure that the subset you choose represents the entire dataset well? This is where the `sample` function comes in. It allows you to randomly select a specified number of rows. Additionally, these selected rows change with each execution, ensuring a different selection every time you run the code.

The US counties dataset contains over three thousand rows, but we’re going to use `sample` to only select a thousand rows.

``` python
(pl.read_csv(counties_in_the_usa)
 .sample(1000)
 )
```

shape: (1_000, 7)

| region | population | county.fips.character | county.name | state.name | state.fips.character | state.abb |
|----|----|----|----|----|----|----|
| i64 | i64 | i64 | str | str | i64 | str |
| 27029 | 8672 | 27029 | "clearwater" | "minnesota" | 27 | "MN" |
| 36069 | 107728 | 36069 | "ontario" | "new york" | 36 | "NY" |
| 26069 | 25880 | 26069 | "iosco" | "michigan" | 26 | "MI" |
| 26107 | 42947 | 26107 | "mecosta" | "michigan" | 26 | "MI" |
| 1079 | 34148 | 1079 | "lawrence" | "alabama" | 1 | "AL" |
| … | … | … | … | … | … | … |
| 55021 | 56596 | 55021 | "columbia" | "wisconsin" | 55 | "WI" |
| 35019 | 4655 | 35019 | "guadalupe" | "new mexico" | 35 | "NM" |
| 48127 | 10054 | 48127 | "dimmit" | "texas" | 48 | "TX" |
| 54061 | 96417 | 54061 | "monongalia" | "west virginia" | 54 | "WV" |
| 55079 | 946584 | 55079 | "milwaukee" | "wisconsin" | 55 | "WI" |

The `sample` function lets you specify the number of rows you want to display as a numerical value. In our case, we are displaying 1000 rows.

## 8. Concat str

This is short for “concatenate string” and it allows you to create a single value which is a mixture of values from 2 or more columns that contain string values. Suppose we wanted to have a column *NameAbbr* that contains the state name and the abbreviation for that state, we can do it by using `concat_str`.

``` python
(pl.read_csv(counties_in_the_usa)
 .select('state.name','state.abb')
 .with_columns(pl.concat_str(['state.name','state.abb'],
                             separator=', '
                             ).alias('NameAbbr'))
 )
```

shape: (3_143, 3)

| state.name | state.abb | NameAbbr      |
|------------|-----------|---------------|
| str        | str       | str           |
| "alabama"  | "AL"      | "alabama, AL" |
| "alabama"  | "AL"      | "alabama, AL" |
| "alabama"  | "AL"      | "alabama, AL" |
| "alabama"  | "AL"      | "alabama, AL" |
| "alabama"  | "AL"      | "alabama, AL" |
| …          | …         | …             |
| "wyoming"  | "WY"      | "wyoming, WY" |
| "wyoming"  | "WY"      | "wyoming, WY" |
| "wyoming"  | "WY"      | "wyoming, WY" |
| "wyoming"  | "WY"      | "wyoming, WY" |
| "wyoming"  | "WY"      | "wyoming, WY" |

In the `concat_str` function above, we used two parameters. The first parameter is a list of the columns whose values we want to concatenate, and the second specifies the separator to use when joining those values. In this case, we used `", "` (a comma followed by a space) to produce values like “wyoming, WY”.

## 9. Format

When presenting data to someone, especially in printed form, you may want to add extra details to make the numbers more understandable. For instance, if you’re sending the quarterly average Close values you calculated earlier to your boss in the UK and want to add a currency symbol to avoid confusion, you could use `format` to include the dollar symbol. This way, your boss will always know that your analysis was done in dollars.

``` python
(apple_stock
 .sort('Date')
 .group_by_dynamic('Date', every='1q')
 .agg(pl.mean('Close').round(2))
 .with_columns(pl.format("${}", pl.col('Close')).alias('Close'))
 )
```

shape: (111, 2)

| Date       | Close      |
|------------|------------|
| date       | str        |
| 1984-07-01 | "\$26.74"  |
| 1984-10-01 | "\$25.29"  |
| 1985-01-01 | "\$26.69"  |
| 1985-04-01 | "\$19.21"  |
| 1985-07-01 | "\$16.02"  |
| …          | …          |
| 2011-01-01 | "\$345.68" |
| 2011-04-01 | "\$337.61" |
| 2011-07-01 | "\$380.51" |
| 2011-10-01 | "\$391.66" |
| 2012-01-01 | "\$503.68" |

> **NOTE:**
>
> I’ve used `round` before applying the currency formatting to ensure the figures are rounded to 2 decimal places.

## 10. Config

The default way of displaying polars dataframes is good, but sometimes you may want to change it up a bit like increase the number of rows displayed or increasing the size of a row to see all the values in that row. The function `Config` allows you to do just that. Below is the dataframe of groceries. Currently we cannot see all the values contained in each row as indicated by the ellipsis (…).

``` python
groceries
```

shape: (4, 2)

| Date       | Groceries                        |
|------------|----------------------------------|
| date       | str                              |
| 2024-12-02 | "Milk, Eggs, Corn Flakes, Bacon… |
| 2024-12-09 | "Bread, Butter, Apples, Oranges… |
| 2024-12-16 | "Rice, Beans, Chicken, Shampoo,… |
| 2024-12-23 | "Milk, Eggs, Bananas, Yogurt, S… |

Now Let’s use `Config` to increase the size of *Groceries*.

``` python
pl.Config(set_fmt_str_lengths=100)

groceries
```

shape: (4, 2)

| Date       | Groceries                                                 |
|------------|-----------------------------------------------------------|
| date       | str                                                       |
| 2024-12-02 | "Milk, Eggs, Corn Flakes, Bacon, Toothpaste, Bread"       |
| 2024-12-09 | "Bread, Butter, Apples, Oranges, Cheese, Bacon"           |
| 2024-12-16 | "Rice, Beans, Chicken, Shampoo, Coffee, Eggs, Bacon"      |
| 2024-12-23 | "Milk, Eggs, Bananas, Yogurt, Soap, Bacon, Apples, Bread" |

The example above demonstrates a global setting, meaning that the next time a dataframe is displayed, it will apply this size to any column whose values don’t fit within the default size. This can be frustrating, especially when working with multiple dataframes. To avoid this, you can apply the `Config` setting to display only one dataframe with the desired settings.

Let’s display a dataframe showing the county name and population. I’ll remove the data types from the columns and add commas as thousand separators to make the population figures easier to read. Additionally, I’ll increase the number of rows displayed to 20. Here’s how the dataframe initially looks.

``` python
usa_counties = (pl.read_csv(counties_in_the_usa)
 .select('county.name','population')
 )
usa_counties
```

shape: (3_143, 2)

| county.name  | population |
|--------------|------------|
| str          | i64        |
| "autauga"    | 54590      |
| "baldwin"    | 183226     |
| "barbour"    | 27469      |
| "bibb"       | 22769      |
| "blount"     | 57466      |
| …            | …          |
| "sweetwater" | 43890      |
| "teton"      | 21326      |
| "uinta"      | 20942      |
| "washakie"   | 8425       |
| "weston"     | 7152       |

And here’s the display with the formatting in place.

``` python
with pl.Config(set_tbl_rows=20,
               set_tbl_hide_column_data_types=True,
               set_thousands_separator=True
               ):
    display(usa_counties)
```

shape: (3_143, 2)

| county.name  | population |
|--------------|------------|
| "autauga"    | 54,590     |
| "baldwin"    | 183,226    |
| "barbour"    | 27,469     |
| "bibb"       | 22,769     |
| "blount"     | 57,466     |
| "bullock"    | 10,779     |
| "butler"     | 20,730     |
| "calhoun"    | 117,834    |
| "chambers"   | 34,228     |
| "cherokee"   | 25,917     |
| …            | …          |
| "niobrara"   | 2,478      |
| "park"       | 28,203     |
| "platte"     | 8,677      |
| "sheridan"   | 29,097     |
| "sublette"   | 10,065     |
| "sweetwater" | 43,890     |
| "teton"      | 21,326     |
| "uinta"      | 20,942     |
| "washakie"   | 8,425      |
| "weston"     | 7,152      |

> **NOTE:**
>
> The settings applied by `Config` are only for display purposes. When you export the data to Excel or another format, these configurations, such as comma separators in numbers, will be lost.

Check out this [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn this powerful Python library for data analysis.
