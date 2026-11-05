# Adding values across multiple columns in polars

sum_horizontal

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-11

Most dataframe libraries are excellent at performing columnar operations, such as adding or multiplying values within a single column. However, there are times when you may want to perform such operations across multiple columns. Below is a dataframe of Apple stock values.

shape: (4, 5)

| Date         | Open       | High       | Low        | Close      |
|--------------|------------|------------|------------|------------|
| str          | f64        | f64        | f64        | f64        |
| "2024-08-12" | 216.070007 | 219.509995 | 215.600006 | 217.529999 |
| "2024-08-13" | 219.009995 | 221.889999 | 219.009995 | 221.270004 |
| "2024-08-14" | 220.570007 | 223.029999 | 219.699997 | 221.720001 |
| "2024-08-15" | 224.600006 | 225.350006 | 222.759995 | 224.720001 |

\
Say we want to create another column called *Sum_OHLC* that adds the values from the *Open* to *Close* columns.

## The manual way

Here’s the manual approach to add the values across columns:

``` python
(df
 .with_columns((pl.col('Open') + pl.col('High') + pl.col('Low') + pl.col('Close'))
               .alias('Sum_OHLC'))
 )
```

shape: (4, 6)

| Date         | Open       | High       | Low        | Close      | Sum_OHLC   |
|--------------|------------|------------|------------|------------|------------|
| str          | f64        | f64        | f64        | f64        | f64        |
| "2024-08-12" | 216.070007 | 219.509995 | 215.600006 | 217.529999 | 868.710007 |
| "2024-08-13" | 219.009995 | 221.889999 | 219.009995 | 221.270004 | 881.179993 |
| "2024-08-14" | 220.570007 | 223.029999 | 219.699997 | 221.720001 | 885.020004 |
| "2024-08-15" | 224.600006 | 225.350006 | 222.759995 | 224.720001 | 897.430008 |

## The efficient way

And here’s the idiomatic and more efficient way to do it:

``` python
(df
 .with_columns(pl.sum_horizontal('Open', 'High', 'Low', 'Close')
               .alias('Sum_OHLC'))
 )
```

shape: (4, 6)

| Date         | Open       | High       | Low        | Close      | Sum_OHLC   |
|--------------|------------|------------|------------|------------|------------|
| str          | f64        | f64        | f64        | f64        | f64        |
| "2024-08-12" | 216.070007 | 219.509995 | 215.600006 | 217.529999 | 868.710007 |
| "2024-08-13" | 219.009995 | 221.889999 | 219.009995 | 221.270004 | 881.179993 |
| "2024-08-14" | 220.570007 | 223.029999 | 219.699997 | 221.720001 | 885.020004 |
| "2024-08-15" | 224.600006 | 225.350006 | 222.759995 | 224.720001 | 897.430008 |

## The showing off way

Or if you want to impress the hiring manager in a coding interview, you can do it like this.

``` python
(df
 .with_columns(pl.sum_horizontal(pl.nth(list(range(1,5))))
               .alias('Sum_OHLC'))
 )
```

shape: (4, 6)

| Date         | Open       | High       | Low        | Close      | Sum_OHLC   |
|--------------|------------|------------|------------|------------|------------|
| str          | f64        | f64        | f64        | f64        | f64        |
| "2024-08-12" | 216.070007 | 219.509995 | 215.600006 | 217.529999 | 868.710007 |
| "2024-08-13" | 219.009995 | 221.889999 | 219.009995 | 221.270004 | 881.179993 |
| "2024-08-14" | 220.570007 | 223.029999 | 219.699997 | 221.720001 | 885.020004 |
| "2024-08-15" | 224.600006 | 225.350006 | 222.759995 | 224.720001 | 897.430008 |

\
Join 100 plus students in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more.
