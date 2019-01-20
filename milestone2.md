Hello Wine Application Write-Up
===============================

Rational:
---------

Our rational for designing this app is to help wine buyers to find their
potential wines based on their desired country, province and region and
their criteria of price and rating. To give users a general sense of
difference varieties of wine across price, we used a scatter plot to
show the price distribution. To make the plot more engaging, we included
the actual data points representing titles of wines and implemented a
hover effect using plotly.Users can easily see the specific title of
wines by hovering over a data point.As a result, users get both a
general sense of the varieties’ price patterns f precise information
from the hover effect.

Similarly, We did the same things to show relationship between variety
and ratings. At this scatterplot, users can get a sense different
varieties’ ratings distribution.

Task:
-----

-   Data Wrangling:
    -   Wrote a script to clean and reshape data to be used in the app
-   Built side panel of Plot tab:
    -   Created a sider panel for user inputs
    -   Used drop-down menus for users to input country, province,
        region and sliders to input price and rating
-   Built main panel of Plot tab:
    -   Create two scatter plot using ggplot
    -   Added interactivity using plotly
-   Built a data tab
    -   Added a tab to dispaly the data
