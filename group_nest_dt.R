# Define function to nest DT by group, and unnest.
# these functions were written by TS Barrett in a document available at https://osf.io/f6pxw/download
group_nest_dt <-function(dt, ..., .key = "data"){
  stopifnot(is.data.table(dt))
  
  by <-substitute(list(...))
  
  dt <- dt[, list(list(.SD)), by = eval(by)]
  setnames(dt, old = "V1", new = .key)
  dt
}

unnest_dt <-function(dt, col, id){
  stopifnot(is.data.table(dt))
  
  by <-substitute(id)
  col <-substitute(unlist(col, recursive = FALSE))
  
  dt[, eval(col), by = eval(by)]
}