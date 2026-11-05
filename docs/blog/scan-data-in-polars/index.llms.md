# Speed up analysis with lazyframes in polars

scan_csv

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-22

Datasets are getting bigger, which means loading the entire dataset into memory can put a strain on your computer. Fortunately, Polars allows you to scan data and store it in a lazyframe before loading it into memory as a dataframe.

Say we have this CSV file:

``` python
csv_file = 'https://raw.githubusercontent.com/jorammutenge/learn-rust/refs/heads/main/sample_sales.csv'
```

## Create a lazyframe by scanning a CSV file

To read a CSV file as a lazyframe, you use the Polars expression `scan_csv`, like this:

``` python
import polars as pl

(pl.scan_csv(csv_file)
 .select('Account Name','ext price')
 .group_by('Account Name')
 .agg(pl.mean('ext price'))
 .collect()
 )
```

shape: (718, 2)

| Account Name                     | ext price  |
|----------------------------------|------------|
| str                              | f64        |
| "Beatty and Sons"                | 521.46     |
| "Reilly-Leannon"                 | 574.135    |
| "Schimmel, Schaefer and Treutel" | 656.596667 |
| "Swift-Okuneva"                  | 320.295    |
| "Terry PLC"                      | 453.0      |
| …                                | …          |
| "Shields-Boyer"                  | 933.2      |
| "Bode, Mohr and Bogan"           | 438.76     |
| "Maggio Inc"                     | 383.48     |
| "Beatty-Dickinson"               | 36.55      |
| "Tillman-Schowalter"             | 430.54     |

In the lazyframe, I selected the two columns I wanted and computed the average price for each customer. The resulting lazyframe was then loaded into memory as a dataframe.

Doing computations on a lazyframe is faster because nothing is stored in memory until you `collect` the results.

Click to join 150+ students learning [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
