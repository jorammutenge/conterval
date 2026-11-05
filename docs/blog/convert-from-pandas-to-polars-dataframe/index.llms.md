# How to convert from pandas to polars dataframe

pl.from_pandas

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-03

Polars is highly versatile. It can accept a Pandas dataframe and convert it into a Polars dataframe. This conversion is especially useful when working with HTML data, as Polars currently does not support reading directly from HTML.

## Reading HTML data with pandas

Yes, it’s possible to read HTML tables using Pandas, just as you would read data from a CSV file.

``` python
import pandas as pd

url = 'https://rstudio-pubs-static.s3.amazonaws.com/383830_4aef25cdc42f4fd88d09cc8217b8924c.html'

df = pd.read_html(url)[0]
df
```

|     | observation | beantype             | cocoapercent | rating |
|-----|-------------|----------------------|--------------|--------|
| 0   | 1           | Forastero (Arriba)   | 0.55         | 2.75   |
| 1   | 2           | Forastero (Arriba)   | 0.70         | 3.00   |
| 2   | 3           | Forastero            | 0.75         | 2.75   |
| 3   | 4           | Forastero (Nacional) | 0.70         | 3.50   |
| 4   | 5           | Criollo, Trinitario  | 0.70         | 3.50   |
| 5   | 6           | Forastero            | 0.70         | 3.50   |

## Change from pandas to polars dataframe

The `pl.from_pandas` expression allows us to turn a Pandas dataframe to a polars dataframe. Here’s how to use it.

``` python
import polars as pl

pl.from_pandas(df)
```

shape: (6, 4)

| observation | beantype               | cocoapercent | rating |
|-------------|------------------------|--------------|--------|
| i64         | str                    | f64          | f64    |
| 1           | "Forastero (Arriba)"   | 0.55         | 2.75   |
| 2           | "Forastero (Arriba)"   | 0.7          | 3.0    |
| 3           | "Forastero"            | 0.75         | 2.75   |
| 4           | "Forastero (Nacional)" | 0.7          | 3.5    |
| 5           | "Criollo, Trinitario"  | 0.7          | 3.5    |
| 6           | "Forastero"            | 0.7          | 3.5    |

\
Make your data analysis work easier by learning how to use Polars in this [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)
