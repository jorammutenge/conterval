# Equalities with nulls in polars

When null values interfere with filtering

data analysis

Author

Joram Mutenge

Published

2026-01-21

Recently at work, I discovered something unexpected when filtering values with Polars. Below is a dataframe showing students’ weekly quiz results.

shape: (5, 3)

| Name    | Week_2 | Week_3 |
|---------|--------|--------|
| str     | i64    | i64    |
| "Lucy"  | 74     | 93     |
| "Pippa" | 89     | 89     |
| "Evan"  | 90     | 90     |
| "Bree"  | 52     | null   |
| "Diana" | null   | 75     |

Two students, Bree and Diana, missed one quiz in week 2 and week 3, respectively. Suppose you want to remove the students who received the same grade so you can focus on those who either increased or decreased their score. You might expect the code below to work.

``` python
(df
 .filter(pl.col('Week_2').ne(pl.col('Week_3')))
 )
```

shape: (1, 3)

| Name   | Week_2 | Week_3 |
|--------|--------|--------|
| str    | i64    | i64    |
| "Lucy" | 74     | 93     |

The problem is that it also removes the students who missed one quiz. Why does this happen?

In Polars, any comparison involving a null value produces null, not `True` or `False`. A filter keeps only the rows where the predicate evaluates to `True`. As a result, rows where the predicate evaluates to null are dropped.

To keep the students who missed one quiz, you need to write the code like this:

``` python
(df
 .filter(pl.col('Week_2').ne(pl.col('Week_3')) | pl.col('Week_2').is_null() | pl.col('Week_3').is_null())
 )
```

shape: (3, 3)

| Name    | Week_2 | Week_3 |
|---------|--------|--------|
| str     | i64    | i64    |
| "Lucy"  | 74     | 93     |
| "Bree"  | 52     | null   |
| "Diana" | null   | 75     |

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more.
