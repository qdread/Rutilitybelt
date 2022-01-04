#' Read all CSVs in a directory
#' 
#' The resulting R objects will have the same name as the CSVs, 
#' with the .csv suffix removed. Uses fread()
#' 
#' @import purrr
#' @export
read_all_csvs <- function(dir_path) {
  purrr::walk(dir(dir_path, pattern = '*.csv'), ~ assign(gsub('.csv', '', .), fread(file.path(dir_path, .)), envir = .GlobalEnv))
}
