# Count the occurrence of some text in a string in polars

count_matches

100DaysOfPolars

Author

Joram Mutenge

Published

2025-12-21

You have a table of passwords and, for some reason, you want to count the number of digits in each password. This is possible using Polars. Below is a dataframe of passwords.

shape: (3, 1)

| Password       |
|----------------|
| str            |
| "marm1te"      |
| "jam543"       |
| "p3anutButt3r" |

## Count number of digits in each password

You can count the number of digits in each password using the function `count_matches` like this:

``` python
(df
 .with_columns(pl.col('Password').str.count_matches(r'\d')
               .alias('Num_of_Digits'))
 )
```

shape: (3, 2)

| Password       | Num_of_Digits |
|----------------|---------------|
| str            | u32           |
| "marm1te"      | 1             |
| "jam543"       | 3             |
| "p3anutButt3r" | 2             |

Discover even more ways to use Polars in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
