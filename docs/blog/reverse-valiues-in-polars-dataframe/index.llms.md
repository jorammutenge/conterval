# Reverse values in a polars dataframe

reverse

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-23

Polars allows you to reverse the values in your dataframe so that the last row becomes the first. Below is a dataframe showing the itinerary of a businessperson like yourself.

shape: (4, 2)

| Itinerary     | Date         |
|---------------|--------------|
| str           | str          |
| "Los Angeles" | "2025-05-01" |
| "Syndney"     | "2025-05-15" |
| "Wellington"  | "2025-06-02" |
| "Tokio"       | "2025-06-17" |

## Reverse values

Suppose you realize that your final destination is Los Angeles, not Tokyo. How can you reverse the values in the dataframe? You can use the `reverse` method like this:

``` python
(df
 .reverse()
 )
```

shape: (4, 2)

| Itinerary     | Date         |
|---------------|--------------|
| str           | str          |
| "Tokio"       | "2025-06-17" |
| "Wellington"  | "2025-06-02" |
| "Syndney"     | "2025-05-15" |
| "Los Angeles" | "2025-05-01" |

> **CAUTION:**
>
> I know that reversing in this context doesn’t make much sense because the dates won’t be chronological. I’m merely demonstrating how to reverse values in a dataframe.

Learn even more Polars tricks from my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
