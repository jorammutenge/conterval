# Padding at the end of a string in polars

pad_end

100DaysOfPolars

Author

Joram Mutenge

Published

2025-11-10

You have part numbers for your products, and you want to ensure they all have the same length, meaning they contain the same number of characters. Below is a dataframe that shows part numbers of varying lengths.

shape: (4, 1)

| Part_Num |
|----------|
| str      |
| "JV24"   |
| "SA1978" |
| "VX4"    |
| "Z5"     |

## Make values same length

To add zeros at the end of each value in *Part_Num* that has fewer than six characters, use the Polars expression `pad_end` as follows:

``` python
(df
 .with_columns(pl.col('Part_Num').str.pad_end(6, '0'))
 )
```

shape: (4, 1)

| Part_Num |
|----------|
| str      |
| "JV2400" |
| "SA1978" |
| "VX4000" |
| "Z50000" |

Now the values all have the same length with six characters.

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) and advance your analysis skills.
