# Formatting dates in polars

dt.strftime

100DaysOfPolars

Author

Joram Mutenge

Published

2025-12-23

The representation of dates in data varies from region to region. In the USA, for instance, dates begin with the month rather than the day. Polars allows you to change how your dates are displayed depending on your audience. Below is a dataframe showing date values.

shape: (2, 1)

| Num_Date   |
|------------|
| date       |
| 2025-09-17 |
| 2025-12-23 |

## Format the date

You can format dates in either short or long form using the datetime component `dt.strftime` like this:

``` python
(df
 .with_columns(Short_Text_Date=pl.col('Num_Date').dt.strftime('%d %b, %Y'),
               Long_Text_Date=pl.col('Num_Date').dt.strftime('%d %B, %Y'),)
 )
```

shape: (2, 3)

| Num_Date   | Short_Text_Date | Long_Text_Date       |
|------------|-----------------|----------------------|
| date       | str             | str                  |
| 2025-09-17 | "17 Sep, 2025"  | "17 September, 2025" |
| 2025-12-23 | "23 Dec, 2025"  | "23 December, 2025"  |

All good things must come to an end. This marks the end of [100DaysOfPolars](https://www.conterval.com/blog/#category=100DaysOfPolars).

I have a [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) you can take to learn more about this powerful data analysis library.
