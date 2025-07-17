#' sessionInfo wrapper that only prints R and package versions
#' 
#' @export
prettyInfo <- function(sinf) {
  message(
    "R version and packages used in this document:\n",
    sinf$R.version$version.string, "\n",
    paste(rev(unname(unlist(lapply(sinf$otherPkgs, function(p) paste(p$Package, p$Version))))), collapse = ', ')
  )
}
