# Store dataframes in a list by alignment in polars

pl.align_frames

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-03

You have two dataframes and want to store them in a list based on shared values in one column. Below are two dataframes; one with movie ratings and the other with duration.

**Movie rating dataframe**

shape: (4, 2)

| Movie                     | Rating |
|---------------------------|--------|
| str                       | f64    |
| "Inception"               | 8.8    |
| "The Revenant"            | 8.0    |
| "The Wolf of Wall Street" | 8.2    |
| "Revolutionary Road"      | 7.3    |

**Movie duration dataframe**

shape: (4, 2)

| Movie                | Duration |
|----------------------|----------|
| str                  | i64      |
| "The Fall Guy"       | 126      |
| "The Revenant"       | 156      |
| "La La Land"         | 128      |
| "Revolutionary Road" | 119      |

## Align dataframes and store in list

To create a list of dataframes that contain movies featuring Leonardo DiCaprio, you can use the Polars expression `pl.align_frames` like this:

``` python
aligned_dfs = (pl.align_frames(rating_df,
                 duration_df,
                 on='Movie',
                 how='inner')
 )
aligned_dfs
```

    [shape: (2, 2)
     ┌────────────────────┬────────┐
     │ Movie              ┆ Rating │
     │ ---                ┆ ---    │
     │ str                ┆ f64    │
     ╞════════════════════╪════════╡
     │ Revolutionary Road ┆ 7.3    │
     │ The Revenant       ┆ 8.0    │
     └────────────────────┴────────┘,
     shape: (2, 2)
     ┌────────────────────┬──────────┐
     │ Movie              ┆ Duration │
     │ ---                ┆ ---      │
     │ str                ┆ i64      │
     ╞════════════════════╪══════════╡
     │ Revolutionary Road ┆ 119      │
     │ The Revenant       ┆ 156      │
     └────────────────────┴──────────┘]

Now that you have a list of dataframes, you can access any one of them by index. For example, to get the first dataframe, do this:

``` python
aligned_dfs[0]
```

shape: (2, 2)

| Movie                | Rating |
|----------------------|--------|
| str                  | f64    |
| "Revolutionary Road" | 7.3    |
| "The Revenant"       | 8.0    |

Notice that this movie rating dataframe is not the same as the original. This one only contains movies in which Leonardo DiCaprio appeared.

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) and have the time of your life learning!
