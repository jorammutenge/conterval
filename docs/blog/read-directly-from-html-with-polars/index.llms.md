# Read directly from HTML with polars

A workaround

data analysis

Author

Joram Mutenge

Published

June 18, 2024

*Suits* was the most-watched TV show in 2023, even though the last episode aired in December 2019. For this reason, I thought I’d use it as an example to show how you can use Polars to extract data from web pages without writing convoluted web scraping scripts with Beautiful Soup or Requests.

In the code below I extract data from a [Wikipedia page](https://en.wikipedia.org/wiki/List_of_Suits_episodes), clean it up, and assign appropriate data types.

``` python
import polars as pl
import pandas as pd

url = 'https://en.wikipedia.org/wiki/List_of_Suits_episodes'

suits = (pl.from_pandas(pd.read_html(url)[1])
 .with_columns(pl.col('Title').str.replace_all('"',''),
               pl.col('U.S. viewers (millions)').str.slice(0,4).cast(pl.Float32),
               pl.col('Original release date').str.strptime(pl.Date, '%B %d, %Y'))
 .sort('U.S. viewers (millions)')
 )
suits
```

shape: (12, 7)

| No. overall | No. in season | Title | Directed by | Written by | Original release date | U.S. viewers (millions) |
|----|----|----|----|----|----|----|
| i64 | i64 | str | str | str | date | f32 |
| 12 | 12 | "Dog Fight" | "Kevin Bray" | "Aaron Korsh" | 2011-09-08 | 3.47 |
| 10 | 10 | "Shelf Life" | "Jennifer Getzinger" | "Sean Jablonski" | 2011-08-25 | 3.82 |
| 2 | 2 | "Errors and Omissions" | "John Scott" | "Sean Jablonski" | 2011-06-30 | 3.89 |
| 8 | 8 | "Identity Crisis" | "Norberto Barba" | "Ethan Drogin" | 2011-08-11 | 3.96 |
| 11 | 11 | "Rules of the Game" | "Mike Smith" | "Jon Cowan" | 2011-09-01 | 3.96 |
| … | … | … | … | … | … | … |
| 5 | 5 | "Bail Out" | "Kate Woods" | "Ethan Drogin" | 2011-07-21 | 4.38 |
| 6 | 6 | "Tricks of the Trade" | "Terry McDonough" | "Rick Muirragui" | 2011-07-28 | 4.44 |
| 9 | 9 | "Undefeated" | "Felix Alcala" | "Rick Muirragui" | 2011-08-18 | 4.45 |
| 3 | 3 | "Inside Track" | "Kevin Bray" | "Aaron Korsh" | 2011-07-07 | 4.53 |
| 1 | 1 | "Pilot" | "Kevin Bray" | "Aaron Korsh" | 2011-06-23 | 4.64 |

Finally, I plot the viewership of all the episodes in season 1 as a bar chart.

Code

``` python
import plotly.express as px

fig = px.bar(suits, x='U.S. viewers (millions)', y='Title', orientation='h', height=600)
fig.update_traces(marker_color='#6A5ACD')
fig.update_layout(
    title={'text': '<b>The insane popularity of Suits season 1</b>', 'font_size':30, 'pad': {'t': 0.75}},
    plot_bgcolor='#D8BFD8',
    paper_bgcolor='#D8BFD8',
    legend_title=None,
    bargap=0.1,
    yaxis={'title':'', 'visible': True, 'showticklabels': True},
    xaxis={'visible': True, 'showticklabels': True, 'tickfont': {'size': 20}, 'showgrid': False, 'zeroline': False},
    font_color="#000000",
    title_font_color="#000000",
    margin={'t': 100}
)

fig.show(renderer="iframe")
```

It’s no surprise that over 4 million people watched the pilot of *Suits* when it aired. In my opinion, this pilot is the best of any TV show ever. Is it any wonder that *Suits* is having a resurgence? I challenge you to find a better pilot.

Polars is taking over pandas as the go-to library for data analysis. [Check out my course](https://www.udemy.com/course/analyzing-data-with-polars-in-python) to learn the fundamentals of Polars.
