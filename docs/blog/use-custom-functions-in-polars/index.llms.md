# Using a custom function in chained polars code

pipe

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-09

Some functions you write in your code may be too specific to exist as built-in Polars methods or expressions. Fortunately, Polars provides a way to apply your custom function to a dataframe within a chained operation. Below is a dataframe of Apple stock data.

shape: (10, 2)

| Date       | Open       |
|------------|------------|
| date       | f64        |
| 2024-01-02 | 187.149994 |
| 2024-01-03 | 184.220001 |
| 2024-01-04 | 182.149994 |
| 2024-01-05 | 181.990005 |
| 2024-01-08 | 182.089996 |
| 2024-01-09 | 183.919998 |
| 2024-01-10 | 184.350006 |
| 2024-01-11 | 186.539993 |
| 2024-01-12 | 186.059998 |
| 2024-01-16 | 182.160004 |

## Create custom function

Suppose you have the following custom function to calculate the change in value between the previous day’s *Open* and the current day’s *Open*.

``` python
def delta_change(df, column):
    return df.with_columns(
        (pl.col(column) - pl.col(column).shift(-1)).alias('Delta Change')
    )
```

This function takes two arguments: the dataframe and the *Open* column.\

## Use custom function

To use a custom function in a chained operation in Polars, you can use the `pipe` method like this:

``` python
df.pipe(delta_change, column='Open')
```

shape: (10, 3)

| Date       | Open       | Delta Change |
|------------|------------|--------------|
| date       | f64        | f64          |
| 2024-01-02 | 187.149994 | 2.929993     |
| 2024-01-03 | 184.220001 | 2.070007     |
| 2024-01-04 | 182.149994 | 0.159989     |
| 2024-01-05 | 181.990005 | -0.099991    |
| 2024-01-08 | 182.089996 | -1.830002    |
| 2024-01-09 | 183.919998 | -0.430008    |
| 2024-01-10 | 184.350006 | -2.189987    |
| 2024-01-11 | 186.539993 | 0.479995     |
| 2024-01-12 | 186.059998 | 3.899994     |
| 2024-01-16 | 182.160004 | null         |

My [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) has over 150 students. Enroll to be part of the happy learners.
