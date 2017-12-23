library(topicmodels)

for( i in c(33,25,28,34) ) {


  f = paste( '../topics_2017oct/topic-', i, '.rdata', sep = '' )

  load( f )

  words <- t( terms( model, 10) )

  write.csv( words, file = paste('terms-', i, '.csv', sep = '')  )

}

