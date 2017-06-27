plotSmooth <- function(x, y, spar) {
  gam <- smooth.spline(x, y, spar = spar)
  x_gam_seq <- seq(0, 1, 0.01)
  yhat_gam <- predict(gam, x_gam_seq)
  
  df_gam <- data.frame(x = x_gam, y = y_gam)
  df_pred <- data.frame(x = yhat_gam$x, y = yhat_gam$y)
  df_true <- data.frame(x = x_gam_seq, y = 1 + 0.5 * x_gam_seq * (1 - x_gam_seq))
  
  ggplot() +
    theme_bw() +
    geom_line(data = df_true, aes(x, y), size = 3, color = 'grey') +
    geom_point(data = df_gam, aes(x, y), size = 3) +
    geom_line(data = df_pred, aes(x, y), size = 1, color = 'red') +
    ylim(0.9, 1.2) + xlim(0, 1) +
    labs(x = '', y = '') +
    theme(aspect.ratio = 1)
}

plotSmoothWrap <- function(spar) plotSmooth(x = x_gam, y_gam, spar = spar)
