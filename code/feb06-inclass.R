## class 06/02/2020

## your turn

data(gss_cat, package = "forcats")

str(gss_cat)

summary(gss_cat$year)

gss_cat$year <- factor(gss_cat$year)

str(gss_cat)

summary(gss_cat$year)

## casting between types

as.character(c(1, 9, 4.3, FALSE))

as.numeric(c(TRUE, FALSE, FALSE))

fruit_char <- c("apple", "banana", "orange", "apple")
fruit_factor <- factor(fruit_char)
as.numeric(fruit_factor)

test <- factor(c(4,6,1,4,7))
test

as.numeric(test)
as.numeric(as.character(test))
  
## reordering levels

levels(gss_cat$relig)

levels(factor(gss_cat$relig, 
              levels=c("Moslem/islam", "Hinduism", "Buddhism", 
                       "Other eastern", "Jewish", "Christian", 
                       "Orthodox-christian", "Catholic", "Protestant", 
                       "Inter-nondenominational", "Native american", "Other", 
                       "None", "No answer", "Don't know",  "Not applicable")))


levels(factor(gss_cat$relig, 
              levels=c("Moslem/islam", "Hinduism", "Buddhism", 
                       "Other eastern", "Jewish", "Christian", 
                       "Orthodox-christian", "Catholic", "Protestant", 
                       "Inter-nondenominational", "Native american", "Other", 
                       "None", "No answer", "Don't know",  "Not applicables")))
library(forcats)
levels(fct_infreq(gss_cat$relig))

levels(reorder(gss_cat$relig, gss_cat$tvhours))   #, na.rm=TRUE))

levels(reorder(gss_cat$relig, gss_cat$tvhours, na.rm=TRUE))

ggplot(gss_cat, aes(x = relig)) + 
  geom_bar() + 
  coord_flip()

ggplot(gss_cat, aes(x = reorder(gss_cat$relig, gss_cat$tvhours, na.rm = TRUE))) + 
  geom_bar() + 
  coord_flip()

# create summary data - do not worry about understanding this code until next week
relig_summary <- gss_cat %>% group_by(relig) %>% summarise(age = mean(age, na.rm = TRUE), tvhours = mean(tvhours, na.rm = TRUE), n = n())

ggplot(relig_summary, aes(x = tvhours, y = relig)) + 
  geom_point()

ggplot(relig_summary, aes(x = tvhours, y = fct_reorder(relig, tvhours))) + 
  geom_point()
  