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

#' Function to get predicted quantiles in 3D (for multinomial responses)
#' 
#' y_pred should be an array.
#' 
#' @export
pred_quantile_3D <- function(x_pred, y_pred, y_dim_names = c('quantile', 'var2', 'var3'), response_name = 'p', probs = c(0.5, 0.005, 0.995, 0.025, 0.975, 0.05, 0.95, 0.17, 0.83)) {
  y_pred_quant <- apply(y_pred, 2:3, quantile, probs = probs)
  dimname_list <- list(paste0('q', probs), x_pred, dimnames(y_pred_quant)[[3]])
  names(dimname_list) <- y_dim_names
  dimnames(y_pred_quant) <- dimname_list
  as.data.frame.table(y_pred_quant, responseName = response_name)
}