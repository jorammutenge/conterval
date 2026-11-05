# Turning a polars dataframe to long format with explode

explode

100DaysOfPolars

Author

Joram Mutenge

Published

2025-06-20

Tabular data is easier to process when columns contain singular values of the same data type for each row. However, sometimes data can be stored as a list in a single row.

Here’s an example of a dataframe where the data in *Subject* is stored as a list.

shape: (2, 2)

| Name       | Subjects                 |
|------------|--------------------------|
| str        | str                      |
| "Eleonora" | "Math,Physics,Economics" |
| "Marion"   | "French,Phyics,Theater"  |

## Why storing data this way is bad

Dataframe libraries like Polars excel at vectorized (parallel) computation. That’s their core strength. However, when data is stored like in the dataframe above, vectorized computations become difficult to perform. For example, if the table contained many students, answering questions like:

- Which subject is taken by every student?
- How many subjects are represented?

would be difficult to compute.

## Turn dataframe to long format

The dataframe above is in what is known as wide format. We need to transform it to long format to answer the questions above more easily. Polars provides the `explode` function, which allows us to transform the dataframe to long format. Here’s how it’s done.

``` python
(df
 .with_columns(pl.col('Subjects').str.split(','))
 )
```

shape: (2, 2)

| Name       | Subjects                           |
|------------|------------------------------------|
| str        | list\[str\]                        |
| "Eleonora" | \["Math", "Physics", "Economics"\] |
| "Marion"   | \["French", "Phyics", "Theater"\]  |

\
We had to convert the values in *Subject* into a list because `"Math,Physics,Economics"` is not a list data type–it’s a string. Splitting on the comma `,` ensures that each subject appears as an individual item in the list. Notice that the data type in the dataframe now shows as a list?

Now let’s explode the list values in *Subject* to make the dataframe longer.

``` python
(df
 .with_columns(pl.col('Subjects').str.split(','))
 .explode('Subjects')
 )
```

shape: (6, 2)

| Name       | Subjects    |
|------------|-------------|
| str        | str         |
| "Eleonora" | "Math"      |
| "Eleonora" | "Physics"   |
| "Eleonora" | "Economics" |
| "Marion"   | "French"    |
| "Marion"   | "Phyics"    |
| "Marion"   | "Theater"   |

Each subject now appears in its own row. This transformation makes it much easier to answer the two questions we posed earlier.

You’re invited to enroll in my popular [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
