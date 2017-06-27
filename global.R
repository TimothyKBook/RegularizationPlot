library(ggplot2)
library(glmnet)
library(ggforce)

set.seed(123)
n_reg <- 100
x1_reg <- runif(n_reg)
x2_reg <- runif(n_reg)

y <- 2 * x1_reg + 7 * x2_reg + rnorm(n_reg, 0, 5)

ols <- lm(y ~ x1_reg + x2_reg)
b_ols_x <- coef(ols)[2]
b_ols_y <- coef(ols)[3]
df_ols <- data.frame(bx = b_ols_x, by = b_ols_y)

lambda_seq <- seq(0.05, 2, 0.05)
lasso <- glmnet(cbind(x1_reg, x2_reg), y, lambda = lambda_seq)
ridge_seq <- seq(0.05, 50, 0.05)
ridge <- glmnet(cbind(x1_reg, x2_reg), y, lambda = ridge_seq, alpha = 0)

set.seed(123)
n_gam <- 20
x_gam <- runif(n)
y_gam <- 1 + 0.5 * x_gam * (1 - x) + rnorm(n, 0, 0.03)


source('functions/lassoPlot.R')
source('functions/ridgePlot.R')
source('functions/smoothPlot.R')
