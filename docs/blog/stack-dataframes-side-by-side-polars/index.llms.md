# Stack polars dataframes side by side

hstack

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-11

If you have two tables with the same number of rows, you can combine them side by side to create a single table. Below are two dataframes to be combined.

**name_df**

shape: (4, 1)

| Name       |
|------------|
| str        |
| "Joram"    |
| "Eleonora" |
| "Lauren"   |
| "Enrico"   |

**profession_df**

shape: (4, 1)

| Profession          |
|---------------------|
| str                 |
| "Data Consultant"   |
| "Software Engineer" |
| "Nurse"             |
| "Film Producer"     |

## Combine dataframes

To combine the two dataframes into a single one, use the `hstack` method like this:

``` python
(name_df
 .hstack(profession_df)
 )
```

shape: (4, 2)

| Name       | Profession          |
|------------|---------------------|
| str        | str                 |
| "Joram"    | "Data Consultant"   |
| "Eleonora" | "Software Engineer" |
| "Lauren"   | "Nurse"             |
| "Enrico"   | "Film Producer"     |

Learn more in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
