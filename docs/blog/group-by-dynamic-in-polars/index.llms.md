# Group by on time series in polars

group_by_dynamic

100DaysOfPolars

Author

Joram Mutenge

Published

2025-12-17

Group by operations are powerful in Polars, but when working with time series data, you can make them even more effective by using `group_by_dynamic` instead of the standard `group_by`. Below is a dataframe showing power usage recorded every half hour over five days.

shape: (193, 2)

| Time                | Power_Usage |
|---------------------|-------------|
| datetime\[ms\]      | i64         |
| 2025-02-01 00:00:00 | 2           |
| 2025-02-01 00:30:00 | 1           |
| 2025-02-01 01:00:00 | 5           |
| 2025-02-01 01:30:00 | 4           |
| 2025-02-01 02:00:00 | 4           |
| …                   | …           |
| 2025-02-04 22:00:00 | 2           |
| 2025-02-04 22:30:00 | 4           |
| 2025-02-04 23:00:00 | 4           |
| 2025-02-04 23:30:00 | 2           |
| 2025-02-05 00:00:00 | 6           |

## Aggregate on time series

Unlike the standard `group_by`, which limits you to predefined datetime components such as month or year, `group_by_dynamic` allows you to aggregate data over custom durations. In this example, the data is aggregated every five and a half hours.

``` python
(df
 .sort('Time') # <1>
 .group_by_dynamic('Time', every='5h30m')
 .agg(pl.sum('Power_Usage'))
 )
```

1.  The data must be sorted before using `group_by_dynamic`, otherwise the code throws an error.

shape: (18, 2)

| Time                | Power_Usage |
|---------------------|-------------|
| datetime\[ms\]      | i64         |
| 2025-01-31 22:00:00 | 21          |
| 2025-02-01 03:30:00 | 59          |
| 2025-02-01 09:00:00 | 61          |
| 2025-02-01 14:30:00 | 50          |
| 2025-02-01 20:00:00 | 64          |
| …                   | …           |
| 2025-02-03 21:30:00 | 65          |
| 2025-02-04 03:00:00 | 60          |
| 2025-02-04 08:30:00 | 48          |
| 2025-02-04 14:00:00 | 73          |
| 2025-02-04 19:30:00 | 56          |

\

Enroll to learn more in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
