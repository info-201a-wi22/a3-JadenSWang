library(readr)
library(dplyr)
library(ggplot2)
# filter the results down to between 1999 and 2018
incarceration_trends <- read_csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv") %>% filter(between(year, 1999, 2013))

tiby_male <- as.list(incarceration_trends %>% group_by(year) %>% summarize(Male_Incarcerated=sum(male_prison_pop, na.rm=TRUE)))
tiby_female <- as.list(incarceration_trends %>% group_by(year) %>% summarize(Female_Incarcerated=sum(female_prison_pop, na.rm=TRUE)))

gender_change <- plot(tiby_female$year, tiby_female$Female_Incarcerated,
     main="Incarcerations By Gender Per Year",
     ylab="Incarcerated Per Year",
     xlab="Year",
     type="l",
     col="blue", ylim=c(0, 1200000))
lines(tiby_male$year, tiby_male$Male_Incarcerated, col="red")
legend("topleft",
       c("female", "male"),
       fill=c("blue","red")
)
