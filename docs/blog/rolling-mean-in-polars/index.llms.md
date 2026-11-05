# Calculate moving average in polars

rolling_mean

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-30

You’re running a store and want to know the average of your sales every 3 days to track whether your sales are dipping. Below is a dataframe showing sales on specific weekdays.

## 3-day moving average

You can calculate the 3-day moving average in Polars using the expression `rolling_mean` like this:

``` python
(df
 .with_columns(Rol_Mean=pl.col('Sales').rolling_mean(window_size=3))
 )
```

shape: (8, 3)

| Day    | Sales | Rol_Mean  |
|--------|-------|-----------|
| str    | i64   | f64       |
| "Mon"  | 93    | null      |
| "Tue"  | 88    | null      |
| "Wed"  | 73    | 84.666667 |
| "Thur" | 69    | 76.666667 |
| "Fri"  | 55    | 65.666667 |
| "Sat"  | 89    | 71.0      |
| "Sun"  | 92    | 78.666667 |
| "Mon"  | 81    | 87.333333 |

Notice that the first 2 rows in *Rol_Mean* are null. That’s because the window size of 3 is not met on the first and second roll. If you don’t want null values, you can use the parameter `min_samples`, which determines the number of values that should be **non-null** before calculating the average. Let’s set it to 1.

``` python
(df
 .with_columns(Rol_Mean=pl.col('Sales').rolling_mean(window_size=3, min_samples=1))
 )
```

shape: (8, 3)

| Day    | Sales | Rol_Mean  |
|--------|-------|-----------|
| str    | i64   | f64       |
| "Mon"  | 93    | 93.0      |
| "Tue"  | 88    | 90.5      |
| "Wed"  | 73    | 84.666667 |
| "Thur" | 69    | 76.666667 |
| "Fri"  | 55    | 65.666667 |
| "Sat"  | 89    | 71.0      |
| "Sun"  | 92    | 78.666667 |
| "Mon"  | 81    | 87.333333 |

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to advance your data analysis skills.
