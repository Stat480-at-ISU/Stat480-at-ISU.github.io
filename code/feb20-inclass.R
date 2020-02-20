# class 2/20/20

# slides: more dplyr ---------------------
library(dplyr)
library(nycflights13)
data(flights, package = "nycflights13")
str(flights)
flights %>%  glimpse()

# CREATE A SUBSET
  
flights %>% filter(month == 1)
filter(flights, month == 1)

flights %>% filter(month == 1, day == 1)
flights %>% filter(month == 1 | day == 1)

flights %>% slice(1:6)
head(flights) 
flights %>% head()

flights %>% slice(1:6, 11:16)
flights %>% slice(-1)
flights %>% slice(-c(1:6))

flights %>% sample_n(5, replace = FALSE)
flights %>% sample_frac(.8, replace = FALSE)

# SELECT COLUMNS

flights %>% select(year, month, day)

flights %>% 
  filter(month == 12) %>% 
  select(-c(year, day))

flights %>% select(flight:distance)
names(flights)

flights %>% select(1:6)
flights %>% select(-1)

flights %>% select(contains("a"))
flights %>% select(starts_with("air"))
  
# & MORE ...

flights %>% arrange(year, month, day)
flights %>% 
  arrange(distance) %>% 
  select(1:3, distance)

flights %>% 
  arrange(desc(distance)) %>% 
  select(1:3, distance, origin, dest)

flights %>% 
  select(dest) %>% 
  distinct() %>% 
  arrange(dest)

flights %>% 
  slice(1:6) %>% 
  pull(carrier)

flights$carrier[1:6]
  

# YOUR TURN -------------------------

# Find all flights that had an arrival delay of two or more hours.
flights %>% 
  filter(arr_delay >= 120)

# Find all flights that were delayed by at least an hour, but made up over 30 minutes in flight
flights %>% filter(dep_delay > 60, dep_delay - arr_delay > 30)

# Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.
flights %>% select(dep_time, dep_delay, arr_time, arr_delay)
flights %>% names()
flights %>% select(4,6,7,9)
flights %>% select(starts_with("arr_"), starts_with("dep_"))

# What happens if you include the name of a variable multiple times in a select() call?
flights %>% select(1:3, year:day, month)
flights %>% select(year:day)

# Sort flights to find the most delayed flights. 
# Find the flights that left earliest.
flights %>% 
  select(starts_with("arr_"), starts_with("dep_")) %>% 
  arrange(desc(dep_delay))

flights %>% 
  select(starts_with("arr_"), starts_with("dep_")) %>% 
  arrange(dep_delay)

flights %>% 
  select(1:3) %>% 
  arrange(dep_delay)

flights %>% 
  select(3:1)
  
flights %>% 
  select(1:3)

# Which flights traveled the longest? Which traveled the shortest?

flights %>% 
  arrange(desc(distance), desc(air_time)) %>% 
  select(dest, origin, air_time, distance)

flights %>% 
  arrange(air_time) %>% 
  select(dest, origin, air_time, distance)


# ADD OR TRANSFORM VARIABLES

flights %>%
  mutate(gain = dep_delay - arr_delay)

# revisit your turn question 2:
# Find all flights that were delayed by at least an hour, but made up over 30 minutes in flight
flights %>% filter(dep_delay > 60, dep_delay - arr_delay > 30)

flights %>%
  mutate(gain = dep_delay - arr_delay) %>% 
  filter(dep_delay > 60, gain > 30)

flights %>%
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours
  ) %>% 
  select(gain:gain_per_hour)


