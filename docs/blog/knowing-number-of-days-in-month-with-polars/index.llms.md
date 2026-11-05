# How to know the number of days in each month with polars

dt.month_end

100DaysOfPolars

Author

Joram Mutenge

Published

2025-06-29

If I asked you, “How many days are in each month of the calendar?” most people would be able to answer for a few months, but not all.

I, on the other hand, never had this problem. At the age of 10, I memorized a line from a TV ad that went:

> “Thirty days hath September, April, June, and November. All the rest have thirty-one, except for February, which has twenty-eight.”

I’ve never forgotten that line–partly because I loved the ad, and partly because it turned out to be surprisingly useful.

## Using polars to know the number of days

But let’s say you’re not as fortunate as I was, and you’re unsure whether April has 30 or 31 days. That’s where Polars can help.

Suppose we have the following dataframe with *Month* and *Date* columns:

shape: (5, 2)

| Month | Date       |
|-------|------------|
| str   | date       |
| "Jan" | 2024-01-13 |
| "Feb" | 2024-02-15 |
| "Mar" | 2024-03-17 |
| "Apr" | 2024-04-19 |
| "May" | 2024-05-21 |

We can use the `month_end` function to determine the last day of each month. This tells us exactly how many days that month has.

``` python
(df
 .with_columns(Month_End=pl.col('Date').dt.month_end())
 )
```

shape: (5, 3)

| Month | Date       | Month_End  |
|-------|------------|------------|
| str   | date       | date       |
| "Jan" | 2024-01-13 | 2024-01-31 |
| "Feb" | 2024-02-15 | 2024-02-29 |
| "Mar" | 2024-03-17 | 2024-03-31 |
| "Apr" | 2024-04-19 | 2024-04-30 |
| "May" | 2024-05-21 | 2024-05-31 |

Now you know that April has only 30 days, without needing to memorize a rhyme from a TV ad from my childhood. Incidentally, that line is actually from a nursery rhyme.

Even more tricks from my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)!
