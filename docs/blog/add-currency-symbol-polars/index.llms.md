# Adding a currency symbol to polars dataframe values

pl.format

100DaysOfPolars

Author

Joram Mutenge

Published

2025-06-23

When your dataframe contains monetary values such as budgets it’s helpful to include a currency symbol. This ensures your audience clearly understands whether the figures are in dollars, euros, pounds, or another currency.

Below is an example of a dataframe that displays budget figures for each department at Duwata Company.

shape: (5, 2)

| Department    | Budget |
|---------------|--------|
| str           | i64    |
| "Hospitality" | 50000  |
| "Legal"       | 120000 |
| "Finance"     | 80000  |
| "Advertising" | 60000  |
| "Sales"       | 90000  |

## Add currency to budget figures

If you were presenting these values to the American division of Duwata, you might want to include the dollar symbol in the *Budget* column values.

Here’s how you can do that using Polars.

``` python
(df
 .select('Department','Budget')
 .with_columns(Budget=pl.format("${}", pl.col("Budget")))
 )
```

shape: (5, 2)

| Department    | Budget     |
|---------------|------------|
| str           | str        |
| "Hospitality" | "\$50000"  |
| "Legal"       | "\$120000" |
| "Finance"     | "\$80000"  |
| "Advertising" | "\$60000"  |
| "Sales"       | "\$90000"  |

\
If you were presenting the data to Duwata’s European division and wanted to use the euro symbol instead, you would simply replace `$` with `€`.

``` python
(df
 .select('Department','Budget')
 .with_columns(Budget=pl.format("€{}", pl.col("Budget")))
 )
```

shape: (5, 2)

| Department    | Budget    |
|---------------|-----------|
| str           | str       |
| "Hospitality" | "€50000"  |
| "Legal"       | "€120000" |
| "Finance"     | "€80000"  |
| "Advertising" | "€60000"  |
| "Sales"       | "€90000"  |

\

> **NOTE:**
>
> Adding a currency symbol to the values in the *Budget* column converts the data type from numeric to string. As a result, you can no longer perform numeric operations like division on this column. This formatting change is meant purely for presentation purposes, such as displaying the data in a PowerPoint slide or a PDF document.

Speed up your data analysis by enrolling in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
