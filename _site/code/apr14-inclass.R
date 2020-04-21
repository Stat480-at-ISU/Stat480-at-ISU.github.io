# class 4/14/20

# slides: maps ---------------------
library(tidyverse)
states <- map_data("state")
head(states)

tail(states)

ggplot(states, aes(x = long, y = lat)) + geom_point()

ggplot(states, aes(x = long, y = lat)) + geom_line()

ggplot(states, aes(x = long, y = lat)) + geom_line(aes(group = group))

ggplot(states, aes(x = long, y = lat)) + geom_path()

ggplot(states, aes(x = long, y = lat)) + geom_path(aes(group = group))


## YOUR TURN

# Use ggplot2 and pull out map data for all US counties: 
  
counties <- map_data("county")

# Draw a map of counties (polygons & path geom)

ggplot(data = counties, aes(x = long, y = lat)) + geom_path()

ggplot(data = counties, aes(x = long, y = lat)) + 
  geom_path(aes(group = group))

ggplot(data = counties, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), color = "white")

ggplot(data = counties, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), color = "white", size = 0.1)

ggplot(data = counties, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), color = "white", size = 0.1, fill = "yellowgreen")

ggplot(data = counties, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), color = "black", size = 0.1, fill = "yellowgreen")

ggplot(data = counties, aes(x = long, y = lat)) + 
  geom_polygon(aes(group = group), color = "black", size = 0.1, fill = "yellowgreen") +
  theme_void()

ggplot(data = counties, aes(x = long, y = lat)) + 
  geom_polygon(aes(group = group, fill = region), color = "white", size = 0.1, show.legend = FALSE)

# Colour all counties called "story"

counties %>% 
  mutate(filled = subregion == "story") %>% 
  ggplot(aes(x = long, y = lat)) + 
  geom_polygon(aes(group = group, fill = filled), color = "white", size = 0.1)

counties %>% 
  ggplot(aes(x = long, y = lat)) + 
  geom_polygon(aes(group = group, fill = subregion == "story"), color = "white", size = 0.1)


# What county names are used most often?

counties %>% 
  count(subregion) %>% 
  arrange(desc(n))

head(counties)


counties %>% 
  distinct(region, subregion) %>% 
  count(subregion) %>% 
  arrange(desc(n))

counties %>% 
  mutate(jeff_wash = replace(subregion, !(subregion %in% c("jefferson", "washington")), NA)) %>% 
  ggplot(aes(x = long, y = lat)) + 
  geom_polygon(aes(group = group, fill = jeff_wash), color = "white", size = 0.1)


#----------------------
# geom_sf()

library(sf)
states <- USAboundaries::us_boundaries()
states %>% select(name, geometry) %>% slice(1:10)
head(states)

states48 <- states %>% 
  dplyr::filter(stringr::str_detect(name, "Hawaii|Alaska|Puerto", negate = T))

ggplot() + geom_sf(data = states48, aes(geometry = geometry))


ggplot() + geom_sf(data = states48)

ggplot() + geom_sf(data = states48, aes(fill = name), show.legend = FALSE)


ggplot() + geom_sf(data = states48, aes(fill = awater))

## YOUR TURN 

# devtools::install_github("hrbrmstr/albersusa")
library(albersusa)
states <- usa_sf()

# Use geom_sf() and the states data to create a map of the US.
ggplot(states) + geom_sf()

#-----------------------------------
data(fbi, package="classdata")
fbi14 <- fbi %>% dplyr::filter(Year == 2014)
head(fbi14)

states <- map_data("state")
head(states)

fbi14$region <- tolower(fbi14$State)
head(fbi14)

nomatch1 <- fbi14 %>% anti_join(states, by="region")
unique(nomatch1$State)

nomatch2 <- states %>% anti_join(fbi14, by="region")

unique(nomatch2$State)

fbi.map <- fbi14 %>% left_join(states, by="region")

fbi.map %>% 
  dplyr::filter(Type=="Burglary") %>% 
  mutate(Rate = Count/Population) %>% 
  ggplot(aes(x = long, y = lat, fill=Rate)) +
  geom_polygon(aes(group=group))




