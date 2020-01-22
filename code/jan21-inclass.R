x <- 2/3
4/5 -> y

sqrt(x)
y <- c(1,2,3,5)
y[1]
y[4]
y[1]+y[2]+y[3]+y[4]
sum(y)
2*y
y^2

x <- c(4,1,3,9)
y <- c(1,2,3,5)

y <- (1,2,3,5)

d <- sqrt(sum((x-y)^2))

sum(t(x) * y)

t(x) %*% y

# install.packages("devtools")
# devtools::install_github("haleyjeppson/classdata")
library(classdata)
?fbi
data(fbi)
fbi
data("diamonds")
diamonds

head(fbi)
head(fbi, n = 2)
tail(fbi)
tail(fbi, n = 2)
summary(fbi)
summary(diamonds)
str(fbi)
dim(fbi)

