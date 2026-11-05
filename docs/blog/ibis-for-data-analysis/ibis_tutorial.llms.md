# 🔍 **Sales Performance**

``` python
from dotenv import load_dotenv
import os
import ibis
from ibis import _
ibis.options.interactive = True

# Load environment variables
load_dotenv()

# Retrieve credentials
user = os.getenv("DB_USER_P")
password = os.getenv("DB_PASSWORD")
host = os.getenv("DB_HOST")
database = os.getenv("DB_NAME_P")

# Create the connection string
connection_string = f"{user}://{user}:{password}@{host}:5432/{database}"

# Connect to the database
con = ibis.connect(connection_string)

# Access a table
t = con.table("sales_orders")
t
```

```
┏━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━━━┳━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━┓
┃ account_num ┃ account_name                      ┃ sku      ┃ category ┃ quantity ┃ unit_price ┃ ext_price ┃ date                ┃
┡━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━━━╇━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━┩
│ int64       │ string                            │ string   │ string   │ int64    │ float64    │ float64   │ timestamp(6)        │
├─────────────┼───────────────────────────────────┼──────────┼──────────┼──────────┼────────────┼───────────┼─────────────────────┤
│      803666 │ Fritsch-Glover                    │ HX-24728 │ Hat      │        1 │      98.98 │     98.98 │ 2014-09-28 11:56:02 │
│       64898 │ O'Conner Inc                      │ LK-02338 │ Sweater  │        9 │      34.80 │    313.20 │ 2014-04-24 16:51:22 │
│      423621 │ Beatty and Sons                   │ ZC-07383 │ Sweater  │       12 │      60.24 │    722.88 │ 2014-09-17 17:26:22 │
│      137865 │ Gleason, Bogisich and Franecki    │ QS-76400 │ Sweater  │        5 │      15.25 │     76.25 │ 2014-01-30 07:34:02 │
│      435433 │ Morissette-Heathcote              │ RU-25060 │ Sweater  │       19 │      51.83 │    984.77 │ 2014-08-24 06:18:12 │
│      198887 │ Shanahan-Bartoletti               │ FT-50146 │ Sweater  │        4 │      18.51 │     74.04 │ 2014-09-05 07:24:23 │
│      969663 │ Gusikowski, Reichert and Gerlach  │ AE-95093 │ Socks    │        4 │      49.95 │    199.80 │ 2014-04-28 21:51:24 │
│        1288 │ Wilderman, Herman and Breitenberg │ FT-50146 │ Sweater  │       14 │      68.20 │    954.80 │ 2013-12-04 13:53:26 │
│      979589 │ Brown Inc                         │ HX-24728 │ Hat      │       16 │      52.99 │    847.84 │ 2014-02-07 14:53:59 │
│      839884 │ Turcotte, Turner and Anderson     │ FT-50146 │ Sweater  │        8 │      21.35 │    170.80 │ 2014-09-03 16:06:44 │
│           … │ …                                 │ …        │ …        │        … │          … │         … │ …                   │
└─────────────┴───────────────────────────────────┴──────────┴──────────┴──────────┴────────────┴───────────┴─────────────────────┘
```

1.  **Which categories generate the most revenue?**

    - Group by `category`, sum `ext_price`.

2.  **What are the top-selling SKUs by quantity and revenue?**

    - Aggregate `quantity` and `ext_price` per `sku`.

3.  **Which accounts contribute the most to total sales?**

    - Sum `ext_price` grouped by `account_name` or `account_num`.

------------------------------------------------------------------------

### 📈 **Time-Based Trends**

4.  **How do sales change over time (monthly/quarterly/yearly)?**

    - Extract date components from `date` and aggregate `ext_price`.

5.  **Is there seasonality in the sales of certain categories (e.g., more sweaters in winter)?**

    - Compare sales of `category` over months or quarters.

6.  **What was the average order value per month?**

    - Average `ext_price` grouped by month.

------------------------------------------------------------------------

### 👤 **Customer Behavior**

7.  **Which customers purchase the highest quantity of items?**

    - Sum `quantity` grouped by `account_name`.

8.  **What is the average unit price customers are paying?**

    - Average of `unit_price`, possibly by `account_name` or `category`.

9.  **Are there customers who only buy from one category?**

    - Count unique categories per `account_name`.

------------------------------------------------------------------------

### 💰 **Product Pricing**

10. **What is the price distribution of items in each category?**

    - Use descriptive stats (`min`, `max`, `mean`, `std`) on `unit_price` by `category`.

11. **Are there categories with high unit prices but low sales volume?**

    - Compare `unit_price` with total `quantity` per `category`.

12. **Do higher-priced products sell less frequently?**

    - Correlate `unit_price` with `quantity`.

------------------------------------------------------------------------

### 🧾 **Order Metrics**

13. **What is the average size of an order (in quantity and price)?**

    - Average `quantity` and `ext_price`.

14. **How many unique SKUs are sold per order/account?**

    - Count distinct `sku` per `account_num`.

``` python
import polars as pl
```

``` python
# Move date to be first column
(t
 .relocate('date')
 )
```

```
┏━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━━━┳━━━━━━━━━━━┓
┃ date                ┃ account_num ┃ account_name                      ┃ sku      ┃ category ┃ quantity ┃ unit_price ┃ ext_price ┃
┡━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━━━╇━━━━━━━━━━━┩
│ timestamp(6)        │ int64       │ string                            │ string   │ string   │ int64    │ float64    │ float64   │
├─────────────────────┼─────────────┼───────────────────────────────────┼──────────┼──────────┼──────────┼────────────┼───────────┤
│ 2014-09-28 11:56:02 │      803666 │ Fritsch-Glover                    │ HX-24728 │ Hat      │        1 │      98.98 │     98.98 │
│ 2014-04-24 16:51:22 │       64898 │ O'Conner Inc                      │ LK-02338 │ Sweater  │        9 │      34.80 │    313.20 │
│ 2014-09-17 17:26:22 │      423621 │ Beatty and Sons                   │ ZC-07383 │ Sweater  │       12 │      60.24 │    722.88 │
│ 2014-01-30 07:34:02 │      137865 │ Gleason, Bogisich and Franecki    │ QS-76400 │ Sweater  │        5 │      15.25 │     76.25 │
│ 2014-08-24 06:18:12 │      435433 │ Morissette-Heathcote              │ RU-25060 │ Sweater  │       19 │      51.83 │    984.77 │
│ 2014-09-05 07:24:23 │      198887 │ Shanahan-Bartoletti               │ FT-50146 │ Sweater  │        4 │      18.51 │     74.04 │
│ 2014-04-28 21:51:24 │      969663 │ Gusikowski, Reichert and Gerlach  │ AE-95093 │ Socks    │        4 │      49.95 │    199.80 │
│ 2013-12-04 13:53:26 │        1288 │ Wilderman, Herman and Breitenberg │ FT-50146 │ Sweater  │       14 │      68.20 │    954.80 │
│ 2014-02-07 14:53:59 │      979589 │ Brown Inc                         │ HX-24728 │ Hat      │       16 │      52.99 │    847.84 │
│ 2014-09-03 16:06:44 │      839884 │ Turcotte, Turner and Anderson     │ FT-50146 │ Sweater  │        8 │      21.35 │    170.80 │
│ …                   │           … │ …                                 │ …        │ …        │        … │          … │         … │
└─────────────────────┴─────────────┴───────────────────────────────────┴──────────┴──────────┴──────────┴────────────┴───────────┘
```

``` python
## Q1
# underscore _ is shorthand for accessing columns. ibis accesses functions.

(t
 .aggregate(by='category', ext_price=_.ext_price.sum())
 .order_by(ibis.desc('ext_price'))
#  .order_by(lambda t: t.ext_price.desc())
 )
```

```
┏━━━━━━━━━━┳━━━━━━━━━━━┓
┃ category ┃ ext_price ┃
┡━━━━━━━━━━╇━━━━━━━━━━━┩
│ string   │ float64   │
├──────────┼───────────┤
│ Sweater  │ 301716.00 │
│ Socks    │ 169169.93 │
│ Hat      │  99294.01 │
└──────────┴───────────┘
```

``` python
#Q1 (idiomatic way)
(t
 .group_by('category')
 .agg(ext_price=_.ext_price.sum())
 .order_by(_.ext_price.desc())
 )
```

```
┏━━━━━━━━━━┳━━━━━━━━━━━┓
┃ category ┃ ext_price ┃
┡━━━━━━━━━━╇━━━━━━━━━━━┩
│ string   │ float64   │
├──────────┼───────────┤
│ Sweater  │ 301716.00 │
│ Socks    │ 169169.93 │
│ Hat      │  99294.01 │
└──────────┴───────────┘
```

``` python
(t
 .filter(t.date.year() == 2014)
 .mutate(month=t.date.strftime('%b-%Y'))
 .select('quantity','month')
 .pivot_wider(names_from='month', values_from='quantity', names_sort=True, values_agg='sum')
)
```

```
┏━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┓
┃ Apr-2014 ┃ Aug-2014 ┃ Feb-2014 ┃ Jan-2014 ┃ Jul-2014 ┃ Jun-2014 ┃ Mar-2014 ┃ May-2014 ┃ Sep-2014 ┃
┡━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━┩
│ int64    │ int64    │ int64    │ int64    │ int64    │ int64    │ int64    │ int64    │ int64    │
├──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┤
│      887 │     1065 │      935 │      833 │     1006 │      684 │      791 │      787 │      911 │
└──────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┘
```

``` python


month_list = (t
 .filter(t.date.year() == 2014)
 .mutate(month_num=_.date.month(),
         month=_.date.strftime('%b-%Y'))
 .select('month','month_num')
 .order_by('month_num')
 .distinct(on=['month', 'month_num'])
 .to_polars()
 ['month'].to_list()
 )
month_list
```

    ['Jan-2014',
     'Feb-2014',
     'Mar-2014',
     'Apr-2014',
     'May-2014',
     'Jun-2014',
     'Jul-2014',
     'Aug-2014',
     'Sep-2014']

``` python
# Now use the list of months
(t
 .filter(t.date.year() == 2014)
 .mutate(month=t.date.strftime('%b-%Y'))
 .select('quantity','month')
 .pivot_wider(names_from='month',values_from='quantity', values_agg='sum')
 .relocate(*[month_list])
)
```

```
┏━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━┓
┃ Jan-2014 ┃ Feb-2014 ┃ Mar-2014 ┃ Apr-2014 ┃ May-2014 ┃ Jun-2014 ┃ Jul-2014 ┃ Aug-2014 ┃ Sep-2014 ┃
┡━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━┩
│ int64    │ int64    │ int64    │ int64    │ int64    │ int64    │ int64    │ int64    │ int64    │
├──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┤
│      833 │      935 │      791 │      887 │      787 │      684 │     1006 │     1065 │      911 │
└──────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┘
```

``` python
## Q2
(t
 .group_by('sku')
 .agg(quantity=_.quantity.sum(),
      ext_price=_.ext_price.sum())
 )
```

```
┏━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━━┓
┃ sku      ┃ quantity ┃ ext_price ┃
┡━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━━┩
│ string   │ int64    │ float64   │
├──────────┼──────────┼───────────┤
│ ZC-07383 │     1144 │  61483.76 │
│ AE-95093 │     1062 │  57146.97 │
│ XX-25746 │     1133 │  59384.57 │
│ FT-50146 │      995 │  53558.69 │
│ RU-25060 │     1167 │  62957.70 │
│ IC-59308 │     1240 │  67312.52 │
│ GS-95639 │      823 │  44710.44 │
│ QS-76400 │     1209 │  69386.07 │
│ LK-02338 │     1036 │  54329.78 │
│ HX-24728 │      756 │  39909.44 │
└──────────┴──────────┴───────────┘
```

``` python
# Show top 5 customers that contribute the largest percentage to revenue

(t
 .group_by('account_name')
 .agg(ext_price=_.ext_price.sum())
 .mutate(percent=(_.ext_price / _.ext_price.sum()) * 100)
 .order_by(_.percent.desc())
 .head(5)
#  .limit(5)
 )
```

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━┳━━━━━━━━━━┓
┃ account_name             ┃ ext_price ┃ percent  ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━╇━━━━━━━━━━┩
│ string                   │ float64   │ float64  │
├──────────────────────────┼───────────┼──────────┤
│ D'Amore PLC              │   3529.41 │ 0.618999 │
│ Wilderman Group          │   3466.92 │ 0.608040 │
│ Hilll, Schultz and Braun │   3390.29 │ 0.594600 │
│ Kuvalis-Roberts          │   3296.00 │ 0.578063 │
│ Mills Inc                │   2852.69 │ 0.500314 │
└──────────────────────────┴───────────┴──────────┘
```

``` python
t.ext_price.sum()
```

```
```

    ┌───────────┐
    │ 570179.94 │
    └───────────┘

``` python
(t
 .nunique(where=t.account_name == "D'Amore PLC")
 )
```

```
```

    ┌───┐
    │ 4 │
    └───┘

``` python
t.get_backend()
```

    <ibis.backends.postgres.Backend at 0x1225ee210>

``` python
# Which year had the most revenue and what was the value?
(t
 .mutate(year=_.date.year())
 .group_by('year')
 .agg(total_sales=_.ext_price.sum())
 .filter(_.total_sales == _.total_sales.max())
 )
```

```
┏━━━━━━━┳━━━━━━━━━━━━━┓
┃ year  ┃ total_sales ┃
┡━━━━━━━╇━━━━━━━━━━━━━┩
│ int32 │ float64     │
├───────┼─────────────┤
│  2014 │    425348.0 │
└───────┴─────────────┘
```

``` python
## Q2
(t
 .group_by('sku')
 .agg(quantity=_.quantity.sum(),
      ext_price=_.ext_price.sum())
 )
```

```
┏━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━━┓
┃ sku      ┃ quantity ┃ ext_price ┃
┡━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━━┩
│ string   │ int64    │ float64   │
├──────────┼──────────┼───────────┤
│ ZC-07383 │     1144 │  61483.76 │
│ AE-95093 │     1062 │  57146.97 │
│ XX-25746 │     1133 │  59384.57 │
│ FT-50146 │      995 │  53558.69 │
│ RU-25060 │     1167 │  62957.70 │
│ IC-59308 │     1240 │  67312.52 │
│ GS-95639 │      823 │  44710.44 │
│ QS-76400 │     1209 │  69386.07 │
│ LK-02338 │     1036 │  54329.78 │
│ HX-24728 │      756 │  39909.44 │
└──────────┴──────────┴───────────┘
```

``` python
(t
 .group_by('sku')
 .agg(quantity=_.quantity.sum(),
      ext_price=_.ext_price.sum())
 )
```

```
┏━━━━━━━━━━┳━━━━━━━━━━┳━━━━━━━━━━━┓
┃ sku      ┃ quantity ┃ ext_price ┃
┡━━━━━━━━━━╇━━━━━━━━━━╇━━━━━━━━━━━┩
│ string   │ int64    │ float64   │
├──────────┼──────────┼───────────┤
│ ZC-07383 │     1144 │  61483.76 │
│ AE-95093 │     1062 │  57146.97 │
│ XX-25746 │     1133 │  59384.57 │
│ FT-50146 │      995 │  53558.69 │
│ RU-25060 │     1167 │  62957.70 │
│ IC-59308 │     1240 │  67312.52 │
│ GS-95639 │      823 │  44710.44 │
│ QS-76400 │     1209 │  69386.07 │
│ LK-02338 │     1036 │  54329.78 │
│ HX-24728 │      756 │  39909.44 │
└──────────┴──────────┴───────────┘
```

``` python
import altair as alt

bar_chart = (alt
 .Chart(t.group_by('sku').agg(total_quantity=_.quantity.sum()))
 .mark_bar(color='#556B2F')
 .encode(x=alt.X('sku', axis=alt.Axis(labelAngle=0, labelFontSize=14), title=None,
                 sort=alt.EncodingSortField(field='total_quantity', order='descending')),
         y=alt.Y('total_quantity', axis=alt.Axis(labelFontSize=14), title=None),
         tooltip=['sku','total_quantity'])
 .properties(width=1000, height=500, 
             title={'text':'Total quantity by product SKU', 'fontSize': 20})
#  .configure_view(fill='#FFE4B5')
 .configure(background='#FFE4B5')
 .interactive()
 )
bar_chart
```

``` python
# What is the total, average, and median sales value for each day of the week. Sort values by average.
(t
 .mutate(day=_.date.day_of_week.full_name())
 .group_by('day')
 .agg(total_sales=_.ext_price.sum(),
      avg_sales=_.ext_price.mean(),
      median_sales=_.ext_price.median(),)
 .order_by(_.avg_sales.desc())
 )
```

```
┏━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┳━━━━━━━━━━━━━━┓
┃ day       ┃ total_sales ┃ avg_sales  ┃ median_sales ┃
┡━━━━━━━━━━━╇━━━━━━━━━━━━━╇━━━━━━━━━━━━╇━━━━━━━━━━━━━━┩
│ string    │ float64     │ float64    │ float64      │
├───────────┼─────────────┼────────────┼──────────────┤
│ Sunday    │    91575.29 │ 627.228014 │      560.825 │
│ Saturday  │    81985.61 │ 611.832910 │      512.260 │
│ Monday    │    88708.66 │ 591.391067 │      411.620 │
│ Tuesday   │    85035.91 │ 578.475578 │      470.890 │
│ Wednesday │    83444.28 │ 563.812703 │      454.200 │
│ Friday    │    69183.76 │ 528.120305 │      456.040 │
│ Thursday  │    70246.43 │ 487.822431 │      395.145 │
└───────────┴─────────────┴────────────┴──────────────┘
```

``` python
# What are the top three hours of the day with the least sales.

(t
 .mutate(hour=_.date.hour())
 .group_by('hour')
 .agg(total_sales=_.ext_price.sum())
 .order_by(_.total_sales.asc())
 .limit(3)
 )
```

```
┏━━━━━━━┳━━━━━━━━━━━━━┓
┃ hour  ┃ total_sales ┃
┡━━━━━━━╇━━━━━━━━━━━━━┩
│ int32 │ float64     │
├───────┼─────────────┤
│    16 │    13706.50 │
│    22 │    16160.71 │
│    21 │    16329.77 │
└───────┴─────────────┘
```

``` python
(t
 .select('category')
 .distinct()
 )
```

```
┏━━━━━━━━━━┓
┃ category ┃
┡━━━━━━━━━━┩
│ string   │
├──────────┤
│ Socks    │
│ Sweater  │
│ Hat      │
└──────────┘
```

``` python
# Customers who bought all clothing products (loyal customers)

(t
 .group_by('account_name')
 .aggregate(category_num=t.category.nunique())
 .filter(_.category_num == 3)
)
```

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━┓
┃ account_name                 ┃ category_num ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━┩
│ string                       │ int64        │
├──────────────────────────────┼──────────────┤
│ Bashirian, Beier and Watsica │            3 │
│ Beier-Bosco                  │            3 │
│ Fritsch-Glover               │            3 │
│ Halvorson PLC                │            3 │
│ Herman Ltd                   │            3 │
│ Koepp-McLaughlin             │            3 │
│ Kuvalis-Roberts              │            3 │
│ Ledner-Kling                 │            3 │
│ Mills Inc                    │            3 │
│ Schultz Group                │            3 │
│ …                            │            … │
└──────────────────────────────┴──────────────┘
```

``` python
# If we didn't know beforehand how many categories we had
(t
 .group_by('account_name')
 .aggregate(category_num=t.category.nunique())
 .filter(_.category_num == t.select(t.category).distinct().count())
)
```

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━┓
┃ account_name                 ┃ category_num ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━┩
│ string                       │ int64        │
├──────────────────────────────┼──────────────┤
│ Bashirian, Beier and Watsica │            3 │
│ Beier-Bosco                  │            3 │
│ Fritsch-Glover               │            3 │
│ Halvorson PLC                │            3 │
│ Herman Ltd                   │            3 │
│ Koepp-McLaughlin             │            3 │
│ Kuvalis-Roberts              │            3 │
│ Ledner-Kling                 │            3 │
│ Mills Inc                    │            3 │
│ Schultz Group                │            3 │
│ …                            │            … │
└──────────────────────────────┴──────────────┘
```

``` python
# Count the actual number of loyal customers

(t
 .group_by('account_name')
 .aggregate(category_num=t.category.nunique())
 .filter(_.category_num == t.select(t.category).distinct().count())
 .count()
)
```

```
```

    ┌────┐
    │ 11 │
    └────┘

``` python
(t
 .filter(t.date.year() == 2014)
 .mutate(month=t.date.strftime('%b-%Y'))
 .select('quantity','month')
 .pivot_wider(names_from='month',values_from='quantity', values_agg='sum')
 .relocate(*[month_list])
)
```

``` python
(t
#  .filter(t.date.year() == 2014)
 .mutate(year=_.date.year().cast('string'),
         date=_.date.date().truncate('M'))
 .select('date','quantity','year')
 .pivot_wider(id_cols='date', names_from='year', values_from='quantity', values_agg='sum')
#  .relocate(*[month_list])
)
```

```
┏━━━━━━━━━━━━┳━━━━━━━┳━━━━━━━┓
┃ date       ┃ 2013  ┃ 2014  ┃
┡━━━━━━━━━━━━╇━━━━━━━╇━━━━━━━┩
│ date       │ int64 │ int64 │
├────────────┼───────┼───────┤
│ 2014-02-01 │  NULL │   935 │
│ 2014-06-01 │  NULL │   684 │
│ 2013-12-01 │  1078 │  NULL │
│ 2013-11-01 │   825 │  NULL │
│ 2014-08-01 │  NULL │  1065 │
│ 2014-04-01 │  NULL │   887 │
│ 2014-07-01 │  NULL │  1006 │
│ 2013-09-01 │     6 │  NULL │
│ 2014-05-01 │  NULL │   787 │
│ 2014-03-01 │  NULL │   791 │
│ …          │     … │     … │
└────────────┴───────┴───────┘
```

``` python
(t
 .rename('snake_case') #change cols to snake case
 .mutate(hour=lambda t: t.date.hour(),
         week_day=lambda t: t.date.day_of_week.full_name(),
         day_abbrev=t.date.day_of_week.full_name().substr(0, 3),
         year=t.date.year(),
         month=t.date.month(),
         minute=t.date.minute(),
         second=t.date.second(),
         )
#  .filter(lambda t: t.second == 2)
#  .execute()
 )
```

``` python
(t
 .to_polars()
 .group_by('account_name')
 .agg(category_num=pl.col('category').unique().count())
 .filter(pl.col('category_num') == 3)
 .unique('account_name')
#  .select('account_name','category')
#  .head(4)
#  .write_clipboard()
#  .with_columns(pl.col('date').dt.weekday())
#  .group_by('account_name')
#  .agg(pl.sum('ext_price'))
#  .with_columns(percent=pl.col('ext_price') / pl.col('ext_price').sum())
#  .sort('percent', descending=True)
 )
```

shape: (11, 2)

| account_name                     | category_num |
|----------------------------------|--------------|
| str                              | u32          |
| "Beier-Bosco"                    | 3            |
| "Koepp-McLaughlin"               | 3            |
| "Herman Ltd"                     | 3            |
| "Halvorson PLC"                  | 3            |
| "Mills Inc"                      | 3            |
| …                                | …            |
| "Schultz Group"                  | 3            |
| "Upton, Runolfsson and O'Reilly" | 3            |
| "Fritsch-Glover"                 | 3            |
| "Kuvalis-Roberts"                | 3            |
| "Bashirian, Beier and Watsica"   | 3            |

## Connecting to the database

``` python
import mysql.connector
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

# Retrieve database credentials from environment variables
user = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")
host = os.getenv("DB_HOST")
database = os.getenv("DB_NAME_IBIS")

# Connect to the database
cnx = mysql.connector.connect(
    user=user,
    password=password,
    host=host,
    database=database
)
```

``` python
import polars as pl

df = pl.read_ndjson('how_to_get_rich.json')
```

``` python
(df
 .with_columns(pl.from_epoch(pl.col("time_parsed"), time_unit="s"))
)
```

## Reading data from database

``` python
import polars as pl

actor = pl.read_database(
    query="SELECT * FROM actor",
    connection=cnx,
)  
actor
```

``` python
# Read all the tables

tables_df = pl.read_clipboard()
tables_df
```

``` python
import polars as pl

# List of table names
tables = tables_df['Tables_in_sakila'].to_list()

# Dictionary to store DataFrames
dataframes = {table: pl.read_database(query=f"SELECT * FROM {table}", connection=cnx) for table in tables}

# Manually unpack the dictionary into variables if needed
city, address = dataframes["city"], dataframes["address"]
```

``` python
city
```

``` python
# Unpacking dynamically into variables
globals().update(dataframes)
```

``` python
actor
```

## Query warm up

Select first and last name from customer where last name is Ziegler.

    SELECT first_name, last_name
    FROM customer
    WHERE last_name = 'ZIEGLER';

``` python
(customer
 .select('first_name','last_name')
 .filter(pl.col('last_name') == 'ZIEGLER')
 )
```

Display the category table

    SELECT *
    FROM category;

``` python
category
```

Subsetting columns - select name from the language table.

    SELECT name
    FROM language;

``` python
(language
 .select('name')
 )
```

Using expressions, literal and built-in function - Creating columns not present in the table.

    SELECT language_id,
        'COMMON' language_usage,
        language_id * 3.1415927 lang_pi_value,
        upper(name) language_name
    FROM language;

``` python
(language
 .with_columns(language_usage=pl.lit('COMMON'),
               lang_pi_value=pl.col('language_id') * 3.1415927,
               language_name=pl.col('name').str.to_uppercase()
               )
 .select('language_id','language_usage','lang_pi_value','language_name')
 )
```

Column aliases - the previous query can also be written as follows.

    SELECT language_id,
        'COMMON' AS language_usage,
        language_id * 3.1415927 AS lang_pi_value,
        upper(name) AS language_name
    FROM language;

Removing duplicates - Show ids of all actors who appeared in a film.

    SELECT actor_id
    FROM film_actor
    ORDER BY actor_id;

Use DISTINCT to show unique ids.

    SELECT DISTINCT actor_id
    FROM film_actor
    ORDER BY actor_id;

``` python
# with duplicates
(film_actor
 .select('actor_id')
 .sort('actor_id')
 )
```

``` python
# without duplicates
(film_actor
 .select('actor_id')
 .unique()
 .sort('actor_id')
 )
```

Subqueries - Create single column to show first and last name for customers named Jessie

    SELECT concat(cust.last_name, ', ', cust.first_name) full_name
    FROM
        (SELECT first_name, last_name, email
        FROM customer
        WHERE first_name = 'JESSIE'
        ) cust;

``` python
(customer
 .with_columns(pl.concat_str(['first_name','last_name'], separator=', ').alias('full_name'))
 .filter(pl.col('first_name') == 'JESSIE')
 .select('full_name')
 )
```

Show names and time of people who rented movies on 2005-06-14

    SELECT customer.first_name, customer.last_name,
        time(rental.rental_date) rental_time
    FROM customer
        INNER JOIN rental
        ON customer.customer_id = rental.customer_id
    WHERE date(rental.rental_date) = '2005-06-14';

``` python
(customer
 .join(rental, on='customer_id', how='inner')
 .with_columns(Date=pl.col('rental_date').dt.date(),
               rental_time=pl.col('rental_date').dt.time())
 .filter(pl.col('Date') == pl.date(2005,6,14))
 .select('first_name', 'last_name', 'rental_time')
 )
```
