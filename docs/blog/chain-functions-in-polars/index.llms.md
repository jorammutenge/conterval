# Use custom functions as dataframe methods in polars

pipe

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-24

Chaining operations in polars is encouraged to take advantage of the query engine in the backend. However, you may want to apply a function that is too specific to your needs and not provided by the built-in functions. Fortunately, there is a way to chain operations using custom-made functions in polars. Below is a dataframe showing Apple stock.

shape: (10, 2)

| Date       | Adj Close |
|------------|-----------|
| date       | f64       |
| 2019-08-16 | 49.954624 |
| 2019-08-19 | 50.885971 |
| 2019-08-20 | 50.88839  |
| 2019-08-21 | 51.43996  |
| 2019-08-22 | 51.39642  |
| 2019-08-23 | 49.020844 |
| 2019-08-26 | 49.952202 |
| 2019-08-27 | 49.388546 |
| 2019-08-28 | 49.719963 |
| 2019-08-29 | 50.561813 |

## Create custom function

Suppose you want to calculate the delta change based on the *Adj Close* price. You can create a custom function as follows:

``` python
def delta_change(df, column):
    return df.with_columns(
        (pl.col(column) - pl.col(column).shift(-1)).alias('Delta Change')
    )
```

## Apply custom function

To apply the custom function as a chained operation, use the `pipe` method in polars. This method accepts the custom function and its parameters. The custom function created above has parameters `df` and `column`. Let’s apply the function.

``` python
(df
 .pipe(delta_change, column='Adj Close')
 )
```

shape: (10, 3)

| Date       | Adj Close | Delta Change |
|------------|-----------|--------------|
| date       | f64       | f64          |
| 2019-08-16 | 49.954624 | -0.931347    |
| 2019-08-19 | 50.885971 | -0.002419    |
| 2019-08-20 | 50.88839  | -0.55157     |
| 2019-08-21 | 51.43996  | 0.04354      |
| 2019-08-22 | 51.39642  | 2.375576     |
| 2019-08-23 | 49.020844 | -0.931358    |
| 2019-08-26 | 49.952202 | 0.563656     |
| 2019-08-27 | 49.388546 | -0.331417    |
| 2019-08-28 | 49.719963 | -0.84185     |
| 2019-08-29 | 50.561813 | null         |

I updated my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/). Be sure to enroll.
