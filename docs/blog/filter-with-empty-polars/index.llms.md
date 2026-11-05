# How to filter with empty to get true or false values in polars

is_empty

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-01

You’re conscious about your calorie intake, and you want to know whether there are any cereals in your dataset with more than 200 calories. How would you go about answering this question? Below is a dataframe containing cereal brands and the number of calories they contain.

shape: (77, 8)

| mfr              | type   | calories | protein | fat | sodium | fiber | carbo |
|------------------|--------|----------|---------|-----|--------|-------|-------|
| str              | str    | i64      | i64     | i64 | i64    | f64   | f64   |
| "Nabisco"        | "Cold" | 70       | 4       | 1   | 130    | 10.0  | 5.0   |
| "Quaker Oats"    | "Cold" | 120      | 3       | 5   | 15     | 2.0   | 8.0   |
| "Kellogs"        | "Cold" | 70       | 4       | 1   | 260    | 9.0   | 7.0   |
| "Kellogs"        | "Cold" | 50       | 4       | 0   | 140    | 14.0  | 8.0   |
| "Ralston Purina" | "Cold" | 110      | 2       | 2   | 200    | 1.0   | 14.0  |
| …                | …      | …        | …       | …   | …      | …     | …     |
| "General Mills"  | "Cold" | 110      | 2       | 1   | 250    | 0.0   | 21.0  |
| "General Mills"  | "Cold" | 110      | 1       | 1   | 140    | 0.0   | 13.0  |
| "Ralston Purina" | "Cold" | 100      | 3       | 1   | 230    | 3.0   | 17.0  |
| "General Mills"  | "Cold" | 100      | 3       | 1   | 200    | 3.0   | 17.0  |
| "General Mills"  | "Cold" | 110      | 2       | 1   | 200    | 1.0   | 16.0  |

## Filter with empty

Suppose you don’t want to see the actual cereal brands with more than 200 calories, you just want to return “true” if there’s any such brand, and “false” if there isn’t. You can do this using the `is_empty` expression in Polars.

``` python
(df
 .filter(pl.col('calories') > 200).is_empty()
 )
```

    True

It turns out you don’t need to worry. None of the cereals in your data have more than 200 calories. The code above might be a bit harder to understand, but here’s what’s happening: first, the data is filtered to return all rows where calories are greater than 200. If no rows are returned, the result is considered true because the filtered result is empty. Hence, the final answer is true.

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
