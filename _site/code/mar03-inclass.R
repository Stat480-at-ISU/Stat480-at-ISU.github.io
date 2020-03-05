# class 3/3/20

# slides: reshaping data ---------------------

# YOUR TURN
data("french_fries", package="reshape2")
library(tidyr)
library(ggplot2)

# Use pivot_longer() from the tidyr package to combine the different  
# scales for assessing french fries into a single variable. 
# Call the key-value pair "scale" and "score".

ff_long <- french_fries %>% 
  pivot_longer(cols = potato:painty, 
               names_to = "scale", 
               values_to = "score") 

# Use pivot_wider() from the tidyr package to get a format in which you 
# can directly compare values from week 1 to week 10. Plot a scatterplot 
# of values in week 1 against week 10. Facet by treatment and scale, 
# color by individuals and use different shapes for the replicates. 
# Is there a pattern visible?

ff_long %>% 
  pivot_wider(names_from = time, values_from = score) %>% 
  head()

ff_long %>% 
  pivot_wider(names_from = time, values_from = score) %>%
  ggplot(aes(x = `1`, y = `10`, color = subject, shape = factor(rep))) +
  geom_point() + 
  facet_grid(treatment~scale)



  