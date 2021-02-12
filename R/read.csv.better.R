#' read.csv wrapper that detects all space characters
#' 
#' A wrapper function for read.csv that uses perl to convert any possible spaces to a single type 
#' and then reads the CSV with any other arguments to read.csv that you want to input.
#' 
#' @examples
#' \dontrun{
# Bad:
# read.csv("spcs.csv", header = FALSE)
#   V1
# 1 Xáš€â€‚â€ƒâ€„â€…â€†â€‡â€ˆâ€‰â€Šâ€¯â\u0081Ÿã€€X

# Better:
# read.csv.better("spcs.csv", header = FALSE)
#   V1
# 1 X             X
#' }
#' 
#' @export
read.csv.better <- function(file_path, ...) {
  read.csv_args <- list(...)
  txt <- system2("perl", args = paste("-CSDA -plE \"s/\\s/ /g\"", file_path), stdout = TRUE)
  conn <- textConnection(txt) 
  do.call(read.csv, args = c(list(file = conn), read.csv_args))
}
