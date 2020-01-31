
# Your turn
fbi <- read.csv("https://raw.githubusercontent.com/Stat480-at-ISU/materials-2020/master/02-r_intro/data/fbi.csv")
library(ggplot2)
str(fbi)

ggplot(data = fbi, aes(x = Violent.crime, weight = Count)) + geom_bar()

ggplot(data = fbi, aes(x = Violent.crime, weight = Count)) + 
  geom_bar() +
  facet_wrap(~Type)

ggplot(data = fbi, aes(x = Violent.crime, weight = Count, color = Type)) + 
  geom_bar()

ggplot(data = fbi, aes(x = Violent.crime, weight = Count, fill = Type)) + 
  geom_bar(color = "black")

ggplot(data = fbi) + geom_histogram(aes(x = Count))

ggplot(data = fbi) + geom_histogram(aes(x = Count)) + facet_wrap(~Type)
str(fbi)


#---------------------------------

a <- c(1,15, 3,20, 5,8,9,10, 1,3)

a < 20

(a^2 >= 100) | (a^2 < 10)

a %in% c(1, 3)
a == c(1, 3, 1, 3, 1)

(a == 1) | (a == 3)

?`%%`

(a %% 2) == 0

#-------------------------------------
library(dplyr)
?filter
