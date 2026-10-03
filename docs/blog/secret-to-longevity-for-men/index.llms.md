# For men, the secret to longevity is marrying a wife much younger than you

visualization

Author

Joram Mutenge

Published

October 22, 2024

Pop culture and the business world are full of older men marrying women who are way younger than them.

- Alec Baldwin, 66 and Hilaria Baldwin, 40
- Donald Trump, 78 and Melania Trump, 54
- Michael Douglas, 80 and Catherine Zeta-Jones, 55
- Eddie Murphy, 63 and Paige Butcher, 45
- Paul McCartney, 82 and Nancy Shevell, 64
- Bruce Willis, 69 and Emma Heming, 46

This is so common it’s become a cliche. Could it be that these men have discovered the secret to living longer?

Code

``` python
import polars as pl
import plotly.graph_objects as go
from pathlib import Path
import base64

# Create the Polars DataFrame
data = pl.DataFrame({
    "Age_Gap": [
        "Wife 10 years older", 
        "Wife 5 years older", 
        "Wife same age", 
        "Wife 5 years younger", 
        "Wife 10 years younger"
    ],
    "Risk": [1.35, 1.15, 1.0, 0.95, 0.85],
    "Error_Bar": [0.05, 0.05, 0.0, 0.05, 0.05]
})

# Replace the second-to-last space with <br>
df = (data
      .with_columns(pl.col('Age_Gap').map_elements(
          lambda x: '<br>'.join(x.rsplit(' ', 2)[:-1]) + ' ' + x.rsplit(' ', 2)[-1], return_dtype=pl.Utf8))
      .with_columns(pl.concat_str(pl.lit('<b>'), pl.col('Age_Gap')).alias('Age_Gap'))
      )

# Load and encode the image
with open(f"{Path('../../')}/images/logo.png", "rb") as image_file:
    encoded_image = base64.b64encode(image_file.read()).decode()

# Create a list of colors based on the Risk value
colors = ['#3CB371' if risk < 1 else '#DC143C' for risk in df['Risk']]

# Create the bar chart
fig = go.Figure(data=[
    go.Bar(
        x=df['Age_Gap'],
        y=df['Risk'],
        error_y=dict(
            type='data',
            array=df['Error_Bar'],
            visible=True,
            width=10  # Increase the cap length of the error bars
        ),
        marker_color=colors
    )
])

# fig.update_yaxes(tickfont_family="Arial Black")

fig.update_layout(
    title="<b>Men with much younger wives<br>have a lower risk of dying</b>",
    title_font=dict(size=24),
    font=dict(size=13),
    yaxis_title="Risk",
    yaxis=dict(range=[0.6, 1.45], dtick=0.1),
    height=600,
    paper_bgcolor='#E0FFFF',
    plot_bgcolor='#E0FFFF',
    # margin=dict(b=100),
    margin=dict(t=120, l=60, b=120),
    annotations=[
        go.layout.Annotation(
            x=0,
            y=-0.26,
            xref="paper",
            yref="paper",
            showarrow=False,
            text="<b>Source</b>: National Library of Medicine<br>https://pmc.ncbi.nlm.nih.gov/articles/PMC3000022",
            xanchor="left",
            yanchor="bottom",
            align="left",
            font=dict(size=10)
        ),
        go.layout.Annotation(
            x=.98,
            y=0.7,
            xref="paper",
            yref="paper",
            showarrow=False,
            text="Sadly, only men with good looks like <b>movie stars</b><br>and <b>multi-millionaires</b> can attract<br>much younger female partners",
            xanchor="right",
            yanchor="middle"
        )
    ]
)

# Add the encoded logo image to the plot
fig.add_layout_image(
    dict(
        source=f"data:image/png;base64,{encoded_image}",  # Use the pre-encoded image
        xref="paper",
        yref="paper",
        x=0.98,
        y=-0.26,
        xanchor="right",
        yanchor="bottom",
        sizex=0.22,
        sizey=0.22,
        layer="above"
    )
)

fig.show(renderer="iframe")
```

Last weekend I stumbled upon a paper by Sven Drefahl titled *How Does the Age Gap Between Partners Affect Their Survival?* It turns out that your risk of dying is somehow affected by the age gap between you and your spouse.

According to Drefahl the risk of dying in men decreases as the age gap increases. Put another way, the younger the wife is compared with her husband, the lower the mortality of the husband. Also, the older the wife is compared with her husband, the higher the mortality of the husband.

This, however, is not the same for women. Mortality in women is lowest when a woman is the same age as her husband and increases with increasing age discrepancy. Therefore, having a younger spouse is beneficial for men but detrimental for women.

While this study is good news for men, the unfortunate part is that you have to be blessed by the looks of a movie star or be extremely wealthy like Donald Trump to attract a much younger female partner.
