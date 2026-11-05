# Get row as dicitonary from polars dataframe

row

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-21

The Polars dataframe is highly accessible. In fact, you can get a row as a dictionary and use it directly in your Python code. Below is a dataframe showing clothing brands.

shape: (4, 3)

| Brand       | Category  | Price |
|-------------|-----------|-------|
| str         | str       | i64   |
| "Gucci"     | "Premium" | 1000  |
| "Versace"   | "Premium" | 5000  |
| "Forever21" | "Basic"   | 39    |
| "Gap"       | "Basic"   | 56    |

## Get row as dictionary

To get the second row as a dictionary from a Polars dataframe, you use the `row` method as like this:

``` python
(df
 .row(2, named=True)
 )
```

    {'Brand': 'Forever21', 'Category': 'Basic', 'Price': 39}

You now have a dictionary where the keys are column names and the values are the corresponding row values.

Join over 150 students in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to sharpen your Polars skills.
