# Filter rows in polars dataframe

filter

100DaysOfPolars

Author

Joram Mutenge

Published

2025-12-15

If you are analyzing data with Polars, it is almost impossible to complete an analysis without filtering. Data analysis usually involves selecting some rows from a dataframe while excluding others. Below is a dataframe of students and their grades.

shape: (6, 2)

| Student   | Grade |
|-----------|-------|
| str       | i64   |
| "Spencer" | 93    |
| "Emily"   | 88    |
| "Hannah"  | 73    |
| "Aria"    | 69    |
| "Mona"    | 55    |
| "Paige"   | 89    |

## Filter for some row

To get the row showing the student with the highest grade, you can use the `filter` method together with the `max` function, as shown below:

``` python
(df
 .filter(pl.col('Grade') == pl.max('Grade'))
 )
```

shape: (1, 2)

| Student   | Grade |
|-----------|-------|
| str       | i64   |
| "Spencer" | 93    |

You can also use `filter` to get the opposite of a specified value by using the “not equal to” operator (`!=`):

``` python
(df
 .filter(pl.col('Grade') != pl.max('Grade'))
 )
```

shape: (5, 2)

| Student  | Grade |
|----------|-------|
| str      | i64   |
| "Emily"  | 88    |
| "Hannah" | 73    |
| "Aria"   | 69    |
| "Mona"   | 55    |
| "Paige"  | 89    |

You can achieve the same result as in the previous example by using the negation symbol `~`:

``` python
(df
 .filter(~(pl.col('Grade') == pl.max('Grade')))
 )
```

shape: (5, 2)

| Student  | Grade |
|----------|-------|
| str      | i64   |
| "Emily"  | 88    |
| "Hannah" | 73    |
| "Aria"   | 69    |
| "Mona"   | 55    |
| "Paige"  | 89    |

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more clever ways to analyze your data.
