# Remove leading whitespace from text values in polars

strip_chars_start

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-20

Your data may contain leading characters like spaces or tabs due to bad user input. Below is a dataframe showing values with leading whitespace.

shape: (4, 2)

| Actress            | DOB          |
|--------------------|--------------|
| str                | str          |
| " Kate Winslet"    | "1975-10-05" |
| "  Lupita Nyong'o" | "1983-03-01" |
| "   Emma Stone"    | "1988-11-06" |
| " Gabrielle Union" | "1972-10-29" |

## Remove whitespace

To remove the unnecessary spaces and tabs at the beginning of values in *Actress*, you can use the Polars expression `strip_chars_start`, like this:

``` python
(df
 .with_columns(pl.col('Actress').str.strip_chars_start())
 )
```

shape: (4, 2)

| Actress           | DOB          |
|-------------------|--------------|
| str               | str          |
| "Kate Winslet"    | "1975-10-05" |
| "Lupita Nyong'o"  | "1983-03-01" |
| "Emma Stone"      | "1988-11-06" |
| "Gabrielle Union" | "1972-10-29" |

I want you to start learning in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
