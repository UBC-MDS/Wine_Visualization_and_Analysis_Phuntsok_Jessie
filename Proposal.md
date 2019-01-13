
Section 1: Overview 

As Hemingway wrote: “Wine is one of the most civilized things in the world … and it offers a greater range for enjoyment 
and appreciation than, possibly, any other purely sensory thing.”
There is no dearth of wines in the world because the shelves of almost all liquor and grocery stores are teeming with the
but it is still very challenging to choose a good wine based on the prospective customer’s taste, budget and knowledge of wine.
Therefore, We propose building a data visualization application about wine that allows wine buyer to visually explore a dataset
of wine reviews to help them find the best wine that meets their desire and requirement. The app will allow the buyer to filter
wines according to country, province, and region they are interested in. Then, it will show each kind of wine’s price-rating 
ratios. Also, it will show the distribution of ratings, price, and tester across the factors they filter. 

Section 2: Description of the data

We will be visualizing a dataset of approximately 130k wine information.Each title of wine has 13 associated variable and we 
will visualize 6 of them.
The app users need to select the country that the wine is from (country), the province that the wine is from (province), 
the region that the wine growing area in a province(region_1). After finished selecting these information, the app will
show the distribution of selected wine’s ratings (points), price (the cost of for a bottle of the wine), and tester
(tester_name). In addition, it will show each kind of wine’s price-ratings ratio, which can help users to determine which 
wine to buy. 

Section 3: Usage scenario & tasks(tasks are underlined)

Peter is a young father and he needs to choose some wine for his first anniversary. Choosing a good wine has always been a  
daunting task for him as he often grapples with what wine to buy because there are so many different types of wines to choose
from.
He wants to explore a dataset of wines and select the best wine, with the highest rating given his tight budget.
When Peter decides to use our wine app, he can just adjust the price slider in your shiny app, and also type in the country 
of origin, the wine rating and also the description of the wine, then the app with act interactively and recommend the best
wine at that particular price range. 

Peter can not only use this app for small events like celebrating an anniversary but he can also use the app for bigger events
like hosting a birthday party. 

We will first test the shiny app with the wine data we are given for this project. Since the data is very large, we will need
to filter the data given our specific needs.
If our prospective customer is Peter, then we can filter our data and include the wines only bottled in the United States, 
because since Peter is American, he will most likely buy American wine for his anniversary. But, if our prospective customer,
if a wine aficionado and wine buyer, then we will have to filter the data less and include wines from all the countries in 
our dataset. The wine buyer will most probably buy a wine from not from the United States but also from other wine producing
countries like France, Spain, Italy, New Zealand, Bulgaria, Argentina, Israel, Portugal and South Africa.
We will test our shiny app on small datasets(like in Peter’s case) and also on large datasets(like the wine buyer’s case), 
so that we can make sure our app is consistent and predicting the right wine all the time.

Section 4: Description of your app & sketch (20%)

This app will be made in shiny library in R studio. In will be built in a dashboard style. On the left side of the dashboard,
you will see see a filter, that will help you select a wine of your choice based on those filters. The filters are Country,
Region, Wine Variety, Price and rating. These filters will be interactive and it will help you make a better decison to buy
your wine. The app will also feature a world map to show where the orgin of your wine is. It willalso include a wine dataset 
so that potential buyers can see, which wine are popular and being procuded and sold more often.

![](Hellowine.png)


