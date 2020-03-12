# class 3/12/20

# slides: dealing with messy (3) ---------------------

# devtools::install_github("haleyjeppson/classdata")
data(box, package = "classdata")
head(box, 4)


# YOUR TURN

# Big goal: we want to create a new dataset movie that consists of movie, distributor, 
# date of first time the movie shows up in the box office, and the number of weeks the 
# movie has been released at that time.

# What are the key variables for the new dataset?
movies <- box %>% select(Movie, Distributor) %>% distinct()
head(movies)

movies %>% count(Movie, Distributor) %>% arrange(desc(n))
movies %>% group_by(Movie, Distributor) %>% 
  summarise(count = n()) %>% arrange(desc(count))

movies %>% count(Movie) %>% arrange(desc(n))

# For the key variable(s), use summarize() to find the first time a movie shows up in the 
# box office and find the related number of weeks.

movies <- box %>% 
  group_by(Movie, Distributor) %>% 
  summarise(
    first_date = Date[which.min(Week)],
    first_week = min(Week, na.rm =TRUE)
  )


movies %>% 
  group_by(Movie) %>% 
  mutate(n = n()) %>% 
  arrange(desc(n))


# slides: dealing with messy (4) ---------------------
library(Lahman)
LahmanData
AllstarFull %>%  head()
Master %>% head()

# YOUR TURN

# Identify all players who were inducted in the Hall of Fame in 2017, by 
# filtering the Master data for their player IDs.

player_ids <- HallOfFame %>% dplyr::filter(yearID == 2017) %>% pull(playerID)

Master %>% filter(playerID %in% player_ids) %>% str()






