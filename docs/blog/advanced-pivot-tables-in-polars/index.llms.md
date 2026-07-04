# Advanced pivot tables with polars

Sometimes group by does the trick

data analysis

Author

Joram Mutenge

Published

2026-07-03

As a data professional, it’s inevitable that you’ll end up creating a pivot table. Stakeholders love pivot tables, and they won’t pass up a chance to request one from you. It’s not surprising that most people think of Microsoft Excel when they hear *PivotTable*. It turns out that Microsoft held a trademark on the term in the United States from 1994 to 2020. Today, however, the name *PivotTable* has become so generic that it no longer qualifies for trademark protection.

![](image.jpeg)

Hex swag I got at PyConUS 2026

Fortunately, pivot tables can also be created with Polars. This means you won’t have to export your data to Excel and fiddle with it just to create a pivot table.

## The dataset

I’ll be using sales funnel data. In business, some sales cycles are very long; for instance, those involving enterprise software or capital equipment, and management often wants to understand them in more detail throughout the year. The following are some of the questions they are likely to ask:

1.  How much revenue is in the pipeline?
2.  What products are in the pipeline?
3.  Who has which products at what stage?
4.  How likely are we to close deals by year-end?

Larger companies typically have CRM tools or other software that the sales team uses to track the sales process. Still, many people simply export the data to Excel, where they summarize it by creating a pivot table.

The benefits of creating a pivot table with Polars are:

- It’s quicker once it’s set up.
- It’s self-documenting. You can look at the code and understand what it does.
- It’s easier to generate multiple reports.
- It offers the flexibility to define custom aggregation functions.

Let’s read in the data.

``` python
import polars as pl
pl.Config(set_tbl_rows=20)

df = pl.read_excel('https://pbpython.com/extras/sales-funnel.xlsx')
df
```

shape: (17, 8)

| Account | Name | Rep | Manager | Product | Quantity | Price | Status |
|----|----|----|----|----|----|----|----|
| i64 | str | str | str | str | i64 | i64 | str |
| 714466 | "Trantow-Barrows" | "Craig Booker" | "Debra Henley" | "CPU" | 1 | 30000 | "presented" |
| 714466 | "Trantow-Barrows" | "Craig Booker" | "Debra Henley" | "Software" | 1 | 10000 | "presented" |
| 714466 | "Trantow-Barrows" | "Craig Booker" | "Debra Henley" | "Maintenance" | 2 | 5000 | "pending" |
| 737550 | "Fritsch, Russel and Anderson" | "Craig Booker" | "Debra Henley" | "CPU" | 1 | 35000 | "declined" |
| 146832 | "Kiehn-Spinka" | "Daniel Hilton" | "Debra Henley" | "CPU" | 2 | 65000 | "won" |
| 218895 | "Kulas Inc" | "Daniel Hilton" | "Debra Henley" | "CPU" | 2 | 40000 | "pending" |
| 218895 | "Kulas Inc" | "Daniel Hilton" | "Debra Henley" | "Software" | 1 | 10000 | "presented" |
| 412290 | "Jerde-Hilpert" | "John Smith" | "Debra Henley" | "Maintenance" | 2 | 5000 | "pending" |
| 740150 | "Barton LLC" | "John Smith" | "Debra Henley" | "CPU" | 1 | 35000 | "declined" |
| 141962 | "Herman LLC" | "Cedric Moss" | "Fred Anderson" | "CPU" | 2 | 65000 | "won" |
| 163416 | "Purdy-Kunde" | "Cedric Moss" | "Fred Anderson" | "CPU" | 1 | 30000 | "presented" |
| 239344 | "Stokes LLC" | "Cedric Moss" | "Fred Anderson" | "Maintenance" | 1 | 5000 | "pending" |
| 239344 | "Stokes LLC" | "Cedric Moss" | "Fred Anderson" | "Software" | 1 | 10000 | "presented" |
| 307599 | "Kassulke, Ondricka and Metz" | "Wendy Yule" | "Fred Anderson" | "Maintenance" | 3 | 7000 | "won" |
| 688981 | "Keeling LLC" | "Wendy Yule" | "Fred Anderson" | "CPU" | 5 | 100000 | "won" |
| 729833 | "Koepp Ltd" | "Wendy Yule" | "Fred Anderson" | "CPU" | 2 | 65000 | "declined" |
| 729833 | "Koepp Ltd" | "Wendy Yule" | "Fred Anderson" | "Monitor" | 2 | 5000 | "presented" |

## Creating pivot tables

The `pivot` method is used to create a pivot table in Polars. However, not all data outputs that look like pivot tables are created with `pivot`. Sometimes, `group_by` does the trick.

Suppose we wanted to find the average (mean) *Account*, *Price*, and *Quantity* for each *Name*. We can do so using `group_by`.

``` python
(df
 .group_by('Name')
 .agg(pl.mean('Account','Price','Quantity'))
 )
```

shape: (12, 4)

| Name                           | Account  | Price    | Quantity |
|--------------------------------|----------|----------|----------|
| str                            | f64      | f64      | f64      |
| "Stokes LLC"                   | 239344.0 | 7500.0   | 1.0      |
| "Keeling LLC"                  | 688981.0 | 100000.0 | 5.0      |
| "Kassulke, Ondricka and Metz"  | 307599.0 | 7000.0   | 3.0      |
| "Kulas Inc"                    | 218895.0 | 25000.0  | 1.5      |
| "Kiehn-Spinka"                 | 146832.0 | 65000.0  | 2.0      |
| "Purdy-Kunde"                  | 163416.0 | 30000.0  | 1.0      |
| "Koepp Ltd"                    | 729833.0 | 35000.0  | 2.0      |
| "Herman LLC"                   | 141962.0 | 65000.0  | 2.0      |
| "Barton LLC"                   | 740150.0 | 35000.0  | 1.0      |
| "Trantow-Barrows"              | 714466.0 | 15000.0  | 1.333333 |
| "Fritsch, Russel and Anderson" | 737550.0 | 35000.0  | 1.0      |
| "Jerde-Hilpert"                | 412290.0 | 5000.0   | 2.0      |

In this case, the values in *Name* are unique keys that appear only once. If the original dataframe contained one name appearing two or more times, Polars would calculate the average of its values and display the company name only once in the final output. This is exactly what `group_by` does.

We can also `group_by` multiple columns.

``` python
(df
 .group_by('Name','Rep','Manager')
 .agg(pl.mean('Account','Price','Quantity'))
 )
```

shape: (12, 6)

| Name | Rep | Manager | Account | Price | Quantity |
|----|----|----|----|----|----|
| str | str | str | f64 | f64 | f64 |
| "Kulas Inc" | "Daniel Hilton" | "Debra Henley" | 218895.0 | 25000.0 | 1.5 |
| "Stokes LLC" | "Cedric Moss" | "Fred Anderson" | 239344.0 | 7500.0 | 1.0 |
| "Kassulke, Ondricka and Metz" | "Wendy Yule" | "Fred Anderson" | 307599.0 | 7000.0 | 3.0 |
| "Koepp Ltd" | "Wendy Yule" | "Fred Anderson" | 729833.0 | 35000.0 | 2.0 |
| "Trantow-Barrows" | "Craig Booker" | "Debra Henley" | 714466.0 | 15000.0 | 1.333333 |
| "Herman LLC" | "Cedric Moss" | "Fred Anderson" | 141962.0 | 65000.0 | 2.0 |
| "Keeling LLC" | "Wendy Yule" | "Fred Anderson" | 688981.0 | 100000.0 | 5.0 |
| "Barton LLC" | "John Smith" | "Debra Henley" | 740150.0 | 35000.0 | 1.0 |
| "Kiehn-Spinka" | "Daniel Hilton" | "Debra Henley" | 146832.0 | 65000.0 | 2.0 |
| "Jerde-Hilpert" | "John Smith" | "Debra Henley" | 412290.0 | 5000.0 | 2.0 |
| "Fritsch, Russel and Anderson" | "Craig Booker" | "Debra Henley" | 737550.0 | 35000.0 | 1.0 |
| "Purdy-Kunde" | "Cedric Moss" | "Fred Anderson" | 163416.0 | 30000.0 | 1.0 |

Of course, this is not a particularly useful output. A better result is one that shows a combination of manager and representative as the key values.

``` python
(df
 .group_by('Manager','Rep')
 .agg(pl.mean('Account','Price','Quantity'))
 )
```

shape: (5, 5)

| Manager         | Rep             | Account  | Price        | Quantity |
|-----------------|-----------------|----------|--------------|----------|
| str             | str             | f64      | f64          | f64      |
| "Debra Henley"  | "Craig Booker"  | 720237.0 | 20000.0      | 1.25     |
| "Fred Anderson" | "Wendy Yule"    | 614061.5 | 44250.0      | 3.0      |
| "Fred Anderson" | "Cedric Moss"   | 196016.5 | 27500.0      | 1.25     |
| "Debra Henley"  | "Daniel Hilton" | 194874.0 | 38333.333333 | 1.666667 |
| "Debra Henley"  | "John Smith"    | 576220.0 | 20000.0      | 1.5      |

The output above shows that Fred Anderson has two representatives, while Debra Henley has three.

We can also perform an aggregation on a single column. The *Account* and *Quantity* columns aren’t providing useful values here, so I’ll exclude them.

``` python
(df
 .group_by('Manager','Rep')
 .agg(pl.mean('Price'))
 )
```

shape: (5, 3)

| Manager         | Rep             | Price        |
|-----------------|-----------------|--------------|
| str             | str             | f64          |
| "Debra Henley"  | "Daniel Hilton" | 38333.333333 |
| "Fred Anderson" | "Wendy Yule"    | 44250.0      |
| "Fred Anderson" | "Cedric Moss"   | 27500.0      |
| "Debra Henley"  | "John Smith"    | 20000.0      |
| "Debra Henley"  | "Craig Booker"  | 20000.0      |

We can also use an aggregation other than `mean`.

``` python
(df
 .group_by('Manager','Rep')
 .agg(pl.sum('Price'))
 )
```

shape: (5, 3)

| Manager         | Rep             | Price  |
|-----------------|-----------------|--------|
| str             | str             | i64    |
| "Fred Anderson" | "Wendy Yule"    | 177000 |
| "Debra Henley"  | "Craig Booker"  | 80000  |
| "Debra Henley"  | "Daniel Hilton" | 115000 |
| "Fred Anderson" | "Cedric Moss"   | 110000 |
| "Debra Henley"  | "John Smith"    | 40000  |

Or even use multiple aggregation functions.

``` python
(df
 .group_by('Manager','Rep')
 .agg(pl.mean('Price').name.prefix('Avg_'), # <1>
      pl.count('Price').name.prefix('Count_'))
 )
```

1.  Since different aggregations are used on the same column *Price*, we must ensure that the final columns have different names, otherwise the code breaks. Polars dataframes can’t have multiple columns with the same name.

shape: (5, 4)

| Manager         | Rep             | Avg_Price    | Count_Price |
|-----------------|-----------------|--------------|-------------|
| str             | str             | f64          | u32         |
| "Fred Anderson" | "Wendy Yule"    | 44250.0      | 4           |
| "Debra Henley"  | "Daniel Hilton" | 38333.333333 | 3           |
| "Debra Henley"  | "Craig Booker"  | 20000.0      | 4           |
| "Fred Anderson" | "Cedric Moss"   | 27500.0      | 4           |
| "Debra Henley"  | "John Smith"    | 20000.0      | 2           |

Sometimes, we may want to see sales broken down by product. This is where `pivot` comes in. The values contained in the column specified by the `on` parameter become new columns in the final output.

``` python
(df
 .pivot(index=['Manager','Rep'],
        on='Product', values='Price',
        aggregate_function='sum')
 )
```

shape: (5, 6)

| Manager         | Rep             | CPU    | Software | Maintenance | Monitor |
|-----------------|-----------------|--------|----------|-------------|---------|
| str             | str             | i64    | i64      | i64         | i64     |
| "Debra Henley"  | "Craig Booker"  | 65000  | 10000    | 5000        | 0       |
| "Debra Henley"  | "Daniel Hilton" | 105000 | 10000    | 0           | 0       |
| "Debra Henley"  | "John Smith"    | 35000  | 0        | 5000        | 0       |
| "Fred Anderson" | "Cedric Moss"   | 95000  | 10000    | 5000        | 0       |
| "Fred Anderson" | "Wendy Yule"    | 165000 | 0        | 7000        | 5000    |

We can also use multiple columns in the `values` parameter.

``` python
(df
 .pivot(index=['Manager','Rep'],
        on='Product', values=['Price','Quantity'],
        aggregate_function='sum')
 )
```

shape: (5, 10)

| Manager | Rep | Price_CPU | Price_Software | Price_Maintenance | Price_Monitor | Quantity_CPU | Quantity_Software | Quantity_Maintenance | Quantity_Monitor |
|----|----|----|----|----|----|----|----|----|----|
| str | str | i64 | i64 | i64 | i64 | i64 | i64 | i64 | i64 |
| "Debra Henley" | "Craig Booker" | 65000 | 10000 | 5000 | 0 | 2 | 1 | 2 | 0 |
| "Debra Henley" | "Daniel Hilton" | 105000 | 10000 | 0 | 0 | 4 | 1 | 0 | 0 |
| "Debra Henley" | "John Smith" | 35000 | 0 | 5000 | 0 | 1 | 0 | 2 | 0 |
| "Fred Anderson" | "Cedric Moss" | 95000 | 10000 | 5000 | 0 | 3 | 1 | 1 | 0 |
| "Fred Anderson" | "Wendy Yule" | 165000 | 0 | 7000 | 5000 | 7 | 0 | 3 | 2 |

A rule of thumb I follow is that whenever you want the values in a column to become new columns in the final output, use `pivot`; otherwise, use `group_by`. So, if we want *Product* to be part of the index and don’t need a column for the `on` parameter, then we’ll have to use `group_by`.

``` python
(df
 .group_by('Manager','Rep','Product')
 .agg(pl.sum('Price','Quantity'))
 .sort('Manager','Rep','Product')
 )
```

shape: (13, 5)

| Manager         | Rep             | Product       | Price  | Quantity |
|-----------------|-----------------|---------------|--------|----------|
| str             | str             | str           | i64    | i64      |
| "Debra Henley"  | "Craig Booker"  | "CPU"         | 65000  | 2        |
| "Debra Henley"  | "Craig Booker"  | "Maintenance" | 5000   | 2        |
| "Debra Henley"  | "Craig Booker"  | "Software"    | 10000  | 1        |
| "Debra Henley"  | "Daniel Hilton" | "CPU"         | 105000 | 4        |
| "Debra Henley"  | "Daniel Hilton" | "Software"    | 10000  | 1        |
| "Debra Henley"  | "John Smith"    | "CPU"         | 35000  | 1        |
| "Debra Henley"  | "John Smith"    | "Maintenance" | 5000   | 2        |
| "Fred Anderson" | "Cedric Moss"   | "CPU"         | 95000  | 3        |
| "Fred Anderson" | "Cedric Moss"   | "Maintenance" | 5000   | 1        |
| "Fred Anderson" | "Cedric Moss"   | "Software"    | 10000  | 1        |
| "Fred Anderson" | "Wendy Yule"    | "CPU"         | 165000 | 7        |
| "Fred Anderson" | "Wendy Yule"    | "Maintenance" | 7000   | 3        |
| "Fred Anderson" | "Wendy Yule"    | "Monitor"     | 5000   | 2        |

This output makes much more sense, at least for this dataset. Now, what if we want to include a grand total row at the bottom of the dataframe, much like you would see in an Excel pivot table? In pandas, this is easy to achieve. The `pivot_table` function has a `margins=True` parameter that adds a grand total row.

By contrast, Polars does not have a `margins=True` parameter in its `pivot` method. However, the versatility of Polars makes it possible to create a grand total row yourself.

``` python
(df
 .group_by('Manager','Rep','Product')
 .agg(pl.sum('Price','Quantity').name.prefix('Sum_'),
      pl.mean('Price','Quantity').name.prefix('Avg_'))
 .sort('Manager','Rep','Product')
 .pipe(lambda _df: _df.vstack(
       _df.select(Manager=pl.lit('All'),
                  Rep=pl.lit(None, dtype=pl.String),
                  Product=pl.lit(None, dtype=pl.String),
                  Sum_Price=pl.sum('Sum_Price'),
                  Sum_Quantity=pl.sum('Sum_Quantity'),
                  Avg_Price=pl.mean('Avg_Price'),
                  Avg_Quantity=pl.mean('Avg_Quantity'),
                  )))
)
```

shape: (14, 7)

| Manager | Rep | Product | Sum_Price | Sum_Quantity | Avg_Price | Avg_Quantity |
|----|----|----|----|----|----|----|
| str | str | str | i64 | i64 | f64 | f64 |
| "Debra Henley" | "Craig Booker" | "CPU" | 65000 | 2 | 32500.0 | 1.0 |
| "Debra Henley" | "Craig Booker" | "Maintenance" | 5000 | 2 | 5000.0 | 2.0 |
| "Debra Henley" | "Craig Booker" | "Software" | 10000 | 1 | 10000.0 | 1.0 |
| "Debra Henley" | "Daniel Hilton" | "CPU" | 105000 | 4 | 52500.0 | 2.0 |
| "Debra Henley" | "Daniel Hilton" | "Software" | 10000 | 1 | 10000.0 | 1.0 |
| "Debra Henley" | "John Smith" | "CPU" | 35000 | 1 | 35000.0 | 1.0 |
| "Debra Henley" | "John Smith" | "Maintenance" | 5000 | 2 | 5000.0 | 2.0 |
| "Fred Anderson" | "Cedric Moss" | "CPU" | 95000 | 3 | 47500.0 | 1.5 |
| "Fred Anderson" | "Cedric Moss" | "Maintenance" | 5000 | 1 | 5000.0 | 1.0 |
| "Fred Anderson" | "Cedric Moss" | "Software" | 10000 | 1 | 10000.0 | 1.0 |
| "Fred Anderson" | "Wendy Yule" | "CPU" | 165000 | 7 | 82500.0 | 3.5 |
| "Fred Anderson" | "Wendy Yule" | "Maintenance" | 7000 | 3 | 7000.0 | 3.0 |
| "Fred Anderson" | "Wendy Yule" | "Monitor" | 5000 | 2 | 5000.0 | 2.0 |
| "All" | null | null | 522000 | 30 | 23615.384615 | 1.692308 |

Let’s look at the sales funnel at the manager level. At the moment, the *Status* column has the string data type. We’ll convert it to the enum data type and define the hierarchy in the order we want.

``` python
(df
 .with_columns(pl.col('Status').cast(pl.Enum(['won','pending','presented','declined'])))
 .group_by('Manager','Status')
 .agg(pl.sum('Price'))
 .sort('Manager','Status', descending=[False,True]) # <1>
 .pipe(lambda _df: _df.vstack(
     _df.select(Manager=pl.lit('All'),
                Status=pl.lit(None),
                Price=pl.sum('Price'),
                )))
 )
```

1.  Notice how values in *Status* follow the order set in the enum, although this time in reverse since `descending=True`.

shape: (9, 3)

| Manager         | Status      | Price  |
|-----------------|-------------|--------|
| str             | enum        | i64    |
| "Debra Henley"  | "declined"  | 70000  |
| "Debra Henley"  | "presented" | 50000  |
| "Debra Henley"  | "pending"   | 50000  |
| "Debra Henley"  | "won"       | 65000  |
| "Fred Anderson" | "declined"  | 65000  |
| "Fred Anderson" | "presented" | 45000  |
| "Fred Anderson" | "pending"   | 5000   |
| "Fred Anderson" | "won"       | 172000 |
| "All"           | null        | 522000 |

So far, we’ve used `group_by` and `pivot` separately. Once again, unlike pandas, where you can pass different aggregation functions for a single column or multiple columns in one pivot table call, Polars allows only one aggregation function at a time. However, the same result can be achieved by combining the `group_by` and `pivot` methods.

``` python
(df
 .group_by('Manager', 'Status', 'Product')
 .agg(Quantity=pl.len(),
      Price=pl.sum('Price'))
 .pivot(index=['Manager','Status'], on='Product',
        values=['Quantity','Price'], sort_columns=True)
 .sort('Manager','Status')
 .fill_null(0)
)
```

shape: (8, 10)

| Manager | Status | Quantity_CPU | Quantity_Maintenance | Quantity_Monitor | Quantity_Software | Price_CPU | Price_Maintenance | Price_Monitor | Price_Software |
|----|----|----|----|----|----|----|----|----|----|
| str | str | u32 | u32 | u32 | u32 | i64 | i64 | i64 | i64 |
| "Debra Henley" | "declined" | 2 | 0 | 0 | 0 | 70000 | 0 | 0 | 0 |
| "Debra Henley" | "pending" | 1 | 2 | 0 | 0 | 40000 | 10000 | 0 | 0 |
| "Debra Henley" | "presented" | 1 | 0 | 0 | 2 | 30000 | 0 | 0 | 20000 |
| "Debra Henley" | "won" | 1 | 0 | 0 | 0 | 65000 | 0 | 0 | 0 |
| "Fred Anderson" | "declined" | 1 | 0 | 0 | 0 | 65000 | 0 | 0 | 0 |
| "Fred Anderson" | "pending" | 0 | 1 | 0 | 0 | 0 | 5000 | 0 | 0 |
| "Fred Anderson" | "presented" | 1 | 0 | 1 | 1 | 30000 | 0 | 5000 | 10000 |
| "Fred Anderson" | "won" | 2 | 1 | 0 | 0 | 165000 | 7000 | 0 | 0 |

> **NOTE:**
>
> The aggregation functions used are `len` for *Quantity* and `sum` for *Price*.

We can also perform more than two aggregations.

``` python
df_pivot_table = (df
 .group_by('Manager', 'Status', 'Product')
 .agg(Quantity=pl.len(),
      Sum_Price=pl.sum('Price'), # <1>
      Avg_Price=pl.mean('Price'))
 .pivot(index=['Manager','Status'], on='Product',
        values=['Quantity','Sum_Price','Avg_Price'], sort_columns=True)
 .sort('Manager','Status')
 .fill_null(0)
)
df_pivot_table
```

1.  Another way of renaming instead of using `name.prefix` to ensure multiple columns don’t have the same name.

shape: (8, 14)

| Manager | Status | Quantity_CPU | Quantity_Maintenance | Quantity_Monitor | Quantity_Software | Sum_Price_CPU | Sum_Price_Maintenance | Sum_Price_Monitor | Sum_Price_Software | Avg_Price_CPU | Avg_Price_Maintenance | Avg_Price_Monitor | Avg_Price_Software |
|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| str | str | u32 | u32 | u32 | u32 | i64 | i64 | i64 | i64 | f64 | f64 | f64 | f64 |
| "Debra Henley" | "declined" | 2 | 0 | 0 | 0 | 70000 | 0 | 0 | 0 | 35000.0 | 0.0 | 0.0 | 0.0 |
| "Debra Henley" | "pending" | 1 | 2 | 0 | 0 | 40000 | 10000 | 0 | 0 | 40000.0 | 5000.0 | 0.0 | 0.0 |
| "Debra Henley" | "presented" | 1 | 0 | 0 | 2 | 30000 | 0 | 0 | 20000 | 30000.0 | 0.0 | 0.0 | 10000.0 |
| "Debra Henley" | "won" | 1 | 0 | 0 | 0 | 65000 | 0 | 0 | 0 | 65000.0 | 0.0 | 0.0 | 0.0 |
| "Fred Anderson" | "declined" | 1 | 0 | 0 | 0 | 65000 | 0 | 0 | 0 | 65000.0 | 0.0 | 0.0 | 0.0 |
| "Fred Anderson" | "pending" | 0 | 1 | 0 | 0 | 0 | 5000 | 0 | 0 | 0.0 | 5000.0 | 0.0 | 0.0 |
| "Fred Anderson" | "presented" | 1 | 0 | 1 | 1 | 30000 | 0 | 5000 | 10000 | 30000.0 | 0.0 | 5000.0 | 10000.0 |
| "Fred Anderson" | "won" | 2 | 1 | 0 | 0 | 165000 | 7000 | 0 | 0 | 82500.0 | 7000.0 | 0.0 | 0.0 |

## Advanced pivot table filtering

Interestingly, we can perform filter operations on *df_pivot_table* because, despite being a pivot table, it’s still a regular dataframe.

Let’s filter the rows for a single manager, Debra Henley.

``` python
(df_pivot_table
 .filter(Manager='Debra Henley')
 )
```

shape: (4, 14)

| Manager | Status | Quantity_CPU | Quantity_Maintenance | Quantity_Monitor | Quantity_Software | Sum_Price_CPU | Sum_Price_Maintenance | Sum_Price_Monitor | Sum_Price_Software | Avg_Price_CPU | Avg_Price_Maintenance | Avg_Price_Monitor | Avg_Price_Software |
|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| str | str | u32 | u32 | u32 | u32 | i64 | i64 | i64 | i64 | f64 | f64 | f64 | f64 |
| "Debra Henley" | "declined" | 2 | 0 | 0 | 0 | 70000 | 0 | 0 | 0 | 35000.0 | 0.0 | 0.0 | 0.0 |
| "Debra Henley" | "pending" | 1 | 2 | 0 | 0 | 40000 | 10000 | 0 | 0 | 40000.0 | 5000.0 | 0.0 | 0.0 |
| "Debra Henley" | "presented" | 1 | 0 | 0 | 2 | 30000 | 0 | 0 | 20000 | 30000.0 | 0.0 | 0.0 | 10000.0 |
| "Debra Henley" | "won" | 1 | 0 | 0 | 0 | 65000 | 0 | 0 | 0 | 65000.0 | 0.0 | 0.0 | 0.0 |

Or we can look at the pending and won deals.

``` python
(df_pivot_table
 .filter(pl.col('Status').is_in(['pending','won']))
 )
```

shape: (4, 14)

| Manager | Status | Quantity_CPU | Quantity_Maintenance | Quantity_Monitor | Quantity_Software | Sum_Price_CPU | Sum_Price_Maintenance | Sum_Price_Monitor | Sum_Price_Software | Avg_Price_CPU | Avg_Price_Maintenance | Avg_Price_Monitor | Avg_Price_Software |
|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| str | str | u32 | u32 | u32 | u32 | i64 | i64 | i64 | i64 | f64 | f64 | f64 | f64 |
| "Debra Henley" | "pending" | 1 | 2 | 0 | 0 | 40000 | 10000 | 0 | 0 | 40000.0 | 5000.0 | 0.0 | 0.0 |
| "Debra Henley" | "won" | 1 | 0 | 0 | 0 | 65000 | 0 | 0 | 0 | 65000.0 | 0.0 | 0.0 | 0.0 |
| "Fred Anderson" | "pending" | 0 | 1 | 0 | 0 | 0 | 5000 | 0 | 0 | 0.0 | 5000.0 | 0.0 | 0.0 |
| "Fred Anderson" | "won" | 2 | 1 | 0 | 0 | 165000 | 7000 | 0 | 0 | 82500.0 | 7000.0 | 0.0 | 0.0 |

Pivot tables are too useful and too powerful to remain the preserve of Microsoft Excel alone. They can be created with many data analysis tools, including Polars, pandas, and DuckDB.

Check out my Polars book to learn more about this powerful data analysis tool.

- [Deep Analysis with Polars, on Leanpub](https://leanpub.com/deep-analysis-with-polars)

- [Deep Analysis with Polars, on Amazon](https://www.amazon.com/dp/B0GXG1BHG6/)
