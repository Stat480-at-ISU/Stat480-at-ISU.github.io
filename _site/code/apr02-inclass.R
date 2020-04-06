# class 4/2/20

# slides: dates & times ---------------------

## YOUR TURN

# is the time between the release of a movie and the date is equal 
# to the number of weeks in theaters?     

box_budget %>% 
  filter(!is.na(ReleaseDate)) %>% 
  mutate(test_week = ceiling((ReleaseDate %--% Date) / dweeks(1))) %>% 
  select(Movie, ReleaseDate, Date, Week, test_week) %>% 
  head(15)

# slides: timeseries ---------------------

# install.packages("GGally")

## YOUR TURN

# Load the nasa data from the package GGally

data(nasa, package = "GGally")

# for one location, draw a time line of Ozone over the time frame (time).

nasa %>% 
  dplyr::filter(id == "13-2") %>%
  ggplot(aes(x = time, y = ozone)) + geom_line()


# Plot separate lines for each of the years, i.e. put month on the x-axis and ozone on the 
# y-axis for the same location. Is there a seasonal pattern apparent?
nasa %>% glimpse()

nasa %>% 
  dplyr::filter(id == "13-2") %>%
  ggplot(aes(x = month, y = ozone, color = factor(year))) + geom_line() 

  
# Pick locations with x in 1:10 and y in 7:10. Plot temperature over time. 
# Comment on the result.


nasa %>% 
  dplyr::filter(x %in% 1:10, y %in% 7:10) %>%
  ggplot(aes(x = date, y = temperature, group = id)) + geom_line(alpha = 0.3) 


## YOUR TURN

# Load the box data from the package classdata
data(box, package="classdata")

# For each movie and distributor, find:
# (1) the highest total gross,
# (2) the last date (and week) the movie was shown in theaters,
# (3) the gross the movie made in the first week it was featured on the box office list.
# (4) the number of times the movie appears on the box office list

box_summary <- box %>% 
  group_by(Movie, Distributor) %>%
  summarize(
    Date = max(Date),
    Week = max(Week),
    Total.Gross = max(Total.Gross),
    Gross = min(Total.Gross)
  )

# ------------------------------
box_summary %>% dplyr::filter(Total.Gross > 5e8)

box %>% 
  ggplot(aes(x = Date, y = Total.Gross, 
             group = interaction(Movie, Distributor))) + geom_line() +
  geom_text(aes(x = Date, y = Total.Gross, label=Movie), 
            data = box_summary %>% dplyr::filter(Total.Gross > 5e8))





