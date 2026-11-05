# Converting from polars to pandas dataframe is as easy as 1, 2, 3

to_pandas

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-05

Almost anything you can do in Pandas can also be done in Polars. However, there are certain outputs that are unique to Pandas, such as creating a hierarchical column table. Fortunately, converting a Polars dataframe to a Pandas dataframe is very easy. Below is a Polars dataframe showing some popular clothing brands.

shape: (4, 3)

| Brand       | Category  | Price |
|-------------|-----------|-------|
| str         | str       | i64   |
| "Gucci"     | "Premium" | 1000  |
| "Versace"   | "Premium" | 5000  |
| "Forever21" | "Basic"   | 39    |
| "Gap"       | "Basic"   | 56    |

## Change to pandas dataframe

Suppose you want to pivot your data to create a hierarchical column table where *Category* is at the top, followed by *Brand*. Currently, this cannot be done in Polars. However, you can use the `to_pandas` method to convert your Polars dataframe into a Pandas dataframe. From there, you can pivot the data to achieve the desired output as shown below:

``` python
(df
 .to_pandas()
 .pivot(columns=['Category', 'Brand'], values='Price')
 )
```

| Category | Premium |         | Basic     |      |
|----------|---------|---------|-----------|------|
| Brand    | Gucci   | Versace | Forever21 | Gap  |
| 0        | 1000.0  | NaN     | NaN       | NaN  |
| 1        | NaN     | 5000.0  | NaN       | NaN  |
| 2        | NaN     | NaN     | 39.0      | NaN  |
| 3        | NaN     | NaN     | NaN       | 56.0 |

Sign up for my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more.
