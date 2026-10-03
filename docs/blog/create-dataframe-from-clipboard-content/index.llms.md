# Create dataframe from clipboard content

Using polars alone

data analysis

Author

Joram Mutenge

Published

May 27, 2024

It’s amazing how much the Polars library has improved! I remember sandwiching my polars code with pandas code to perform some operations. Even though the library was deficient for other operations, I didn’t want to let it go because I love it to bits.

There’s one operation I perform a lot in my work, and I wanted polars to have it so I could ditch pandas entirely in my code base.

So I wrote to the Polars team using our modern communication tool, X (or Twitter, for those who refuse to use the new name).

![](image1.png)

To my surprise, they listened to my request! Now you can create a dataframe from a table copied to your clipboard, without resorting to pandas.

Here’s how to do it.

![A dataframe copied from Excel](image2.png)

I’ve copied the table from Excel containing the names and positions of characters in the popular TV show *The Office*.

Then I run the following polars code to print the table as a dataframe.

``` python
import polars as pl

df = pl.read_clipboard()
df
```

shape: (6, 2)

| Character        | Position                         |
|------------------|----------------------------------|
| str              | str                              |
| "Michael Scott"  | "Regional Manager"               |
| "Dwight Schrute" | "Assistant to the Regional Mana… |
| "Jim Halpert"    | "Salesman / Co-Regional Manager… |
| "Pam Beesly"     | "Receptionist / Office Administ… |
| "Ryan Howard"    | "Temp / Vice President of North… |
| "Andy Bernard"   | "Salesman / Regional Manager (l… |

And there you have it! To learn more about this fast-growing library, check out my [Udemy course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/)!
