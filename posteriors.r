library(topicmodels)

for( i in c(34, 25, 28, 33) ) {

  ## load and compute posterior

  load( paste( 'models/topic-', i, '.rdata', sep = '' ) )
  load( 'models/dtm.rdata' )

  data.post <- posterior( model, dtm )
  data.posterior <- as.data.frame( data.post$topics )
  data.posterior$source <- row.names( data.posterior )

  library(reshape)
  data.posterior <- melt( data.posterior, id=c("source") )
  data.posterior$topic <- factor( data.posterior$variable )
  data <- data.posterior
  save( data, file = paste( 'models/posterior-', i, '.rdata', sep = '')  )

}
