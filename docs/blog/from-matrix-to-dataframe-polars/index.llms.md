# Turn a matrix of data to a polars dataframe

from_records

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-06

In data science and analysis, storing data in an array or nested arrays (a matrix) is a common practice. Unfortunately, performing operations directly on arrays can be challenging. Fortunately, Polars allows you to convert a matrix into a dataframe. Below is a matrix of people and their professions.

``` python
data_matrix = [['Joram','Ashwin','Ollie','Jeremie'], ['Data Consultant','Product Manager','Lawyer','Doctor']]
data_matrix
```

    [['Joram', 'Ashwin', 'Ollie', 'Jeremie'],
     ['Data Consultant', 'Product Manager', 'Lawyer', 'Doctor']]

## Turn matrix to dataframe

Polars provides the `from_records` expression, which creates a dataframe from matrix records. You can also add a schema to specify column names for the dataframe. Here’s how to use it:

``` python
import polars as pl
df = pl.from_records(data_matrix, schema=['Name', 'Profession'])
df
```

shape: (4, 2)

| Name      | Profession        |
|-----------|-------------------|
| str       | str               |
| "Joram"   | "Data Consultant" |
| "Ashwin"  | "Product Manager" |
| "Ollie"   | "Lawyer"          |
| "Jeremie" | "Doctor"          |

Join my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to improve your data analysis skills.
