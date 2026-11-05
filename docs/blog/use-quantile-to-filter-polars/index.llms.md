# Using quantile to filter data in polars

quantile

100DaysOfPolars

Author

Joram Mutenge

Published

2025-08-13

If you’ve ever taken the SAT, ACT, or GMAT, you might have wondered what percentile you scored in. A percentile is a way of describing a score’s position in a dataset relative to the other scores. Below is a dataset showing the scores of students on a test.

shape: (5, 2)

| Student   | Score |
|-----------|-------|
| str       | i64   |
| "Harvey"  | 88    |
| "Donna"   | 76    |
| "Mike"    | 93    |
| "Jessica" | 85    |
| "Louis"   | 91    |

## Filter with quantile

You can get the students who scored in the 50th percentile by using the Polars expression `quantile`. These are the students who performed better than half of the students in the dataset.

``` python
(df
 .filter(pl.col('Score').gt(pl.col('Score').quantile(.50)))
 )
```

shape: (2, 2)

| Student | Score |
|---------|-------|
| str     | i64   |
| "Mike"  | 93    |
| "Louis" | 91    |

Join 100+ students improving their polars skills in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
