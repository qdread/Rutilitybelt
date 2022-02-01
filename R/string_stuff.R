#' Pull substrings if present in character vector
#' 
#' @export
pull_substring <- function(x, substrings) {
  idx <- lapply(substrings, function(y) ifelse(grepl(y, x), y, as.character(NA)))
  fcoalesce(idx)
}
