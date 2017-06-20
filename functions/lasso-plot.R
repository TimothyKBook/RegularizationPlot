library(ggplot2)
library(mvtnorm)
library(lattice)
library(MASS)
library(glmnet)

n <- 100
x1 <- runif(n)
x2 <- runif(n)

y <- 3 * x1 + 4 * x2 + rnorm(n, 0, 5)

m <- lm(y ~ x1 + x2)
b_ols_x <- coef(m)[2]
b_ols_y <- coef(m)[3]
df_ols <- data.frame(bx = b_ols_x, by = b_ols_y)

lasso <- glmnet(cbind(x1, x2), y, lambda = c(1, 2, 3)/ 6)
summary(lasso)
lasso$beta
b_lasso_x <- coef(lasso)[2, 2]
b_lasso_y <- coef(lasso)[3, 2]
t_tuning <- sum(coef(lasso)[2:3, 2])
df_poly <- data.frame(x = c(t_tuning, 0, -t_tuning, 0),
                      y = c(0, t_tuning, 0, -t_tuning))
df_lasso <- data.frame(bx = b_lasso_x, by = b_lasso_y)

ggplot(df_ols) + 
  geom_point(aes(x = bx, y = by)) +
  geom_polygon(data = df_poly, aes(x, y), fill = 'blue', color = 'black', alpha = 1/2, size = 1) +
  geom_point(data = df_lasso, aes(x = bx, y = by), size = 3, color = 'green') +
  theme_bw() +
  xlim(-2, 5.5) +
  ylim(-2, 8) +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = 0) +
  labs(x = '', y = '')