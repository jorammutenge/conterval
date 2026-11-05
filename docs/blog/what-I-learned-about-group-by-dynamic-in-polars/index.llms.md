# What I learned about group by dynamic in polars while working on a client’s project

Author

Joram Mutenge

Published

2024-12-30

In the last client project I worked on, I learned something about the `group_by_dynamic` function in Polars. While what I learned was surprising, the fact that I learned it during the project was not. This aligns with the philosophy of “let the work be the practice” that Cal Newport advocates, and I’m proud to say I follow it. Most people spend time learning about a particular technology before they use it in a project. Cal Newport’s philosophy suggests combining learning with doing. By practicing through actual work, you gain mastery. By the end of this project, my proficiency in Polars increased dramatically.

## A brief overview of the project

The client had forecast data for 2025 for electronic gadgets in monthly buckets, but she wanted it converted into weekly buckets. The dates in the data she presented all started at the beginning of each month. For instance, the first row contained the date January 1, 2025. Below is the forecast data from the client.

shape: (96, 3)

| Date       | Gadget       | Forecast |
|------------|--------------|----------|
| date       | str          | i16      |
| 2025-01-01 | "Headphones" | 3439     |
| 2025-01-01 | "Keyboard"   | 1652     |
| 2025-01-01 | "Monitor"    | 311      |
| 2025-01-01 | "Mouse"      | 1139     |
| 2025-01-01 | "Printer"    | 123      |
| …          | …            | …        |
| 2025-12-01 | "Mouse"      | 1385     |
| 2025-12-01 | "Printer"    | 166      |
| 2025-12-01 | "Smartwatch" | 678      |
| 2025-12-01 | "Tablet"     | 496      |
| 2025-12-01 | "Webcam"     | 512      |

## How we solved the problem

At first, I thought I could solve the problem by simply dividing each forecast value by 7, the number of days in a week. However, a colleague quickly reminded me that not all months are created equal—some have more days than others. So, I quickly abandoned that approach and searched for an alternative.

The solution that worked involved creating, from scratch, a single-column dataframe containing all the days of the year 2025, from January to December. We joined this dataframe with the client’s forecast data and then applied `group_by_dynamic`. It worked like a charm, but it also exposed something I hadn’t been fully aware of regarding `group_by_dynamic`.

## Creating the date dataframe.

Using `datetime_range`, I created a dataframe containing timeseries values for the entire year of 2025. The interval was set to 1 day, ensuring that every single date in the year is included. Below is the resulting timeseries dataframe. Then I extracted the month values from the dates to create a new column *Month*.

``` python
from datetime import datetime
date_df = pl.DataFrame(
    {
        "Date": pl.datetime_range(
            start=datetime(2025, 1, 1),
            end=datetime(2025, 12, 31),
            interval="1d",
            eager=True,
        )
    }
).with_columns(pl.col('Date').dt.date(),
               Month=pl.col('Date').dt.month())
date_df
```

shape: (365, 2)

| Date       | Month |
|------------|-------|
| date       | i8    |
| 2025-01-01 | 1     |
| 2025-01-02 | 1     |
| 2025-01-03 | 1     |
| 2025-01-04 | 1     |
| 2025-01-05 | 1     |
| …          | …     |
| 2025-12-27 | 12    |
| 2025-12-28 | 12    |
| 2025-12-29 | 12    |
| 2025-12-30 | 12    |
| 2025-12-31 | 12    |

## Joining the two dataframes

Before joining the two DataFrames, I converted the date values in the forecast dataset to month-only values. This ensured a unique common value between both dataframes, enabling the join to proceed. The dataframe below illustrates the transformation from date values to month-only values.

``` python
df = (data
 .with_columns(pl.col('Date').dt.month())
 )
df
```

shape: (96, 3)

| Date | Gadget       | Forecast |
|------|--------------|----------|
| i8   | str          | i16      |
| 1    | "Headphones" | 3439     |
| 1    | "Keyboard"   | 1652     |
| 1    | "Monitor"    | 311      |
| 1    | "Mouse"      | 1139     |
| 1    | "Printer"    | 123      |
| …    | …            | …        |
| 12   | "Mouse"      | 1385     |
| 12   | "Printer"    | 166      |
| 12   | "Smartwatch" | 678      |
| 12   | "Tablet"     | 496      |
| 12   | "Webcam"     | 512      |

\

The two dataframes were joined using a left join. Also, I decided to divide the forecast values by 4 since most months have at least 4 weeks Here’s an example of the resulting dataframe for Headphones showing the monthly and weekly forecast.

``` python
(date_df
 .join(df, left_on='Month', right_on='Date', how='left')
 .drop('Month')
 .with_columns(Weekly_Forecast=pl.col('Forecast').truediv(4).round(0).cast(pl.Int16))
 .sort('Date')
 .filter(pl.col('Gadget') == "Headphones")
 )
```

shape: (365, 4)

| Date       | Gadget       | Forecast | Weekly_Forecast |
|------------|--------------|----------|-----------------|
| date       | str          | i16      | i16             |
| 2025-01-01 | "Headphones" | 3439     | 860             |
| 2025-01-02 | "Headphones" | 3439     | 860             |
| 2025-01-03 | "Headphones" | 3439     | 860             |
| 2025-01-04 | "Headphones" | 3439     | 860             |
| 2025-01-05 | "Headphones" | 3439     | 860             |
| …          | …            | …        | …               |
| 2025-12-27 | "Headphones" | 2992     | 748             |
| 2025-12-28 | "Headphones" | 2992     | 748             |
| 2025-12-29 | "Headphones" | 2992     | 748             |
| 2025-12-30 | "Headphones" | 2992     | 748             |
| 2025-12-31 | "Headphones" | 2992     | 748             |

## Converting to weekly buckets

The dates are still in days, but the client wants them in weeks so I used `groub_by_dynamic` with an interval of 7 days to convert them into weekly buckets. Below is the resulting dataframe.

``` python
from great_tables import loc, style

processed_df = (date_df
 .join(df, left_on='Month', right_on='Date', how='left')
 .drop('Month')
 .with_columns(Weekly_Forecast=pl.col('Forecast').truediv(4).round(0).cast(pl.Int16))
 .sort('Date')
 .filter(pl.col('Gadget') == "Headphones")
 .group_by_dynamic('Date', every='7d')
 .agg(pl.first('Gadget', 'Forecast', 'Weekly_Forecast'))
 )

processed_df[0:10].style.tab_style(
    style.fill("yellow"),
    loc.body(
        rows=pl.col("Date").dt.year() == 2024,
    ),
)
```

| Date       | Gadget     | Forecast | Weekly_Forecast |
|------------|------------|----------|-----------------|
| 2024-12-26 | Headphones | 3439     | 860             |
| 2025-01-02 | Headphones | 3439     | 860             |
| 2025-01-09 | Headphones | 3439     | 860             |
| 2025-01-16 | Headphones | 3439     | 860             |
| 2025-01-23 | Headphones | 3439     | 860             |
| 2025-01-30 | Headphones | 3439     | 860             |
| 2025-02-06 | Headphones | 2620     | 655             |
| 2025-02-13 | Headphones | 2620     | 655             |
| 2025-02-20 | Headphones | 2620     | 655             |
| 2025-02-27 | Headphones | 2620     | 655             |

\

Do you notice the peculiarity that `group_by_dynamic` introduces? None of our original DataFrames contained the year 2024, yet after using `group_by_dynamic`, we now see 2024. What’s going on here? I was initially unaware of this behavior. It turns out that `group_by_dynamic` shifts date values by the interval specified in the `every` parameter. Since we used a 7-day interval, the date values were moved 7 days back, causing the appearance of 2024.

But wait—the client specifically needs forecast data for 2025. How can we address this? Thankfully, the developers of Polars anticipated this issue and provided a solution. As outlined in the documentation, adding the `start_by` parameter with the value `"datapoint"` to `group_by_dynamic` resolves the problem. With this adjustment, the year 2024 disappeared entirely.

``` python
(date_df
 .join(df, left_on='Month', right_on='Date', how='left')
 .drop('Month')
 .filter(pl.col('Gadget') == 'Monitor')
 .with_columns(Weekly_Forecast=pl.col('Forecast').truediv(4).round(0).cast(pl.Int16))
 .sort('Date')
 .group_by_dynamic('Date', every='7d', start_by='datapoint')
 .agg(pl.first('Gadget', 'Forecast', 'Weekly_Forecast'))
 )
```

shape: (53, 4)

| Date       | Gadget    | Forecast | Weekly_Forecast |
|------------|-----------|----------|-----------------|
| date       | str       | i16      | i16             |
| 2025-01-01 | "Monitor" | 311      | 78              |
| 2025-01-08 | "Monitor" | 311      | 78              |
| 2025-01-15 | "Monitor" | 311      | 78              |
| 2025-01-22 | "Monitor" | 311      | 78              |
| 2025-01-29 | "Monitor" | 311      | 78              |
| …          | …         | …        | …               |
| 2025-12-03 | "Monitor" | 325      | 81              |
| 2025-12-10 | "Monitor" | 325      | 81              |
| 2025-12-17 | "Monitor" | 325      | 81              |
| 2025-12-24 | "Monitor" | 325      | 81              |
| 2025-12-31 | "Monitor" | 325      | 81              |

\

With the date issue resolved, we can now proceed to develop the code needed to create the final dataset for presentation to the client.

``` python
gadget_list = df['Gadget'].unique().to_list()

bucket_dfs = []
for gadget in gadget_list:
    bucket_df = (date_df
        .join(df, left_on='Month', right_on='Date', how='left')
        .drop('Month')
        .filter(pl.col('Gadget') == gadget)
        .with_columns(Weekly_Forecast=pl.col('Forecast').truediv(4).round(0).cast(pl.Int16))
        .sort('Date')
        .group_by_dynamic('Date', every='7d', start_by='datapoint')
        .agg(pl.first('Gadget', 'Forecast', 'Weekly_Forecast'))
        )
    bucket_dfs.append(bucket_df)

all_bucket_df = pl.concat(bucket_dfs).drop('Forecast')
all_bucket_df
```

shape: (424, 3)

| Date       | Gadget   | Weekly_Forecast |
|------------|----------|-----------------|
| date       | str      | i16             |
| 2025-01-01 | "Tablet" | 97              |
| 2025-01-08 | "Tablet" | 97              |
| 2025-01-15 | "Tablet" | 97              |
| 2025-01-22 | "Tablet" | 97              |
| 2025-01-29 | "Tablet" | 97              |
| …          | …        | …               |
| 2025-12-03 | "Mouse"  | 346             |
| 2025-12-10 | "Mouse"  | 346             |
| 2025-12-17 | "Mouse"  | 346             |
| 2025-12-24 | "Mouse"  | 346             |
| 2025-12-31 | "Mouse"  | 346             |

\

The lesson to remember is that `group_by_dynamic` will move the date values back by the specified interval you set in the `every` parameter. If you want to maintain the date values in your dataset, you must add ananother parameter `start_at` and set it to `"datapoint"`.

Reach out if you need help with your data problems. Also, take a look at our [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to improve your data analysis skills using this fast Python library.
