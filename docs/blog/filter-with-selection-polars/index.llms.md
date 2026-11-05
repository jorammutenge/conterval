# Using polars selectors to filter dataframes

polars.selectors

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-07

Selecting specific columns to filter out unnecessary columns is common in data analysis. Polars makes this type of filtering straightforward through the use of selectors. Below is a dataframe showing cereal brands.

shape: (4, 5)

| name                | mfr              | type   | weight | cups |
|---------------------|------------------|--------|--------|------|
| str                 | str              | str    | f64    | f64  |
| "Almond Delight"    | "Ralston Purina" | "Cold" | 1.0    | 0.75 |
| "Total Whole Grain" | "General Mills"  | "Cold" | 1.0    | 1.0  |
| "Trix"              | "General Mills"  | "Cold" | 1.0    | 1.0  |
| "Nutri-grain Wheat" | "Kellogs"        | "Cold" | 1.0    | 1.0  |

## Get numerical columns

You can use Polars selectors to filter for numerical columns only. In this case, the dataframe will show the columns *weight* and *cups*. Here’s how to do it:

``` python
import polars.selectors as cs

(df
 .select(cs.by_dtype(pl.Float64))
)
```

shape: (4, 2)

| weight | cups |
|--------|------|
| f64    | f64  |
| 1.0    | 0.75 |
| 1.0    | 1.0  |
| 1.0    | 1.0  |
| 1.0    | 1.0  |

You can also filter for columns with the string data type by replacing `pl.Float64` with `pl.String`. This method of filtering is especially useful when your dataframe has many columns and you don’t want to spend time listing each column you want to include manually.

I’m accepting students in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
