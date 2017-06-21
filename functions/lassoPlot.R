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
  
  lasso_plot <- ggplot(df_ols) + 
    geom_point(aes(x = bx, y = by)) +
    geom_polygon(data = df_poly, aes(x, y), 
                 fill = '#52B6E9', color = 'black', alpha = 1/2, size = 1) +
    geom_point(data = df_lasso, aes(x = bx, y = by), size = 3, color = 'red') +
    theme_bw() +
    coord_map(xlim = c(-9, 9), ylim = c(-9, 9)) +
    geom_hline(yintercept = 0) +
    geom_vline(xintercept = 0) +
    labs(x = '', y = '')
  
  return(lasso_plot)
}

