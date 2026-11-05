# Creating dummy variables in a polars dataframe

to_dummies

100DaysOfPolars

Author

Joram Mutenge

Published

2025-09-12

Computers process numerical data faster than text data. That’s why it’s a good idea to convert text data into numerical data when training machine learning models. You want to squeeze out as much performance as possible from your machine. For instance, if you have a column *Is_Present*, instead of values like “Yes” and “No,” you should use 1 and 0 respectively.

Below is a dataframe showing the computer brands and the chip used in their computer models.

shape: (896, 2)

| brand     | chip       |
|-----------|------------|
| str       | str        |
| "Lenovo"  | "AMD"      |
| "Lenovo"  | "AMD"      |
| "Avita"   | "AMD"      |
| "Avita"   | "AMD"      |
| "Avita"   | "AMD"      |
| …         | …          |
| "ASUS"    | "AMD"      |
| "ASUS"    | "AMD"      |
| "ASUS"    | "AMD"      |
| "SAMSUNG" | "Qualcomm" |
| "Lenovo"  | "AMD"      |

## Create dummy variable from chip types

To make data processing faster, we need to convert chip values into numerical data. One approach is to create a separate column for each chip type, with a value of 1 if a computer brand uses that chip and 0 if it does not. Fortunately, this is very easy to do in Polars with the `to_dummies` method.

``` python
df.to_dummies(columns='chip')
```

shape: (896, 6)

| brand     | chip_AMD | chip_Intel | chip_M1 | chip_MediaTek | chip_Qualcomm |
|-----------|----------|------------|---------|---------------|---------------|
| str       | u8       | u8         | u8      | u8            | u8            |
| "Lenovo"  | 1        | 0          | 0       | 0             | 0             |
| "Lenovo"  | 1        | 0          | 0       | 0             | 0             |
| "Avita"   | 1        | 0          | 0       | 0             | 0             |
| "Avita"   | 1        | 0          | 0       | 0             | 0             |
| "Avita"   | 1        | 0          | 0       | 0             | 0             |
| …         | …        | …          | …       | …             | …             |
| "ASUS"    | 1        | 0          | 0       | 0             | 0             |
| "ASUS"    | 1        | 0          | 0       | 0             | 0             |
| "ASUS"    | 1        | 0          | 0       | 0             | 0             |
| "SAMSUNG" | 0        | 0          | 0       | 0             | 1             |
| "Lenovo"  | 1        | 0          | 0       | 0             | 0             |

Now all the chip information has been converted into zeroes and ones. For example, in the first row, Lenovo uses an AMD chip. It does not use Intel or any of the other chips.

I want you to join the 150+ students in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
