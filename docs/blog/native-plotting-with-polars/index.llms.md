# Native plotting with polars

Using YouTube comments data

data analysis

Author

Joram Mutenge

Published

June 20, 2024

Visualizations simplify data comprehension. A glance at a graph or chart conveys the data’s message, saving you time compared to analyzing a table without visuals.

As a polars fanatic, I hated converting my polars dataframes to pandas dataframes whenever I wanted to plot my data. Luckily, I can now say goodbye to doing that and say hello to native plotting in polars with the new release of the library.

Here’s an example of what I mean. Below is a polars dataframe of YouTube comments from my favorite late-night show, *Last Week Tonight with John Oliver*. The dataframe contains comments from 20 episodes of the show.

``` python
import polars as pl
import polars_xdt as xdt
from pathlib import Path

df = pl.read_parquet(f"{Path('../../')}/datasets/last_week_tonight.parquet")
df.head()
```

shape: (5, 3)

| text                             | author           | time_parsed |
|----------------------------------|------------------|-------------|
| str                              | str              | f64         |
| "The legislator who said he did… | "@breathnstop"   | 1.7065e9    |
| "This commentator is no doubt a… | "@pdm4pdm4"      | 1.7064e9    |
| "Satanists run this world."      | "@pdm4pdm4"      | 1.7064e9    |
| "All abortions are a sacrifice … | "@pdm4pdm4"      | 1.7064e9    |
| "I just had a guy say that givi… | "@RedDragonsRme" | 1.7062e9    |

Now let’s create a heatmap to show the comment post frequency by hour and day of the week (weekday).

``` python
import hvplot.polars
(df
 .with_columns(Datetime=pl.from_epoch('time_parsed'))
 .with_columns(Weekday=xdt.day_name('Datetime'),
               Hour=pl.col('Datetime').dt.hour())
 .group_by('Weekday','Hour').len()
 .hvplot.heatmap(x='Hour', y='Weekday', C='len', height=500, width=800, ylabel='',
               title='Last Week Tonight with John Oliver\nComment Post Frequency')
 )
```

> **TIP:**
>
> Polars uses numbers for day names, so Monday is 1. I used the library `polars_xdt` to get proper day names.

By the way, this heatmap is interactive. For example, I can see that on Tuesday at hour 16, a total of 49,403 comments were posted!

Surprisingly, most of the comments are posted on Wednesday. Intuitively I would’ve thought that Monday would have more comments. That’s because the episodes are posted on YouTube late at night on Sunday, and most people are likely to watch on Monday morning.

> **NOTE:**
>
> The YouTube channel now posts new episodes on Thursday morning.

So, what do I mean by native plotting? As you can see from my code, I just invoked `.plot.heatmap`, and voila, the visualization was created. Yes, it’s as easy as that!

Imagine being John Oliver’s intern, juggling multiple comments flooding in. The heatmap above becomes your secret weapon. It pinpoints the optimal day and hour to efficiently respond to many people.

Check out my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn this fast growing library.
