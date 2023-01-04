#' Functions to produce kable output from anova() 
#' 
#' @import knitr
#' @export
anova2kable <- function(a, row_labels, table_caption = NULL, sig_figs = 3, alpha = 0.05, p_thresh = 0.0001) {
  a <- a |> as.data.frame() |> signif(sig_figs)
  dimnames(a) <- list(
    row_labels,
    c('sum sq.', 'mean sq.', 'numerator df', 'denominator df', 'F-value', 'p-value')
  )
  
  a$`p-value` <- ifelse(a$`p-value` < p_thresh, paste('<', p_thresh), as.character(a$`p-value`))
  a$`p-value` <- ifelse(a$`p-value` < alpha, paste0('**', a$`p-value`, '**'), a$`p-value`)
  
  a[] <- lapply(a, as.character)
  
  knitr::kable(a, caption = table_caption)
}

# FIXME later we could add cld() here.

#' Function to produce "pretty" scientific notation in HTML or LaTeX style
#' 
#' @param x Numeric vector.
#' @param sig_figs Number of significant figures for the mantissa. Default 3.
#' @param log_thresh Any number with a base-10 exponent (absolute value) 
#' less than this number will not be output in scientific notation. Default 4.
#' @param style 'html' (default) or 'latex'
#' @param minimum if provided, any number less than this value will be set to this
#' value and preceded by ">"
#' 
#' @return Character vector.
#'
#' @export
pretty_sci_not <- function(x, sig_figs = 3, log_thresh = 4, style = 'html', minimum = NA) {
  if (!missing(minimum)) x[x < minimum] <- minimum
  style <- tolower(style)
  stopifnot(style %in% c('html', 'latex'))
  
  xs <- signif(x, sig_figs)
  xsci <- format(xs, scientific = TRUE)
  xsplit <- strsplit(xsci, 'e')
  if (style == 'html') {
    xpretty <- sapply(xsplit, function(n) paste0(as.numeric(n)[1], ' &times; 10<sup>', as.numeric(n)[2], '</sup>'))
  } else {
    xpretty <- sapply(xsplit, function(n) paste0(as.numeric(n)[1], ' \times 10^{', as.numeric(n)[2], '}'))
  }
  xpretty <- ifelse(abs(log10(abs(x))) > log_thresh & x != 0, xpretty, as.character(xs))
  
  if (!missing(minimum)) xpretty[x == minimum] <- paste('<', xpretty[x == minimum])
  
  return(xpretty)
}
