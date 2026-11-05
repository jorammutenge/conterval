# Get the index of unique values in a polars dataframe

arg_unique

100DaysOfPolars

Author

Joram Mutenge

Published

2025-11-19

You have a table with repeating names, and you want to get the index where each unique name appears. Below is a dataframe showing students and their grades on various tests.

shape: (20, 2)

| Student   | Grade |
|-----------|-------|
| str       | i64   |
| "Spencer" | 93    |
| "Spencer" | 88    |
| "Emily"   | 73    |
| "Emily"   | 69    |
| "Hannah"  | 55    |
| …         | …     |
| "Hannah"  | 89    |
| "Aria"    | 92    |
| "Aria"    | 81    |
| "Mona"    | 97    |
| "Paige"   | 71    |

## Index where each unique value first appears

To get the index location where each unique name in the dataframe first appears, use the Polars expression `arg_unique` like this:

``` python
(df
 .select(pl.col('Student').arg_unique())
 )
```

shape: (6, 1)

| Student |
|---------|
| u32     |
| 0       |
| 2       |
| 4       |
| 6       |
| 8       |
| 9       |

I want you to enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) so you can learn more.
