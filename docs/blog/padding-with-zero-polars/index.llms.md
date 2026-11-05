# Pad the start of values with zeros in polars

zfill

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-21

You have a shop and want your receipt numbers to have four digits instead of just one. So rather than receipt “No. 1”, you want receipt “No. 0001”. Below is a dataframe showing customers and their receipt numbers.

shape: (4, 2)

| Customer  | Receipt No |
|-----------|------------|
| str       | i64        |
| "Serena"  | 1          |
| "Blair"   | 2          |
| "Dan"     | 21         |
| "Vanessa" | 153        |

## Pad with zeros

To add zeros at the start of values in *Receipt No*, you first need to convert the column’s data type to string (text) and then use the Polars expression `zfill`, like this:

``` python
(df
 .with_columns(pl.col('Receipt No').cast(pl.String).str.zfill(length=4))
 )
```

shape: (4, 2)

| Customer  | Receipt No |
|-----------|------------|
| str       | str        |
| "Serena"  | "0001"     |
| "Blair"   | "0002"     |
| "Dan"     | "0021"     |
| "Vanessa" | "0153"     |

> **NOTE:**
>
> Setting `length=4` means the final value will have 4 digits. It **does not** mean the number of zeros to add.

My [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) is newly updated. Enroll now to advance your data analysis skills.
