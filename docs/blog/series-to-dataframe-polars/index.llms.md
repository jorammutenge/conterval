# Turn a polars series to a dataframe

to_frame

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-09

In Polars, a series is a one-column table, while a dataframe is a multi-column table. However, it’s possible to convert a series into a dataframe. Below is a series of cities.

shape: (5_339,)

| City            |
|-----------------|
| str             |
| "GANADO"        |
| "WEST MEMPHIS"  |
| "MIAMI"         |
| "BRADENTON"     |
| "BOISE"         |
| …               |
| "SHELBYVILLE"   |
| "DAYTON"        |
| "WICHITA FALLS" |
| "GULF BREEZE"   |
| "SWEET SPRINGS" |

## Convert series to dataframe

Notice that the series above has a shape of (5339,). This indicates that it contains 5339 values. Polars doesn’t need to display the number of columns in the shape because a series always has one column, which is already named *City*.

To convert the series to a dataframe, use the `to_frame` method like this:

``` python
(ser
 .to_frame()
 )
```

shape: (5_339, 1)

| City            |
|-----------------|
| str             |
| "GANADO"        |
| "WEST MEMPHIS"  |
| "MIAMI"         |
| "BRADENTON"     |
| "BOISE"         |
| …               |
| "SHELBYVILLE"   |
| "DAYTON"        |
| "WICHITA FALLS" |
| "GULF BREEZE"   |
| "SWEET SPRINGS" |

## Why convert to dataframe

You may want to save your series data to a CSV file, but calling `ser.write_csv()` will result in an attribute error because `write_csv` is not a method of a series; it belongs to dataframes. So, to save your series data, you must first convert it to a dataframe and then save it.

Start learning Polars with my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
