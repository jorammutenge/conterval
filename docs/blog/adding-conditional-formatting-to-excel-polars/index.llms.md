# Adding conditional formatting to excel workbooks with polars

write_excel

100DaysOfPolars

Author

Joram Mutenge

Published

2025-07-07

Polars allows you to save data in multiple file formats like CSV, Parquet, Avro—even Excel. What most people don’t know is that you can add special formatting to the Excel file, such as setting a background color for the title cells. Yes, you can even apply conditional formatting based on a value threshold.

## Data to save

Below is a DataFrame containing the data we want to save as an Excel file.

shape: (5, 5)

| Acc_Num | SKU        | Category  | Qty | Price |
|---------|------------|-----------|-----|-------|
| i64     | str        | str       | i64 | f64   |
| 29068   | "FT-50146" | "Sweater" | 2   | 46.48 |
| 77116   | "IC-59308" | "Socks"   | 19  | 29.25 |
| 23749   | "IC-59308" | "Socks"   | 18  | 54.79 |
| 172519  | "RU-25060" | "Sweater" | 15  | 62.53 |
| 914594  | "LK-02338" | "Sweater" | 11  | 86.4  |

## Adding special formatting

Let’s write code to save the data as an Excel file. We’ll set the background color of the headers to blue and apply conditional formatting to the *Qty* column so that cells with a value less or equal to 15 have background color red; otherwise, they have green.

Additionally, we’ve frozen the headers so they remain visible when you scroll down. We’ve also created a new column, *Ext_Price*, containing the formula `Qty × Price`. This formula appears in the output file just as if it had been typed directly into the Excel sheet.

``` python
(df
 .write_excel('sales.xlsx',
              formulas={'Ext_Price': '=[@Qty]*[@[Price]]'},
              freeze_panes=(1, 0),
              conditional_formats={'Qty': [
             {'type': 'cell', 'criteria': '<=', 'value': 15, 'format': {'bg_color': '#DC143C'}},
             {'type': 'cell', 'criteria': '>', 'value': 15, 'format': {'bg_color': '#008000'}}]},
              header_format={'bg_color': '#00BFFF'})
)
```

\

Here’s what the saved and formatted Excel file looks like.

![](image.png)

stylized excel file

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) and join the list of satisfied students.

![](image2.png)

what students are saying
