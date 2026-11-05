# When you want to count values without null in polars

pl.count

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-08

Most of the time, when you’re counting the number of values in a column, you’re not interested in including empty (null) values. Therefore, simply counting the number of rows in the dataframe isn’t enough. Luckily, Polars makes this kind of count easy to perform. Below is a dataframe showing department managers.

shape: (5, 2)

| Manager    | Department    |
|------------|---------------|
| str        | str           |
| "Mae C"    | "Hospitality" |
| "Lauren K" | "Legal"       |
| "Sahill H" | "Finance"     |
| null       | "Advertising" |
| "Titus P"  | "Sales"       |

## Count values in each column

To get the number of non-null values in each column, you can use the Polars expression `pl.count` like this:

``` python
(df
 .select(pl.count('Manager','Department'))
 )
```

shape: (1, 2)

| Manager | Department |
|---------|------------|
| u32     | u32        |
| 4       | 5          |

As you can see, the number of values in the two columns is not the same. *Manager* has only 4 values because it contains a null value.

Take your data skills to another level with my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
