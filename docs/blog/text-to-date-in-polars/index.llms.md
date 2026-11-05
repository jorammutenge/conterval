# Easily convert text to date values in polars

to_date

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-18

Usually, when you want to convert string (text) data to a date type, you have to introduce some esoteric formatting like “%m%d%Y”. Unfortunately, this looks like gibberish to most people. The good news is that in Polars, you don’t always need to know that strange formatting, especially when your data starts with the year.

Below is a dataframe showing date values stored as text.

shape: (4, 2)

| Itinerary     | Date         |
|---------------|--------------|
| str           | str          |
| "Los Angeles" | "2025-05-01" |
| "Syndney"     | "2025-05-15" |
| "Wellington"  | "2025-06-02" |
| "Tokio"       | "2025-06-17" |

## Convert text to date

Since the values in *Date* start with the year, then month, and day, you can use the Polars expression `to_date` to convert the data type from text to date, like this:

``` python
(df
 .with_columns(pl.col('Date').str.to_date())
 )
```

shape: (4, 2)

| Itinerary     | Date       |
|---------------|------------|
| str           | date       |
| "Los Angeles" | 2025-05-01 |
| "Syndney"     | 2025-05-15 |
| "Wellington"  | 2025-06-02 |
| "Tokio"       | 2025-06-17 |

Now the data type in *Date* has been successfully changed from text to date.

I have a [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) you can sign up for to learn more.
