library(readr)
library(dplyr)
library(ggplot2)
library(plotly)
library(usdata)

map_data <- read_csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
map_data <- map_data %>% group_by(state) %>% summarise(sum = sum(total_prison_pop, na.rm = TRUE))

state_shape <- map_data("state")%>%
  rename(state = region) %>%
  mutate(state = state2abbr(state)) %>%
  left_join(map_data, by = "state")

map <- ggplot(state_shape) + geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = sum),
    color = "red", 
    size = .1      
  ) + coord_map() + scale_fill_continuous(low = "white", high = "red")

map <-map + ggtitle("A Map Showing Prison Population in Each State in the US in 2013")
map <- ggplotly(map)
map

