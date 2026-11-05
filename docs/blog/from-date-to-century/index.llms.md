# From date to century in polars

dt.century

100DaysOfPolars

Author

Joram Mutenge

Published

2025-11-23

You are querying a historical database that contains dates, and you want to create another column that indicates the century for each date. The dataframe below shows a set of example dates.

shape: (4, 1)

| Date       |
|------------|
| date       |
| 0999-12-31 |
| 1897-05-07 |
| 1945-01-01 |
| 2025-01-01 |

## Extract century from date

To extract the century from a date value, use the Polars expression `dt.century` like this:

``` python
(df
 .with_columns(Century=pl.col('Date').dt.century())
 )
```

shape: (4, 2)

| Date       | Century |
|------------|---------|
| date       | i32     |
| 0999-12-31 | 10      |
| 1897-05-07 | 19      |
| 1945-01-01 | 20      |
| 2025-01-01 | 21      |

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more.
