# class 2/25/20

# slides: more dplyr ---------------------
library(dplyr)
library(nycflights13)
data(flights, package = "nycflights13")
str(flights)
flights %>% glimpse()
?flights

flights %>% select(dest) %>% distinct() %>% arrange(dest)

all_dest <- flights %>% select(dest) %>% distinct() %>% arrange(dest)

all_dest

all_dest_vector <- flights %>% 
  select(dest) %>% 
  distinct() %>% 
  arrange(dest) %>% 
  pull(dest)

all_dest_vector
all_dest$dest

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

flights %>%
  mutate(gain = dep_delay - arr_delay) %>% 
  mutate(hours = air_time / 60) %>% 
  mutate(gain_per_hour = gain / hours) %>% 
  select(gain:gain_per_hour)

# YOUR TURN 

517 %/% 100 
# 5

517 %% 100 
# 17

# Calculate the air speed of each flight in miles per minute (create mpm) 
# using distance and air_time.

flights %>% 
  mutate(mpm = distance/air_time) %>% 
  select(distance, air_time, mpm) %>% 
  head()

# Add to the mutate() statement from above to calculate the air speed
# in miles per hour (create mph).

flights %>% 
  mutate(mpm = distance/air_time,
         air_time_hours = air_time / 60,
         mph = distance/air_time_hours) %>% 
  select(distance, air_time, mpm, air_time_hours, mph) %>% 
  head()

# Compute arr_hour and arr_min from arr_time. 

flights %>% 
  mutate(arr_hour = arr_time %/% 100,
         arr_min = arr_time %% 100) %>% 
  glimpse()


flights %>% 
  mutate(arr_hour = arr_time %/% 100,
         arr_min = arr_time %% 100,
         arr_time_min = (arr_hour * 60 ) + arr_min) %>% 
  glimpse()

# Find the 10 most delayed flights using a ranking function. 
# How do you want to handle ties? 
# Print the top 10 in descending order according to the amount of delay.

flights %>% 
  mutate(delay_rank = min_rank(desc(arr_delay))) %>% 
  filter(delay_rank < 11) %>% 
  select(arr_delay, delay_rank) %>% 
  arrange(desc(arr_delay))

# Compare dep_time, sched_dep_time, and dep_delay. 

flights %>% 
  select(dep_time, sched_dep_time, dep_delay) %>% 
  slice(1:10)

flights %>% 
  mutate(test = dep_time - sched_dep_time) %>% 
  select(dep_time, sched_dep_time, dep_delay, test) %>% 
  slice(1:10)

# CREATE SUMMARIES

flights %>%
  summarise(m_delay = mean(dep_delay, na.rm = TRUE))

mean(flights$dep_delay, na.rm = TRUE)


flights %>%
  summarise(m_delay = mean(dep_delay, na.rm = TRUE),
            sd_delay = sd(dep_delay, na.rm = TRUE),
            sum_delay = sum(dep_delay, na.rm = TRUE))


flights %>%
  group_by(dest) %>%
  summarise(
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  )



flights %>%
  group_by(dest) %>%
  summarise(dist = mean(distance, na.rm = TRUE),
            delay = mean(arr_delay, na.rm = TRUE))
  
# GROUPING HELPER FUNCTIONS

flights %>% group_by(dest) %>% summarise(count = n())

# test <- flights %>% filter(dest == "ABQ") # length(test$dest)

flights %>% group_by(dest) %>% tally()

flights %>% count(dest)

flights %>% count(tailnum)

flights %>% count(tailnum, wt = distance)

flights %>% 
  group_by(tailnum) %>% 
  summarise(total_dist = sum(distance))


flights %>% group_by(carrier) %>% select(origin)

flights %>% group_by(carrier) %>% ungroup() %>% select(origin)


