# Filter data with any in polars

contains_any

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-29

You’re a teacher who has just finished grading student exams, and you want to identify the students who either got a C or a D so that you can talk to them about their poor performance. Below is a dataframe showing student grades.

shape: (4, 2)

| Pupil    | Grade |
|----------|-------|
| str      | str   |
| "Lauren" | "A+"  |
| "Larry"  | "B"   |
| "Chanda" | "B+"  |
| "Katis"  | "C"   |

## Filter data

To display the students who either got a C or a D, you use the Polars expression `contains_any` like this:

``` python
(df
 .filter(pl.col('Grade').str.contains_any(['C','D']))
 )
```

shape: (1, 2)

| Pupil   | Grade |
|---------|-------|
| str     | str   |
| "Katis" | "C"   |

Only one student matched the filter condition.

> **NOTE:**
>
> The code worked even though there was no D grade. That’s the power of `contains_any`. It works whether one or both of the specified values are present.

Interested in learning Polars? Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
