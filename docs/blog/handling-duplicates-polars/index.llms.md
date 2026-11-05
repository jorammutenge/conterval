# Identify and remove duplicate rows in polars

is_duplicated

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-30

Duplicates are a common problem in most datasets. That’s why it’s important to check for duplicate rows before analyzing your data. Fortunately, Polars provides an easy way to identify duplicate rows. Below is a dataframe showing sales for each day of the week.

shape: (8, 2)

| Day    | Sales |
|--------|-------|
| str    | i64   |
| "Fri"  | 319   |
| "Mon"  | 182   |
| "Tue"  | 247   |
| "Wed"  | 547   |
| "Thur" | 481   |
| "Fri"  | 319   |
| "Sat"  | 208   |
| "Sun"  | 67    |

## Show duplicates

To display duplicated rows in Polars, use the `is_duplicated` method. This method highlights rows that have identical values across all columns.

``` python
(df
 .filter(df.is_duplicated())
 )
```

shape: (2, 2)

| Day   | Sales |
|-------|-------|
| str   | i64   |
| "Fri" | 319   |
| "Fri" | 319   |

You can see that the sales record for Friday was entered twice, so it is duplicated.

## Remove duplicates

To remove duplicates in Polars, use the `unique` method. This ensures that only rows with distinct values across columns are retained. Here’s how to do it:

``` python
(df
 .unique()
 )
```

shape: (7, 2)

| Day    | Sales |
|--------|-------|
| str    | i64   |
| "Sun"  | 67    |
| "Wed"  | 547   |
| "Mon"  | 182   |
| "Thur" | 481   |
| "Tue"  | 247   |
| "Sat"  | 208   |
| "Fri"  | 319   |

Now you can see that Friday appears only once!

Join the many students improving their Polars skills in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
