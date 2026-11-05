# How to sample data with polars

sample

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-10

Analyzing a very large dataset can be strenuous on your computer, especially if you don’t have a fast machine. Instead of overworking your computer and waiting a long time to see the results, you can perform your analysis on a smaller subset of the data. Below is a dataframe with 1000 rows.

shape: (1_000, 2)

| category  | quantity |
|-----------|----------|
| str       | i64      |
| "Hat"     | 1        |
| "Sweater" | 9        |
| "Sweater" | 12       |
| "Sweater" | 5        |
| "Sweater" | 19       |
| …         | …        |
| "Sweater" | 2        |
| "Socks"   | 19       |
| "Socks"   | 18       |
| "Sweater" | 15       |
| "Sweater" | 11       |

## Getting a subset of the data

Say we want to reduce the size of the dataset to 100 rows for faster analysis. A poor way to get those 100 rows would be to select the first or last 100 rows. Why? Because they don’t provide a true representation of the entire dataset.

For example, if the dataset had null values in the last 100 rows of the *quantity* column, you might wrongly assume that the entire column contains missing values. Conversely, if you only selected the first 100 rows, you could completely miss those null values.

## Sampling is the best method

To get a true representation of the data, you should use the `sample` function. This ensures that rows are randomly selected until you reach the desired number. Here’s how to use it:

``` python
(df
 .sample(100)
 )
```

shape: (100, 2)

| category  | quantity |
|-----------|----------|
| str       | i64      |
| "Sweater" | 16       |
| "Sweater" | 12       |
| "Socks"   | 10       |
| "Sweater" | 11       |
| "Sweater" | 13       |
| …         | …        |
| "Socks"   | 19       |
| "Sweater" | 13       |
| "Sweater" | 5        |
| "Socks"   | 18       |
| "Sweater" | 17       |

\
If you want your results to be reproducible, you can use the `seed` parameter.

``` python
(df
 .sample(100, seed=42)
 )
```

shape: (100, 2)

| category  | quantity |
|-----------|----------|
| str       | i64      |
| "Socks"   | 10       |
| "Sweater" | 12       |
| "Socks"   | 9        |
| "Sweater" | 5        |
| "Sweater" | 14       |
| …         | …        |
| "Socks"   | 2        |
| "Socks"   | 9        |
| "Socks"   | 7        |
| "Hat"     | 20       |
| "Hat"     | 15       |

\
Now, whenever you run the code, you’ll always get the same 100 rows.

Learn more in this [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
