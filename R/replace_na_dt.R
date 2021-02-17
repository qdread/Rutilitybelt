#' Replace NA in a data table
#' 
#' Modified from a function written by Matt Dowle 
#' See answer at https://stackoverflow.com/questions/7235657/fastest-way-to-replace-nas-in-a-large-data-table
#' 
#' @export
replace_na_dt = function(DT, cols = names(DT), replace_with = 0) {
  for (i in cols)
    DT[is.na(get(i)), (i) := replace_with]
}
