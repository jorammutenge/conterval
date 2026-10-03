# The many ways to rename columns in polars

data analysis

Author

Joram Mutenge

Published

July 23, 2024

Dataframes that have column names with spaces in them can be annoying to work with. I like to remove any spaces or unusual characters from column names. This makes it easier to perform operations on the dataframe. The main advantage you get with columns that don’t have spaces is that you can access them using the dot method. Let me show you what I mean.

``` python
import polars as pl
pl.Config(tbl_rows=6) #this displays only 6 rows of dataframe
from pathlib import Path

df = pl.read_parquet(f"{Path('../../')}/datasets/regional_sales.parquet")
df
```

shape: (20, 5)

| Customer ID | Customer Name | Region Name | Segment | Sales In Dollars |
|----|----|----|----|----|
| i64 | str | str | str | i32 |
| 740150 | "Barton LLC" | "US" | "Gold" | 215000 |
| 714466 | "Trantow-Barrows" | "EMEA" | "Silver" | 430000 |
| 218895 | "Kulas Inc" | "EMEA" | "Platinum" | 410000 |
| … | … | … | … | … |
| 257198 | "Cronin, Oberbrunner and Spence… | "US" | "Platinum" | 425000 |
| 604255 | "Halvorson, Crona and Champlin" | "US" | null | 430000 |
| 163416 | "Purdy-Kunde" | "APAC" | "Silver" | 410000 |

The only column without a space in the dataframe above is `Segment`. I can access this column using the dot method as shown below.

``` python
df.select(pl.col.Segment)
```

shape: (20, 1)

| Segment    |
|------------|
| str        |
| "Gold"     |
| "Silver"   |
| "Platinum" |
| …          |
| "Platinum" |
| null       |
| "Silver"   |

However, I cannot use the dot method to access any of the columns with spaces, for instance, `Customer ID`. To access it I need to enclose the column name in square quotation marks as shown below.

``` python
df.select(pl.col('Customer ID'))
```

shape: (20, 1)

| Customer ID |
|-------------|
| i64         |
| 740150      |
| 714466      |
| 218895      |
| …           |
| 257198      |
| 604255      |
| 163416      |

Removing spaces in column names is the first data-cleaning step I take when I’m doing that analysis. I’ll show you three ways to clean up the column names in our dataframe.

#### Method 1

This is the manual way because it involves copying every column name with a space and giving it a name without a space. I don’t advise you to use this method if you have a dataset with many columns.

``` python
(df
 .rename({'Customer ID':'Customer_ID',
          'Customer Name':'Customer_Name',
          'Region Name':'Region_Name',
          'Sales In Dollars':'Sales_In_Dollars'})
)
```

shape: (20, 5)

| Customer_ID | Customer_Name | Region_Name | Segment | Sales_In_Dollars |
|----|----|----|----|----|
| i64 | str | str | str | i32 |
| 740150 | "Barton LLC" | "US" | "Gold" | 215000 |
| 714466 | "Trantow-Barrows" | "EMEA" | "Silver" | 430000 |
| 218895 | "Kulas Inc" | "EMEA" | "Platinum" | 410000 |
| … | … | … | … | … |
| 257198 | "Cronin, Oberbrunner and Spence… | "US" | "Platinum" | 425000 |
| 604255 | "Halvorson, Crona and Champlin" | "US" | null | 430000 |
| 163416 | "Purdy-Kunde" | "APAC" | "Silver" | 410000 |

#### Method 2

This may be considered the idiomatic polars way, although it uses many aspects of the library. As such, it may be difficult to remember.

``` python
(df
 .select(pl.all().name.map(lambda col: col.replace(' ', '_')))
 )
```

shape: (20, 5)

| Customer_ID | Customer_Name | Region_Name | Segment | Sales_In_Dollars |
|----|----|----|----|----|
| i64 | str | str | str | i32 |
| 740150 | "Barton LLC" | "US" | "Gold" | 215000 |
| 714466 | "Trantow-Barrows" | "EMEA" | "Silver" | 430000 |
| 218895 | "Kulas Inc" | "EMEA" | "Platinum" | 410000 |
| … | … | … | … | … |
| 257198 | "Cronin, Oberbrunner and Spence… | "US" | "Platinum" | 425000 |
| 604255 | "Halvorson, Crona and Champlin" | "US" | null | 430000 |
| 163416 | "Purdy-Kunde" | "APAC" | "Silver" | 410000 |

#### Method 3

This is my personal favorite. It’s short and easy to remember.

``` python
(df
 .rename(lambda col: col.replace(' ', '_'))
 )
```

shape: (20, 5)

| Customer_ID | Customer_Name | Region_Name | Segment | Sales_In_Dollars |
|----|----|----|----|----|
| i64 | str | str | str | i32 |
| 740150 | "Barton LLC" | "US" | "Gold" | 215000 |
| 714466 | "Trantow-Barrows" | "EMEA" | "Silver" | 430000 |
| 218895 | "Kulas Inc" | "EMEA" | "Platinum" | 410000 |
| … | … | … | … | … |
| 257198 | "Cronin, Oberbrunner and Spence… | "US" | "Platinum" | 425000 |
| 604255 | "Halvorson, Crona and Champlin" | "US" | null | 430000 |
| 163416 | "Purdy-Kunde" | "APAC" | "Silver" | 410000 |

Check out [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more about this new and fast data processing library.
