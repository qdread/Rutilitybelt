#' Function to get quantiles from a Bayesian emm or contrast object
#' 
#' It calculates median and 99%, 95%, 90%, and 66% quantile-based HPD.
#' For contrasts, it separates group1 and group2 into separate columns.
#' For emmGrids not contrasts, it provides a separate column for each factor. 
#' 
#' @export
emm_quantile <- function(x, probs = c(0.5, 0.005, 0.995, 0.025, 0.975, 0.05, 0.95, 0.17, 0.83)) {
  if (x@roles$predictors[1] == 'contrast') {
    if (x@misc$.pairby == '') {
      cc <- combn(1:(nrow(x@misc$orig.grid)), 2)
    } else {
      cc <- do.call(cbind, by(x@misc$orig.grid, x@misc$orig.grid[, -1], function(dat) combn(1:nrow(dat), 2)))
    }
    levs <- as.data.frame(t(apply(cc, 2, function(ii) apply(x@misc$orig.grid[ii, , drop = FALSE], 1, paste, collapse = ' '))))
    names(levs) <- c('group1', 'group2')
  } else {
    levs <- expand.grid(x@levels)
  }
  mat <- x@post.beta %*% t(x@linfct)
  qs <- as.data.frame(t(apply(mat, 2, quantile, probs = probs)))
  names(qs) <- paste0('q', probs)
  cbind(levs, qs)
}

