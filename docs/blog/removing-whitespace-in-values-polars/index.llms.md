# How to remove whitespace in column values using polars in python

strip_chars

100DaysOfPolars

Author

Joram Mutenge

Published

2025-06-18

In data science or data analysis, counting unique values is very common. However, having whitespace (empty space at the beginning or at the end) in your values can lead to inaccurate counts.

Whitespace can end up in your dataset, especially when the data is entered manually. A data entry person might press the spacebar before or after typing a value.

## Dataframe with whitespace in values

Let me show you an example of a dataframe containing values with whitespace. The first two values in *Items_Bought* contain whitespace.

shape: (8, 2)

| Name      | Items_Bought |
|-----------|--------------|
| str       | str          |
| "Jeremie" | "Apples   "  |
| "Ashwine" | "   Milk"    |
| "Joram"   | "Bread"      |
| "Ollie"   | "Eggs"       |
| "Jeremie" | "Bananas"    |
| "Ashwine" | "Cheese"     |
| "Joram"   | "Milk"       |
| "Ollie"   | "Apples"     |

## Show unique values

Now let’s show the unique items in the *Items_Bought* column.

``` python
(df
 .select('Items_Bought')
 .unique()
 )
```

shape: (8, 1)

| Items_Bought |
|--------------|
| str          |
| "   Milk"    |
| "Apples"     |
| "Milk"       |
| "Bread"      |
| "Cheese"     |
| "Apples   "  |
| "Eggs"       |
| "Bananas"    |

\
We know that ” Milk” and “Milk” are the same item, but the computer doesn’t realize this. The presence of whitespace makes the values different.

## True unique values

To get the true unique values, we need to remove the whitespace from the values. Polars has a handy function that can help with this known as `strip_chars`.

``` python
(df
 .select('Items_Bought')
 .with_columns(pl.col('Items_Bought').str.strip_chars())
 .unique()
 )
```

shape: (6, 1)

| Items_Bought |
|--------------|
| str          |
| "Eggs"       |
| "Bananas"    |
| "Bread"      |
| "Cheese"     |
| "Apples"     |
| "Milk"       |

\
See how the number of values has decreased from 8 to 6? That’s because ” Milk” and “Milk” are now counted as the same item.

Whenever you want to count the number of unique values in a column, it’s good practice to remove any whitespace. This ensures you get an accurate count of the unique values.

Learn more in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)!
