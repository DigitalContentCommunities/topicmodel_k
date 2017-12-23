library(xlsx)

data <- read.xlsx('data.xlsx', 2)

library(ggplot2)
library(scales)

data$year <- as.integer( as.character( data$vuosi ) )

ggplot( data, aes( x=year ) ) +
geom_histogram( breaks= seq(1880, 2020, by=10) ) +
xlab("Vuosi") +
ylab("Määrä") +
theme_minimal() +
scale_x_continuous(breaks = seq(1880,2010,20)) +
scale_y_continuous()

table( data$puolue )

library(xtable)

xtable( table( data$puolue ) )

xtable( table( floor( data$year / 10 ) * 10 ) )
