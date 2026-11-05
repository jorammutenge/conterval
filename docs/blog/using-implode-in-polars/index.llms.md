# Collect text data into a list in polars

implode

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-14

Long format data (data with many rows) is good for performing analyses but bad for presentation. If you want people to easily understand your data, you should strive to reduce the length of the dataframe. Below is a dataframe showing students and the subjects they take.

shape: (8, 2)

| Student   | Subject     |
|-----------|-------------|
| str       | str         |
| "Spencer" | "Chemistry" |
| "Spencer" | "Physics"   |
| "Emily"   | "Physics"   |
| "Emily"   | "Biology"   |
| "Hannah"  | "History"   |
| "Hannah"  | "Art"       |
| "Aria"    | "English"   |
| "Aria"    | "Biology"   |

> **NOTE:**
>
> The student’s name is repeated in each row for every subject she takes. This is what it means to have long format data.

## Show subjects in list

Instead of repeating the name of every student for each subject they take, let’s show the student’s name only once and collect the subjects she takes in a list. We can achieve this using the Polars expression `implode`, but first, we must group the data by *Student* to ensure each student appears only once.

``` python
(df
 .group_by('Student')
 .agg(pl.col('Subject').implode())
 )
```

shape: (4, 2)

| Student   | Subject                    |
|-----------|----------------------------|
| str       | list\[str\]                |
| "Emily"   | \["Physics", "Biology"\]   |
| "Aria"    | \["English", "Biology"\]   |
| "Hannah"  | \["History", "Art"\]       |
| "Spencer" | \["Chemistry", "Physics"\] |

I’d appreciate it if you checked out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
