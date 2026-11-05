# Getting summary statistics in polars

describe

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-28

Data exploration is the first step in any data analysis task. You can’t start analyzing your data without understanding what it’s about. If you have numerical columns, one of the first things to do is get summary statistics for those columns like the mean (average), median, and standard deviation. Below is a dataframe of a clothing store showing customer purchase details.

shape: (1_000, 4)

| company                          | category  | quantity | price |
|----------------------------------|-----------|----------|-------|
| str                              | str       | i64      | f64   |
| "Fritsch-Glover"                 | "Hat"     | 1        | 98.98 |
| "O'Conner Inc"                   | "Sweater" | 9        | 34.8  |
| "Beatty and Sons"                | "Sweater" | 12       | 60.24 |
| "Gleason, Bogisich and Franecki" | "Sweater" | 5        | 15.25 |
| "Morissette-Heathcote"           | "Sweater" | 19       | 51.83 |
| …                                | …         | …        | …     |
| "Brekke and Sons"                | "Sweater" | 2        | 46.48 |
| "Lang-Wunsch"                    | "Socks"   | 19       | 29.25 |
| "Bogisich and Sons"              | "Socks"   | 18       | 54.79 |
| "Kutch, Cormier and Harber"      | "Sweater" | 15       | 62.53 |
| "Roberts, Volkman and Batz"      | "Sweater" | 11       | 86.4  |

## Get summary stats

To get summary statistics for all the columns in the above dataframe, you can use the Polars method `describe`. Summary statistics are most meaningful for numerical columns, but Polars provides them for categorical columns as well. For categorical columns, the most important statistic is `null_count`, which tells you the number of missing (empty) values in that column.

``` python
(df
 .describe()
 )
```

shape: (9, 5)

| statistic    | company       | category  | quantity | price     |
|--------------|---------------|-----------|----------|-----------|
| str          | str           | str       | f64      | f64       |
| "count"      | "1000"        | "1000"    | 1000.0   | 1000.0    |
| "null_count" | "0"           | "0"       | 0.0      | 0.0       |
| "mean"       | null          | null      | 10.565   | 54.06643  |
| "std"        | null          | null      | 5.887311 | 26.068011 |
| "min"        | "Abbott PLC"  | "Hat"     | 1.0      | 10.01     |
| "25%"        | null          | null      | 5.0      | 31.25     |
| "50%"        | null          | null      | 11.0     | 53.27     |
| "75%"        | null          | null      | 16.0     | 75.1      |
| "max"        | "Zulauf-Will" | "Sweater" | 20.0     | 100.0     |

You can now quickly see that the highest quantity for a single purchase is 20, and the highest price is 100. More importantly, none of the columns have missing values, as indicated by a `null_count` value of 0 for all columns.

Enroll in the [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) and join 100 plus students.
