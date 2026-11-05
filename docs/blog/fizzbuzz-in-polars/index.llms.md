# Did you know polars can execute fizzbuzz?

I didn’t know too, until I tried

data analysis

Author

Joram Mutenge

Published

2026-01-15

As a huge fan of the Polars data analysis library, I often find myself testing its capabilities to their limits. For example, I wanted to see whether I could implement the FizzBuzz challenge using Polars alone. No Python functions, just pure Polars. I will admit that I initially thought this would be beyond Polars’ capabilities. Spoiler alert, I was wrong.

As a refresher on what FizzBuzz is, I refer you to my other post titled [Can you do FizzBuzz in rust?](https://www.conterval.com/blog/fizzbuzz-in-rust/index.html)

## Implementing fizzbuzz in polars

Here is the complete code that implements FizzBuzz using pure Polars.

``` python
import polars as pl

(pl.int_range(1, 101, eager=True)
 .to_frame('Num')
 .with_columns(pl.when(pl.col('Num').mod(15) == 0)
               .then(pl.lit('FizzBuzz'))
               .when(pl.col('Num').mod(3) == 0)
               .then(pl.lit('Fizz'))
               .when(pl.col('Num').mod(5) == 0)
               .then(pl.lit('Buzz'))
               .otherwise(pl.col('Num'))
               .alias('Num')
              )
 )
```

shape: (100, 1)

| Num    |
|--------|
| str    |
| "1"    |
| "2"    |
| "Fizz" |
| "4"    |
| "Buzz" |
| …      |
| "Fizz" |
| "97"   |
| "98"   |
| "Fizz" |
| "Buzz" |

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more!
