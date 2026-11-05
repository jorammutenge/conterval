# Store values from a row into a single column

transpose

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-09

For presentation purposes, you may want to have the values from a row stored in a single column. Below is a dataframe showing electronic gadgets.

shape: (4, 3)

| Brand       | Product      | Price |
|-------------|--------------|-------|
| str         | str          | i64   |
| "Sharp"     | "TV"         | 400   |
| "Panasonic" | "Speaker"    | 300   |
| "Aiwa"      | "Stereo"     | 700   |
| "Sony"      | "Headphones" | 150   |

## Get row values in one column

To get the values of a single row into its own column in Polars, use the `transpose` method like this:

``` python
(df
 .transpose(include_header=False,
            header_name='',
            column_names=[' ' * i for i in range(4)],
            )
 )
```

shape: (3, 4)

|         |             |          |              |
|---------|-------------|----------|--------------|
| str     | str         | str      | str          |
| "Sharp" | "Panasonic" | "Aiwa"   | "Sony"       |
| "TV"    | "Speaker"   | "Stereo" | "Headphones" |
| "400"   | "300"       | "700"    | "150"        |

Now each gadget, along with its brand and price, is stored in one column.

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn even more ways to analyze data with Polars.
