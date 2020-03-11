# class 3/5/20

# slides: reshaping data ---------------------
library(tidyr)
library(dplyr)
library(ggplot2)

# YOUR TURN
data("fbiwide", package="classdata")
fbiwide %>% glimpse()

# Use pivot_longer() from the tidyr package to combine the variables for the different 
# types of crimes into one variable. Call the key-value pair "Type" and "Incidences". 
# Compute a crime rate.

fbiwide %>% 
  pivot_longer(cols = Aggravated.assault:Robbery, # cols = 5:12, cols = -c(1:4)
              names_to = "Type",
              values_to = "Incidences"
               )

fbilong <- fbiwide %>% 
  pivot_longer(cols = Aggravated.assault:Robbery, names_to = "Type", values_to = "Incidences") %>% 
  mutate(Rate = Incidences/Population)
  

# Only consider crime rates for Iowa and Minnesota. Use pivot_wider() to create 
# incidence columns for each of these states. Plot crimes in Iowa against crimes in 
# Minnesota, colour by type of crime. Note: you need to exclude some variables.

fbilong %>% 
  filter(State %in% c("Iowa", "Minnesota")) %>% 
  pivot_wider(names_from = State, values_from = Rate) %>% tail()

# pivot_wider() issue
fbilong %>% 
  filter(State %in% c("Iowa", "Minnesota"), Year == 2014, Type == "Burglary")

fbilong %>% 
  filter(State %in% c("Iowa", "Minnesota"), Year == 2014, Type == "Burglary") %>% 
  select(-Abb, -Population, -Incidences) %>% 
  pivot_wider(names_from = State, values_from = Rate)

# Only consider crime rates for Iowa and Minnesota. Use pivot_wider() to create 
# incidence columns for each of these states. Plot crimes in Iowa against crimes in 
# Minnesota, colour by type of crime. Note: you need to exclude some variables.

fbilong %>% 
  filter(State %in% c("Iowa", "Minnesota")) %>% 
  select(-Abb, -Population, -Incidences) %>% 
  pivot_wider(names_from = State, values_from = Rate) %>% 
  ggplot(aes(x = Iowa, y = Minnesota, color = Type)) +
  geom_abline(color = "grey70") +
  geom_point()


# YOUR TURN

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)


stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, 
               names_to = "year", 
               values_to = "return",
               names_ptype = list(year = double()))


# slides: dealing with messy (2) ---------------------

df <- data_frame(x = c(NA, "a45.1432", "a754.442", "b3.3234"))
df

df %>% separate(x, into = c("A", "B"))

df %>% 
  separate(x, into = c("A", "B"), sep = "([.])", convert = TRUE)


  