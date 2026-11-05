# Get schema of parquet file without reading data in polars

read_parquet_schema

100DaysOfPolars

Author

Joram Mutenge

Published

2025-11-22

You have a large Parquet dataset and want to determine its columns and their data types. However, you do not want to read the entire dataset just to retrieve this information. The path to the Parquet file is shown below.

``` py
data = 'file_data.parquet'
```

## Get schema on read

To get the schema of the file without reading the dataset contents, use the Polars function `read_parquet_schema` as like this:

``` py
pl.read_parquet_schema(data)
```

    Schema([('name', String),
            ('manufacturer', String),
            ('calories', Int64),
            ('rating', Float64)])

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more!
