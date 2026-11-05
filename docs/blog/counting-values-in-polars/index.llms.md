# Counting how many times a value appears in polars

value_counts

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-17

When dealing with categorical data, you may want to know how many times each category appears in a column. Below is a dataframe containing three different categories of clothing items.

shape: (1_000, 2)

| category  | quantity |
|-----------|----------|
| str       | i64      |
| "Hat"     | 1        |
| "Sweater" | 9        |
| "Sweater" | 12       |
| "Sweater" | 5        |
| "Sweater" | 19       |
| …         | …        |
| "Sweater" | 2        |
| "Socks"   | 19       |
| "Socks"   | 18       |
| "Sweater" | 15       |
| "Sweater" | 11       |

## Count appearance of values

To count how many times each clothing category appears in the dataframe above, you can use `value_counts` in Polars. Here’s how to do it:

``` python
(df
 ['category']
 .value_counts(sort=True)
 )
```

shape: (3, 2)

| category  | count |
|-----------|-------|
| str       | u32   |
| "Sweater" | 526   |
| "Socks"   | 297   |
| "Hat"     | 177   |

## Doing it the idiomatic way

If you want to impress your colleagues with your Polars knowledge, you can do it the idiomatic way (which I highly encourage).

``` python
(df
 .select('category')
 .to_series()
 .value_counts(sort=True)
 )
```

shape: (3, 2)

| category  | count |
|-----------|-------|
| str       | u32   |
| "Sweater" | 526   |
| "Socks"   | 297   |
| "Hat"     | 177   |

For more idiomatic ways, enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)
