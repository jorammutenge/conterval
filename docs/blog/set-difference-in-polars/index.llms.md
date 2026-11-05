# Performing set difference in polars

anti join

100DaysOfPolars

Author

Joram Mutenge

Published

2025-11-20

Polars provides a special type of join that lets you retrieve items in dataframe 1 that do not have a match in dataframe 2. This works like set difference in mathematics.

\\ \text{set A} - \text{set B} \\

Below are two dataframes to be joined.

**df1**

shape: (7, 1)

| All_Students |
|--------------|
| str          |
| "Serena"     |
| "Dan"        |
| "Blair"      |
| "Chuck"      |
| "Nate"       |
| "Jenny"      |
| "Raina"      |

**df2**

shape: (4, 1)

| Passed_Exam |
|-------------|
| str         |
| "Dan"       |
| "Raina"     |
| "Blair"     |
| "Jenny"     |

## Get students who failed the exam

To retrieve the names of students who failed the exam from the complete list of students, use the Polars `join` method as follows.

``` python
(df1
 .join(df2, left_on='All_Students', right_on='Passed_Exam', how='anti')
)
```

shape: (3, 1)

| All_Students |
|--------------|
| str          |
| "Serena"     |
| "Chuck"      |
| "Nate"       |

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn advanced topics.
