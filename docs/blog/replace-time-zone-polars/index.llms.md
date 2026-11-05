# Replace time zone in polars dataframe

dt.replace_time_zone

100DaysOfPolars

Author

Joram Mutenge

Published

2025-12-16

If you are working remotely and your team spans multiple time zones, it is important to ensure that the data you are analyzing matches the time zone in which it originated. For example, if you are in Chicago and a client in New York sends you a dataset to analyze, loading the dataset may display timestamps in your local time zone.

shape: (4, 1)

| Chicago_Time                    |
|---------------------------------|
| datetime\[ms, America/Chicago\] |
| 2023-12-31 18:00:00 CST         |
| 2024-01-01 19:00:00 CST         |
| 2024-01-02 20:00:00 CST         |
| 2024-01-03 21:00:00 CST         |

## Replace the time zone

To replace your local time zone with the time zone of the location where the data originated, you can use the date component `replace_time_zone`, as shown below:

``` python
(df
 .with_columns(pl.col('Chicago_Time').dt.replace_time_zone('America/New_York')
               .alias('New_York_Time'))
 )
```

shape: (4, 2)

| Chicago_Time                    | New_York_Time                    |
|---------------------------------|----------------------------------|
| datetime\[ms, America/Chicago\] | datetime\[ms, America/New_York\] |
| 2023-12-31 18:00:00 CST         | 2023-12-31 18:00:00 EST          |
| 2024-01-01 19:00:00 CST         | 2024-01-01 19:00:00 EST          |
| 2024-01-02 20:00:00 CST         | 2024-01-02 20:00:00 EST          |
| 2024-01-03 21:00:00 CST         | 2024-01-03 21:00:00 EST          |

The time zone is now changed from Chicago time to New York time.

Learn more ways to analyze data in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
