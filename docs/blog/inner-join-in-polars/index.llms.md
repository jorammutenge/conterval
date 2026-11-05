# Combine dataframes with inner join in polars

inner join

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-22

Just like in SQL, it’s possible to join two dataframes in Polars. In this article, I’ll show you how to use the `inner` join in Polars to create a dataframe with more columns. Below is a dataframe, **movies_df**, showing finance movies.

shape: (4, 3)

| movie                | year | rating |
|----------------------|------|--------|
| str                  | i64  | f64    |
| "Margin Call"        | 2011 | 7.1    |
| "Rogue Trader"       | 1999 | 6.4    |
| "Boiler Room"        | 2000 | 7.0    |
| "The Wizard of Lies" | 2017 | 6.8    |

And here’s another dataframe, **minutes_df**, showing the duration of the movies.

shape: (4, 2)

| movie                | minutes |
|----------------------|---------|
| str                  | i64     |
| "Margin Call"        | 107     |
| "Rogue Trader"       | 101     |
| "Boiler Room"        | 120     |
| "The Wizard of Lies" | 133     |

## Join dataframes

You can use the `inner` join to get all the rows that match in both dataframes based on a column you choose as the key. In this case, the key column is *movie*.

``` python
(movies_df
 .join(minutes_df, on='movie', how='inner')
 )
```

shape: (4, 4)

| movie                | year | rating | minutes |
|----------------------|------|--------|---------|
| str                  | i64  | f64    | i64     |
| "Margin Call"        | 2011 | 7.1    | 107     |
| "Rogue Trader"       | 1999 | 6.4    | 101     |
| "Boiler Room"        | 2000 | 7.0    | 120     |
| "The Wizard of Lies" | 2017 | 6.8    | 133     |

Now we have a single dataframe that contains all four columns.

> **TIP:**
>
> Polars supports several other joins, such as:
>
> - `left` join - Keeps all rows from the left dataframe, even those without a match, and includes only matching rows from the right dataframe. Polars does not support a right join directly, but you can achieve the same result by swapping the dataframes.
> - `anti` join - Similar to a set difference in mathematics. It removes matching rows from the left dataframe.

Improve your Polars skills by taking this [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/). See you in class.
