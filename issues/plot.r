library(xlsx)
library(topicmodels)

for( k in c(25,28, 33, 34)) {

  effective <- read.csv('effective_parties.csv')

  load( paste('../models/posterior-', k, '.rdata', sep = '') )

  meta <- read.xlsx('../data.xlsx', 2)
  meta$year <- as.integer( as.character( meta$vuosi ) )

  ## merge with data here
  data <- merge( data, meta, by.x = 'source', by.y = 'dokumentti' )
  print( summary( data$value ) )

  t <- table( cut( data$value, seq(0, 1, 0.1) ) )

  print( t )

}
