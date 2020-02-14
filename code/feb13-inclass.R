# class 2/13/20

# slides: visualizing factors
library(classdata)
data("titanic")
library(ggplot2)

ggplot(titanic, aes(x = Class)) + 
  geom_bar()

ggplot(titanic, aes(x = Class, fill = Survived)) + 
  geom_bar()

ggplot(titanic, aes(x = Class, fill = Survived)) + 
  geom_bar(position = "fill")

# YOUR TURN -----------------

# devtools::install_github("haleyjeppson/classdata")
library(classdata)
data("titanic")

# Draw a barchart of Gender. 
ggplot(data = titanic) + geom_bar(aes(x = Sex))

# Map survival to fill color in the barchart of Gender. 
ggplot(data = titanic) + geom_bar(aes(x = Sex, fill = Survived))

# In the previous barchart change the position parameter to "fill". 
ggplot(data = titanic) + geom_bar(aes(x = Sex, fill = Survived), position = "fill")

# Read up on the position parameter in ?geom_bar. Try out other options.
ggplot(data = titanic) + geom_bar(aes(x = Sex, fill = Survived), position = "stack")
ggplot(data = titanic) + geom_bar(aes(x = Sex, fill = Survived))

ggplot(data = titanic) + geom_bar(aes(x = Sex, fill = Survived), position = "dodge")
ggplot(data = titanic) + geom_bar(aes(x = Sex, fill = Survived), position = "dodge2")


# YOUR TURN -----------------
ucb_admit <- read.csv("https://raw.githubusercontent.com/Stat480-at-ISU/materials-2020/master/02_r-intro/data/ucb-admit.csv")

# Draw a barchart of Gender. 
ggplot(ucb_admit) + geom_bar(aes(x = Gender))

# Map Admit to fill color in the barchart of Gender. 
ggplot(ucb_admit) + geom_bar(aes(x = Gender, fill = Admit))

# In the previous barchart change the position parameter to "fill". 
ggplot(ucb_admit) + geom_bar(aes(x = Gender, fill = Admit), position = "fill")

# Try out other options of looking at the data. 
# Is there evidence of a sex bias in graduate admissions?
ggplot(ucb_admit) + 
  geom_bar(aes(x = Gender, fill = Admit), position = "fill") +
  facet_grid(~Dept)


# -------------------------------------------
# slides: intro to tidyverse

# using the pipe
ggplot(data = filter(fbi, Type == "Murder.and.nonnegligent.Manslaughter"), 
       aes(x = Year, y = Count)) + 
  geom_point()

fbi %>% 
  filter(Type == "Murder.and.nonnegligent.Manslaughter") %>%
  ggplot(aes(x = Year, y = Count)) + 
  geom_point()


# YOUR TURN --------------

# Using the pipe, 
# create a subset of the data for one type of crime in Iowa and then 
# create a line chart (use geom_line()) that shows counts over time.
library(classdata)
library(dplyr)
library(tidyverse)
fbi %>% 
  dplyr::filter(State == "Iowa") %>% 
  filter(Type == "Burglary") %>% 
  ggplot() + geom_line(aes(x = Year, y = Count))
  




  