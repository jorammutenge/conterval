# Change numbers from positive to negative and vice versa in polars

neg

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-08

You want to understand what makes your life better, so you start assigning a Collins score to each day to gain insights from your high-scoring days. However, after five entries, you realize that your numbers are reversed. The positive values should be negative, and the negative ones should be positive.

> **WARNING:**
>
> If you’ve never heard of the **Collins score**, stop reading this right now and google it. More importantly, google the man behind it **Jim Collins**.

Below is a dataframe showing your entries.

shape: (5, 2)

| Day   | Collins Score |
|-------|---------------|
| str   | i64           |
| "Mon" | 1             |
| "Tue" | 2             |
| "Wed" | -1            |
| "Thu" | 0             |
| "Fri" | -2            |

## Swap signs on values

To swap the signs of the values in the dataframe above, use the Polars expression `neg` as shown below:

``` python
(df
 .with_columns(pl.col('Collins Score').neg())
 )
```

shape: (5, 2)

| Day   | Collins Score |
|-------|---------------|
| str   | i64           |
| "Mon" | -1            |
| "Tue" | -2            |
| "Wed" | 1             |
| "Thu" | 0             |
| "Fri" | 2             |

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more!
