# Create hierarchy on text data in polars

Enum

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-29

Polars has a special data type that allows you to filter text values based on hierarchy. Let’s create a dataframe where the *Degree* column is of the data type `Enum`.

``` python
import polars as pl

education_level = ["High school", "BSc", "MSc", "PhD"]
education_enum = pl.Enum(education_level)

df = pl.DataFrame({
    "Name": ["Watson", "Justin", "Cheelo", "Joshua"],
    "Degree": pl.Series(["High school", "MSc", "PhD", "BSc"]),
})
df
```

shape: (4, 2)

| Name     | Degree        |
|----------|---------------|
| str      | str           |
| "Watson" | "High school" |
| "Justin" | "MSc"         |
| "Cheelo" | "PhD"         |
| "Joshua" | "BSc"         |

## Filter with inequality

Because the *Degree* column is of type `Enum`, you can use inequality symbols to filter text values as if they were numbers. For example, you can filter for students who have a master’s degree (MSc) or higher like this:

``` python
(df
 .filter(pl.col("Degree") >= "MSc")
 )
```

shape: (2, 2)

| Name     | Degree |
|----------|--------|
| str      | str    |
| "Justin" | "MSc"  |
| "Cheelo" | "PhD"  |

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more!
