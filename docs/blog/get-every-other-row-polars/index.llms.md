# Getting every other row of the dataframe with polars

gather_every

100DaysOfPolars

Author

Joram Mutenge

Published

2025-06-30

There comes a time when you want to extract every other row from your DataFrame. What I mean is: get the first row, skip the second, get the third, skip the fourth, and so on.

Say you have the dataframe below:

shape: (10, 3)

| Episode_Title          | Release_Date | Director             |
|------------------------|--------------|----------------------|
| str                    | date         | str                  |
| "Pilot"                | 2011-06-23   | "Kevin Bray"         |
| "Errors and Omissions" | 2011-06-30   | "John Scott"         |
| "Inside Track"         | 2011-07-07   | "Kevin Bray"         |
| "Dirty Little Secrets" | 2011-07-14   | "Dennie Gordon"      |
| "Bail Out"             | 2011-07-21   | "Kate Woods"         |
| "Tricks of the Trade"  | 2011-07-28   | "Terry McDonough"    |
| "Play the Man"         | 2011-08-04   | "Tim Matheson"       |
| "Identity Crisis"      | 2011-08-11   | "Norberto Barba"     |
| "Undefeated"           | 2011-08-18   | "Felix Alcala"       |
| "Shelf Life"           | 2011-08-25   | "Jennifer Getzinger" |

\
And you want to select every odd-numbered row—like the first, third, fifth, etc.

I remember writing overly complex code with lambda functions just to achieve this.

## Getting every other row with polars

With Polars, you don’t have to torture yourself writing convoluted Python code. The `gather_every` function does exactly that.

``` python
(df
 .gather_every(2)
 )
```

shape: (5, 3)

| Episode_Title  | Release_Date | Director       |
|----------------|--------------|----------------|
| str            | date         | str            |
| "Pilot"        | 2011-06-23   | "Kevin Bray"   |
| "Inside Track" | 2011-07-07   | "Kevin Bray"   |
| "Bail Out"     | 2011-07-21   | "Kate Woods"   |
| "Play the Man" | 2011-08-04   | "Tim Matheson" |
| "Undefeated"   | 2011-08-18   | "Felix Alcala" |

\
Isn’t that cool?

Even cooler ways to use Polars in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)!
