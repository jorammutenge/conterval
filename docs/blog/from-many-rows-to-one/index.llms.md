# Collapse rows into a single row in polars

str.join

100DaysOfPolars

Author

Joram Mutenge

Published

2025-12-20

Polars allows you to collapse multiple rows into a single row, combining the values from all the rows into one. Below is a dataframe showing parts of a phone number.

shape: (3, 2)

| Represent       | Value |
|-----------------|-------|
| str             | i64   |
| "Area code"     | 563   |
| "Exchange code" | 384   |
| "Line number"   | 9905  |

## Collapse rows into one

We can construct the full phone number from the three rows using the Polars expression `str.join` like this:

``` python
(df
 .select((pl.col('Value').str.join('-')).alias('Phone_No'))
 )
```

shape: (1, 1)

| Phone_No       |
|----------------|
| str            |
| "563-384-9905" |

> **NOTE:**
>
> This is different from the `implode` function, which returns a list of values instead of a string.

``` python
(df
 .select(pl.col('Value').implode().alias('Phone_No'))
 )
```

shape: (1, 1)

| Phone_No           |
|--------------------|
| list\[i64\]        |
| \[563, 384, 9905\] |

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more.
