# Converting unix timestamp to polars datetime

pl.from_epoch

100DaysOfPolars

Author

Joram Mutenge

Published

2025-06-24

Computers are good at recording timestamps, but they do it in Unix time. Sadly, humans aren’t great at interpreting Unix time.

Below is a dataframe of YouTube comments where users posted what they considered to be the best opening line in literature.

shape: (4, 3)

| Commment                         | User         | Unix_Time         |
|----------------------------------|--------------|-------------------|
| str                              | str          | f64               |
| "In my younger and more vulnera… | "@fscott"    | 1698592675.131816 |
| "Call me Ishmael."               | "@hmelville" | 1680453910.612181 |
| "It was the best of times, it w… | "@cdickens"  | 1701274456.134241 |
| "It is a truth universally ackn… | "@jausten"   | 1701274277.673785 |

\

## From Unix time to normal datetime

Unless you’re familiar with interpreting Unix timestamps, it’s difficult to tell when each comment was posted. Fortunately, Polars makes it easy to convert these timestamps into a human-readable format. Here’s how to do it.

``` python
(df
 .with_columns(Datetime=pl.from_epoch('Unix_Time'))
 )
```

shape: (4, 4)

| Commment | User | Unix_Time | Datetime |
|----|----|----|----|
| str | str | f64 | datetime\[μs\] |
| "In my younger and more vulnera… | "@fscott" | 1.6986e9 | 2023-10-29 15:17:55.131816 |
| "Call me Ishmael." | "@hmelville" | 1.6805e9 | 2023-04-02 16:45:10.612181 |
| "It was the best of times, it w… | "@cdickens" | 1.7013e9 | 2023-11-29 16:14:16.134241 |
| "It is a truth universally ackn… | "@jausten" | 1.7013e9 | 2023-11-29 16:11:17.673785 |

\
Now you can see the exact date, hour, and even minute each comment was posted.

Learn even more ways to analyze data in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
