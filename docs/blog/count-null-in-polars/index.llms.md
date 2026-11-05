# Count null values in every column in polars

null_count

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-25

Everyone working in the data field knows that data is never perfectly clean, and missing values are almost inevitable. That’s why it’s important to check whether your dataset contains any null values before you start analyzing it. Below is a dataframe showing visits to fast food stores.

shape: (4, 3)

| Store         | Visits | Opinion     |
|---------------|--------|-------------|
| str           | i64    | str         |
| "Burger King" | 4      | "It's good" |
| "McDonald's"  | 7      | null        |
| "Shake Shack" | 10     | "Loved it"  |
| "Pizza Hut"   | null   | null        |

## Check number of nulls

To check how many null values are in each column, use the Polars method `null_count` like this:

``` python
(df
 .null_count()
 )
```

shape: (1, 3)

| Store | Visits | Opinion |
|-------|--------|---------|
| u32   | u32    | u32     |
| 0     | 1      | 2       |

You can now see the number of null values in each column. For instance, *Opinion* has 2 null values.

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more ways to analyze your data.
