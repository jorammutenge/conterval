# Convert a polars dataframe to a Python dictionary

to_dict

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-02

Dictionaries are an important data structure in Python. They’re used everywhere from storing data retrieved from web requests to keeping values in a lookup table by key. It’s no wonder Polars makes it easy to convert your dataframe to a Python dictionary.

Below is a dataframe of students and their characteristics:

shape: (5, 2)

| Student   | Character      |
|-----------|----------------|
| str       | str            |
| "Spencer" | "Bossy"        |
| "Emily"   | "Sporty"       |
| "Hannah"  | "Artistic"     |
| "Aria"    | "Word smith"   |
| "Mona"    | "Manipulative" |

## Convert to dictionary

To convert a Polars dataframe to a dictionary, use the `to_dict` method like this:

``` python
(df
 .to_dict(as_series=False)
 )
```

    {'Student': ['Spencer', 'Emily', 'Hannah', 'Aria', 'Mona'],
     'Character': ['Bossy', 'Sporty', 'Artistic', 'Word smith', 'Manipulative']}

When working with APIs, the data is usually in JSON format, which is the same structure as a Python dictionary. You can read your data with Polars, convert it to a dictionary, and then send it via the API. This way, you take advantage of Polars’ faster processing.

I’d be grateful if you became a student in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
