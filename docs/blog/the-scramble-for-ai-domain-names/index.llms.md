# The scramble for .ai domain names

visualization

Author

Joram Mutenge

Published

September 24, 2024

Before ChatGPT came out, AI was a joke. No one paid attention to it. In fact, the majority of people thought virtual reality (VR) was going to happen sooner. Remember the metaverse?

But on November 30, 2022, the image of AI changed forever. That’s because OpenAI released a product called ChatGPT. The massive success of ChatGPT led to the proliferation of AI companies, causing a surge in the purchase of `.ai` domain names.

Here’s a table showing the date and the total number of `.ai` domains purchased.

shape: (9, 2)

| Date       | Count  |
|------------|--------|
| str        | i64    |
| "Jul-2018" | 48272  |
| "Jan-2019" | 62183  |
| "Jan-2020" | 85596  |
| "Jul-2021" | 123651 |
| "Apr-2022" | 138022 |
| "Jul-2022" | 143737 |
| "Jun-2023" | 248608 |
| "Sep-2023" | 306861 |
| "Dec-2023" | 353928 |

Now let’s create the chart to see how fast these `.ai` domain names are being snatched up.

``` python
import plotly.graph_objects as go
from plotly_customizations import customize_plotly_figure
from pathlib import Path

# Define the y-axis scale
y_scale = list(range(0, 500000, 100000))

# Create the figure
fig = go.Figure()
customize_plotly_figure(fig, f"{Path('../../')}/images/logo.png")

# Add trace for the line plot with red line color
fig.add_trace(go.Scatter(
    x=df['Date'], 
    y=df['Count'], 
    mode='lines+markers+text',  # Add 'text' to mode to show text labels
    line=dict(color='#613583', width=3),  # Set line color and increase width
))

# Update the layout with font settings and title font size
fig.update_layout(
    title='<b>The rise of .ai domains<br>(2018 to 2023)',
    title_font=dict(size=26),  # Set title font size to 20
    hovermode="x unified",
    width=790,
    yaxis=dict(
        tickvals=y_scale,  # Set the custom y-axis scale
        tickformat=',',    # Ensure numbers are not truncated
        showgrid=True,     # Show horizontal gridlines
        gridwidth=1,       # Set gridline thickness
        gridcolor='white', # Set gridline color
    ),
    xaxis=dict(
        showgrid=False,    # Disable vertical gridlines
        linecolor='#FFFFFF',  # Set the x-axis line color
        linewidth=3,       # Increase x-axis line thickness
    ), 
    annotations=[
        dict(
            x=0, y=-0.2,  # Position at the bottom left corner
            xref="paper", yref="paper",  # Use paper coordinates
            text="<b>Sources: Originality.ai & DNS",  # Text to display
            showarrow=False,  # No arrow pointing to the text
            xanchor='left',  # Align text to the left
            yanchor='bottom',  # Align text to the bottom
            font=dict(size=12, color="#9a9996")  # Set font family and size
        ),
        dict(
            xref='paper',
            x=.97,
            y=df['Count'][-1],
            xanchor='right', 
            yanchor='bottom',
            text=f'{df["Count"][-1]:,}',  # Escape double quotes within f-string
            showarrow=False,
            font=dict(size=16, color='#3d3846')  # Apply font family
        ),
        dict(
            x=.8, y=0.3,
            xref="paper", yref="paper",
            text="<b>+110,000<br>ytd 2024",
            showarrow=False,
            xanchor='left',
            yanchor='bottom',
            font=dict(size=16, color="#613583",)  # Apply font family
        ),
    ],
)

# Add a square shape around the annotation
fig.add_shape(
    type="rect",
    xref="paper", yref="paper",
    x0=0.78, y0=0.28, x1=0.95, y1=0.47,  # Coordinates slightly adjusted to fit the annotation
    line=dict(
        color="#f6f5f4",
        width=2,
    ),
    fillcolor="#f6f5f4",
)

fig.show(renderer="iframe")
```

> **NOTE:**
>
> The original chart was posted by [Efi Pylarinou](https://www.linkedin.com/feed/update/urn:li:activity:7241137792053907456/). I recreated it with Plotly.

> **TIP:**
>
> `you.ai` is the most expensive `.ai` domain ever bought? It was purchased for \$700,000 by Dharmesh Shah, the founder of HubSpot.
