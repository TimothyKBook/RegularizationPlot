plotRidge <- function(lambda, 
                      ridge = ridge, 
                      df_ols = df_ols, 
                      ridge_seq = ridge_seq) {
  
  slope_ind <- length(ridge_seq) - which(abs(ridge_seq - lambda) < 1e-6) + 1
  b_ridge <- coef(ridge)[2:3, slope_ind]
  t_tuning <- sqrt(norm(b_ridge, '2'))
  
  df_ridge <- data.frame(bx = b_ridge[1], by = b_ridge[2])
  df_poly <- data.frame(x = c(t_tuning, 0, -t_tuning, 0),
                        y = c(0, t_tuning, 0, -t_tuning))
  
  df_ols$lbl <- paste0('OLS = (', round(df_ols$bx, 3), 
                       ', ', round(df_ols$by, 3), ')')
  df_ridge$lbl <- paste0('ridge = (', round(df_ridge$bx, 3),
                         ', ', round(df_ridge$by, 3), ')')
  
  ridge_plot <- ggplot(df_ols) + 
    geom_point(aes(x = bx, y = by), size = 3) +
    geom_text(aes(x = bx + 1, y = by + 1, label = lbl), size = 5, hjust = 0.4, fontface = 'bold') +
    geom_circle(aes(x0 = 0, y0 = 0, r = t_tuning^2), fill = 'navy', alpha = 1/2, color = 'black', size = 1) +
    geom_point(data = df_ridge, aes(x = bx, y = by), size = 3, color = 'darkorange') +
    geom_text(data = df_ridge, aes(x = bx - 0.5, y = by, label = lbl), color = 'darkorange', size = 5, hjust = 1, fontface = 'bold') +
    theme_bw() +
    xlim(-9, 9) + ylim(-9, 9) +
    theme(aspect.ratio = 1) +
    geom_hline(yintercept = 0) +
    geom_vline(xintercept = 0) +
    labs(x = '', y = '')
  
  return(ridge_plot)
}

plotRidgeWrap <- function(lambda) plotRidge(lambda,
                                            ridge = ridge,
                                            df_ols = df_ols,
                                            ridge_seq = ridge_seq)