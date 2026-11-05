# Get middle rows from a polars dataframe

slice

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-05

We all know how to get the first or last five rows of a dataset. But did you know you can also retrieve the middle rows? Below is a dataframe showing cereal brands:

shape: (77, 4)

| mfr              | type   | calories | protein |
|------------------|--------|----------|---------|
| str              | str    | i64      | i64     |
| "Nabisco"        | "Cold" | 70       | 4       |
| "Quaker Oats"    | "Cold" | 120      | 3       |
| "Kellogs"        | "Cold" | 70       | 4       |
| "Kellogs"        | "Cold" | 50       | 4       |
| "Ralston Purina" | "Cold" | 110      | 2       |
| …                | …      | …        | …       |
| "General Mills"  | "Cold" | 110      | 2       |
| "General Mills"  | "Cold" | 110      | 1       |
| "Ralston Purina" | "Cold" | 100      | 3       |
| "General Mills"  | "Cold" | 100      | 3       |
| "General Mills"  | "Cold" | 110      | 2       |

## Get middle rows

With the `slice` method, Polars allows you to retrieve middle rows from your dataframe. Let’s get 20 rows starting from the 10th row:

``` python
(df
 .slice(10,20)
 )
```

shape: (20, 4)

| mfr             | type   | calories | protein |
|-----------------|--------|----------|---------|
| str             | str    | i64      | i64     |
| "Quaker Oats"   | "Cold" | 120      | 1       |
| "General Mills" | "Cold" | 110      | 6       |
| "General Mills" | "Cold" | 120      | 1       |
| "General Mills" | "Cold" | 110      | 3       |
| "General Mills" | "Cold" | 110      | 1       |
| …               | …      | …        | …       |
| "Kellogs"       | "Cold" | 110      | 1       |
| "Kellogs"       | "Cold" | 100      | 3       |
| "Post"          | "Cold" | 120      | 3       |
| "Kellogs"       | "Cold" | 120      | 3       |
| "Post"          | "Cold" | 110      | 1       |

As you can see from the code above, `slice` takes two parameters. The first is the position (index) of the starting row, and the second is the number of rows to return. In this case, the resulting dataframe will have 20 rows.

Become a student in my data analysis [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
