# Get a column’s index position in polars dataframe

get_column_index

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-12

Your table has many columns, and you want to know the position of a specific column in the table. How can you do that? Below is a dataframe showing cereal brands.

shape: (5, 17)

| name | mfr | type | calories | protein | fat | sodium | fiber | carbo | sugars | potass | vitamins | shelf | weight | cups | rating | cereal |
|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| str | str | str | i64 | i64 | i64 | i64 | f64 | f64 | i64 | i64 | i64 | str | f64 | f64 | f64 | i64 |
| "Total Corn Flakes" | "General Mills" | "Cold" | 110 | 2 | 1 | 200 | 0.0 | 21.0 | 3 | 35 | 100 | "Top" | 1.0 | 1.0 | 38.84 | 1 |
| "Fruity Pebbles" | "Post" | "Cold" | 110 | 1 | 1 | 135 | 0.0 | 13.0 | 12 | 25 | 25 | "Middle" | 1.0 | 0.75 | 28.03 | 1 |
| "Smacks" | "Kellogs" | "Cold" | 110 | 2 | 1 | 70 | 1.0 | 9.0 | 15 | 40 | 25 | "Middle" | 1.0 | 0.75 | 31.23 | 1 |
| "Triples" | "General Mills" | "Cold" | 110 | 2 | 1 | 250 | 0.0 | 21.0 | 3 | 60 | 25 | "Top" | 1.0 | 0.75 | 39.11 | 1 |
| "Post Nat. Raisin Bran" | "Post" | "Cold" | 120 | 3 | 1 | 200 | 6.0 | 11.0 | 14 | 260 | 25 | "Top" | 1.33 | 0.67 | 37.84 | 1 |

## Get index position of column

To get the index position of the *cereal* column, use the Polars method `get_column_index` like this:

``` python
(df
 .get_column_index('cereal')
 )
```

    16

Join almost 160 students advancing their skills in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
