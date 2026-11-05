# Convert your data from wide to long format in polars

unpivot

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-19

Wide-format data (data with many columns) is good for presentation, but for computation, long format is best. That’s what computers love! Below is a dataframe showing software sold on different days of the week.

shape: (4, 6)

| Item        | Mon | Tue | Wed | Thu | Fri |
|-------------|-----|-----|-----|-----|-----|
| str         | i64 | i64 | i64 | i64 | i64 |
| "Photoshop" | 25  | 30  | 28  | 26  | 27  |
| "CorelDRAW" | 18  | 20  | 22  | 21  | 19  |
| "Netscape"  | 22  | 24  | 19  | 23  | 25  |
| "Encarta"   | 15  | 17  | 20  | 18  | 16  |

## Convert to long format

To convert the data to long format, you can use the Polars method `unpivot`, which is the opposite of `pivot`, like this:

``` python
(df
 .unpivot(index='Item',
          variable_name='Day',
          value_name='Units')
 )
```

shape: (20, 3)

| Item        | Day   | Units |
|-------------|-------|-------|
| str         | str   | i64   |
| "Photoshop" | "Mon" | 25    |
| "CorelDRAW" | "Mon" | 18    |
| "Netscape"  | "Mon" | 22    |
| "Encarta"   | "Mon" | 15    |
| "Photoshop" | "Tue" | 30    |
| …           | …     | …     |
| "Encarta"   | "Thu" | 18    |
| "Photoshop" | "Fri" | 27    |
| "CorelDRAW" | "Fri" | 19    |
| "Netscape"  | "Fri" | 25    |
| "Encarta"   | "Fri" | 16    |

Now the dataframe has fewer columns but many more rows, making it long format.

Join other students learning in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
