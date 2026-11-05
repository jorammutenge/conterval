# Pivot data without any aggregation in polars

unstack

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-10

You have a table with four rows and want to turn it into a table with two rows. In other words, you want to transform a long-format table into a wide-format table, which means you’ll have more columns. Below is a dataframe showing company departments and their budgets.

shape: (4, 2)

| Department    | Budget |
|---------------|--------|
| str           | i64    |
| "Hospitality" | 100    |
| "Legal"       | 80     |
| "Finance"     | 200    |
| "Advertising" | 120    |

## Convert to wide format

To convert the dataframe above to a wide-format table without performing any aggregation, use the `unstack` method like this:

``` python
(df
 .unstack(step=2, how='horizontal')
 )
```

shape: (2, 4)

| Department_0  | Department_1  | Budget_0 | Budget_1 |
|---------------|---------------|----------|----------|
| str           | str           | i64      | i64      |
| "Hospitality" | "Legal"       | 100      | 80       |
| "Finance"     | "Advertising" | 200      | 120      |

The `step` parameter determines the number of rows you want to have in the final dataframe. You could also use `pivot` and leave the `aggregate_function` parameter blank to achieve the same result. However, `unstack` is often faster because it skips the grouping phase.

Learn more in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
