Hello Wine Application Write-Up
===============================

Rational:
-----------

Our rational for designing this app is to help wine buyers find their
wines of choice based on their budgets, the origin of the wine(Country, province,
and region) and also the rating of differnt varieties of wine.

To give users a general sense of different varieties of wine according to price,
we used a scatter plot to show the price distribution of the different varieties 
of wine. To make the plot more engaging, we included the actual data points representing
titles of wines and implemented a hover effect using plotly. With this feature,users can 
easily see the specific title of wines by hovering over a data point.As a result, users can
get a general sense of the varieties’ of wine and also prices attached to those varieties just 
from the hovering effect.

Similarly, We repeated the hovering process in our scatterplot to show relationship between variety 
of wine and ratings of wine. The scatterplot can help users of the app get a sense different varieties
of wine and their ratings.

Tasks:
---------
-   Data Wrangling:
    -   Wrote a script to clean and reshape data to be used in the app
-   Built a sidebar panel:
    -   Created a sider panel for user inputs
    -   Used drop-down menus for users to input country, province,
        region and sliders for price and rating
-   Built a Plot tab:
    -   Create two scatter plots using ggplot
    -   Added interactivity using plotly
-   Built a table tab
    -   Added a tab to dispaly the data
    
Vision & Next Steps:
------------------------
Vision & Next Steps:

My goal for the next milestone is to create a user-friendly experience that is easy to navigate. I would like the tabs on the right side of my app to contain the right documents.
For instance, I would like to have the summary tab contain some summary, and the table tab contain the 
datatable.

I would also like to change the color of the histogram.


Bugs:
-------

There are several bugs in my app that will need to be fixed for the next iteration. For example, the sliders on the sidepanel of the Analysis tab return only a few data points when the sliders are selected 
within a certain range. I will come up with a solution and fix it for the next lab.

The other bug that I encounterd was that my tabs, except for the plot tab, does not contain the right information. For example, my summary tab and also my table  contain the graphs. I plan to fix it in the 
next lab by using fluidPage in Shiny. This will help me with the layout of the tabs.
