# Get the chance of all events happening at once in polars

cum_prod

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-27

Probabilities are all around us, and if you work in the data field, you’re bound to encounter them. For example, what are the chances that you’ll get into Harvard, become a billionaire, or even better, get into Harvard *and* become a billionaire? Below is a dataframe showing the chances (probabilities) of each event happening to you.

shape: (4, 2)

| Event                | Chance |
|----------------------|--------|
| str                  | f64    |
| "Get into Harvard"   | 0.04   |
| "Become billionaire" | 0.5    |
| "Be happily married" | 0.12   |
| "Die a hero"         | 0.02   |

## Get chance of all events happening

To determine the chance of all four events happening to you, use the Polars expression `cum_prod` like this:

``` python
(df
 .with_columns(All_Happening=pl.col('Chance').cum_prod())
 )
```

shape: (4, 3)

| Event                | Chance | All_Happening |
|----------------------|--------|---------------|
| str                  | f64    | f64           |
| "Get into Harvard"   | 0.04   | 0.04          |
| "Become billionaire" | 0.5    | 0.02          |
| "Be happily married" | 0.12   | 0.0024        |
| "Die a hero"         | 0.02   | 0.000048      |

The last value in *All_Happening* represents the chance of all events happening. It turns out that your chance of getting into Harvard, becoming a billionaire, being happily married, and dying a hero is 1 in 21 thousand!

> **IMPORTANT:**
>
> The 1 in 21 thousand chance is not indicative of real-life odds. It’s based on fictitious values in the dataframe.

Sign up for my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more!
