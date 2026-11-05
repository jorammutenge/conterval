# Calculating cumulative sum in polars

pl.cum_sum

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-15

Say you have a target you want to hit for your weekly sales total, and you also want to know how close you are to hitting that target with each passing day. It turns out there’s a way to perform that calculation in Polars. Below is a dataframe containing daily sales.

shape: (7, 2)

| Day    | Sales |
|--------|-------|
| str    | i64   |
| "Mon"  | 182   |
| "Tue"  | 247   |
| "Wed"  | 547   |
| "Thur" | 481   |
| "Fri"  | 319   |
| "Sat"  | 208   |
| "Sun"  | 67    |

## Calculate cumulative sum

In Polars, you use the expression `pl.cum_sum` to add the next number to the sum of the previous numbers. Here’s how to do it:

``` python
(df
 .with_columns(Cum_Sales=pl.col('Sales').cum_sum())
 )
```

shape: (7, 3)

| Day    | Sales | Cum_Sales |
|--------|-------|-----------|
| str    | i64   | i64       |
| "Mon"  | 182   | 182       |
| "Tue"  | 247   | 429       |
| "Wed"  | 547   | 976       |
| "Thur" | 481   | 1457      |
| "Fri"  | 319   | 1776      |
| "Sat"  | 208   | 1984      |
| "Sun"  | 67    | 2051      |

So, if you had a target of \$2,000 by the end of the week, you’d know by Friday that you’re not too far from hitting that target.

Hey, do me a solid, checkout my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
