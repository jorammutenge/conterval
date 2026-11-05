# Changing data types while reading the file in polars

schema_overrides

100DaysOfPolars

Author

Joram Mutenge

Published

2025-11-13

Most people read CSV files and then change the data type of columns. That is an amateur way of doing it. The professional approach is to do it all at once. Below is a dataframe showing a Polars function I covered each day in my [100DaysOfPolars](https://www.conterval.com/blog/#category=100DaysOfPolars).

``` py
import polars as pl
pl.read_csv('days_data')
```

shape: (3, 2)

| Function      | Day_Count |
|---------------|-----------|
| str           | i64       |
| "strip_chars" | 1         |
| "pl.nth"      | 2         |
| "explode"     | 3         |

## Assign data type on read

To assign a different data type to a column while reading a CSV file, use the option `schema_overrides` like this:

``` py
pl.read_csv('days_data.csv', schema_overrides={'Day_Count': pl.String})
```

shape: (3, 2)

| Function      | Day_Count |
|---------------|-----------|
| str           | str       |
| "strip_chars" | "1"       |
| "pl.nth"      | "2"       |
| "explode"     | "3"       |

There’s more you can learn in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
