# Filter between a range of values in polars

is_between

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-21

It’s not always the case that you want to filter your data based on a single specific value. Sometimes, you may want to filter your data based on a range of values. Below is a dataframe showing the streaming services I subscribe to.

shape: (7, 2)

| Subscription | Price |
|--------------|-------|
| str          | f64   |
| "Netflix"    | 15.49 |
| "Hulu"       | 7.99  |
| "HBO Max"    | 15.99 |
| "Showtime"   | 10.99 |
| "Paramount"  | 11.99 |
| "Disney+"    | 7.99  |
| "AMC"        | 8.99  |

## Filter on range of values

Suppose I want to cut down on spending and only keep streaming services with prices between \$7 and \$10. I can use the `is_between` expression in Polars to achieve this. Here’s how to do it:

``` python
(df
 .filter(pl.col('Price').is_between(7.99,10.99))
 )
```

shape: (4, 2)

| Subscription | Price |
|--------------|-------|
| str          | f64   |
| "Hulu"       | 7.99  |
| "Showtime"   | 10.99 |
| "Disney+"    | 7.99  |
| "AMC"        | 8.99  |

## Exclude some or both bounds

By default, `is_between` includes both the left and right bounds. You can choose to exclude either the left or right bound, or even both. Here’s how to exclude the left bound:

``` python
(df
 .filter(pl.col('Price').is_between(7.99,10.99, closed='right'))
 )
```

shape: (2, 2)

| Subscription | Price |
|--------------|-------|
| str          | f64   |
| "Showtime"   | 10.99 |
| "AMC"        | 8.99  |

To exclude the right bound instead, replace `'right'` with `'left'` in the `closed` parameter. Here’s how you can exclude both the left and right bounds:

``` python
(df
 .filter(pl.col('Price').is_between(7.99,10.99, closed='none'))
 )
```

shape: (1, 2)

| Subscription | Price |
|--------------|-------|
| str          | f64   |
| "AMC"        | 8.99  |

Join 100+ students in this [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)!
