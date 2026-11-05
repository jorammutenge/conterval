# Display thousand values with a comma separator in polars

pl.Config.set_thousands_separator

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-04

It’s easier to read large numerical values when they’re separated by a comma every three digits. For instance, your brain can more easily comprehend **5,000,000** at a glance than **5000000**. Polars allows you to format numerical values with commas to improve readability. Below is a dataframe showing department budgets for a company:

shape: (5, 2)

| Department    | Budget  |
|---------------|---------|
| str           | i64     |
| "Hospitality" | 5700000 |
| "Legal"       | 1200000 |
| "Finance"     | 8300000 |
| "Advertising" | 6800000 |
| "Sales"       | 9200000 |

## Insert commas in values

We can make the budget values more human-readable by separating each group of three digits with a comma. Here’s how to do it:

``` python
with pl.Config(thousands_separator=','):
    display(df)
```

shape: (5, 2)

| Department    | Budget    |
|---------------|-----------|
| str           | i64       |
| "Hospitality" | 5,700,000 |
| "Legal"       | 1,200,000 |
| "Finance"     | 8,300,000 |
| "Advertising" | 6,800,000 |
| "Sales"       | 9,200,000 |

If you live in Brazil (where the thousand separator is a full stop), you can replace `,` with `.`

``` python
with pl.Config(thousands_separator='.'):
    display(df)
```

shape: (5, 2)

| Department    | Budget    |
|---------------|-----------|
| str           | i64       |
| "Hospitality" | 5.700.000 |
| "Legal"       | 1.200.000 |
| "Finance"     | 8.300.000 |
| "Advertising" | 6.800.000 |
| "Sales"       | 9.200.000 |

> **TIP:**
>
> You can configure this setting globally so that all your dataframes use the same configuration. All you need to do is have these two lines at the beginning of your Python script.
>
> ``` py
> import polars as pl
> pl.Config(thousands_separator=',')
> ```

I teach Polars. Join my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
