# Get top values without sorting in polars

top_k

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-15

Sorting values is an expensive operation, especially when you have a large dataset. However, sometimes you have no choice but to sort the data, particularly when you need to pick the top 5 or 10 values. Below is a dataframe showing student scores on a test.

shape: (5, 2)

| Student   | Score |
|-----------|-------|
| str       | i64   |
| "Harvey"  | 88    |
| "Donna"   | 76    |
| "Mike"    | 93    |
| "Jessica" | 85    |
| "Louis"   | 91    |

## Get top 3 scores

Suppose you want to get the three students with the highest scores without sorting the data first. How can you do it? Polars has the method `top_k`, which you can use to accomplish exactly that.

``` python
(df
 .top_k(3, by='Score')
 )
```

shape: (3, 2)

| Student  | Score |
|----------|-------|
| str      | i64   |
| "Mike"   | 93    |
| "Louis"  | 91    |
| "Harvey" | 88    |

> **TIP:**
>
> If you want to get the bottom 3 students, use `bottom_k`.

Sign up for my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to improve your data analysis skills.
