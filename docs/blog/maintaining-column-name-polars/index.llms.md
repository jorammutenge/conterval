# Maintaining a column name without retyping it in polars

name.keep

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-02

DataFrames make it easy to create new columns and rename existing ones. That’s why I prefer doing data analysis with DataFrames rather than SQL tables. Say we have a dataframe shown below and we wanted to categorize the budget values into two groups: “Too high” and “Just right”

shape: (5, 2)

| Department    | Budget |
|---------------|--------|
| str           | i64    |
| "Hospitality" | 50000  |
| "Legal"       | 120000 |
| "Finance"     | 80000  |
| "Advertising" | 60000  |
| "Sales"       | 90000  |

## Amateur way to maintain column name

In Polars, when you use the conditional expression `pl.when`, it creates a new column named literal by default. You can override this by assigning a new name to the column using `alias`. Here’s how it’s done:

``` python
(df
 .with_columns(pl.when(pl.col('Budget') > 80_000)
               .then(pl.lit('Too high'))
               .otherwise(pl.lit('Just right'))
               .alias('Budget'))
 )
```

shape: (5, 2)

| Department    | Budget       |
|---------------|--------------|
| str           | str          |
| "Hospitality" | "Just right" |
| "Legal"       | "Too high"   |
| "Finance"     | "Just right" |
| "Advertising" | "Just right" |
| "Sales"       | "Too high"   |

## Pro way to maintain column name

What if you want to keep the name of the existing column after modifying its values, without having to retype it to override the default literal column? The approach shown above, which involves manually retyping the column name, can be frustrating–especially if you’re working with an Excel file from a colleague who uses long column names like *External Customer Part Number*.

Here’s how you can do it like a pro.

``` python
(df
 .with_columns(pl.when(pl.col('Budget') > 80_000)
               .then(pl.lit('Too high'))
               .otherwise(pl.lit('Just right'))
               .name.keep())
 )
```

shape: (5, 2)

| Department    | Budget       |
|---------------|--------------|
| str           | str          |
| "Hospitality" | "Just right" |
| "Legal"       | "Too high"   |
| "Finance"     | "Just right" |
| "Advertising" | "Just right" |
| "Sales"       | "Too high"   |

\
You too can be a pro at Polars. All you have to do is enroll in the [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)
