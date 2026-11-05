# Adding an index to a polars dataframe

with_row_index

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-11

Ritchie Vink, the creator of Polars, once wrote something like this in a post (probably on Reddit):

> You don’t need an index. Come at me bro.

At least, that’s what I heard on *The Real Python* podcast. Whether it’s true or not, I share Ritchie’s sentiment. The index is one of the things I find most annoying about Pandas. Each time I want to save data to Excel or CSV, I have to remember to include `index=False`, and almost always forget to do it on the first attempt.

Not having an index is one of the ways Polars sets itself apart from other dataframe libraries. In most cases, you don’t need an index. But there are times when you do. Below is a dataframe with no index.

shape: (8, 2)

| Student   | Subject     |
|-----------|-------------|
| str       | str         |
| "Spencer" | "Chemistry" |
| "Spencer" | "Physics"   |
| "Emily"   | "Physics"   |
| "Emily"   | "Biology"   |
| "Hannah"  | "History"   |
| "Hannah"  | "Art"       |
| "Aria"    | "English"   |
| "Aria"    | "Biology"   |

## Add index to dataframe

To add an index to a Polars dataframe, use the `with_row_index` method like this:

``` python
df.with_row_index()
```

shape: (8, 3)

| index | Student   | Subject     |
|-------|-----------|-------------|
| u32   | str       | str         |
| 0     | "Spencer" | "Chemistry" |
| 1     | "Spencer" | "Physics"   |
| 2     | "Emily"   | "Physics"   |
| 3     | "Emily"   | "Biology"   |
| 4     | "Hannah"  | "History"   |
| 5     | "Hannah"  | "Art"       |
| 6     | "Aria"    | "English"   |
| 7     | "Aria"    | "Biology"   |

Notice that the index starts at zero. If you want it to start at a different number, such as 1, you can add the `offset` parameter like this:

``` python
df.with_row_index(offset=1)
```

shape: (8, 3)

| index | Student   | Subject     |
|-------|-----------|-------------|
| u32   | str       | str         |
| 1     | "Spencer" | "Chemistry" |
| 2     | "Spencer" | "Physics"   |
| 3     | "Emily"   | "Physics"   |
| 4     | "Emily"   | "Biology"   |
| 5     | "Hannah"  | "History"   |
| 6     | "Hannah"  | "Art"       |
| 7     | "Aria"    | "English"   |
| 8     | "Aria"    | "Biology"   |

I updated my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) on Udemy. Join 150+ students and level up your data analysis skills with this fast dataframe library.
