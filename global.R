library(ggplot2)
library(glmnet)

set.seed(123)
n_reg <- 100
x1_reg <- runif(n_reg)
x2_reg <- runif(n_reg)

y <- 2 * x1_reg + 7 * x2_reg + rnorm(n_reg, 0, 5)

ols <- lm(y ~ x1_reg + x2_reg)
b_ols_x <- coef(ols)[2]
b_ols_y <- coef(ols)[3]
df_ols <- data.frame(bx = b_ols_x, by = b_ols_y)

lambda_seq <- seq(0.1, 2, 0.1)
lasso <- glmnet(cbind(x1_reg, x2_reg), y, lambda = lambda_seq)

source('functions/lassoPlot.R')
# TODO:
# source('functions/ridgePlot.R')
# source('functions/splinePlot.R')

# Used for debugging:
# lp <- plotLasso(lambda = 0.4, 
#           lasso = lasso,
#           df_ols = df_ols,
#           lambda_seq = lambda_seq)