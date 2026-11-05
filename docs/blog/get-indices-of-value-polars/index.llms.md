# Get indices for a specific value in a polars dataframe

arg_true

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-26

Sometimes you may want to get the index positions of a repeating value in a Polars dataframe. Below is a dataframe showing students and their grades.

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

## Get index of rows

To get the index positions of rows where the name “Aria” appears, use the Polars expression `arg_true` like this:

``` python
(df
 .select((pl.col('Student') == 'Aria').arg_true())
 )
```

shape: (4, 1)

| Student |
|---------|
| u32     |
| 6       |
| 7       |
| 16      |
| 17      |

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to advance your data analysis skills.
