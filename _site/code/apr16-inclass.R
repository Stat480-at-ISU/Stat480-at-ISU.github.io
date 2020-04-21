# class 4/16/20

# slides: maps ---------------------
library(tidyverse)

data(fbi, package="classdata")
 

states <- map_data("state")
head(states)

fbi %>% 
  filter(Year == 2014) %>% 
  mutate(region = tolower(State),
         rate = Count/Population) %>% 
  left_join(states, by="region") %>% 
  filter(Type=="Burglary") %>% 
  ggplot(aes(x = long, y = lat, fill= rate)) +
  geom_polygon(aes(group=group), color = "white", size = 0.2)

## YOUR TURN

#Draw a choropleth map of the rate of motor vehicle thefts in 2012 across the US.

# unique(fbi$Type)

car_map <- fbi %>% 
  filter(Year == 2012) %>% 
  mutate(region = tolower(State),
         rate = Count/Population*60000,
         rate = ifelse(State == "Iowa", NA, rate)) %>% 
  left_join(states, by="region") %>% 
  filter(Type=="Motor.vehicle.theft") %>% 
  ggplot(aes(x = long, y = lat, fill= rate)) +
  geom_polygon(aes(group=group), color = "white", size = 0.2)

car_map
# scale_fill_gradient2() allows you to set a color scheme with two main colors. 
# Read up on it and change the scheme in the first choropleth map.

?scale_fill_gradient2

car_map + 
  scale_fill_gradient2(midpoint = 200, na.value = "grey80", low = "#2874A6", high = "#E74C3C") + 
  theme_bw()

car_map + 
  scale_fill_gradient2(midpoint = 200, na.value = "grey80", low = "#28B463", high = "#F39C12") + 
  theme_bw()

# -------------------------
## YOUR TURN
acc <- read.csv("https://raw.githubusercontent.com/DS202-at-ISU/labs/master/data/fars2016/accident.csv", stringsAsFactors = FALSE)
names(acc)
head(acc)

# Use the accident data to plot the geographic location of all accidents in the US in 2016.

#unique(acc$YEAR)
# map %>% ggplot(aes(x = long, y = lat)) + 
#   geom_polygon(aes(group = group)) +
#   geom_point(data = content, aes(x=longitude, y = latitude))

# states <- map_data("state")

states %>% 
  ggplot(aes(x = long, y = lat)) +
  geom_path(aes(group = group)) 

states %>% 
  ggplot(aes(x = long, y = lat)) +
  geom_path(aes(group = group)) + 
  geom_point(data = acc, aes(x = LONGITUD, y = LATITUDE))

states %>% 
  ggplot(aes(x = long, y = lat)) +
  geom_path(aes(group = group)) + 
  geom_point(data = acc %>% filter(LONGITUD < 500, LONGITUD > -130), aes(x = LONGITUD, y = LATITUDE))


states %>% 
  ggplot(aes(x = long, y = lat)) +
  geom_path(aes(group = group)) + 
  geom_point(data = acc %>% filter(LONGITUD < 500, LONGITUD > -130), 
             aes(x = LONGITUD, y = LATITUDE), size = 0.5)


states %>% 
  ggplot(aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), fill = "white", colour = "black", size = 0.5) + 
  geom_point(data = acc %>% filter(LONGITUD < 500, LONGITUD > -130), 
             aes(x = LONGITUD, y = LATITUDE), size = 0.5,
             color = "violetred4", alpha = 0.4)

states %>% 
  ggplot(aes(x = long, y = lat)) +
  geom_path(aes(group = group)) + 
  geom_point(data = acc %>% filter(LONGITUD < 500, LONGITUD > -130), 
             aes(x = LONGITUD, y = LATITUDE), size = 0.1,
             color = "violetred4", alpha = 0.1)

acc
# Plot accidents on a map of the US (use the map of the US as first layer)




# Why would it be tricky to plot a choropleth map of the number of accidents by state?


library(albersusa)
states_sf <- usa_sf()
head(states_sf)

