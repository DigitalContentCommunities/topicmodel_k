library(topicmodels)

library(xlsx)

library(ggplot2)
library(scales)

source('../iwanthue.r')
source('../mapper.r')

for( i in c(34, 25, 28, 33) ) {

  ## take posterior values
  load( paste( '../models/posterior-', i, '.rdata', sep = '')  )

  meta <- read.xlsx('../data.xlsx', 2)
  meta$year <- as.integer( as.character( meta$vuosi ) )

  ## merge with data here
  data <- merge( data, meta, by.x = 'source', by.y = 'dokumentti' )

  data$year <- cut( data$year, c(0, 1922, 1939, 1965, 1978, 2007, 2020), labels=c("-1922", "1923-1939", "1940-1965", "1966-1978", "1979-2007", "2008-") )
  d <- aggregate( data$value, FUN = sum, by = list( data$variable, data$year  ) )
  d <- as.data.frame( d )
  d$topic <- d$Group.1
  d$year <- d$Group.2
  d$value <- d$x

  d$label <- topics[[i]][ d$topic ]
  d$label_colour <- iwanthue( 46 )[ d$label ]

  g <-
  ggplot() +
    geom_bar( aes( year, fill = label_colour , weight = value ) , data = d, na.rm = T, position = "fill" ) +
    theme_minimal() +
    xlab('Year') + ylab('% of documents') +
    theme(legend.position="none")

  ggsave( g, file = paste('timeline-', i, '.pdf', sep = '' ) )

}
