library(ggplot2)
library(mvtnorm)
library(lattice)
library(MASS)
library(glmnet)

set.seed(123)
n <- 100
x1 <- runif(n)
x2 <- runif(n)

y <- 2 * x1 + 7 * x2 + rnorm(n, 0, 5)

ols <- lm(y ~ x1 + x2)
b_ols_x <- coef(ols)[2]
b_ols_y <- coef(ols)[3]
df_ols <- data.frame(bx = b_ols_x, by = b_ols_y)

lambda_seq <- seq(0.1, 3, 0.1)
lasso <- glmnet(cbind(x1, x2), y, lambda = lambda_seq)

plotLasso <- function(lambda, 
                      lasso = lasso, 
                      df_ols = df_ols, 
                      lambda_seq = lambda_seq) {
  
  slope_ind <- which(abs(lambda_seq - lambda) < 1e-6)
  b_lasso <- coef(lasso)[2:3, slope_ind]
  t_tuning <- sum(abs(b_lasso))
  
  df_lasso <- data.frame(bx = b_lasso[1], by = b_lasso[2])
  df_poly <- data.frame(x = c(t_tuning, 0, -t_tuning, 0),
                        y = c(0, t_tuning, 0, -t_tuning))
  
  lasso_plot <- ggplot(df_ols) + 
    geom_point(aes(x = bx, y = by)) +
    geom_polygon(data = df_poly, aes(x, y), 
                 fill = '#52B6E8', color = 'black', alpha = 1/2, size = 1) +
    geom_point(data = df_lasso, aes(x = bx, y = by), size = 3, color = 'red') +
    theme_bw() +
    xlim(-8, 8) +
    ylim(-8, 8) +
    geom_hline(yintercept = 0) +
    geom_vline(xintercept = 0) +
    labs(x = '', y = '')
  
  return(lasso_plot)
}

plotLasso(1.0)
debug(plotLasso)
