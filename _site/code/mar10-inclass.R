# class 3/10/20

# slides: dealing with messy (2) ---------------------

# YOUR TURN
library(tidyverse)

url <- "https://github.com/Stat579-at-ISU/materials/blob/master/03_tidyverse/data/Iowa_Liquor_Sales.csv.zip?raw=TRUE"
download.file(url, "iowa.zip", mode="wb")
iowa <- readr::read_csv("iowa.zip")

glimpse(iowa)

# YOUR TURN

?parse_number
head(parse_number(iowa$`Store Location`))
head(iowa$`Store Location`)

# Use separate() to split the date variable into year, month and day.

iowa %>% 
 separate(Date, into = c("Month", "Day", "Year"), remove = FALSE) %>% glimpse()

# Use separate() again to extract geographic latitude and longitude 
iowa %>% 
  separate(Date, into = c("Month", "Day", "Year"), remove = FALSE) %>%
  separate(`Store Location`, into = c("var1", "var2", "var3"), sep = " ") %>% 
  select(-var1) %>% 
  mutate(long = parse_number(var2),
         lat = parse_number(var3)) %>% 
  select(-var2, -var3) %>%
  glimpse()

iowa <- iowa %>% 
  separate(Date, into = c("Month", "Day", "Year"), remove = FALSE) %>%
  separate(`Store Location`, into = c("var1", "var2", "var3"), sep = " ") %>% 
  select(-var1) %>% 
  mutate(long = parse_number(var2),
         lat = parse_number(var3)) %>% 
  select(-var2, -var3) 

# YOUR TURN

# What is the total amount spent on Liquor Sales?
iowa %>% ggplot(aes(x = Year)) + geom_bar()

iowa %>% ggplot(aes(x = Year, weight = `Sale (Dollars)`)) + geom_bar()

iowa %>% ggplot(aes(x = Year, weight = `Volume Sold (Gallons)`)) + geom_bar()

sum(iowa$`Sale (Dollars)`, na.rm = TRUE)

iowa %>% 
  group_by(Year) %>% 
  summarise(total_sales = sum(`Sale (Dollars)`, na.rm = TRUE),
            total_gallons = sum(`Volume Sold (Gallons)`))

# What is the single largest sale (in volume/in dollar amount)?

iowa %>% arrange(desc(`Volume Sold (Gallons)`)) %>% slice(1) %>% str()

iowa %>% arrange(desc(`Sale (Dollars)`)) %>% slice(1) %>% str()

# Plot geographic longitude and latitude. Where are liquor sales in Ames happening?

iowa %>% 
  ggplot(aes(x = long, y = lat)) + geom_point()



