# My submission to the posit table contest

Creating a stunning table with TSA airport checking data

visualization

Author

Joram Mutenge

Published

June 13, 2024

This year, I decided to participate in the [Posit Table Contest](https://posit.co/blog/announcing-the-2024-table-contest/). Because I’m a fan of the great tables Python library I thought it would be great to enhance my mastery of this beautiful library by designing a table. I’ll use the Polars library for data munging and transformation.

![](image.png)

snapshot of table

### Data collection

The data was collected from the [Transport Security Administration](https://www.tsa.gov/travel/passenger-volumes) website, which has archived data on the number of airport passenger checkings done daily from 2019 to 2023. The data was then saved as a parquet file containing columns `Date` and `Numbers`.

### Data transformation

Reading the original data and displaying five random records.

``` python
import polars as pl
from pathlib import Path

data = pl.read_parquet(f"{Path('../../')}/datasets/tsa.parquet")
data.sample(5)
```

shape: (5, 2)

| Date       | Numbers |
|------------|---------|
| date       | i64     |
| 2021-11-21 | 2216940 |
| 2022-09-27 | 1842212 |
| 2023-04-19 | 2227164 |
| 2021-06-21 | 2036775 |
| 2020-08-01 | 749886  |

Creating new columns to enable more data transformations.

``` python
df = (data
 .with_columns(Year=pl.col('Date').dt.year(),
             Month=pl.col('Date').dt.month(),
             Day=pl.col('Date').dt.day())
 .with_columns(pl.when(pl.col('Month').eq(11) & pl.col('Day').eq(28))
             .then(pl.lit('Thanksgiving'))
             .when(pl.col('Month').eq(12) & pl.col('Day').eq(25))
             .then(pl.lit('Christmas'))
             .when(pl.col('Month').eq(7) & pl.col('Day').eq(4))
             .then(pl.lit('July 4th'))
             .when(pl.col('Month').eq(5) & pl.col('Day').eq(27))
             .then(pl.lit('Memorial Day'))
             .otherwise(None)
             .alias('Holiday')
             )
)
df.head()
```

shape: (5, 6)

| Date       | Numbers | Year | Month | Day | Holiday |
|------------|---------|------|-------|-----|---------|
| date       | i64     | i32  | i8    | i8  | str     |
| 2019-01-01 | 2201765 | 2019 | 1     | 1   | null    |
| 2019-01-02 | 2424225 | 2019 | 1     | 2   | null    |
| 2019-01-03 | 2279384 | 2019 | 1     | 3   | null    |
| 2019-01-04 | 2230078 | 2019 | 1     | 4   | null    |
| 2019-01-05 | 2049460 | 2019 | 1     | 5   | null    |

In the code below, I’m creating a single-row dataframe, showing the highest number of checkings for each year. I’m leveraging looping to avoid repeating myself five times. The five dataframes are combined into a single dataframe called *highest_df*.

``` python
# Create high dataframe
high_dfs = []
for year in df['Year'].unique().to_list():
    high_df = pl.DataFrame({'Year':year,
            'Date':(df.filter(pl.col('Year') == year).filter(pl.col('Numbers') == pl.col('Numbers').max())['Date']),
            'Numbers':df.filter(pl.col('Year') == year)['Numbers'].max(),
            'Holiday':'Highest Record',
            })
    high_dfs.append(high_df)
highest_df = pl.concat(high_dfs).with_columns(pl.col('Numbers').cast(pl.Int64))
highest_df.sample(3)
```

shape: (3, 4)

| Year | Date       | Numbers | Holiday          |
|------|------------|---------|------------------|
| i32  | date       | i64     | str              |
| 2019 | 2019-12-01 | 2882915 | "Highest Record" |
| 2022 | 2022-11-27 | 2639616 | "Highest Record" |
| 2020 | 2020-02-14 | 2507588 | "Highest Record" |

To create a dataframe with the lowest number of checkings, I repeat the above process, replacing `max()` with `min()`.

``` python
# Create low dataframe
low_dfs = []
for year in df['Year'].unique().to_list():
    low_df = pl.DataFrame({'Year':year,
            'Date':(df.filter(pl.col('Year') == year).filter(pl.col('Numbers') == pl.col('Numbers').min())['Date']),
            'Numbers':df.filter(pl.col('Year') == year)['Numbers'].min(),
            'Holiday':'Lowest Record',
            })
    low_dfs.append(low_df)
lowest_df = pl.concat(low_dfs).with_columns(pl.col('Numbers').cast(pl.Int64))
lowest_df.sample(3)
```

shape: (3, 4)

| Year | Date       | Numbers | Holiday         |
|------|------------|---------|-----------------|
| i32  | date       | i64     | str             |
| 2022 | 2022-01-25 | 1063856 | "Lowest Record" |
| 2019 | 2019-11-28 | 1591158 | "Lowest Record" |
| 2020 | 2020-04-14 | 113147  | "Lowest Record" |

In this code, I create another dataframe with the total number of checkings for each year by using `sum()`.

``` python
# Create total dataframe
tot_dfs = []
for year in df['Year'].unique().to_list():
    tot_df = pl.DataFrame({'Year':year,
            'Date':None,
            'Numbers':df.filter(pl.col('Year') == year)['Numbers'].sum(),
            'Holiday':'Annual Checkings',
            'Distribution':None
            })
    tot_dfs.append(tot_df)
total_df = pl.concat(tot_dfs).with_columns(pl.col('Year').cast(pl.Int32))
total_df.sample(3)
```

shape: (3, 5)

| Year | Date | Numbers   | Holiday            | Distribution |
|------|------|-----------|--------------------|--------------|
| i32  | null | i64       | str                | null         |
| 2019 | null | 848102043 | "Annual Checkings" | null         |
| 2021 | null | 585250987 | "Annual Checkings" | null         |
| 2022 | null | 760071362 | "Annual Checkings" | null         |

This code creates a dataframe where the value in `Holiday` is not null.

``` python
# Create holiday dataframe
hol_dfs = []
for year in df['Year'].unique().to_list():
    hol_df = (df
    .filter(pl.col('Year') == year)
    .filter(pl.col('Holiday').is_not_null())
    .select('Year','Date','Numbers','Holiday')
    )
    hol_dfs.append(hol_df)
holiday_dfs = pl.concat(hol_dfs)
holiday_dfs.sample(3)
```

shape: (3, 4)

| Year | Date       | Numbers | Holiday        |
|------|------------|---------|----------------|
| i32  | date       | i64     | str            |
| 2023 | 2023-11-28 | 2171943 | "Thanksgiving" |
| 2021 | 2021-12-25 | 1535935 | "Christmas"    |
| 2021 | 2021-05-27 | 1867067 | "Memorial Day" |

The dataframe below creates a list of the average number of monthly checkings for each year. The created lists are row values for a column called `Distribution`.

``` python
# Create distribution dataframe
dist_dfs = []
for year in df['Year'].unique().to_list():
    dist_df = (df
    .filter(pl.col('Year') == year)
    .group_by('Month')
    .agg(pl.mean('Numbers'), pl.first('Year'))
    .sort('Month')
    .with_columns(Distribution=pl.col('Numbers').implode())
    .select('Year','Distribution').head(1)
    )
    dist_dfs.append(dist_df)
distribution_df = pl.concat(dist_dfs)
distribution_df.sample(3)
```

shape: (3, 2)

| Year | Distribution                                 |
|------|----------------------------------------------|
| i32  | list\[f64\]                                  |
| 2021 | \[803976.419355, 879766.035714, … 1.9142e6\] |
| 2019 | \[1.9902e6, 2.0906e6, … 2.3577e6\]           |
| 2020 | \[2.0946e6, 2.1359e6, … 896292.225806\]      |

Finally, I’m combining all the created dataframes into a single dataframe called **TSA** and adding another column `Icon` containing the names of the icons like the turkey and Christmas tree used in the stunning table. **TSA** is the dataframe used to make the stunning table.

``` python
# Combine all dataframes and add Icon column.
TSA = (pl.concat([holiday_dfs, highest_df, lowest_df])
.join(distribution_df, on='Year', how='inner')
.vstack(total_df)
.with_columns(pl.when(pl.col('Holiday') == "Thanksgiving")
            .then(pl.col('Distribution'))
            .otherwise(None)
            .alias('Distribution')
            )
.with_columns(pl.when(pl.col('Holiday') == "Memorial Day")
           .then(pl.lit('memorial.svg'))
           .when(pl.col('Holiday') == "July 4th")
           .then(pl.lit('flag.svg'))
           .when(pl.col('Holiday') == "Thanksgiving")
           .then(pl.lit('turkey.svg'))
           .when(pl.col('Holiday') == "Christmas")
           .then(pl.lit('christmas.svg'))
           .when(pl.col('Holiday') == "Highest Record")
           .then(pl.lit('high.svg'))
           .when(pl.col('Holiday') == "Lowest Record")
           .then(pl.lit('low.svg'))
           .otherwise(pl.lit('calendar.svg'))
           .alias('Icon')
           )
.select('Icon', 'Holiday', 'Year', 'Date', 'Numbers', 'Distribution')
.sort('Year')
)
TSA.sample(3)
```

shape: (3, 6)

| Icon            | Holiday         | Year | Date       | Numbers | Distribution |
|-----------------|-----------------|------|------------|---------|--------------|
| str             | str             | i32  | date       | i64     | list\[f64\]  |
| "low.svg"       | "Lowest Record" | 2019 | 2019-11-28 | 1591158 | null         |
| "flag.svg"      | "July 4th"      | 2023 | 2023-07-04 | 2007441 | null         |
| "christmas.svg" | "Christmas"     | 2021 | 2021-12-25 | 1535935 | null         |

After transforming the data into the desired format, I am now creating the table. The code below generates the table, which will be my final submission.

``` python
from great_tables import GT, html, loc, style, md, nanoplot_options

display(
    GT(TSA, rowname_col="Icon", groupname_col="Year")
    .tab_stubhead(label=html('<b style="font-family: Inter, sans-serif; font-weight: 500;">Year</b>'))
    .tab_header(title=html('''
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;900&display=swap" rel="stylesheet">
        <h2 style="text-align:center; display: flex; align-items: center; justify-content: center; font-family: Inter, sans-serif; font-weight: 500; color: #014eac;">
            <img src="assets/plane3.svg" alt="Plane Icon" style="margin-right: 34px; height: 54px;">
            TSA Airport Checkings<br>on Major Holidays
            <img src="assets/plane3.svg" alt="Plane Icon" style="margin-left: 34px; height: 54px;">
        </h2>
    '''))
    .tab_options(container_width="100%",
                 table_background_color='#F0FFF0',
                 heading_background_color="#C0C0C0",
                 column_labels_background_color="#696969",
                 row_group_font_weight='bold',
                 row_group_background_color='#C0C0C0',
                 source_notes_font_size='12px',
                 row_group_padding='8px',
                 table_font_names="Open Sans")
    .cols_label(Date=html('<b style="font-family: Inter, sans-serif; font-weight: 500;">Date</b>'),
                Numbers=html('<b style="font-family: Inter, sans-serif; font-weight: 500;">Checkings</b>'),
                Distribution=html('<b style="font-family: Inter, sans-serif; font-weight: 500;">Avg Monthly Checkings</b>'),
                Holiday='')
    .fmt_number(columns='Numbers', decimals=0)
    .cols_width(cases={'Date': '10%'})
    .fmt_date(columns="Date", date_style="day_m")
    .tab_style(style=style.text(color='#556B2F', weight='bold'),
               locations=loc.body(rows=pl.col("Holiday") == "Annual Checkings"))
    .tab_style(style=style.text(color='black', weight='normal'),
               locations=loc.body(columns="Holiday"))
    .sub_missing(missing_text='')
    .fmt_nanoplot(columns="Distribution", reference_line="mean",
                  options=nanoplot_options(data_point_radius=12,
                                           data_point_stroke_color="black",
                                           data_point_stroke_width=4,
                                           data_point_fill_color="white",
                                           data_line_type="straight",
                                           data_line_stroke_color="brown",
                                           data_line_stroke_width=2,
                                           data_area_fill_color="#FF8C00",
                                           vertical_guide_stroke_color="green"))
    .fmt_image("Icon", path="assets")
    .tab_source_note(source_note=md("**Source:** [TSA Passenger Volumes](https://www.tsa.gov/travel/passenger-volumes)<br/>**Designer:** Joram Mutenge<br/>*www.conterval.com*"))
)
```

[TABLE]

Get the full code [here](https://github.com/jorammutenge/contest). If you want to learn how to transform data like I did in this post, check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/).
