# Milestone 4 
<br>

## What changes did you decide to implement given the time limit, and why do you think this is the best thing to focus on?

- We implemented a summary tab to introduce our users about how to use our app and what informations they can gain from the graphs. In addition, we referenced links to our public and personal repositories. 

- We change the position of  two  of our plots' (price distribution and points distribution). Before, the two plots were displayed vertically, and it proved to be a hassle for  users  to scroll up and down our app just to visualize all the three plots. Therefore, we came up with a solution and found a way to display the two plots horizontally for better visualization. 

- We filled the histograms with the count variable, so that it shows a range of values ranging from darker to lighter color of blue, to show the ranges of prices and ratings/points of our wines.

- We changed app's theme using package 'shinytheme'. 

- We better document on app's code. 

We believe these are the best changes to implement as we can do all of the changes efficiently and quickly within the time limit. 

## If you were to make the app again from scratch (or some other app in general), what would you do differently?

We would make better use of features in the data set. In the data set, there are reviews of testers for each different wines. We would use Word Cloud to provide a user with insight into word use within reviews. By emulating testers' review, users can gain more information about different varieties and are able to find their desired wines more exactly. <br>
Additionally, we would be more deliberate to choose the types of graphs and make decisions earlier on which graphs to use for our app. We went back and forth to decide what kinds of plot to present the data, though we already have our objectives at the early stage.  

## What were the greatest challenges you faced in creating the final product?

Some of the challenges we faced were:
1)Trying to find the best form of visualization for our dataset. We used scatterplots in the early stages of our app, but after received feedbacks from our lab instructor, teaching assistants, instructor and our peers(via peer review), we changed out plots to include a violin plot and two histograms.

2) Trying to fix the bugs in our sidebar filters. 
Our "Select your region" sidebar filter, threw an error when there was no region selected, but we managed to fix that bug.

3) Trying to fix the bug in our scatterplot that showed the prices of wine given the variety of wine. Eventhough this scatterplot was interactive, the prices did not make sense at all. We eventually replaced the scatterplot with a viloin plot because violin plot was a better choice for our app.

4) Trying to line up all the tabs with the same spacing between them.


