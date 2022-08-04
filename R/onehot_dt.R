#' One-hot encoding of a single factor column in a data.table
#' 
#' @export
one_hot <- function(DT, col) {
  col <-substitute(unlist(col, recursive = FALSE))
  id_dat <- data.table(ID = 1:nrow(DT), col = DT[, eval(col)])
  y <- dcast(id_dat[, .(ID, col)], ID ~ col, length)
  y[, ID := NULL][]
}
