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
clean_data<-clean_data %>% filter(region_1 != "")

clean_data<- clean_data %>% mutate(price_points_ratio = price / points)

write.csv(clean_data,file = "clean_data.csv")

# to use map the average price_points_ratio VS country 
ratio_country<-clean_data %>% 
  select(country,price_points_ratio) %>% 
  group_by(country) %>%  
  summarise(avg = mean(price_points_ratio))

write.csv(ratio_country,file= "ratio_country.csv")
