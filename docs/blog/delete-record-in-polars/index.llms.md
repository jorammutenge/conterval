# Deleting a record in a polars dataframe

remove

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-13

Deleting records from a table is a common operation when analyzing data. Suppose you have a dataframe of lawyers and the scores they received on their bar exam.

shape: (5, 2)

| Student   | Score |
|-----------|-------|
| str       | i64   |
| "Harvey"  | 88    |
| "Donna"   | 76    |
| "Mike"    | 93    |
| "Jessica" | 85    |
| "Louis"   | 91    |

## Delete record

If you’re a fan of the TV show *Suits*, you’ll know that Donna is not a lawyer. Let’s remove her from the table.

``` python
df.remove(pl.col('Student') == 'Donna')
```

shape: (4, 2)

| Student   | Score |
|-----------|-------|
| str       | i64   |
| "Harvey"  | 88    |
| "Mike"    | 93    |
| "Jessica" | 85    |
| "Louis"   | 91    |

If you’re a diehard fan of *Suits*, you’ll also point out that Mike is not a real lawyer. That’s true, but let’s keep that just between us, the diehard fans.

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more ways to analyze data with Polars.
