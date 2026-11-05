# Take a glimpse into your data with polars

glimpse

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-03

I’ve said it before, and I’ll say it again: it’s important to know the data you’re working with before you start analyzing it. Below is a dataframe showing cereal brands.

shape: (77, 4)

| mfr              | type   | calories | protein |
|------------------|--------|----------|---------|
| str              | str    | i64      | i64     |
| "Nabisco"        | "Cold" | 70       | 4       |
| "Quaker Oats"    | "Cold" | 120      | 3       |
| "Kellogs"        | "Cold" | 70       | 4       |
| "Kellogs"        | "Cold" | 50       | 4       |
| "Ralston Purina" | "Cold" | 110      | 2       |
| …                | …      | …        | …       |
| "General Mills"  | "Cold" | 110      | 2       |
| "General Mills"  | "Cold" | 110      | 1       |
| "Ralston Purina" | "Cold" | 100      | 3       |
| "General Mills"  | "Cold" | 100      | 3       |
| "General Mills"  | "Cold" | 110      | 2       |

## Look into the dataset

Polars has a handy function, `glimpse`, that allows you to explore the dataset and see what values each column contains. More importantly, it displays one column per line, making it easier to view wider columns. Here’s how to use it:

``` python
df.glimpse(max_items_per_column=5)
```

    Rows: 77
    Columns: 4
    $ mfr      <str> 'Nabisco', 'Quaker Oats', 'Kellogs', 'Kellogs', 'Ralston Purina'
    $ type     <str> 'Cold', 'Cold', 'Cold', 'Cold', 'Cold'
    $ calories <i64> 70, 120, 70, 50, 110
    $ protein  <i64> 4, 3, 4, 4, 2

The `max_items_per_column` parameter controls how many values are shown for each column. The default is 10.

Join my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)
