# Creating a datetime column from multiple columns in polars

pl.date

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-06

When you have a column with date values, having its data type as `datetime` is beneficial because it allows you to perform time series analysis on your data. You can slice the data into months, weeks, days, etc. This is not possible when your date values are stored as a string (text) data type.

Below is a dataframe containing three columns: *Day*, *Month*, and *Year*.

shape: (4, 3)

| Day | Month | Year |
|-----|-------|------|
| i64 | i64   | i64  |
| 23  | 12    | 1997 |
| 14  | 9     | 2001 |
| 18  | 7     | 2003 |
| 15  | 10    | 1999 |

\
You now want to create a new column, *Date*, that will contain all the values from each column as a full date. Normally, to create this new column, you would have to convert the values in each column to strings and then concatenate them into a single date. Then, you would need to change the data type of that full date from text to *datetime*. Fortunately, there’s a better way.

## The better way

Polars has a handy expression, `pl.date`, that allows you to concatenate these values into a new column with a *datetime* data type. Here’s how to do it:

``` python
(df
 .with_columns(pl.date(pl.col('Year'), pl.col('Month'), pl.col('Day')))
 )
```

shape: (4, 4)

| Day | Month | Year | date       |
|-----|-------|------|------------|
| i64 | i64   | i64  | date       |
| 23  | 12    | 1997 | 1997-12-23 |
| 14  | 9     | 2001 | 2001-09-14 |
| 18  | 7     | 2003 | 2003-07-18 |
| 15  | 10    | 1999 | 1999-10-15 |

\
Notice that the new column has `date` as its data type.

Join 100+ students in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) sharpening their data analysis skills.
