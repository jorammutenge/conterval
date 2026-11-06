# Is US air travel still growing? A TSA checkpoint demand dashboard

Dashboards

Data analysis

Eight years of daily TSA screenings turned into five planning questions, including the finding that 2026 demand has slipped below 2025.

Published

November 2026

Data: TSA daily checkpoint counts, Jan 2019 to Nov 2026 Tools: Python, Polars, hvPlot, Quarto

[Open the dashboard](../../portfolio/tsa-passenger-demand/dashboard.llms.md)

## The challenge

The TSA publishes one number per day: how many people passed through airport security checkpoints. That’s 2,864 days of data. Charting it is easy. The harder job is deciding what an airport operator, airline or staffing planner should do differently after seeing it.

I didn’t want to build a dashboard that just restates the data, so I started with five business questions:

1.  **Is demand still growing?** Should next year be planned on a growth curve?
2.  **How did the pandemic play out, and when did demand really come back?**
3.  **When do passengers travel?** Which matters more for staffing: the week or the season?
4.  **Which unusual days could have been predicted?**
5.  **How does this year compare with last year?**

## The approach

- **Compare like with like.** Every year-over-year number compares each day with the same weekday 364 days earlier. A plain calendar comparison would set a Saturday against a Friday and hide the real trend.
- **Measure recovery against 2019.** Each month is shown as a share of the same month in 2019. That way seasonality doesn’t get mistaken for recovery.
- **Separate surprises from the calendar.** A day’s expected level is the same weekday a year earlier, scaled by the trend over the previous 28 days. Days more than 15% off are flagged. A flag counts as calendar-driven when the day, or the day it’s compared with, falls near a holiday such as Thanksgiving, whose date moves each year.
- **Keep the analysis in Polars.** The charts are interactive hvPlot charts with hover detail, published as a five-page Quarto dashboard.

## What the data says

- **Growth has stalled and turned negative.** Volume grew 5.3% in 2024 and 0.3% in 2025. In 2026, every month from April on has come in below the year before, and the year is now about 6.7M passengers behind 2025.
- **The pressure is in the peaks.** Days above 2.8M passengers went from 4 in 2023 to 70 in 2025. Checkpoints have to be sized for those days, not for the average.
- **The week matters almost as much as the season.** Sundays run 23% above Tuesdays. June runs 29% above January.
- **Most extreme days can be planned for.** 93% of the large swings since 2024 come from the holiday calendar. The worst true surprise was the late-January 2026 winter storm, when traffic was 45% below the expected level.

## What was delivered

- A five-page dashboard: Executive Overview, Pandemic & Recovery, Travel Seasonality, Demand & Anomalies and Year over Year
- A reusable baseline method for spotting anomalies that accounts for weekday, seasonality and moving holidays
- A recommendation on every page, ending with this one: build the 2027 plan from a flat baseline, not from the post-pandemic growth trend

[Open the dashboard →](../../portfolio/tsa-passenger-demand/dashboard.llms.md)
