data <- c(34, 25, 28, 25)

library(ggplot2)
library(scales)

ggplot( data.frame( value = data, id = 1:length(data) ), aes(x=id,y=value) ) +
geom_bar( stat="identity", position="dodge" ) +
xlab("Koehenkilö") +
ylab("Valittu aiheiden määrä aiheiden määrä") +
theme_minimal() +
scale_x_discrete(breaks = NULL) +
scale_y_continuous( breaks = 20:39, minor_breaks = NULL, limits=c(20,40),oob = rescale_none)
