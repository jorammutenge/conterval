# Arranging columns in a specific order using index in polars

pl.nth

100DaysOfPolars

Author

Joram Mutenge

Published

2025-06-19

Stacking dataframes vertically only works when the column names are the same and arranged in the same order. For example, if you have `df1` with columns *Name* and *Age*, and `df2` with columns *Age* and *Name*, these two dataframes cannot be stacked into a single dataframe. Although they contain the same column names, the order of the columns does not align.

## Inefficient ordering of columns

You can rearrange columns using `select` by typing out the column names one by one. The columns in the dataframe will appear in the order you specify. However, this method can be tedious, especially when working with many columns or columns with long names.

## Efficient ordering of columns

If you’re too lazy to type out the columns names, you can reference them by index. Polars provides the `pl.nth` function that lets you to do this. Here’s how you can rearrange the columns in the dataframe below.

shape: (5, 5)

| Number_of_People | Budget | Department_Name | Location   | Manager          |
|------------------|--------|-----------------|------------|------------------|
| i64              | i64    | str             | str        | str              |
| 17               | 50000  | "Hospitality"   | "Thailand" | "Sritala"        |
| 25               | 120000 | "Legal"         | "New York" | "Harvey Specter" |
| 15               | 80000  | "Finance"       | "London"   | "Ken Leung"      |
| 12               | 60000  | "Advertising"   | "New York" | "Don Draper"     |
| 20               | 90000  | "Sales"         | "Scranton" | "Michael Scott"  |

\
Now let’s arrange the columns by referencing their index (position) instead of manually typing the column names.

``` python
(df
 .select(pl.nth(2,4,3,0,1))
 )
```

shape: (5, 5)

| Department_Name | Manager          | Location   | Number_of_People | Budget |
|-----------------|------------------|------------|------------------|--------|
| str             | str              | str        | i64              | i64    |
| "Hospitality"   | "Sritala"        | "Thailand" | 17               | 50000  |
| "Legal"         | "Harvey Specter" | "New York" | 25               | 120000 |
| "Finance"       | "Ken Leung"      | "London"   | 15               | 80000  |
| "Advertising"   | "Don Draper"     | "New York" | 12               | 60000  |
| "Sales"         | "Michael Scott"  | "Scranton" | 20               | 90000  |

\
See how much time this method can save you?

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)!
