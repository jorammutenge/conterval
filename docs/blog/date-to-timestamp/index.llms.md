# From date to timestamp in milliseconds

dt.timestamp

100DaysOfPolars

Author

Joram Mutenge

Published

2025-11-17

Sometimes you may want the date value in your dataframe to display as a timestamp. This is useful when you need to hide the date of birth (DOB) of people in your dataset while presenting the data. Below is a dataframe showing the DOB of yours truly.

shape: (1, 2)

| Name            | DOB        |
|-----------------|------------|
| str             | date       |
| "Joram Mutenge" | 2020-07-13 |

## Convert date to timestamp

To convert a date to a timestamp, use the date component `timestamp` as shown below:

``` python
(df
 .with_columns(DOB_ms=pl.col('DOB').dt.timestamp('ms'))
 )
```

shape: (1, 3)

| Name            | DOB        | DOB_ms        |
|-----------------|------------|---------------|
| str             | date       | i64           |
| "Joram Mutenge" | 2020-07-13 | 1594598400000 |

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) for more insights.
