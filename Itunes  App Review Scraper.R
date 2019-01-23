#Install
install.packages("itunesr") # for scraping reviews
install.packages("wordcloud") # for generating word clouds
install.packages("highcharter") # graphing
install.packages("dplyr") #table binding
install.packages("lubridate") # time series plotting
install.packages("RColorBrewer") # Wordcloud color palettes
#Load
library("itunesr")
library("plyr")
library("highcharter")
library("lubridate")
library("highcharter")
library("dplyr")
library("wordcloud")
library("RColorBrewer")

###Review Scraper###

reviews <- bind_rows(lapply(1:10, function(n) {getReviews("INSERT APP ID",'us',n)}))

###Export Reviews as CSV###
write.csv(reviews, file = "App_reviews.csv")

###Ratings Trend Over Time###

#reviews into date table
dt <- reviews
# extract dates column
dt$Date <- as.Date(dt$Date)
# extract ratings column
dt$Rating <- as.numeric(dt$Rating)
#Combine date and rating
dt <- dt %>% select(Date,Rating) %>% group_by(Date) %>% summarise(Rating = round(weighted.mean(Rating),1))

#graph ratings over time 
highchart() %>%   hc_add_series_times_values(dt$Date,dt$Rating, name = 'Average Rating')



#Wordcloud
wordcloud::wordcloud(reviews_only,max.words = 200, random.order = FALSE,colors = brewer.pal(2, 'Dark2'))











