library(xlsx)
library(topicmodels)


run_analysis <- function( k ) {

  effective <- read.csv('effective_parties.csv')



  load( paste('../models/posterior-', k, '.rdata', sep = '') )

  meta <- read.xlsx('../data.xlsx', 2)
  meta$year <- as.integer( as.character( meta$vuosi ) )

  ## merge with data here
  data <- merge( data, meta, by.x = 'source', by.y = 'dokumentti' )

  ## only choose those with over 10% of topics
  selected = data[ data$value >= 0.1, ]

  selected_year = selected[ selected$year >= 1907, ]

  topics <- selected_year[ complete.cases( selected_year$topic ) , ]
  topics <- topics$topic

  topics = length( unique( topics ) )

  df <- data.frame( year = 1907, parties = 3.56569798538, issues = topics )

  for( row in 2:dim( effective )[1] ) {

    previous_year = effective[ row - 1 ,1]
    this_year = effective[ row, 1 ]

    selected_year = selected[ selected$year > previous_year - 4 & selected$year <= this_year, ]

    topics <- selected_year[ complete.cases( selected_year$topic ) , ]
    topics <- topics$topic

    topics = length( unique( topics ) )

    df <- rbind( df, c( year = this_year, parties = effective[ row, 2 ], issues = topics) )

  }

  ## todo: this should be dynamic!

  m <- lm( issues ~ parties  , data = df )
  return( m )

}


library( stargazer )

models.k25 = run_analysis( 25 )
models.k28 = run_analysis( 28 )
models.k33 = run_analysis( 33 )
models.k34 = run_analysis( 34 )

stargazer( models.k25, models.k28, models.k33, models.k34 )
