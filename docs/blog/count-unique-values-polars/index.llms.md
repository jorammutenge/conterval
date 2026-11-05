# Count unique values in a column in polars?

n_unique

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-01

Knowing the cardinality of columns in your table is important. What’s cardinality? It’s the number of unique values contained in a column. If a column has many unique values, like *Customer_ID*, then it has high cardinality. Fewer unique values mean low cardinality. Below is a dataframe showing student grades.

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

## Get unique values

To get the number of unique values in a column, you use the Polars method `n_unique` like this:

``` python
(df
 .n_unique('Student')
 )
```

    6

The *Student* column has 6 unique values, which means it has low cardinality.

Join 150+ students improving their skills in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
