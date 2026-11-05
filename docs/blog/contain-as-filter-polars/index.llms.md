# Using contains to filter data in polars

contains

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-11

The dirty secret is that data work is mainly about working with text data rather than numerical data. That’s why knowing how to filter text data is a valuable skill to have. Below is a dataframe showing cereal brands.

shape: (77, 2)

| manufacturer     | type   |
|------------------|--------|
| str              | str    |
| "Nabisco"        | "Cold" |
| "Quaker Oats"    | "Cold" |
| "Kellogs"        | "Cold" |
| "Kellogs"        | "Cold" |
| "Ralston Purina" | "Cold" |
| …                | …      |
| "General Mills"  | "Cold" |
| "General Mills"  | "Cold" |
| "Ralston Purina" | "Cold" |
| "General Mills"  | "Cold" |
| "General Mills"  | "Cold" |

## Filter with contain

Sometimes you may want to filter rows without knowing the exact value of a column. In such cases, you can select a word that’s common in the values you want to retrieve. Let’s filter for manufacturers that contain the word “Mills.”

``` python
(df
 .filter(pl.col('manufacturer').str.contains('Mills'))
 )
```

shape: (22, 2)

| manufacturer    | type   |
|-----------------|--------|
| str             | str    |
| "General Mills" | "Cold" |
| "General Mills" | "Cold" |
| "General Mills" | "Cold" |
| "General Mills" | "Cold" |
| "General Mills" | "Cold" |
| …               | …      |
| "General Mills" | "Cold" |
| "General Mills" | "Cold" |
| "General Mills" | "Cold" |
| "General Mills" | "Cold" |
| "General Mills" | "Cold" |

## Use multiple words

You can use the pipe operator `|` to filter with multiple words, like this:

``` python
(df
 .filter(pl.col('manufacturer').str.contains('Mills|Purina'))
 )
```

shape: (30, 2)

| manufacturer     | type   |
|------------------|--------|
| str              | str    |
| "Ralston Purina" | "Cold" |
| "General Mills"  | "Cold" |
| "General Mills"  | "Cold" |
| "Ralston Purina" | "Cold" |
| "General Mills"  | "Cold" |
| …                | …      |
| "General Mills"  | "Cold" |
| "General Mills"  | "Cold" |
| "Ralston Purina" | "Cold" |
| "General Mills"  | "Cold" |
| "General Mills"  | "Cold" |

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
