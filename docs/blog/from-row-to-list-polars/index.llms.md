# Collapsing row values into a list in polars

to_list

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-16

Python is big on lists because they are one of the fundamental data structures of the language. It’s no surprise that data analysis tasks in Python almost always involve using lists. Luckily, Polars allows you to collapse a series of rows into a list. Below is a dataframe showing sales from a clothing store.

shape: (1_000, 2)

| category  | quantity |
|-----------|----------|
| str       | i64      |
| "Hat"     | 1        |
| "Sweater" | 9        |
| "Sweater" | 12       |
| "Sweater" | 5        |
| "Sweater" | 19       |
| …         | …        |
| "Sweater" | 2        |
| "Socks"   | 19       |
| "Socks"   | 18       |
| "Sweater" | 15       |
| "Sweater" | 11       |

## Get list of clothing categories

Suppose you want to know the unique categories of clothing available at this store and store those categories in a list. How would you do it in Polars? You simply use the method `to_list`, but it’s a series method, not a dataframe method. Therefore, you’ll need to convert the dataframe into a series.

``` python
(df
 ['category']
 .unique()
 .to_list()
 )
```

    ['Socks', 'Sweater', 'Hat']

## The idiomatic way

Subscribers to the idiomatic way of writing Polars code, like myself, would frown upon the use of square brackets in the code above. Let me show you how to rewrite the code above (without embarrassment) if you, too, want to be a Polars connoisseur.

``` python
(df
 .select('category')
 .unique()
 .to_series()
 .to_list()
 )
```

    ['Hat', 'Socks', 'Sweater']

Become a master of Polars my enrolling in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
