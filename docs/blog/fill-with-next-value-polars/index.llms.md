# Replace null with next value in polars

backward_fill

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-04

Anyone working with data knows that encountering null values in a dataset is inevitable. There are several ways to fill null values in Polars. One approach is to replace each null value with the next non-null value that appears after it. Below is a dataframe showing companies and their corresponding company numbers.

shape: (5, 2)

| Company    | Number |
|------------|--------|
| str        | i64    |
| "Meta"     | null   |
| "Facebook" | 1001   |
| "Google"   | 1020   |
| "OpenAI"   | 2304   |
| "Oracle"   | 1022   |

## Fill null with value

To replace null values with the next value that follows them, use the Polars expression `backward_fill` as shown below:

``` python
(df
 .with_columns(pl.col('Number').backward_fill())
 )
```

shape: (5, 2)

| Company    | Number |
|------------|--------|
| str        | i64    |
| "Meta"     | 1001   |
| "Facebook" | 1001   |
| "Google"   | 1020   |
| "OpenAI"   | 2304   |
| "Oracle"   | 1022   |

Now the values in *Number* are filled. The opposite of this method is `forward_fill`.

I encourage you to enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
