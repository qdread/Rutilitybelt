#' Get p-values from standardized differences in loo_compare
#' 
#' @export
loo_diff_p <- function(loo_compare) {
  2 * pnorm(-abs(loo_compare[-1, 'elpd_diff'] / loo_compare[-1, 'se_diff']))
}