# Insert a column into a polars dataframe

insert_column

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-13

Polars allows you to insert a column into a dataframe at any position you want. Below is a dataframe showing the ratings of some unknown movies.

**ratings_df**

shape: (4, 3)

| year | rating | minutes |
|------|--------|---------|
| i64  | f64    | i64     |
| 2011 | 7.1    | 107     |
| 1999 | 6.4    | 101     |
| 2000 | 7.0    | 120     |
| 2017 | 6.8    | 133     |

**movie_title_column**

shape: (4,)

| movie                |
|----------------------|
| str                  |
| "Margin Call"        |
| "Rogue Trader"       |
| "Boiler Room"        |
| "The Wizard of Lies" |

## Insert column into dataframe

To insert another column into the dataframe above, make sure the column type is `series`, not `dataframe`. Here’s how you can insert a new column as the first column in the dataframe:

``` python
(ratings_df
 .insert_column(0, movie_title_column)
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

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more.
