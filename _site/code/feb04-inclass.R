filter(fbi, Year == 2014)

fbi %>% filter(Year == 2014)

# YOUR TURN
str(fbi)
iowa <- filter(fbi, State == "Iowa")
iowa_murders <- filter(iowa, Type == "Murder.and.nonnegligent.Manslaughter")
head(iowa_murders)

iowa_murders <- filter(fbi, State == "Iowa", Type == "Murder.and.nonnegligent.Manslaughter")

ggplot(iowa_murders, aes(x = Year, y = Count)) + geom_line()


crimes09 <- filter(fbi, Year == 2009)
crimes09_assaults <- filter(crimes09, Type == "Aggravated.assault")

ggplot(crimes09_assaults, aes(x = State, y = Count)) + 
  geom_point() + 
  coord_flip()

max(fbi$Year)
summary(fbi$Type)

fbi_subset <- filter(fbi, Type == "Murder.and.nonnegligent.Manslaughter", Year >= 2012)
fbi_subset$rate <- fbi_subset$Count/fbi_subset$Population

fivenum(fbi_subset$rate)
?quantile

quantile(fbi_subset$rate, 0.9)

top90 <- filter(fbi_subset, rate > quantile(fbi_subset$rate, 0.9))

ggplot(top90, aes(x = State, y = rate)) + 
  geom_point() + 
  coord_flip()

# ----------------------
# Useful commands
nrow(fbi)
dim(fbi)

fivenum(fbi$Count)
quantile(fbi$Count, c(.25, .5, .75), na.rm = TRUE)

which.max(fbi$Count)
fbi$Count[16121]

which(fbi$Count == 986120)

# ----------------------
# your turn
fbi <- read.csv("https://raw.githubusercontent.com/Stat480-at-ISU/materials-2020/master/02_r-intro/data/fbi.csv")
fbiwide <- read.csv("https://raw.githubusercontent.com/Stat480-at-ISU/materials-2020/master/02_r-intro/data/fbiwide.csv")
unique(fbi$Type)
cali_burgs <- filter(fbi, State == "California", Type == "Burglary")
which.max(cali_burgs$Count)  
cali_burgs$Year[20]  

max(cali_burgs$Count)
cali_burgs[cali_burgs$Count == 545138, "Year"]
cali_burgs[cali_burgs$Count == 545138, ]

violentcrimes <- filter(fbi, Violent.crime)
violentcrimes$rate <- violentcrimes$Count/violentcrimes$Population

violentcrimes14 <- filter(violentcrimes, Year == 2014)
which.max(violentcrimes14$rate)
violentcrimes14[217, ]

violentcrimes61 <- filter(violentcrimes, Year == 1961)
which.max(violentcrimes61$rate)
violentcrimes61[209, ]

str(fbiwide)
fbiwide_subset <- filter(fbiwide, Motor.vehicle.theft < Robbery, Year == 2011)
fbiwide_subset


fbiwide_subset <- filter(fbiwide, Motor.vehicle.theft < Robbery)
unique(fbiwide_subset$State)


# ---------------------------

a <- 1:4
a

a[4] <- 8
a
a[a>3] <- 9
a

# -------------------
life5060 <- read.csv("https://stat480-at-isu.github.io/materials-2020/01_collaborative-environment/data/gapminder-5060.csv")
str(life5060)

canada1957 <- filter(life5060, country == "Canada", year == 1957)
canada1957

life5060[life5060$country == "Canada" & life5060$year == 1957, ]

life5060[life5060$country == "Canada" & life5060$year == 1957, "lifeExp"]

life5060[life5060$country == "Canada" & life5060$year == 1957, "lifeExp"] <- 69.96

filter(life5060, country == "Canada", year == 1957)

# other option
life5060$lifeExp[life5060$year==1957 & life5060$country=="Canada"] <- 69.96

