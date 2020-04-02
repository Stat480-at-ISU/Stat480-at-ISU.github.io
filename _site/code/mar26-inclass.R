# class 3/26/20

# homework 9 ---------------------
library(tidyverse)
library(classdata)
data(box)
head(box)

# Re-derive variables: Change (percent change in gross income from last week), Rank.Last.Week, 
# Per.Thtr. (as gross per theater), and Total.Gross (as the cumulative sum of weekly gross).

sample <- box %>% 
  filter(Movie == "13 Minutes") %>% 
  arrange(Week)

lag()
lag(1:10, 1)

sample %>% 
  mutate(rank_last_week = lag(Rank, order_by = Week)) %>% 
  select(Week, Rank, Rank.Last.Week, rank_last_week)

sample %>% 
  mutate(week_diff = Week - lag(Week),
         rank_last_week = lag(Rank, order_by = Week)) %>% 
  select(Week, Rank, Rank.Last.Week, week_diff, rank_last_week)

# ifelse example
x <- c(6:-4)
sqrt(x)  #- gives warning
ifelse(x >= 0, x, NA)
sqrt(ifelse(x >= 0, x, NA))  # no warning

sample %>% 
  mutate(week_diff = Week - lag(Week),
         rank_last_week_old = lag(Rank, order_by = Week), 
         rank_last_week = ifelse(week_diff == 1, rank_last_week_old, NA)) %>% 
  select(Week, Rank, Rank.Last.Week, week_diff, rank_last_week_old, rank_last_week)

cumsum(1:10)

# slides: dealing with messy (4) ---------------------

library(nycflights13)

flights %>% 
  left_join(airports, by = c("dest" = "faa")) %>% 
  select(dest, origin, name:tzone)

flights %>% 
  left_join(airports, by = c("origin" = "faa")) %>% 
  select(dest, origin, name:tzone)

# YOUR TURN

# Add the location of the origin and destination (i.e. the lat and lon) from 
# the airports data to the flights data

airport_locations <- airports %>% 
  select(faa, lat, lon)

flights_subset <- flights %>% 
  select(year:day, hour, origin, dest)

flights_subset %>% 
  left_join(airport_locations, by = c("origin" = "faa"))

flights_subset %>% 
  left_join(airport_locations, by = c("origin" = "faa")) %>% 
  left_join(airport_locations, by = c("dest" = "faa"), suffix = c("_origin", "_dest"))

# Is there a relationship between the age of a plane and its arrival delays?
# Join the tables flights and planes and calculate the average arrival delay for each age of a flight. 
# Since there are few planes older than 25 years, truncate age at 25 years.
# Plot age against the average arrival delay.

plane_ages <- planes %>% 
  select(tailnum, plane_year = year)

flights_subset <- flights %>% 
  select(year:day, arr_delay, tailnum)

flights_subset %>% 
  left_join(plane_ages) %>% 
  mutate(plane_age = year - plane_year) %>% 
  filter(!is.na(plane_age)) %>% 
  mutate(plane_age = ifelse(plane_age > 25, 25, plane_age)) %>% 
  group_by(plane_age) %>% 
  summarise(arr_delay_mean = mean(arr_delay, na.rm = TRUE),
            n_arr_delay = sum(!is.na(arr_delay))) %>% 
  ggplot() +
  geom_point(aes(x = plane_age, y = arr_delay_mean))


# What weather conditions make it more likely to see a departure delay?
# Join the tables flights and weather, calculate the mean departure delay for each amount of 
# precipitation, and plot your results.

flight_weather <- flights %>% 
  left_join(weather) %>% 
  select(year:day, dep_delay, temp:visib)
  

flight_weather %>% 
  group_by(precip) %>% 
  summarise(mean_delay = mean(dep_delay, na.rm = TRUE)) %>% 
  ggplot(aes(x = precip, y = mean_delay)) + geom_point() + geom_line()

