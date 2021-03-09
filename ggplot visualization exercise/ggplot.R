#1. load tidyverse

# install.packages("tidyverse")

library(tidyverse)
library(dplyr)
##2 scatterplot of dinosaur NM visitation

# Create subset 

# another method: dino_nm2 <- read_csv(~/github/data-vis/np_visit.csv)
dino_nm <- read_csv("np_visit.csv")
# have to open np_visit.csv file (import data) first
dino_nm2 <- np_visit %>% 
  filter(park_name == "Dinosaur National Monument")  #%>% command+shif+M

# steps for ggplot

#1. Tell R that I'm using ggplot
#2. Tell R what data I'm using (including what's x and y)
#3. What type of graph I want to creat

ggplot(data = dino_nm2, aes(x = year, y = visitors)) +
  geom_point() # geom_point: scatterplot

# Multi-series scatterplot graph for NPs in California

np_ca <-np_visit %>% 
  filter(state == "CA" & type == "National Park")

# Using themes to update overall look of the graph
ggplot(data = np_ca, aes(x= year, y = visitors)) + geom_point(aes(color = park_name)) +
  geom_line()+
  xlab("This is my x-axis label")+
  ylab("This is a y-axis label")+
  ggtitle("Added Title")+
  theme_bw() # theme_classic() # theme_dark()


np_ut <- np_visit %>% 
  filter(state == "UT" )

ggplot(data = np_ut, aes(x = year, y = visitors)) + 
  geom_point(aes(color = park_name)) + 
  labs(x= "test x-label", 
       y = "test y-label", 
       title = "main title")

## Different gg geoms

ggplot(data = np_ca, aes(x=year, y = visitors))+
  geom_line(aes(color = park_name))

ggplot(data = np_ca, aes(x=year, y = visitors))+
  geom_boxplot(aes(color = park_name))

ggplot(data = np_ca, aes(x=year, y = visitors))+
  geom_line(aes(color = park_name))+
  geom_point(aes(color=park_name))

ggplot(data = dino_nm2, aes(x=year, y = visitors))+
  geom_point(aes(color = park_name))+
  geom_smooth()


ggplot(data = np_ca, aes(x = park_name, y = visitors))+
  geom_jitter(aes(color=park_name))+
  coord_flip() #use when some labels are longer

## Faceting (facet_wrap) to split up series into isolated graphics windows

ggplot(data = np_ca, aes(x = year, y = visitors)) +
  geom_point(aes(color = park_name)) + 
  facet_wrap(~ park_name, scales = "free") # free_x, or free_y

## Bar plot


visit_16 <- np_visit %>% 
  filter(year == 2016) %>% 
  filter(type == "National Park" | 
           type == "National Monument") # "|" or 
# stacked bar
ggplot(data = visit_16, aes(x = type)) + 
  geom_bar(aes(fill = region))

# stacked bar + percent (0-1)
my_graph <- ggplot(data = visit_16, aes(x = type)) + 
  geom_bar(aes(fill = region), position = "fill")

## Save

ggsave("my_park_graph.png", my_graph, width = 6, height = 7, dpi = 200)



