plotLasso <- function(lambda, 
                      lasso = lasso, 
                      df_ols = df_ols, 
                      lambda_seq = lambda_seq) {
  
  slope_ind <- length(lambda_seq) - which(abs(lambda_seq - lambda) < 1e-6) + 1
  b_lasso <- coef(lasso)[2:3, slope_ind]
  t_tuning <- sum(abs(b_lasso))
  
  df_lasso <- data.frame(bx = b_lasso[1], by = b_lasso[2])
  df_poly <- data.frame(x = c(t_tuning, 0, -t_tuning, 0),
                        y = c(0, t_tuning, 0, -t_tuning))
  
  df_ols$lbl <- paste0('OLS = (', round(df_ols$bx, 3), 
                       ', ', round(df_ols$by, 3), ')')
  df_lasso$lbl <- paste0('LASSO = (', round(df_lasso$bx, 3),
                         ', ', round(df_lasso$by, 3), ')')
  
  lasso_plot <- ggplot(df_ols) + 
    geom_point(aes(x = bx, y = by), size = 3) +
    geom_text(aes(x = bx + 1, y = by + 1, label = lbl), size = 5, hjust = 0.4, fontface = 'bold') +
    geom_polygon(data = df_poly, aes(x, y), 
                 fill = 'navy', color = 'black', alpha = 1/2, size = 1) +
    geom_point(data = df_lasso, aes(x = bx, y = by), size = 3, color = 'darkorange') +
    geom_text(data = df_lasso, aes(x = bx - 0.5, y = by, label = lbl), color = 'darkorange', size = 5, hjust = 1, fontface = 'bold') +
    theme_bw() +
    xlim(-9, 9) + ylim(-9, 9) +
    theme(aspect.ratio = 1) +
    geom_hline(yintercept = 0) +
    geom_vline(xintercept = 0) +
    labs(x = '', y = '')
  
  return(lasso_plot)
}

plotLassoWrap <- function(lambda) plotLasso(lambda,
                                            lasso = lasso,
                                            df_ols = df_ols,
                                            lambda_seq = lambda_seq)