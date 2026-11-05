# Grouping with over in polars

over

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-19

Group by operations usually reduce the size of a dataframe, both in the number of columns and rows returned. However, sometimes you may want to maintain the original dataframe size.

Below is a dataframe showing different types of groceries bought on each day of the week.

shape: (9, 3)

| Day   | Product   | Price |
|-------|-----------|-------|
| str   | str       | f64   |
| "Mon" | "Bread"   | 3.89  |
| "Tue" | "Milk"    | 4.0   |
| "Wed" | "Tea"     | 3.89  |
| "Mon" | "Cheese"  | 7.99  |
| "Tue" | "Oats"    | 8.0   |
| "Wed" | "Yogurt"  | 4.67  |
| "Mon" | "Apple"   | 4.0   |
| "Tue" | "Juice"   | 7.89  |
| "Wed" | "Lettuce" | 5.99  |

## Group with over

To perform a group by operation while keeping the same dataframe length in Polars, you use the `over` expression like this:

``` python
(df
 .with_columns(Avg_Spend=pl.col('Price').mean().over('Day'))
 )
```

shape: (9, 4)

| Day   | Product   | Price | Avg_Spend |
|-------|-----------|-------|-----------|
| str   | str       | f64   | f64       |
| "Mon" | "Bread"   | 3.89  | 5.293333  |
| "Tue" | "Milk"    | 4.0   | 6.63      |
| "Wed" | "Tea"     | 3.89  | 4.85      |
| "Mon" | "Cheese"  | 7.99  | 5.293333  |
| "Tue" | "Oats"    | 8.0   | 6.63      |
| "Wed" | "Yogurt"  | 4.67  | 4.85      |
| "Mon" | "Apple"   | 4.0   | 5.293333  |
| "Tue" | "Juice"   | 7.89  | 6.63      |
| "Wed" | "Lettuce" | 5.99  | 4.85      |

Here, we’ve calculated the average spend for each day.

> **NOTE:**
>
> The size of the dataframe remains the same in both dataframes, with 9 rows.

Enroll in [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more.
