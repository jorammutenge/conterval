# Remove suffix in column names in polars

name.map

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-27

You may have a table with long column names that contain suffixes like “Undergraduate_Student”, where the suffix is “\_Student”. These long column names can be difficult to work with because typing them is time-consuming. Fortunately, there’s a way to fix this. Below is a dataframe showing graduate and undergraduate students.

shape: (4, 2)

| Undergraduate_Student | Graduate_Student |
|-----------------------|------------------|
| str                   | str              |
| "Lauren"              | "Gabrielle"      |
| "Larry"               | "Penny"          |
| "Chanda"              | "Chisenga"       |
| "Katis"               | "Titus"          |

## Remove suffix in column names

You can remove the suffix “\_Student” from the column names by using the expression `name.map`. This allows you to change column names without manually typing both the original names and their replacements, such as:

``` py
{'Graduate_Student': 'Graduate'}
```

Here’s how to do it:

``` python
(df
 .with_columns(pl.all().name.map(lambda c: c.removesuffix('_Student')))
 )
```

shape: (4, 4)

| Undergraduate_Student | Graduate_Student | Undergraduate | Graduate    |
|-----------------------|------------------|---------------|-------------|
| str                   | str              | str           | str         |
| "Lauren"              | "Gabrielle"      | "Lauren"      | "Gabrielle" |
| "Larry"               | "Penny"          | "Larry"       | "Penny"     |
| "Chanda"              | "Chisenga"       | "Chanda"      | "Chisenga"  |
| "Katis"               | "Titus"          | "Katis"       | "Titus"     |

Advance your polars skills by enrolling in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
