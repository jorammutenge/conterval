# Use clip to set upper and lower bound values in polars

clip

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-06

Imagine you’re a teacher who isn’t satisfied with the range of grades your students received on what you thought was a fairly easy math test. You want to set the lowest possible grade to 60 and the highest to 90. How can you do that?

Below is a dataframe showing the students and their grades on the math test.

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

## Set boundaries where grades should be

To ensure that all grades fall within the 60 to 90 range, use the Polars expression `clip` as shown below:

``` python
(df
 .with_columns(pl.col('Grade').clip(60,90))
 )
```

shape: (6, 2)

| Student   | Grade |
|-----------|-------|
| str       | i64   |
| "Spencer" | 90    |
| "Emily"   | 88    |
| "Hannah"  | 73    |
| "Aria"    | 69    |
| "Mona"    | 60    |
| "Paige"   | 89    |

Now none of the values in *Grade* are above 90 or below 60. You’ve successfully clipped the values!

Hey, do me a solid. Sign up for my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)
