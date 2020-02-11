# code from class 2/11

# Working with factors

# CASTING BETWEEN TYPES
as.numeric(c(TRUE, FALSE, FALSE))
as.logical(as.numeric(c(TRUE, FALSE, FALSE)))

factor(c("apple", "banana", "orange"))
as.factor(c("apple", "banana", "orange"))

factor(c(4,6,1,4,7))
as.numeric(factor(c(4,6,1,4,7)))

# LEVELS OF FACTOR VARIABLES
levels(factor(c(4,6,1,4,7)))

levels(gss_cat$race)
summary(gss_cat$race)

# CHANGING THE ORDER
library(forcats)
levels(fct_infreq(gss_cat$race))
levels(gss_cat$race)

gss_cat$race <- fct_infreq(gss_cat$race)
levels(gss_cat$race)

# YOUR TURN
fbi <- read.csv("https://raw.githubusercontent.com/Stat480-at-ISU/materials-2020/master/02_r-intro/data/fbi.csv")

# (Q1) Introduce a rate of the number of reported offenses by population into the fbi data. 
# You could use the Ames standard to make values comparable to a city of the size of Ames (population ~70,000).
fbi$rate <- fbi$Count/fbi$Population*70000
str(fbi)

# (Q2) Plot boxplots of crime rates by different types of crime. 
# How can you make axis text legible?
library(ggplot2)
ggplot(fbi, aes(x = Type, y = rate)) + 
  geom_boxplot() + 
  coord_flip()

ggplot(fbi, aes(x = Type, y = rate)) + 
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 90))

# (Q3) Reorder the boxplots of crime rates, such that the boxplots are ordered by their medians.
is.factor(fbi$Type)

# base R option
ggplot(fbi, aes(x = reorder(Type, rate, median), y = rate)) + 
  geom_boxplot() + 
  coord_flip()

ggplot(fbi, aes(x = reorder(Type, rate, median, na.rm = TRUE), y = rate)) + 
  geom_boxplot() + 
  coord_flip()

# forcats option
library(forcats)
# default function is median
ggplot(fbi, aes(x = fct_reorder(Type, rate, na.rm = TRUE), y = rate)) + 
  geom_boxplot() + 
  coord_flip()

# (Q4) For one type of crime (subset!) plot boxplots of rates by state,  
# reorder boxplots by median crime rates
library(dplyr)
burgs <- filter(fbi, Type == "Burglary")

ggplot(burgs, aes(x = Abb, y = rate)) + 
  geom_boxplot() + 
  coord_flip()

ggplot(burgs, aes(x = fct_reorder(Abb, rate), y = rate)) + 
  geom_boxplot() + 
  coord_flip()

# CHANGING LEVELS' NAMES - USING BASE R

levels(gss_cat$partyid)[2] <- "Not sure"
levels(gss_cat$partyid)

levels(gss_cat$partyid)[1:2] <- c("Did not answer", "Not sure")
levels(gss_cat$partyid)


# CHANGING LEVELS' NAMES - USING FORCATS
partyid2 <- fct_recode(gss_cat$partyid,
                      "Republican, strong"    = "Strong republican", 
                      "Republican, weak"      = "Not str republican",
                      "Independent, near rep" = "Ind,near rep", 
                      "Independent, near dem" = "Ind,near dem",
                      "Democrat, weak"        = "Not str democrat", 
                      "Democrat, strong"      = "Strong democrat"
)
levels(partyid2)
levels(gss_cat$partyid)

# LUMP LEVELS TOGETHER
partyid2 = fct_collapse(gss_cat$partyid,
                        other = c("Did not answer", "Not sure", "Other party"),
                        rep = c("Strong republican", "Not str republican"),
                        ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                        dem = c("Not str democrat", "Strong democrat"))
levels(partyid2)


summary(gss_cat$relig)
relig2 = fct_lump(gss_cat$relig, n = 6)
summary(relig2)

# -------------------------
# Visualizing factors

# load data
# devtools::install_github("haleyjeppson/classdata")
library(classdata)
data("titanic")
str(titanic)

# EX: SURVIVAL ON THE TITANIC
ggplot(titanic, aes(Class)) + geom_bar()

ggplot(titanic, aes(Class, fill = Survived)) + 
  geom_bar()

ggplot(titanic, aes(Class, fill = Survived)) + 
  geom_bar(position = "fill")

# 2+ FACTOR VARIABLES
ggplot(gss_cat, aes(x = race, fill = marital)) + geom_bar(position = "fill")


# 2+ FACTOR VARIABLES
library(ggmosaic)
ggplot(data = titanic)  + 
  geom_mosaic(aes(x = product(Sex), fill=Survived, weight=1)) +
  facet_grid(Age~Class)
  