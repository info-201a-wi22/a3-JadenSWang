library(readr)
library(dplyr)
# filter the results down to between 1999 and 2018
incarceration_trends <- read_csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv") %>% filter(between(year, 1999, 2016))
View(incarceration_trends)

# year with highest incarceration for all
highest_incarceration_year <- (incarceration_trends %>% group_by(year) %>% summarize(Incarcerated=sum(total_prison_pop_rate, na.rm=TRUE)) %>% arrange(desc(Incarcerated)))[1,]['year']
View(highest_incarceration_year)

# year with lowest incarceration for all
lowest_incarceration_year <- (incarceration_trends %>% group_by(year) %>% summarize(Incarcerated=sum(total_prison_pop_rate, na.rm=TRUE)) %>% arrange(desc(Incarcerated)))[18,]['year']
View(lowest_incarceration_year)

# percentage of men vs women for that highest
num_women_for_highest <- incarceration_trends %>% filter(year == 2013) %>% summarize(Incarcerated=sum(female_prison_pop, na.rm=TRUE))
View(num_women_for_highest)

num_men_for_highest <- incarceration_trends %>% filter(year == 2013) %>% summarize(Incarcerated=sum(male_prison_pop, na.rm=TRUE))
View(num_men_for_highest)

# percentage of men vs women for that lowest
num_women_for_lowest <- incarceration_trends %>% filter(year == 1999) %>% summarize(Incarcerated=sum(female_prison_pop, na.rm=TRUE))
View(num_women_for_lowest)

num_men_for_lowest <- incarceration_trends %>% filter(year == 1999) %>% summarize(Incarcerated=sum(male_prison_pop, na.rm=TRUE))
View(num_men_for_lowest)

#percentage change
total_highest = num_women_for_highest + num_men_for_highest
male_percentage_highest = num_men_for_highest / total_highest
female_percentage_highest = num_women_for_highest / total_highest
total_lowest = num_women_for_lowest + num_men_for_lowest
female_percentage_lowest = num_women_for_lowest / total_lowest
male_percentage_highest = num_men_for_lowest / total_lowest
