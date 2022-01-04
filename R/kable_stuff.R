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