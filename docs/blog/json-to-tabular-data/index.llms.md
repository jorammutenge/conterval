# From JSON to tabular data with polars

pl.json_normalize

100DaysOfPolars

Author

Joram Mutenge

Published

2025-12-22

JSON data obtained through an API call can be nested at multiple levels, making it difficult to analyze. Fortunately, Polars can read JSON data at multiple levels, ensuring that the data is fully un-nested. Below is some JSON data to load into a dataframe.

``` python
data = [
    {
        "id": 1,
        "name": "Dan Humphrey",
        "fitness": {"height": 180, "weight": 85},
    },
    {
        "id": 2,
        "name": "Blair Waldolf",
        "fitness": {"height": 155, "weight": 58},
    }
]
```

## Read data at level zero

We can start by unnesting the first level. This will return a three-column dataframe:

``` python
import polars as pl

pl.json_normalize(data, max_level=0)
```

shape: (2, 3)

| id  | name            | fitness                         |
|-----|-----------------|---------------------------------|
| i64 | str             | str                             |
| 1   | "Dan Humphrey"  | "{"height": 180, "weight": 85}" |
| 2   | "Blair Waldolf" | "{"height": 155, "weight": 58}" |

## Read data at level one

Some nested data remains in the *fitness* column. We can unnest it by increasing the level by 1:

``` python
pl.json_normalize(data, max_level=1)
```

shape: (2, 4)

| id  | name            | fitness.height | fitness.weight |
|-----|-----------------|----------------|----------------|
| i64 | str             | i64            | i64            |
| 1   | "Dan Humphrey"  | 180            | 85             |
| 2   | "Blair Waldolf" | 155            | 58             |

Discover even more ways to use Polars in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
