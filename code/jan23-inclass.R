# x$variable
# x[, "variable"]
# x[rows, columns]
# x[1:5, 2:3]
# x[c(1,5,6), c("State","Year")]
# x$variable[rows]

# devtools::install_github("haleyjeppson/classdata")
library(classdata) # comment
# fbi <- read.csv("https://raw.githubusercontent.com/Stat480-at-ISU/materials-2020/master/02-r_intro/data/fbi.csv")

str(fbi)
fbi$Type
head(fbi$Type)
# type <- fbi$Type
1:6
fbi[1:6, "Type"]
fbi$Type[1:6]
fbi[1:6, 5]
fbi[c(1,2,3,4,5,6), 5]

# mean, median, min, max, quartiles
# range, sd, var
# cor, cov

fivenum(fbi$Population)
min(fbi$Population)
max(fbi$Population)
median(fbi$Population)
quantile(fbi$Population, .5)
quantile(fbi$Population, .9)

# your turn
fbi[1:10, ]
head(fbi, 10)
mean(fbi$Count)
?NA
a <- "apple"
b <- NA
is.na(a)
is.na(b)
any(is.na(fbi$Count))
mean(fbi$Count, na.rm = FALSE)
mean(fbi$Count, na.rm = TRUE)
sd(fbi$Count)
sd(fbi$Count, na.rm = TRUE)
