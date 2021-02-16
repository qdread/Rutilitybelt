#' Nest a data.table by group
#' 
#' This function was originally written by TS Barrett in a document available at https://osf.io/f6pxw/download.
#' QDR edited so that it can also accept a character vector (good for programmatic usage of the function)
#' 
#' @import data.table
#' @export
group_nest_dt <- function(dt, ..., .key = "data", group_vars = NULL) {
  stopifnot(is.data.table(dt))
  
  if (missing(group_vars)) {
    by <-substitute(list(...))
    
    dt <- dt[, list(list(.SD)), by = eval(by)]
  } else {
    dt <- dt[, list(list(.SD)), by = c(group_vars)]
  }
  
  setnames(dt, old = "V1", new = .key)
  dt
}

#' Unnest a nested data.table
#' 
#' This function was written by TS Barrett in a document available at https://osf.io/f6pxw/download.
#' 
#' @export
unnest_dt <- function(dt, col, id, id_vars = NULL) {
  stopifnot(is.data.table(dt))
  
  if (missing(id_vars)) {
    by <-substitute(id)
    col <-substitute(unlist(col, recursive = FALSE))
    
    dt[, eval(col), by = eval(by)]
  } else {
    col <-substitute(unlist(col, recursive = FALSE))
    dt[, eval(col), by = id_vars]
  }
}
