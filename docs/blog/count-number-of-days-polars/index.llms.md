# Count number of days between dates in polars

total_days

100DaysOfPolars

Author

Joram Mutenge

Published

2025-11-12

Counting the number of days between dates is a common calculation in data analysis. Below is a dataframe showing start and end dates.

shape: (3, 2)

| Start_Date | End_Date   |
|------------|------------|
| date       | date       |
| 2022-06-05 | 2025-04-04 |
| 2019-03-18 | 2023-11-11 |
| 1999-12-12 | 2009-08-14 |

## Get total days between dates

To get the total number of days between dates in polars, use the date component `total_days` like this:

``` python
(df
 .with_columns(Total_Days=(pl.col('End_Date') - pl.col('Start_Date')).dt.total_days())
 )
```

shape: (3, 3)

| Start_Date | End_Date   | Total_Days |
|------------|------------|------------|
| date       | date       | i64        |
| 2022-06-05 | 2025-04-04 | 1034       |
| 2019-03-18 | 2023-11-11 | 1699       |
| 1999-12-12 | 2009-08-14 | 3533       |

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more.
