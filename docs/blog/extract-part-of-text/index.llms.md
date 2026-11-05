# Extract the first few characters of text in polars

str.head

100DaysOfPolars

Author

Joram Mutenge

Published

2025-11-24

Sometimes you may need to extract the first five or seven characters from a text value. This is useful when working with long strings. The following example uses a dataframe of Canadian provinces.

shape: (3, 1)

| Provinces      |
|----------------|
| str            |
| "Newfoundland" |
| "Saskatchewan" |
| "Manitoba"     |

## Get first 5 letters

To get the first five letters of each province name, use the Polars expression `str.head` like this:

``` python
(df
 .with_columns(First_5_Chars=pl.col('Provinces').str.head(5))
 )
```

shape: (3, 2)

| Provinces      | First_5_Chars |
|----------------|---------------|
| str            | str           |
| "Newfoundland" | "Newfo"       |
| "Saskatchewan" | "Saska"       |
| "Manitoba"     | "Manit"       |

> **TIP:**
>
> To get the last five letters, use the Polars expression `str.tail`.

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more.
