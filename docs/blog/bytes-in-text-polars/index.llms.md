# Counting bytes in text in polars

len_bytes

100DaysOfPolars

Author

Joram Mutenge

Published

2025-11-11

The number of characters in text is not always the same as the number of bytes, especially when the text contains emojis. Below is a dataframe showing YouTube comments.

shape: (4, 1)

| YouTube_Comment                   |
|-----------------------------------|
| str                               |
| "🤔 I don't think this works IRL… |
| "💛💛"                            |
| "🔥"                              |
| "Wow!"                            |

## Count characters and bytes

To count the number of characters and bytes in each comment, use `len_chars` and `len_bytes` respectively. The code below shows how:

``` python
(df
 .with_columns(Chars=pl.col('YouTube_Comment').str.len_chars(),
               Bytes=pl.col('YouTube_Comment').str.len_bytes())
 )
```

shape: (4, 3)

| YouTube_Comment                   | Chars | Bytes |
|-----------------------------------|-------|-------|
| str                               | u32   | u32   |
| "🤔 I don't think this works IRL… | 31    | 34    |
| "💛💛"                            | 2     | 8     |
| "🔥"                              | 1     | 4     |
| "Wow!"                            | 4     | 4     |

> **NOTE:**
>
> An emoji with one character can have many bytes.

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more.
