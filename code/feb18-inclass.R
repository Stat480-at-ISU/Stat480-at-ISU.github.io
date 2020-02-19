# class 2/18/20

# notes on homework:

# Q4: NA vs. "NA"
levels(fly$Education)[6] <- NA
levels(fly$Education)

is.na(fly$Education)
sum(is.na(fly$Education))
summary(is.na(fly$Education))

# Q6: `names()`

names(fly)[19] <- ""




# slides: dplyr ---------------------

fbi %>% 
  arrange(desc(State), Year) %>% 
  tail()

fbi %>% 
  mutate(Rate = Count/Population*70000) %>% 
  summarise(mean_rate = mean(Rate, na.rm=TRUE), 
            sd_rate = sd(Rate, na.rm = TRUE))

mean(fbi$Count/fbi$Population*70000, na.rm = TRUE)

# YOUR TURN -----------------
library(dplyr)
data(french_fries, package="reshape2")
glimpse(french_fries)

# Do ratings of potato-y show a difference between the 
# different oils over time?
# Draw a plot of the average potato-y rating by time, color by treatment.
french_fries %>% 
  group_by(treatment, time) %>% 
  summarise(m_pot = mean(potato, na.rm = TRUE)) %>% 
  ggplot() + 
  geom_line(aes(x = time, y = m_pot, 
                color = treatment, group = treatment))

# How does this plot look like for the rancid rating?
french_fries %>% 
  group_by(treatment, time) %>% 
  summarise(m_rancid = mean(rancid, na.rm = TRUE)) %>% 
  ggplot() + 
  geom_line(aes(x = time, y = m_rancid, 
                color = treatment, group = treatment))


# YOUR TURN -----------------

# How much consistency do we see between ratings? 
# For buttery and rancid ratings find the mean and the absolute difference 
# between the two replicates (for each subject, each treatment and each time point). Use dplyr functions to find this summary dataset.


# Are ratings more different between the two scales? 
# What would you need to draw a side-by-side boxplot of the two ratings? 
# Describe in words.


# Are some subjects in the study more consistent than others? 
# Show the variability in the potato-y ratings by subjects. 
# Order subjects from least variability to most.


  