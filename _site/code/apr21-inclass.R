# class 4/21/20

# slides: plots ---------------------
library(tidyverse)

ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class))

ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
  labs(title = "Fuel efficiency generally decreases with engine size",
       subtitle = "Two seaters (sports cars) are an exception because of their light weight",
       caption = "Data from fueleconomy.gov",
       x = "Engine displacement (L)", y = "Highway fuel economy (mpg)",
       colour = "Car type")


ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
  ggtitle("Fuel efficiency generally decreases with engine size")

ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
  ggtitle("Fuel efficiency generally decreases with engine size") +
  xlab("Engine displacement (L)")


best_in_class <- mpg %>% group_by(class) %>%
  dplyr::filter(row_number(desc(hwy)) == 1)

ggplot(mpg, aes(displ, hwy)) +  geom_point(aes(colour = class)) +
  geom_text(data = best_in_class, aes(label = model))

ggplot(mpg, aes(displ, hwy)) +  geom_point(aes(colour = class)) +
  geom_label(data = best_in_class, aes(label = model))

library(ggrepel)


ggplot(mpg, aes(displ, hwy)) +  geom_point(aes(colour = class)) +
  geom_label_repel(data = best_in_class, aes(label = model))

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_point(data = best_in_class, size = 3, shape = 1) +
  ggrepel::geom_label_repel(data = best_in_class, aes(label = model))

p <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(data = dplyr::filter(mpg, manufacturer == "subaru"), colour = "orange", size = 3) +
  geom_point() 
p

p1 <- ggplot(mpg, aes(x = displ, y = hwy, colour = cyl)) +
  geom_point()
p1

p1 + scale_colour_continuous()
p1 + scale_colour_continuous("name")
p1 + scale_colour_continuous(type = "viridis")


p2 <- ggplot(mpg, aes(x = displ, y = hwy, colour = factor(cyl))) +
  geom_point()
p2
p2 + scale_colour_discrete("cyl")

p2 + scale_colour_manual("cyl", values = c("magenta", "mediumaquamarine", "orange", "orangered"))

ggplot(mpg, aes(x = displ, y = hwy, colour = factor(cyl),  shape = factor(cyl))) +
  geom_point()

library(RColorBrewer)
display.brewer.all()

p2
p2 + scale_colour_brewer()
p2 + scale_colour_brewer(palette = "Set1")
p2 + scale_colour_brewer(palette = "Dark2")

library(ggthemes)
p2 + theme_economist() + scale_colour_economist() 
p2 + theme_bw()


p2 + 
  theme_economist() + 
  scale_colour_economist() +
  theme(panel.background = element_rect(fill = "white"), 
        panel.grid.major.y = element_line("black"),
        legend.position = "bottom",
        legend.title = element_blank()) 

?ggsave
