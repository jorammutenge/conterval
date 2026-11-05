# Get unique values in a column in polars

unique

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-12

If one value in a column is overrepresented, you might think it’s the only value present since Polars displays only the first five and last five rows of the dataframe. To see the different kinds of values in a column, you need to ensure that each value is shown only once. Below is a dataframe showing cereal brands.

shape: (77, 2)

| manufacturer     | type   |
|------------------|--------|
| str              | str    |
| "Nabisco"        | "Cold" |
| "Quaker Oats"    | "Cold" |
| "Kellogs"        | "Cold" |
| "Kellogs"        | "Cold" |
| "Ralston Purina" | "Cold" |
| …                | …      |
| "General Mills"  | "Cold" |
| "General Mills"  | "Cold" |
| "Ralston Purina" | "Cold" |
| "General Mills"  | "Cold" |
| "General Mills"  | "Cold" |

## Show each value once

Say you want to see all the different types of cereal, you can select the *type* column and use the `unique` method to display each value only once like this:

``` python
(df
 .select('type')
 .unique()
 )
```

shape: (2, 1)

| type   |
|--------|
| str    |
| "Hot"  |
| "Cold" |

Now you can see that there are two types of cereal in this dataset: cold and hot.

I want you to be my student in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)
