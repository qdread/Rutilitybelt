#' Calculate all pairwise differences between levels of a variable, by group
#' 
#' Updated version that does not have any dependencies. Works well with the output of \code{tidybayes::add_epred_draws}.
#'
#' @param dt Input data frame.
#' @param groupvar Name of column for which you want the pairwise differences between its levels.
#' @param valuevar Name of value column that is going to be differenced.
#' @param byvars Vector of column names within each combination of which you want the pairwise differences between the levels of the group variable.
#' @param op Pairwise operation. Defaults to subtraction. Supply the operator in backticks.
#' @param reverse Whether to reverse the order of the pairwise comparisons. Default is FALSE meaning we subtract meanA-meanB, where meanA is the first of the two levels when sorting the levels of groupvar in increasing order.
#' @param difference_name Name of the difference column in the output. Default is "diff".
#' 
#' @import data.table
#' @export
get_pairwise_differences <- function(dt, valuevar, groupvar, byvars, op = `-`, reverse = FALSE, difference_name = 'diff') {
  grps <- sort(unique(dt[[groupvar]]))
  combs <- combn(1:length(grps), 2)
  if (reverse) combs <- combs[2:1, ]
  
  # Sort data frame by variables
  if (!inherits(dt, 'data.table')) {
    dt <- dt[do.call(order, dt[, c(byvars, groupvar)]), ]
    bygrpcombos <- unique(dt[, byvars])
  } else {
    setorderv(dt, c(byvars, groupvar))
    bygrpcombos <- unique(dt[, ..byvars])
  }
  
  # Create data frame with by-group combinations, the two group names, and the row index of the sorted data frame where their means are
  out <- data.frame(bygrpcombos[rep(1:nrow(bygrpcombos), each = ncol(combs)), ], grp1 = grps[combs[1, ]], grp2 = grps[combs[2, ]], idx1 = combs[1,], idx2 = combs[2,], adj = rep(0:(nrow(bygrpcombos)-1) * length(grps), each = ncol(combs)))

  # Add the mean columns to the data frame and take their difference
  out$mean1 <- dt[[valuevar]][out$idx1 + out$adj]
  out$mean2 <- dt[[valuevar]][out$idx2 + out$adj]
  
  out <- out[, !names(out) %in% c('idx1', 'idx2', 'adj')]
  within(out, assign(difference_name, op(mean1, mean2)))

}

#' Mean class mode predictions
#' 
#' This function will get predictions from the output of \code{tidybayes::add_epred_draws} for a Bayesian cumulative logistic model similar to what we get from \code{emmeans::emmeans(..., mode = 'mean.class')} for a frequentist CLM. Uses tidyverse.
#' 
#' @import dplyr
#' @export
mean_class_pred <- function(fit, pred_grid, groupvars) {
  tidybayes::add_epred_draws(pred_grid, fit, re_formula = ~ 0) %>%
    mutate(.category = as.numeric(levels(.category))[.category]) %>%
    group_by(across(all_of(groupvars))) %>%
    summarize(mean_class = weighted.mean(x = .category, w = .epred))
}
