# Move dates back and forward in polars

offset_by

100DaysOfPolars

Author

Joram Mutenge

Published

2025-10-28

Sometimes, you may want to change the dates of your appointments, either moving them forward or backward. Below is a dataframe showing your appointments.

shape: (3, 2)

| Appointment | Date       |
|-------------|------------|
| str         | date       |
| "Dentist"   | 2026-06-02 |
| "Doctor"    | 2026-07-15 |
| "Therapist" | 2026-09-05 |

## Move dates back or forward

``` python
(df
 .with_columns(One_Month_Past=pl.col('Date').dt.offset_by('-1mo'))
 .with_columns(Five_Days_Future=pl.col('Date').dt.offset_by('5d'))
 )
```

shape: (3, 4)

| Appointment | Date       | One_Month_Past | Five_Days_Future |
|-------------|------------|----------------|------------------|
| str         | date       | date           | date             |
| "Dentist"   | 2026-06-02 | 2026-05-02     | 2026-06-07       |
| "Doctor"    | 2026-07-15 | 2026-06-15     | 2026-07-20       |
| "Therapist" | 2026-09-05 | 2026-08-05     | 2026-09-10       |

> **NOTE:**
>
> - To move dates closer to the present, use a negative value such as `-1mo`.
> - To move dates farther into the future, use a positive value such as `5d`.

Enroll in my [Polars course](https://www.udemy.com/course/analyzing-data-with-polars-in-python/) to learn more about this powerful data analysis library.
