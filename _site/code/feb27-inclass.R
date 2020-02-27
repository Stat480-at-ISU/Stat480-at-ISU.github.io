# class 2/27/20

# slides: more dplyr ---------------------
library(dplyr)
library(nycflights13)
data(flights, package = "nycflights13")
str(flights)
flights %>% glimpse()
?flights


## CREATE SUMMARIES

flights %>%
  group_by(dest) %>%
  summarise(
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  )


## GROUPING HELPER FUNCTIONS

flights %>% group_by(dest) %>% summarise(count = n())

flights %>% group_by(dest) %>% tally()

flights %>% count(dest)

flights %>% count(tailnum)

flights %>% count(tailnum, wt = distance)

flights %>% 
  group_by(tailnum) %>% 
  summarise(total_dist = sum(distance))


## GROUPED MUTATES & FILTERS

flights %>%
  group_by(dest) %>%
  filter(n() >365)

flights %>%
  group_by(dest) %>%
  filter(n() < 365) %>% 
  select(distance)

flights %>%
  group_by(dest) %>%
  filter(n() < 365) %>% 
  ungroup() %>% 
  select(distance)


## YOUR TURN

# Calculate the average delay per date.
flights %>% 
  group_by(year, month, day) %>% 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE),
            n_flights = n()) %>% 
  arrange(desc(avg_delay))


# What time of day should you fly if you want to 
# avoid delays as much as possible?
flights %>% 
  group_by(hour) %>% 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE)) %>% 
  arrange(avg_delay)

flights %>% 
  filter(hour == 1)

# Explore the relationship between the distance and average delay 
# for each destination. 
# Also calculate the number of flights flown to each destination.

flights %>% 
  group_by(dest) %>% 
  summarise(n_flights = n(),
            avg_delay = mean(arr_delay, na.rm = TRUE),
            avg_distance = mean(distance, na.rm = TRUE)) %>% 
  arrange(desc(avg_distance)) %>% 
  ggplot() + 
  geom_hline(aes(yintercept = 0), alpha = 0.7, color = "blue") +
  geom_point(aes(x = avg_distance, y = avg_delay, 
                 size = n_flights), alpha = .4)


## YOUR TURN

# Which carrier has the worst delays?

flights %>% 
  group_by(carrier) %>% 
  summarise(max_delay = max(arr_delay, na.rm = TRUE)) %>% 
  arrange(desc(max_delay))

flights %>% 
  group_by(carrier) %>% 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE)) %>% 
  arrange(desc(avg_delay))

# Rank airlines by the number of destinations that they 
# fly to, considering only those airports that are flown 
# to by two or more airlines.

flights %>% 
  group_by(dest) %>% 
  mutate(n_carriers = n_distinct(carrier)) %>% 
  filter(n_carriers > 1) %>% 
  group_by(carrier) %>% 
  summarise(n_dest = n_distinct(dest)) %>% 
  arrange(desc(n_dest))

# Look at the number of cancelled flights per day. 
# Is there a pattern? Is the proportion of cancelled 
# flights related to the average delay?

flights %>% 
  mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>% 
  group_by(year, month, day) %>% 
  summarise(n_cancelled = sum(cancelled),
            n_flights = n()) %>% 
  ggplot() + geom_point(aes(x = n_flights, y = n_cancelled))

flights %>% 
  mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>% 
  group_by(year, month, day) %>% 
  summarise(prop_cancelled = mean(cancelled),
            avg_delay = mean(arr_delay, na.rm = TRUE)) %>% 
  ggplot() + geom_point(aes(x = avg_delay, y = prop_cancelled))
  
