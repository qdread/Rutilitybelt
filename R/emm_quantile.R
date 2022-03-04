#' Function to get quantiles from an emm or contrast object
#' @export
emm_quantile <- function(x, probs = c(0.5, 0.025, 0.975, 0.05, 0.95, 0.17, 0.83)) {
  levs <- expand.grid(x@levels)
  mat <- x@post.beta %*% t(x@linfct)
  qs <- as.data.frame(t(apply(mat, 2, quantile, probs = probs)))
  names(qs) <- paste0('q', probs)
  cbind(levs, qs)
}

