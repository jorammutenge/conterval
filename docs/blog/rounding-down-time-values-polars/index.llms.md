# Rounding down time in polars

dt.truncate

100DaysOfPolars

Author

Joram Mutenge

Published

2025-12-19

Polars allows you to round down datetime values, similar to how you would round decimal values–well, almost. Below is a dataframe showing time series data.

shape: (5, 1)

| Timestamp           |
|---------------------|
| datetime\[μs\]      |
| 2023-01-01 00:00:00 |
| 2023-01-01 02:05:00 |
| 2023-01-01 04:10:00 |
| 2023-01-01 06:15:00 |
| 2023-01-01 08:20:00 |

## Round down time values

Here, we use Polars to scan a 10-minute interval of the time series and set each value to the lower bound of its interval. For example, minutes between 0 and 10 become 0, minutes between 10 and 20 become 10, and so on. Essentially, we are rounding down the values to the specified interval of 10 minutes.

``` python
(df
 .with_columns(pl.col('Timestamp').dt.truncate('10m')
               .alias('Truncated_by_10min'))
 )
```

shape: (5, 2)

| Timestamp           | Truncated_by_10min  |
|---------------------|---------------------|
| datetime\[μs\]      | datetime\[μs\]      |
| 2023-01-01 00:00:00 | 2023-01-01 00:00:00 |
| 2023-01-01 02:05:00 | 2023-01-01 02:00:00 |
| 2023-01-01 04:10:00 | 2023-01-01 04:10:00 |
| 2023-01-01 06:15:00 | 2023-01-01 06:10:00 |
| 2023-01-01 08:20:00 | 2023-01-01 08:20:00 |

Learn more in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
