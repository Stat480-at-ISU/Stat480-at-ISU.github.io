# class 3/5/20

# slides: dealing with messy (2) ---------------------

# YOUR TURN
library(tidyverse)

url <- "https://github.com/Stat579-at-ISU/materials/blob/master/03_tidyverse/data/Iowa_Liquor_Sales.csv.zip?raw=TRUE"
download.file(url, "iowa.zip", mode="wb")
iowa <- readr::read_csv("iowa.zip")

glimpse(iowa)

# YOUR TURN





