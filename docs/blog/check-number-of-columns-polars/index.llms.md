# Checking the number of columns in your dataframe in polars

width

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-02

Sometimes your dataset may have too many columns to display on the screen at once. However, you might still want to know how many columns it contains. The Polars dataframe has a property called `width` that returns the number of columns. Below is a dataframe with too many columns to display all at once.

shape: (77, 17)

| name | mfr | type | calories | protein | fat | sodium | fiber | carbo | sugars | potass | vitamins | shelf | weight | cups | rating | cereal |
|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| str | str | str | i64 | i64 | i64 | i64 | f64 | f64 | i64 | i64 | i64 | str | f64 | f64 | f64 | i64 |
| "100% Bran" | "Nabisco" | "Cold" | 70 | 4 | 1 | 130 | 10.0 | 5.0 | 6 | 280 | 25 | "Top" | 1.0 | 0.33 | 68.4 | 1 |
| "100% Natural Bran" | "Quaker Oats" | "Cold" | 120 | 3 | 5 | 15 | 2.0 | 8.0 | 8 | 135 | 0 | "Top" | 1.0 | 1.0 | 33.98 | 1 |
| "All-Bran" | "Kellogs" | "Cold" | 70 | 4 | 1 | 260 | 9.0 | 7.0 | 5 | 320 | 25 | "Top" | 1.0 | 0.33 | 59.43 | 1 |
| "All-Bran with Extra Fiber" | "Kellogs" | "Cold" | 50 | 4 | 0 | 140 | 14.0 | 8.0 | 0 | 330 | 25 | "Top" | 1.0 | 0.5 | 93.7 | 1 |
| "Almond Delight" | "Ralston Purina" | "Cold" | 110 | 2 | 2 | 200 | 1.0 | 14.0 | 8 | -1 | 25 | "Top" | 1.0 | 0.75 | 34.38 | 1 |
| … | … | … | … | … | … | … | … | … | … | … | … | … | … | … | … | … |
| "Triples" | "General Mills" | "Cold" | 110 | 2 | 1 | 250 | 0.0 | 21.0 | 3 | 60 | 25 | "Top" | 1.0 | 0.75 | 39.11 | 1 |
| "Trix" | "General Mills" | "Cold" | 110 | 1 | 1 | 140 | 0.0 | 13.0 | 12 | 25 | 25 | "Middle" | 1.0 | 1.0 | 27.75 | 1 |
| "Wheat Chex" | "Ralston Purina" | "Cold" | 100 | 3 | 1 | 230 | 3.0 | 17.0 | 3 | 115 | 25 | "Bottom" | 1.0 | 0.67 | 49.79 | 1 |
| "Wheaties" | "General Mills" | "Cold" | 100 | 3 | 1 | 200 | 3.0 | 17.0 | 3 | 110 | 25 | "Bottom" | 1.0 | 1.0 | 51.59 | 1 |
| "Wheaties Honey Gold" | "General Mills" | "Cold" | 110 | 2 | 1 | 200 | 1.0 | 16.0 | 8 | 60 | 25 | "Bottom" | 1.0 | 0.75 | 36.19 | 1 |

## Check column count

Here’s how you can check the number of columns in your dataframe:

``` python
df.width
```

    17

## Real world usage

You might say that the dataframe already displays the number of columns at the top. However, there may be situations where you need to check whether two dataframes have the same number of columns before concatenating them. This is where the `width` property becomes useful. When automating your process, you won’t be able to visually inspect the shapes of the dataframes, so checking their column counts programmatically is essential.

Over 100 students have enrolled in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/). I encourage you to do the same.
