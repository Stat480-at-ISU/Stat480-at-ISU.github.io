# class 3/31/20

# slides: dates & times ---------------------

## Create date objects for today's date by typing the date 
## in text format and converting it with one of the lubridate converter functions.

## Try different formats of writing the date and compare the end results.

## Use the appropriate converter function to parse each of the following dates:
library(lubridate)

d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14"

mdy(d1)
ymd(d2)
dmy(d3)
mdy(d4)
mdy(d5)

## -----------------------
library(nycflights13)
library(tidyverse)

flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute)) %>% 
  head()

today()
now()
as_datetime(today())
as_date(now())

## YOUR TURN ------------------------

# Use make_datetime() to create a date-time variable for dep_time and
# arr_time. Save results as flights_dt.

# Hint: use modular arithmetic %/% for hour and %% for minute

517 %/% 100 # hour
517 %% 100 # minute

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(dep_hour = dep_time %/% 100,
         dep_min = dep_time %% 100,
         arr_hour = arr_time %/% 100,
         arr_min = arr_time %% 100,
         dep_time = make_datetime(year, month, day, dep_hour, dep_min),
         arr_time = make_datetime(year, month, day, arr_hour, arr_min))

flights_dt

### accessor functions ------------------------

now()
month(now())
month(now(), label = TRUE)
month(now(), label = TRUE, abbr = FALSE)

mday(now())
yday(now())
wday(now())

flights_dt %>% 
  mutate(wday = wday(dep_time), label = TRUE) %>% 
  ggplot(aes(x = wday)) +
  geom_bar()

flights_dt %>% 
  mutate(wday = factor(wday(dep_time))) %>% 
  ggplot(aes(x = wday)) +
  geom_bar()

(date <- now())

year(date)
year(date) <- 1920
date

hour(date)
hour(date) + 2

hour(date) <- hour(date) + 2
date

## YOUR TURN ------------------------

# Use an accessor function to calculate the average
# departure delay by minute within the hour.
# Use ggplot2 to plot your results.

flights_dt %>% 
  mutate(minute = minute(dep_time)) %>% 
  group_by(minute) %>% 
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE)) %>% 
  ggplot(aes(x = minute, y = avg_delay)) + 
  geom_line()

## time spans ------------------------

h_age <- today() - ymd(19900327)
h_age

as.duration(h_age)

next_year <- today() + years(1)
next_year

today() %--% next_year

(today() %--% next_year) / ddays(1)

(today() %--% next_year) / dweeks(1)

(today() %--% next_year) %/% dweeks(1)




## YOUR TURN

# inspect the budget data set from the classdata package
# make sure the variable Release Date is a date format

budget %>% glimpse()

# plot a histogram of the variable

ggplot(budget, aes(x = ReleaseDate)) + geom_histogram(binwidth = 365)
       
# merge (join) budget and box office data (by movie name)

box_budget <- box %>% left_join(budget, by = "Movie")
head(box_budget)       
       
# is the time between the release of a movie and the date is equal 
# to the number of weeks in theaters?     

box_budget %>% 
  filter(!is.na(ReleaseDate)) %>% 
  mutate(test_week = ceiling((ReleaseDate %--% Date) / dweeks(1))) %>% 
  select(Movie, ReleaseDate, Date, Week, test_week) %>% 
  head(15)



       
