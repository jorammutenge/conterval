# Get a value in a specific cell of a polars dataframe

item

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-22

Polars allows you to target a dataframe down to a specific value, such as selecting a value from a particular cell in the table. Below is a dataframe showing streaming services.

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

## Get specific value

To get a specific value from the dataframe, such as “Disney+”, use the `item` method like this:

``` python
(df
 .item(5,0)
 )
```

    'Disney+'

> **NOTE:**
>
> The output value “Disney+” is a string that can be used in other Python code unrelated to Polars. This is not the same as running this code:
>
> ``` python
> (df
>  .filter(pl.col('Subscription') == 'Disney+')
>  .select('Subscription')
>  )
> ```

Learn more in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)!
