library(classdata)
library(ggplot2)

ggplot(data = fbiwide, aes(x = Burglary, y = Murder)) +
  geom_point(aes(color = State))

ggplot(data = fbiwide, aes(x = Burglary, y = Murder)) +
  geom_point(aes(color = State)) +
  geom_point()

ggplot(data = fbiwide, aes(x = Burglary, y = Murder)) +
  geom_point() + 
  geom_point(aes(color = State))

ggplot(data = fbiwide, aes(x = Burglary, y = Murder)) +
  geom_point(color = "orange", alpha = .4)  

ggplot(data = fbiwide) +
  geom_point(aes(x = Burglary, y = Murder), 
             color = "orange", alpha = .4)  

# Your turn
ggplot(data = fbiwide, aes(x = Burglary, y = Murder)) +
  geom_point()
ggplot(data = fbiwide, aes(x = log(Burglary), y = log(Murder))) +
  geom_point()
ggplot(data = fbiwide, aes(x = log(Burglary), y = log(Motor.vehicle.theft))) +
  geom_point()

ggplot(aes(x = log(Burglary), y = log(Motor.vehicle.theft),
           colour=State), data=fbiwide) + geom_point()
ggplot(aes(x = log(Burglary), y = log(Motor.vehicle.theft),
           colour=Year), data=fbiwide) + geom_point()
ggplot(aes(x = log(Burglary), y = log(Motor.vehicle.theft),
           size=Population), data=fbiwide) + geom_point()

# -----------
# 03-graphics

# Your turn
ggplot(data = fbiwide, aes(x = Year, y = Larceny.theft)) +
  geom_point() + facet_wrap(~State)

ggplot(data = fbiwide, aes(x = Year, y = Larceny.theft)) +
  geom_point() + facet_wrap(~State) + scale_y_log10()

ggplot(data = fbiwide, aes(x = Year, y = Larceny.theft)) +
  geom_point() + facet_wrap(~State, scales = "free")

ggplot(data = fbiwide, aes(x = Year, y = Larceny.theft)) +
  geom_point() + facet_wrap(~State, scales = "free_y")
  

# your turn
str(fbiwide)

ggplot(data = fbiwide, aes(x = State, y = Robbery)) + 
  geom_boxplot()

ggplot(data = fbiwide, aes(x = Abb, y = Robbery)) + 
  geom_boxplot() + 
  scale_y_log10()

ggplot(data = fbiwide, aes(x = State, y = Robbery)) + 
  geom_boxplot() + 
  scale_y_log10() +
  coord_flip()

#---------
ggplot(fbiwide, aes(x = Motor.vehicle.theft)) + 
  geom_histogram(binwidth=5000) +
  ggtitle("binwidth = 5000")

ggplot(fbiwide, aes(x = Motor.vehicle.theft)) + 
  geom_histogram(binwidth=1000) +
  ggtitle("binwidth = 1000")

ggplot(fbiwide, aes(x = Motor.vehicle.theft)) + 
  geom_histogram() 
