# Assign column names while reading the file

new_columns

100DaysOfPolars

Author

Joram Mutenge

Published

2025-11-18

Most people read a CSV file with poorly named columns and then rename them afterward. If you’re one of those people, stop doing that. Below is a dataframe showing a CSV file read with original column names.

``` py
df1 = pl.read_csv('data.csv')
df1
```

shape: (5, 2)

| Col1      | Col2           |
|-----------|----------------|
| str       | str            |
| "Spencer" | "Bossy"        |
| "Emily"   | "Sporty"       |
| "Hannah"  | "Artistic"     |
| "Aria"    | "Word smith"   |
| "Mona"    | "Manipulative" |

## Assign column names on read

To assign column names as you read the CSV file, use the parameter `new_columns` and list the new columns names.

``` py
df2 = pl.read_csv('data.csv', new_columns=['Name','Character'])
df2
```

shape: (5, 2)

| Name      | Character      |
|-----------|----------------|
| str       | str            |
| "Spencer" | "Bossy"        |
| "Emily"   | "Sporty"       |
| "Hannah"  | "Artistic"     |
| "Aria"    | "Word smith"   |
| "Mona"    | "Manipulative" |

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more!
