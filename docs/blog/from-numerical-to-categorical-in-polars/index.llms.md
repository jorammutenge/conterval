# Group numerical data into categorical buckets in polars

qcut

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-20

If you’re a movie buff like me, you probably subscribe to multiple streaming services. Suppose you wanted to categorize the cost of your subscription fees for these services into three categories: cheap, okay, and expensive. How could you do it?

Below is a dataframe showing various streaming services.

shape: (7, 2)

| Subscription | Price |
|--------------|-------|
| str          | f64   |
| "Netflix"    | 15.49 |
| "Hulu"       | 7.99  |
| "HBO Max"    | 15.99 |
| "Showtime"   | 10.99 |
| "Paramount"  | 11.99 |
| "Disney+"    | 7.99  |
| "AMC"        | 8.99  |

It’s difficult to look at a table full of numbers and decide which category each streaming service belongs to based on price. To make this process easier, you can use the Polars expression `qcut` as shown below:

``` python
(df
 .with_columns(pl.col('Price').qcut([0.25, 0.75],
               labels=['Cheap','Okay','Expensive'])
               .alias('Category')
               )
 )
```

shape: (7, 3)

| Subscription | Price | Category    |
|--------------|-------|-------------|
| str          | f64   | cat         |
| "Netflix"    | 15.49 | "Expensive" |
| "Hulu"       | 7.99  | "Cheap"     |
| "HBO Max"    | 15.99 | "Expensive" |
| "Showtime"   | 10.99 | "Okay"      |
| "Paramount"  | 11.99 | "Okay"      |
| "Disney+"    | 7.99  | "Cheap"     |
| "AMC"        | 8.99  | "Okay"      |

The code above divides the range of values in *Price* based on quantile probabilities. Now you can simply look at the streaming service and the *Category* column to see whether it’s within your budget.

Learn more in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)!
