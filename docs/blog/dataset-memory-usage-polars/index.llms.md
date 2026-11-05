# Checking dataset memory usage in polars

estimated_size

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-29

It’s important to know how much memory the dataset you’re processing is consuming on your machine. Why? Because lower memory consumption leads to faster processing. Fortunately, there are ways to reduce that memory usage. In Polars, you can check memory usage using the `estimated_size` method. Below is a dataframe from a clothing store showing customer purchase details.

shape: (1_000, 6)

| company | sku | category | quantity | price | ext price |
|----|----|----|----|----|----|
| str | str | str | i64 | f64 | f64 |
| "Fritsch-Glover" | "HX-24728" | "Hat" | 1 | 98.98 | 98.98 |
| "O'Conner Inc" | "LK-02338" | "Sweater" | 9 | 34.8 | 313.2 |
| "Beatty and Sons" | "ZC-07383" | "Sweater" | 12 | 60.24 | 722.88 |
| "Gleason, Bogisich and Franecki" | "QS-76400" | "Sweater" | 5 | 15.25 | 76.25 |
| "Morissette-Heathcote" | "RU-25060" | "Sweater" | 19 | 51.83 | 984.77 |
| … | … | … | … | … | … |
| "Brekke and Sons" | "FT-50146" | "Sweater" | 2 | 46.48 | 92.96 |
| "Lang-Wunsch" | "IC-59308" | "Socks" | 19 | 29.25 | 555.75 |
| "Bogisich and Sons" | "IC-59308" | "Socks" | 18 | 54.79 | 986.22 |
| "Kutch, Cormier and Harber" | "RU-25060" | "Sweater" | 15 | 62.53 | 937.95 |
| "Roberts, Volkman and Batz" | "LK-02338" | "Sweater" | 11 | 86.4 | 950.4 |

## Check memory usage

Here’s how to check how much memory, in kilobytes (KB), this dataset is using on your machine.

``` python
initial_usage = df.estimated_size('kb')
initial_usage
```

    54.2451171875

> **TIP:**
>
> To check memory usage in megabytes, replace `kb` with `mb`.

## Techniques to reduce memory usage

You can reduce the memory usage of the dataframe by changing the data types of some columns. For instance, you can change numerical columns from `Int64` (which is unnecessarily large) to `Int32`, as long as the maximum value in that column does not exceed the maximum value that `Int32` can hold. But how do you determine the maximum or minimum values allowed for each data type? This is where NumPy comes into the picture.

### Change data types of numerical columns

First, check the summary statistics of the numerical columns to see their maximum and minimum values.

``` python
import polars.selectors as cs

(df
 .select(cs.numeric())
 .describe()
 )
```

shape: (9, 4)

| statistic    | quantity | price     | ext price  |
|--------------|----------|-----------|------------|
| str          | f64      | f64       | f64        |
| "count"      | 1000.0   | 1000.0    | 1000.0     |
| "null_count" | 0.0      | 0.0       | 0.0        |
| "mean"       | 10.565   | 54.06643  | 570.17994  |
| "std"        | 5.887311 | 26.068011 | 443.949007 |
| "min"        | 1.0      | 10.01     | 11.13      |
| "25%"        | 5.0      | 31.25     | 204.0      |
| "50%"        | 11.0     | 53.27     | 456.64     |
| "75%"        | 16.0     | 75.1      | 848.55     |
| "max"        | 20.0     | 100.0     | 1958.6     |

Now, let’s see the minimum and maximum values accepted by `Int64` and `Int8` data types.

``` python
import numpy as np

print(f'{np.iinfo(np.int64)}\n\n{np.iinfo(np.int8)}')
```

    Machine parameters for int64
    ---------------------------------------------------------------
    min = -9223372036854775808
    max = 9223372036854775807
    ---------------------------------------------------------------


    Machine parameters for int8
    ---------------------------------------------------------------
    min = -128
    max = 127
    ---------------------------------------------------------------

Starting with the *quantity* column, you’ll see that the maximum value is within the bounds of the `Int8` data type. Therefore, we can convert the data type for *quantity* from `Int64` to `Int8`.

Let’s apply the same technique to columns with floating-point data types. Again, we’ll use NumPy to determine the appropriate bounds for these data types.

``` python
print(f'{np.finfo(np.float64)}\n\n{np.finfo(np.float32)}')
```

    Machine parameters for float64
    ---------------------------------------------------------------
    precision = 15   resolution = 1e-15
    machep = -52   eps =        2.220446049250313e-16
    negep =  -53   epsneg =     1.1102230246251565e-16
    minexp = -1022   tiny =       2.2250738585072014e-308
    maxexp = 1024   max =        1.7976931348623157e+308
    nexp =   11   min =        -max
    smallest_normal = 2.2250738585072014e-308   smallest_subnormal = 5e-324
    ---------------------------------------------------------------


    Machine parameters for float32
    ---------------------------------------------------------------
    precision = 6   resolution = 1e-06
    machep = -23   eps =        1.1920929e-07
    negep =  -24   epsneg =     5.9604645e-08
    minexp = -126   tiny =       1.1754944e-38
    maxexp = 128   max =        3.4028235e+38
    nexp =   8   min =        -max
    smallest_normal = 1.1754944e-38   smallest_subnormal = 1e-45
    ---------------------------------------------------------------

From the summary statistics table, you can see that the `Float64` data type for the *price* and *ext price* columns is overkill. So, we can safely convert their data type to `Float32`, which is the lowest float type in Polars.

``` python
(df
 .with_columns(pl.col('quantity').cast(pl.Int8),
               pl.col(pl.Float64).cast(pl.Float32))
 )
```

shape: (1_000, 6)

| company | sku | category | quantity | price | ext price |
|----|----|----|----|----|----|
| str | str | str | i8 | f32 | f32 |
| "Fritsch-Glover" | "HX-24728" | "Hat" | 1 | 98.980003 | 98.980003 |
| "O'Conner Inc" | "LK-02338" | "Sweater" | 9 | 34.799999 | 313.200012 |
| "Beatty and Sons" | "ZC-07383" | "Sweater" | 12 | 60.240002 | 722.880005 |
| "Gleason, Bogisich and Franecki" | "QS-76400" | "Sweater" | 5 | 15.25 | 76.25 |
| "Morissette-Heathcote" | "RU-25060" | "Sweater" | 19 | 51.830002 | 984.77002 |
| … | … | … | … | … | … |
| "Brekke and Sons" | "FT-50146" | "Sweater" | 2 | 46.48 | 92.959999 |
| "Lang-Wunsch" | "IC-59308" | "Socks" | 19 | 29.25 | 555.75 |
| "Bogisich and Sons" | "IC-59308" | "Socks" | 18 | 54.790001 | 986.219971 |
| "Kutch, Cormier and Harber" | "RU-25060" | "Sweater" | 15 | 62.529999 | 937.950012 |
| "Roberts, Volkman and Batz" | "LK-02338" | "Sweater" | 11 | 86.400002 | 950.400024 |

### Change data types of text columns

For text columns, you can reduce memory usage by converting them to categorical data types. I recommend applying this conversion only to columns with low cardinality (a small number of unique values).

Let’s check the number of unique values in each of the text columns.

``` python
(df
 .select(~cs.numeric())
 .select(pl.all().n_unique())
 )
```

shape: (1, 3)

| company | sku | category |
|---------|-----|----------|
| u32     | u32 | u32      |
| 718     | 10  | 3        |

We can convert the *sku* and *category* columns to categorical because they have low cardinality.

``` python
(df
 .with_columns(pl.col(pl.Float64).cast(pl.Float32),
               pl.col('quantity').cast(pl.Int8),
               pl.col('sku','category').cast(pl.Categorical))
 )
```

shape: (1_000, 6)

| company | sku | category | quantity | price | ext price |
|----|----|----|----|----|----|
| str | cat | cat | i8 | f32 | f32 |
| "Fritsch-Glover" | "HX-24728" | "Hat" | 1 | 98.980003 | 98.980003 |
| "O'Conner Inc" | "LK-02338" | "Sweater" | 9 | 34.799999 | 313.200012 |
| "Beatty and Sons" | "ZC-07383" | "Sweater" | 12 | 60.240002 | 722.880005 |
| "Gleason, Bogisich and Franecki" | "QS-76400" | "Sweater" | 5 | 15.25 | 76.25 |
| "Morissette-Heathcote" | "RU-25060" | "Sweater" | 19 | 51.830002 | 984.77002 |
| … | … | … | … | … | … |
| "Brekke and Sons" | "FT-50146" | "Sweater" | 2 | 46.48 | 92.959999 |
| "Lang-Wunsch" | "IC-59308" | "Socks" | 19 | 29.25 | 555.75 |
| "Bogisich and Sons" | "IC-59308" | "Socks" | 18 | 54.790001 | 986.219971 |
| "Kutch, Cormier and Harber" | "RU-25060" | "Sweater" | 15 | 62.529999 | 937.950012 |
| "Roberts, Volkman and Batz" | "LK-02338" | "Sweater" | 11 | 86.400002 | 950.400024 |

## Memory usage after

Let’s now check the memory usage of the dataset after making these data type changes.

``` python
new_usage = (df
 .with_columns(pl.col(pl.Float64).cast(pl.Float32),
               pl.col('quantity').cast(pl.Int8),
               pl.col('sku','category').cast(pl.Categorical))
 .estimated_size('kb')
 )
new_usage
```

    34.0322265625

Now we have the same dataset using less memory. In fact, that’s a 37.26 percent reduction.

My [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) is now open for enrollment, if you want to learn more!
