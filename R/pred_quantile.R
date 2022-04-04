#' Function to get prediction quantiles and bind x and predicted y together.
#' 
#' It calculates median and 99%, 95%, 90%, and 66% quantile-based HPD.
#' 
#' @export
pred_quantile <- function(x_pred, y_pred, x_names = NULL, probs = c(0.5, 0.005, 0.995, 0.025, 0.975, 0.05, 0.95, 0.17, 0.83)) {
  # x_pred vector or data.frame of x values
  # y_pred matrix of y values where each column is an x value and each row an iteration
  
  if(missing(x_names)) {
    if (is.null(names(x_pred))) x_names <- 'x' else x_names <- names(x_pred)
  }
  
  y_pred_quant <- t(apply(y_pred, 2, quantile, probs = probs))
  out <- data.frame(x_pred, y_pred_quant)
  setNames(out, c(x_names, paste0('q', probs)))
}
