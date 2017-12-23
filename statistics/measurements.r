library('topicmodels')

load('topics_2017oct/dtm.rdata')

data <- data.frame(k= numeric(0), p= numeric(0), logl= numeric(0), harmlogl=numeric(0) )

for( k in 2:250 ){

  load( paste('topics_2017oct/topic-', k, '.rdata', sep = '') )

  per <- perplexity(model, dtm )
  print( per )

  logL <- logLik( model )
  print( logL )

  library(Rmpfr)

  burnin = 1000
  iter = 1000
  keep = 50

  ll <- model@logLiks[ -c(1:(burnin/keep)) ]

  precision = 2000L
  llMed <- median( ll )
  ll = as.double( llMed - log( mean( exp( -mpfr(ll , prec = precision) + llMed ) ) ) )

  print("Loglike min")
  print( ll )

  data[1, ] <- c( k, per, logL, ll )

}

write.csv( data, 'model_measurements.csv' )



## => dump in csv
