library(readr)
library(dplyr)
library(ggplot2)
# filter the results down to between 1999 and 2018
incarceration_trends <- read_csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv") %>% filter(between(year, 1999, 2013))

tiby_male <- as.list(incarceration_trends %>% group_by(year) %>% summarize(Male_Incarcerated=sum(male_prison_pop, na.rm=TRUE)))
tiby_female <- as.list(incarceration_trends %>% group_by(year) %>% summarize(Female_Incarcerated=sum(female_prison_pop, na.rm=TRUE)))

total_women_data <- as.list(incarceration_trends %>% group_by(year) %>% summarize(total_women=sum(female_pop_15to64, na.rm=TRUE)))
total_women_prison_data <- as.list(incarceration_trends %>% group_by(year) %>% summarize(total_incarcerated_women=sum(female_prison_pop, na.rm=TRUE)))

plot(total_women_data$total_women, total_women_prison_data$total_incarcerated_women,
                               main="Total Female Population vs Total Female Incarceration",
                               ylab="Total Female Incarceration",
                               xlab="Total Female Population",
                               type='l',
                               color='blue')