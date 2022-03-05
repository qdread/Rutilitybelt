#' Read all CSVs in a directory
#' 
#' The resulting R objects will have the same name as the CSVs, 
#' with the .csv suffix removed. Uses fread()
#' 
#' @export
read_all_csvs <- function(dir_path) {
  csv_files <- dir(dir_path, pattern = '*.csv')
  invisible(sapply(
    csv_files,
    function(filename) assign(gsub('.csv', '', filename), fread(file.path(dir_path, filename)), envir = .GlobalEnv)
  ))
}
