# Retrieving a schema from a table in polars

collect_schema

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-18

In addition to showing column data types in the dataframe, Polars allows you to get a dictionary of data types where the key is the column name and the value is the data type. This is especially helpful when you’re writing data to a database and want the schema to be maintained. Below is a dataframe with various data types.

shape: (5, 4)

| date                | sku        | quantity | unit price |
|---------------------|------------|----------|------------|
| datetime\[μs\]      | str        | i64      | f64        |
| 2013-12-21 23:59:55 | "LK-02338" | 8        | 43.46      |
| 2013-12-29 11:36:39 | "ZC-07383" | 3        | 82.71      |
| 2014-07-26 06:58:04 | "ZC-07383" | 7        | 52.88      |
| 2013-10-09 03:43:24 | "XX-25746" | 3        | 15.37      |
| 2014-06-24 16:37:56 | "HX-24728" | 4        | 44.87      |

## Get data types as dictionary

To get the data types as a dictionary, you can use the Polars method `collect_schema`. Here’s how to do it:

``` python
print(df
 .collect_schema()
)
```

    Schema({'date': Datetime(time_unit='us', time_zone=None), 'sku': String, 'quantity': Int64, 'unit price': Float64})

## Get names, keys from schema

The schema dictionary has properties that you can access. For instance, if you only want the table column names from the schema, you can get them like this:

``` python
(df
 .collect_schema()
 .names()
)
```

    ['date', 'sku', 'quantity', 'unit price']

Or, if you want the data types, you can get them like this:

``` python
(df
 .collect_schema()
 .keys()
)
```

    odict_keys(['date', 'sku', 'quantity', 'unit price'])

My [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) is accepting enrollments. I can’t wait to teach you!
