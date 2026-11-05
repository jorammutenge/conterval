# Group by calculations in polars

group_by

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-12

Aggregations to data professionals are what a saw is to a carpenter. Almost every data analysis you perform will involve an aggregate calculation, or `group_by` calculations, to use the technical term. Below is a dataframe containing 1,000 rows.

shape: (1_000, 3)

| acct_name                        | category  | quantity |
|----------------------------------|-----------|----------|
| str                              | str       | i64      |
| "Fritsch-Glover"                 | "Hat"     | 1        |
| "O'Conner Inc"                   | "Sweater" | 9        |
| "Beatty and Sons"                | "Sweater" | 12       |
| "Gleason, Bogisich and Franecki" | "Sweater" | 5        |
| "Morissette-Heathcote"           | "Sweater" | 19       |
| …                                | …         | …        |
| "Brekke and Sons"                | "Sweater" | 2        |
| "Lang-Wunsch"                    | "Socks"   | 19       |
| "Bogisich and Sons"              | "Socks"   | 18       |
| "Kutch, Cormier and Harber"      | "Sweater" | 15       |
| "Roberts, Volkman and Batz"      | "Sweater" | 11       |

## Aggregating numerical values

Your boss isn’t interested in knowing how many sweaters Sally bought. She’s interested in how many total sweaters the store sold. Here’s how to perform that calculation in Polars. We’ll calculate both the total and average quantity.

``` python
(df
 .group_by('category')
 .agg(pl.sum('quantity').alias('Total_Qty'),
      pl.mean('quantity').alias('Avg_Qty'))
 )
```

shape: (3, 3)

| category  | Total_Qty | Avg_Qty   |
|-----------|-----------|-----------|
| str       | i64       | f64       |
| "Hat"     | 1889      | 10.672316 |
| "Sweater" | 5551      | 10.553232 |
| "Socks"   | 3125      | 10.521886 |

## Aggregating text values

In Polars, `group_by` aggregations can also be performed on non-numerical columns. Let’s consider a practical example. Suppose we wanted to know which customers bought clothing from all three categories. Here’s how we would do that.

``` python
(df
 .group_by('acct_name')
 .agg('category')
 .filter(pl.col('category').list.n_unique() == 3) # three is the max number of categories
 )
```

shape: (11, 2)

| acct_name                        | category                              |
|----------------------------------|---------------------------------------|
| str                              | list\[str\]                           |
| "Koepp-McLaughlin"               | \["Sweater", "Hat", "Socks"\]         |
| "Halvorson PLC"                  | \["Hat", "Sweater", "Socks"\]         |
| "Bashirian, Beier and Watsica"   | \["Socks", "Hat", "Sweater"\]         |
| "Beier-Bosco"                    | \["Hat", "Sweater", "Socks"\]         |
| "Ledner-Kling"                   | \["Hat", "Sweater", "Socks"\]         |
| …                                | …                                     |
| "Upton, Runolfsson and O'Reilly" | \["Hat", "Sweater", "Socks"\]         |
| "Herman Ltd"                     | \["Sweater", "Sweater", … "Socks"\]   |
| "Mills Inc"                      | \["Sweater", "Sweater", … "Sweater"\] |
| "Kuvalis-Roberts"                | \["Sweater", "Socks", … "Sweater"\]   |
| "Fritsch-Glover"                 | \["Hat", "Sweater", "Socks"\]         |

\
Now we know that 11 customers bought clothing from all three categories: hats, socks, and sweaters.

I’m looking forward to teaching you in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
