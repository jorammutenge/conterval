# Divide with no remainder in polars

floordiv

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-07

In programming, division comes in two forms: with a remainder and without a remainder. In most programming languages, the symbol `/` represents division with a remainder, while `//` represents division without a remainder. Polars provides equivalent expressions for these operations, called `truediv` and `floordiv`, respectively.

Below is a dataframe showing the years of some of the greatest inventions of the last century.

shape: (4, 2)

| Invention        | Year |
|------------------|------|
| str              | i64  |
| "Airplane"       | 1903 |
| "Sliced bread"   | 1928 |
| "Microwave"      | 1945 |
| "World Wide Web" | 1989 |

## Get decade from year

You can create a new column to show the decade in which each invention occurred by using the `floordiv` expression and multiplying the non-decimal value by 10, as shown below:

``` python
(df
 .with_columns(Decade=pl.col('Year').floordiv(10)*10)
 )
```

shape: (4, 3)

| Invention        | Year | Decade |
|------------------|------|--------|
| str              | i64  | i64    |
| "Airplane"       | 1903 | 1900   |
| "Sliced bread"   | 1928 | 1920   |
| "Microwave"      | 1945 | 1940   |
| "World Wide Web" | 1989 | 1980   |

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more cool Polars tricks.
