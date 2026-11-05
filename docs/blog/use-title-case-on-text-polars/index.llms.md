# Use title case on text in polars

to_titlecase

100DaysOfPolars

Author

Joram Mutenge

Published

2025-12-18

You have a table with authors in one column and the books they wrote in another. However, the book titles are all in lowercase, which is not the standard formatting for book titles.

shape: (4, 2)

| Author                | Book                     |
|-----------------------|--------------------------|
| str                   | str                      |
| "Harper Lee"          | "to kill a mocking bird" |
| "F. Scott Fitzgerald" | "this side of paradise"  |
| "Haruki Murakami"     | "men without women"      |
| "Binwell Sinyangwe"   | "quills of desire"       |

## Use title case

You can format the book titles properly in the dataframe using the Polars expression `to_titlecase` like this:

``` python
(df
 .with_columns(pl.col('Book').str.to_titlecase())
 )
```

shape: (4, 2)

| Author                | Book                     |
|-----------------------|--------------------------|
| str                   | str                      |
| "Harper Lee"          | "To Kill A Mocking Bird" |
| "F. Scott Fitzgerald" | "This Side Of Paradise"  |
| "Haruki Murakami"     | "Men Without Women"      |
| "Binwell Sinyangwe"   | "Quills Of Desire"       |

Learn more ways to use Polars in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
