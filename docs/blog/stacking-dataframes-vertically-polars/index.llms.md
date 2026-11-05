# Stacking dataframes vertically in polars

vstack

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-09

Combining two dataframes into a single dataframe is a common operation in data analysis. Dataframes can be combined vertically (one on top of the other) or horizontally (side by side). In this example, I’ll demonstrate how to combine them vertically.

Below is a dataframe with 10 rows:

shape: (10, 2)

| category  | quantity |
|-----------|----------|
| str       | i64      |
| "Hat"     | 1        |
| "Sweater" | 9        |
| "Sweater" | 12       |
| "Sweater" | 5        |
| "Sweater" | 19       |
| "Sweater" | 4        |
| "Socks"   | 4        |
| "Sweater" | 14       |
| "Hat"     | 16       |
| "Sweater" | 8        |

## Combine first and last two rows

Suppose we want to extract two dataframes from the original data:

- The first dataframe, `df1`, containing the first two rows.
- The second dataframe, `df2`, containing the last two rows.

We’ll then combine these two extracted dataframes into a single dataframe with four rows.

Let’s display the first dataframe:

``` python
df1 = df.head(2)
df1
```

shape: (2, 2)

| category  | quantity |
|-----------|----------|
| str       | i64      |
| "Hat"     | 1        |
| "Sweater" | 9        |

\
Now the second dataframe:

``` python
df2 = df.tail(2)
df2
```

shape: (2, 2)

| category  | quantity |
|-----------|----------|
| str       | i64      |
| "Hat"     | 16       |
| "Sweater" | 8        |

\
Finally, let’s combine the two dataframes:

``` python
df1.vstack(df2)
```

shape: (4, 2)

| category  | quantity |
|-----------|----------|
| str       | i64      |
| "Hat"     | 1        |
| "Sweater" | 9        |
| "Hat"     | 16       |
| "Sweater" | 8        |

## With method chaining

We can also combine the two dataframes in a single step without creating intermediate variables—something I highly recommend. Here’s how to do it:

``` python
(df
 .head(2)
 .vstack(df.tail(2))
 )
```

shape: (4, 2)

| category  | quantity |
|-----------|----------|
| str       | i64      |
| "Hat"     | 1        |
| "Sweater" | 9        |
| "Hat"     | 16       |
| "Sweater" | 8        |

\
Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to level up your data analysis skills.
