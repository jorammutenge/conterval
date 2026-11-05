# Moving rows up or down in polars

shift

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-10

When working with timeseries data, you may want to move values in a column a few rows up or down. This is particularly important when calculating moving averages, where the first rows have null values depending on the window used in your moving average calculation. The dataframe below shows a snapshot of Apple stock data in 2024.

shape: (10, 3)

| Date       | Open       | High       |
|------------|------------|------------|
| date       | f64        | f64        |
| 2024-01-02 | 187.149994 | 188.440002 |
| 2024-01-03 | 184.220001 | 185.880005 |
| 2024-01-04 | 182.149994 | 183.089996 |
| 2024-01-05 | 181.990005 | 182.759995 |
| 2024-01-08 | 182.089996 | 185.600006 |
| 2024-01-09 | 183.919998 | 185.149994 |
| 2024-01-10 | 184.350006 | 186.399994 |
| 2024-01-11 | 186.539993 | 187.050003 |
| 2024-01-12 | 186.059998 | 186.740005 |
| 2024-01-16 | 182.160004 | 184.259995 |

## Shifting rows down

Polars makes it easy to shift rows in a column up or down. Let’s create two columns based on *High*: one with 2 rows shifted up and another with 2 rows shifted down.

``` python
(df
 .with_columns(High_2rows_Up=pl.col('High').shift(-2),
               High_2rows_Down=pl.col('High').shift(2))
 )
```

shape: (10, 5)

| Date       | Open       | High       | High_2rows_Up | High_2rows_Down |
|------------|------------|------------|---------------|-----------------|
| date       | f64        | f64        | f64           | f64             |
| 2024-01-02 | 187.149994 | 188.440002 | 183.089996    | null            |
| 2024-01-03 | 184.220001 | 185.880005 | 182.759995    | null            |
| 2024-01-04 | 182.149994 | 183.089996 | 185.600006    | 188.440002      |
| 2024-01-05 | 181.990005 | 182.759995 | 185.149994    | 185.880005      |
| 2024-01-08 | 182.089996 | 185.600006 | 186.399994    | 183.089996      |
| 2024-01-09 | 183.919998 | 185.149994 | 187.050003    | 182.759995      |
| 2024-01-10 | 184.350006 | 186.399994 | 186.740005    | 185.600006      |
| 2024-01-11 | 186.539993 | 187.050003 | 184.259995    | 185.149994      |
| 2024-01-12 | 186.059998 | 186.740005 | null          | 186.399994      |
| 2024-01-16 | 182.160004 | 184.259995 | null          | 187.050003      |

## Practical application of shifting rows

You may be wondering, “What’s the use of shifting rows in a column?” Here’s a practical example. Let’s create a 3-day moving average based on *Open*.

``` python
(df
 .with_columns(MA_3days_Open=pl.col('Open').rolling_mean(window_size=3))
 .with_columns(MA_3days_Open_Shifted_Up=pl.col('MA_3days_Open').shift(-2))
 )
```

shape: (10, 5)

| Date       | Open       | High       | MA_3days_Open | MA_3days_Open_Shifted_Up |
|------------|------------|------------|---------------|--------------------------|
| date       | f64        | f64        | f64           | f64                      |
| 2024-01-02 | 187.149994 | 188.440002 | null          | 184.506663               |
| 2024-01-03 | 184.220001 | 185.880005 | null          | 182.786667               |
| 2024-01-04 | 182.149994 | 183.089996 | 184.506663    | 182.076665               |
| 2024-01-05 | 181.990005 | 182.759995 | 182.786667    | 182.666666               |
| 2024-01-08 | 182.089996 | 185.600006 | 182.076665    | 183.453333               |
| 2024-01-09 | 183.919998 | 185.149994 | 182.666666    | 184.936666               |
| 2024-01-10 | 184.350006 | 186.399994 | 183.453333    | 185.649999               |
| 2024-01-11 | 186.539993 | 187.050003 | 184.936666    | 184.919998               |
| 2024-01-12 | 186.059998 | 186.740005 | 185.649999    | null                     |
| 2024-01-16 | 182.160004 | 184.259995 | 184.919998    | null                     |

Notice that the first 2 rows in *MA_3days_Open* are null. Suppose you want to remove those null values because you plan to subtract the first 3-day moving average from the first value in *High*. This is where shifting values becomes useful. By shifting values in *MA_3days_Open* 2 rows up, the first non-null value aligns with the first value in *High*.

Now you can perform the subtraction.

## Shifting rows in all columns

It’s also possible to shift rows for all columns in the dataframe at once. Let’s shift each column 2 rows down.

``` python
df.shift(2)
```

shape: (10, 3)

| Date       | Open       | High       |
|------------|------------|------------|
| date       | f64        | f64        |
| null       | null       | null       |
| null       | null       | null       |
| 2024-01-02 | 187.149994 | 188.440002 |
| 2024-01-03 | 184.220001 | 185.880005 |
| 2024-01-04 | 182.149994 | 183.089996 |
| 2024-01-05 | 181.990005 | 182.759995 |
| 2024-01-08 | 182.089996 | 185.600006 |
| 2024-01-09 | 183.919998 | 185.149994 |
| 2024-01-10 | 184.350006 | 186.399994 |
| 2024-01-11 | 186.539993 | 187.050003 |

The first 2 rows in our original dataframe are now gone. They’ve been replaced by null.

Checkout my newly updated [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/). I included a section on **data visualization** because Polars now supports native plotting!
