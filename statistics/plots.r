df <- read.csv( 'model_measurements.csv' )

print("Best fit normal logll" )
print( df$k[ which.max( df$logll1 ) ] )

print("Best fit harmonic logll" )
print( df$k[ which.max( df$logll2 ) ] )

print("Best fit normal logll" )
print( df$k[ which.min( df$perplex ) ] )

library(ggplot2)

g <- ggplot( df , aes(k , logll2 ) ) +
geom_line() +
xlab('k') + ylab('measure (higher is better)') +
theme_minimal() +
xlim(2,250) ## TODO: make args

ggsave( file = 'plot_meanloglike.pdf' , g)

g <- ggplot( df , aes(k , perplex ) ) +
geom_line() +
xlab('k') + ylab('measure (lower is better)') +
theme_minimal() +
xlim(2,250) ## TODO: make args

ggsave( file = 'plot_perplex.pdf' , g)

g <- ggplot( df , aes(k , logll2 ) ) +
geom_line() +
xlab('k') + ylab('measure (higher is better)') +
theme_minimal() +
xlim(20,39) ## TODO: make args

ggsave( file = 'plot_meanloglike_detail.pdf' , g)

g <- ggplot( df , aes(k , perplex ) ) +
geom_line() +
xlab('k') + ylab('measure (lower is better)') +
theme_minimal() +
xlim(20,39) ## TODO: make args

ggsave( file = 'plot_perplex_detail.pdf' , g)
