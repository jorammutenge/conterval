# All the movies and series I watched in 2025

And how to calculate the Mutenge score

data analysis

Author

Joram Mutenge

Published

2025-12-31

![](image.jpg)

source: Prime Video

If someone asks about your hobbies, do you tell them something that makes you seem smart or cool, or do you tell the truth? If a hobby is what you spend most of your free time doing, then many people would be embarrassed to say their true hobbies out loud. But numbers do not lie, and the evidence they provide is always beautiful. I spend most of my free time watching movies and TV series. That is my hobby. The good news is that I have been recording every movie or series I have watched since 2022.

## About the dataset

Below is a snapshot of my movies and series dataset. I’ve filtered for the year 2025 to only show the movies I watched this year.

shape: (3, 7)

| Type | Title | Season | Release_Year | Person | Quote | Watch_Year |
|----|----|----|----|----|----|----|
| str | str | i64 | i64 | str | str | i16 |
| "Series" | "Hotel Babylon" | 4 | 2006 | "Rachael Stirling \| Natalie Men… | "Imagine your worst day a day w… | 2025 |
| "Movie" | "You Hurt My Feelings" | null | 2023 | "Sunita Mani \| Erica Matlin" | "No man wants to have a V-neck.… | 2025 |
| "Series" | "Bad Sisters" | 2 | 2022 | "Eve Hewson \| Sharon Horgan \| S… | "We do things for those we love… | 2025 |

Most of the columns are self-explanatory, but two require some explaing:

- *Person*: contains a list of people I enjoyed watching. Names are separated by `|`, so “Eve Hewson \| Sharon Horgan” contains two people Eve Hewson and Sharon Horgan.
- *Quote*: contains lines that were good enough to be quotable. Lines are saprated by `|`.

## Some analysis

Since the dataset is proprietary, I’ll show you a few analyses that I think you may be eager to know the answers to.

### How much TV did I watch in 2025?

Let me answer the question you are dying to have answered. As I said earlier, I watch a lot of TV. It is my hobby. Let us find out how much with the help of some Polars code:

``` python
(df
 .select(Titles=pl.col('Title').count())
 )
```

shape: (1, 1)

| Titles |
|--------|
| u32    |
| 32     |

Watching 32 titles in a year may not seem like a lot, but remember that some of these titles are series with 40 episodes spread across multiple seasons. That’s a lot of watch time!

> **NOTE:**
>
> I have watched all the series and movies on this list from beginning to end. If it is a series, then I have watched all the seasons and episodes released under that title.

### What’s the breakdown between movies and series

Let us get more granular and see how many of these 32 titles were movies and how many were series:

``` python
(df
 .group_by('Type').len()
 )
```

shape: (2, 2)

| Type     | len |
|----------|-----|
| str      | u32 |
| "Series" | 15  |
| "Movie"  | 17  |

## The Mutenge score

You may be wondering why I go through the trouble of building this dataset. The IMDB ratings assigned to movies and series do not mean much to me. They do not truly capture my taste. To capture my true taste in movies and series, I created a metric known as the ***Mutenge score*** (yes, it is named after yours truly) to quantify how much I like a movie or series. At first glance, the formula may seem complicated, but after explaining it, I promise it will make a lot of sense.

### Formula

\\ \text{Mutenge Score} = 4 \cdot \tanh\left( \frac{ \dfrac{ \begin{cases} 2P + Q & \text{Movie } (S = 0) \\ 4P + Q & \text{Series } (S \> 0) \end{cases} }{1 + 0.5(8S - 1)} - \begin{cases} 3.5 & \text{Movie} \\ 2.0 & \text{Series} \end{cases} }{1.5} \right) \\

------------------------------------------------------------------------

### Explanation

The ***Mutenge score*** ranges from -4 to +4. A score of -4 signifies **OK**, a score of 0 signifies **Good**, and a score of +4 signifies **Excellent**. Each movie or series is assigned a single score, which can be an integer or a decimal value.

Unlike most scales that range from most disliked to most liked, the ***Mutenge score*** is divided into two territories. The OK-to-Good territory encompasses the scale between -4 and 0 (the midpoint), while the Good-to-Excellent territory encompasses the scale between 0 and +4. I liked all the movies and series that ended up in the dataset; if I do not, I simply stop watching and move on to something else. When it comes to movies and series, we are spoiled for choice. There is no need to punish yourself by watching something you are not enjoying. The ***Mutenge score*** allows me to quantify how much I liked and enjoyed a movie or series.

### Parameters and their meaning

**P — Person count**

- Number of unique persons in the title
- Weighted more heavily because characters matter more to me
- Person count weight is not the same. Movies = 2, Series = 4

**Q — Quote count**

- Number of unique quotes
- Still important, but secondary to people

> *More people matters more than more quotes.*

------------------------------------------------------------------------

**S — Season count**

- `S = 0` → Movie
- `S ≥ 1` → Series

------------------------------------------------------------------------

**Episodes per season = 8**

A fixed storytelling-length assumption used for normalization.

------------------------------------------------------------------------

**\\α\\ (alpha) — exposure softening factor**

\\ \alpha = 0.5 \\

Controls how strongly long series are penalized.

- `α = 1.0` → full linear penalty (too harsh)
- `α = 0.5` → diminishing penalty (**chosen**)
- `α → 0` → almost no length penalty

------------------------------------------------------------------------

**Exposure**

\\ \text{Exposure} = 1 + \alpha \cdot (8S - 1) \\

- Movies → exposure = 1
- Series → grows sublinearly with seasons
- Prevents series from collapsing toward −4

------------------------------------------------------------------------

**D₀(S) — Neutral density**

\\ D_0(S) = \begin{cases} 3.5 & \text{Movie} \\ 2.0 & \text{Series} \end{cases} \\

- Represents “Good” (neutral enjoyment) per unit exposure.

------------------------------------------------------------------------

**k — Sensitivity**

\\ k = 1.5 \\

Controls how quickly scores approach ±4.

- Smaller → more extreme scores
- Larger → flatter distribution

------------------------------------------------------------------------

**tanh compression**

- Smoothly bounds the score to **\[−4, +4\]**
- Preserves relative differences without hard clipping

------------------------------------------------------------------------

[Table 1](#tbl-param) illustrates a summarized version of the parameters of the formula.

| **Parameter**       | **Value**         | **Meaning**                        |
|:--------------------|:------------------|:-----------------------------------|
| \\P\\               | number of persons | unique persons in the title        |
| \\Q\\               | number of quotes  | unique quotes in the title         |
| \\S\\               | number of seasons | 0 = movie, ≥1 = series             |
| \\W(S)\\            | person weight     | 2 for movies, 4 for series         |
| Episodes per season | 8                 | exposure constant                  |
| \\α\\               | 0.5               | exposure softening factor          |
| \\D\\₀\\(S)\\       | neutral density   | 3.5 movies, 2.0 series             |
| k                   | 1.5               | sensitivity for `tanh` compression |
| Score range         | \[-4, +4\]        | bounded via `tanh`                 |

Table 1: Parameters for Mutenge score formula.

## Apply the Mutenge score

Now that I’ve explained how to calculate the ***Mutenge score***, let’s use Polars to assign a score to each movie/series.

``` python
(df
 .with_columns(pl.col('Season').fill_null(0))
 .with_columns(pl.col('Person', 'Quote').str.split(' | ').list.n_unique())

 # ---- constants ----
 .with_columns(_episodes_per_season=pl.lit(8),
               _alpha=pl.lit(0.5),
               _sensitivity=pl.lit(1.5))

 # ---- type-aware neutral density ----
 .with_columns(pl.when(pl.col('Season') == 0)
               .then(3.5)
               .otherwise(2.0)
               .alias('_neutral_density'))

 # ---- softened exposure ----
 .with_columns((1 + pl.col('_alpha') * (pl.col('_episodes_per_season') * pl.col('Season') - 1))
               .alias('_exposure'))

 # ---- type-aware person weighting ----
 .with_columns(pl.when(pl.col('Season') == 0)
               .then(2 * pl.col('Person') + pl.col('Quote'))   # movies
               .otherwise(4 * pl.col('Person') + pl.col('Quote'))  # series
               .alias('_weighted_content'))

 # ---- density ----
 .with_columns(_density=pl.col('_weighted_content') / pl.col('_exposure'))

 # ---- calculate score ----
 .with_columns((4 * ((pl.col('_density') - pl.col('_neutral_density')) / pl.col('_sensitivity')).tanh())
               .alias('Mutenge_Score'))

 # ---- cleanup ----
 .select(pl.exclude("^_.*$")) # remove cols that start with underscore.
 .sample(5, seed=31)
)
```

shape: (5, 8)

| Type | Title | Season | Release_Year | Person | Quote | Watch_Year | Mutenge_Score |
|----|----|----|----|----|----|----|----|
| str | str | i64 | i64 | u32 | u32 | i16 | f64 |
| "Series" | "The Split" | 3 | 2018 | 2 | 2 | 2025 | -2.656147 |
| "Movie" | "Roommate Wanted" | 0 | 2015 | 1 | 6 | 2025 | 4.0 |
| "Movie" | "Frances Ferguson" | 0 | 2019 | 1 | 2 | 2025 | 3.980219 |
| "Series" | "Halt and Catch Fire" | 4 | 2014 | 5 | 28 | 2025 | 2.165392 |
| "Series" | "StartUp" | 3 | 2016 | 13 | 10 | 2025 | 3.848377 |

If you have any questions about the ***Mutenge score***, email me and I will be happy to offer a more detailed explanation.

What movies or series did you find gripping in 2025? Share them with me. I will watch them, assign the ***Mutenge score*** to them, and include them in a follow-up article.
