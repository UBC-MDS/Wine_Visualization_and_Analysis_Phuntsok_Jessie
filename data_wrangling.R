library(tidyverse)
library(plotly)

data<-read.csv("data/winemag-data-130k-v2.csv")
#class(data$country)
clean_data<-data %>% 
  select(-X,-description,-designation,-region_2,-taster_twitter_handle) %>%
  filter(country != "")
sum(is.na(data$price)) #8992 NA
sum(is.na(data$region_1)) #no NA 
sum(is.na(data$points)) # no NA
clean_data<-clean_data %>% filter(price != "")

