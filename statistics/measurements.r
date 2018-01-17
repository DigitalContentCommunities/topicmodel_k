library('topicmodels')

load('../models/dtm.rdata')

data <- data.frame(k= numeric(0), p= numeric(0), logl= numeric(0), harmlogl=numeric(0) )

for( k in 2:250 ){

  load( paste('../models/topic-', k, '.rdata', sep = '') )

  per <- perplexity(model, dtm )

  logL <- logLik( model )

  library(Rmpfr)

  burnin = 1000
  iter = 1000
  keep = 50

  ll <- model@logLiks[ -c(1:(burnin/keep)) ]

  precision = 2000L
  llMed <- median( ll )
  ll = as.double( llMed - log( mean( exp( -mpfr(ll , prec = precision) + llMed ) ) ) )

  data <- rbind( data, c( k, per, logL, ll ) )

}

write.csv( data, 'model_measurements.csv' )



## => dump in csv
