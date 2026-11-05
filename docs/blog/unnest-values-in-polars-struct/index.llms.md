# Unnesting values in a polars struct

unnest

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-24

Polars has a special data type called **struct**, which is useful for storing data efficiently without using too much memory. However, performing tabular operations on structs can be challenging. Fortunately, it’s easy to extract data from a struct into separate columns. Below is a dataframe showing movies and their attributes.

shape: (4, 1)

| Movie_Struct                     |
|----------------------------------|
| struct\[4\]                      |
| {"Margin Call",2011,7.1,107}     |
| {"The Big Short",2015,7.8,130}   |
| {"Arbitrage",2012,6.6,107}       |
| {"American Psycho",2000,7.6,104} |

## Unnest struct

To place each value in the struct into its own column, use the `unnest` method like this:

``` python
(df
 .unnest('Movie_Struct')
 )
```

shape: (4, 4)

| movie             | year | rating | minutes |
|-------------------|------|--------|---------|
| str               | i64  | f64    | i64     |
| "Margin Call"     | 2011 | 7.1    | 107     |
| "The Big Short"   | 2015 | 7.8    | 130     |
| "Arbitrage"       | 2012 | 6.6    | 107     |
| "American Psycho" | 2000 | 7.6    | 104     |

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more ways to analyze data.
