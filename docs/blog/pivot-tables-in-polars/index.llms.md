# Create pivot tables in polars

pivot

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-25

Excel is known for pivot tables, but did you know that you can create pivot tables in polars too? That’s how versatile polars is. Below is a dataframe of students and their scores on different exams.

shape: (16, 3)

| Student   | Exam       | Grade |
|-----------|------------|-------|
| str       | str        | i64   |
| "Spencer" | "Mid-term" | 93    |
| "Spencer" | "Final"    | 88    |
| "Emily"   | "Mid-term" | 73    |
| "Emily"   | "Final"    | 69    |
| "Hannah"  | "Mid-term" | 55    |
| …         | …          | …     |
| "Emily"   | "Final"    | 69    |
| "Hannah"  | "Mid-term" | 55    |
| "Hannah"  | "Final"    | 89    |
| "Aria"    | "Mid-term" | 92    |
| "Aria"    | "Final"    | 81    |

## Pivot the dataframe

Right now, the dataframe is in long format, and you can see student names repeating. You can pivot the dataframe so that each student’s name appears only once, with the exam types as column names. Here’s how to do it:

``` python
(df
 .pivot(index='Student',
        on='Exam',
        values='Grade',
        aggregate_function='mean')
 )
```

shape: (4, 3)

| Student   | Mid-term | Final |
|-----------|----------|-------|
| str       | f64      | f64   |
| "Spencer" | 93.0     | 88.0  |
| "Emily"   | 73.0     | 69.0  |
| "Hannah"  | 55.0     | 89.0  |
| "Aria"    | 92.0     | 81.0  |

I used average (mean) in the code above, but you can also use other statistical measures like max, min, std, etc.

Enroll in my newly updated [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
