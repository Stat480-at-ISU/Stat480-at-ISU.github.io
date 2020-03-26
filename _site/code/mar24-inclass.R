# class 3/24/20

library(tidyverse)

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

# left_join()

df1 <- data.frame(id = 1:6, trt = rep(c("A", "B", "C"), rep=c(2,1,3)), value = c(5,3,7,1,2,3))
df1

df2 <- data.frame(id=c(4,4,5,5,7,7), stress=rep(c(0,1), 3), bpm = c(65, 125, 74, 136, 48, 110))
df2

left_join(df1, df2, by="id")
right_join(df1, df2, by="id")
right_join(df2, df1, by="id")
inner_join(df1, df2, by = "id")
full_join(df1, df2, by = "id")


# YOUR TURN
library(Lahman)
LahmanData
HallOfFame %>%  head()
Master %>% head()

# Join (relevant pieces of) the Master data set and the HallOfFame data.
dim(HallOfFame)
dim(Master)
fame_master <- HallOfFame %>% left_join(Master, by = "playerID")
dim(fame_master)
str(fame_master)

# master_fame <- Master %>% left_join(HallOfFame, by = "playerID")
# dim(master_fame)
# str(master_fame)

# Find all Hall of Famers who were alive as of 2019. 
fame_master %>% 
  filter(inducted == "Y", is.na(deathYear)) %>% 
  select(nameFirst, nameLast) %>% 
  arrange(nameLast) %>% 
  head()

# How many attempts at being inducted to the HoF does Sammy Sosa have already? 
fame_master %>% filter(nameLast == "Sosa")

#---------------------
anti_join(df1, df2, by="id") # no values for id in df2
left_join(df2, df1)

anti_join(df2, df1, by="id") # no values for id in df1
left_join(df1, df2)

# Your Turn
devtools::install_github("haleyjeppson/classdata", force = TRUE)
library(classdata)
data(box)
data(budget)
head(budget)
head(box)

# Join the two datasets to incorporate the release date of movies into the box office gross.
new_box <- box %>% left_join(budget, by = "Movie")

# Check on the dimensions of the data sets before and after the join. Where are potential problems?
dim(box)
dim(budget)
dim(new_box)

budget %>% filter(Movie == "Beauty and the Beast")
box %>% filter(Movie == "Beauty and the Beast")
new_box %>% filter(Movie == "Beauty and the Beast")

# Use anti_join to detect problematic cases.
anti_join(box, budget, by = "Movie") %>% head()

anti_join(budget, box, by = "Movie") %>%  head()

