# Filtering for multiple items in polars

is_in

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-14

Sometimes, you may want to filter data for more than one item. Polars makes this type of filtering straightforward. Below is a dataframe showing streaming services and their corresponding prices.

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

## Multiple item filtering

For example, if you want to view the prices of only a few specific streaming services like Netflix, Hulu, and AMC, you can use the `is_in` expression. This allows you to filter the data by specifying a list of the items you’re interested in. Here’s how to do it.

``` python
(df
 .filter(pl.col('Subscription').is_in(['Netflix','Hulu','AMC']))
 )
```

shape: (3, 2)

| Subscription | Price |
|--------------|-------|
| str          | f64   |
| "Netflix"    | 15.49 |
| "Hulu"       | 7.99  |
| "AMC"        | 8.99  |

\
I want to teach you. Please enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
