#' Make a heat map from contrasts between estimated marginal means
#' 
#' @export
emm_heatmap <- function(emms, level_plot_order = NULL, bayes = FALSE, alpha = 0.95, back_tran_fn = c, fill_scale_fn = ggplot2::scale_fill_viridis_c, fill_scale_trans = 'identity', asterisk_color = 'white', axis_labels = 'group', legend_label = 'difference') {
  
  separator = ' - '
  axis_labels = rep_len(axis_labels, 2)

  message(ifelse(bayes, 'Using HPD limit as decision rule (Bayes style).', 'Using p-value as decision rule (Freqy style).'))
  
  
  contr <- emmeans::contrast(emms, 'tukey', type = 'link')
  contr_rev <- emmeans::contrast(emms, 'tukey', type = 'link', reverse = TRUE)
  
  rearranged_dat <- rbind(as.data.frame(contr), as.data.frame(contr_rev)) |>
    tidyr::separate(contrast, into = c('num', 'denom'), sep = separator)
  
  if (missing(level_plot_order)) {
    level_plot_order <- unique(rearranged_dat$num)
    message('Order of levels not given. Using order they appear in the contrasts.')
  }
    
  rearranged_dat$num <- factor(rearranged_dat$num, levels = level_plot_order)
  rearranged_dat$denom <- factor(rearranged_dat$denom, levels = level_plot_order)

  combos_to_plot <- t(combn(as.character(level_plot_order), 2)) |> 
    as.data.frame() |>
    setNames(c('denom', 'num'))
  combos_to_plot$num <- factor(combos_to_plot$num, levels = level_plot_order)
  combos_to_plot$denom <- factor(combos_to_plot$denom, levels = level_plot_order)
  
  combos_to_plot <- merge(combos_to_plot, rearranged_dat, all.x = TRUE)
  combos_to_plot$estimate <- back_tran_fn(combos_to_plot$estimate)
  # FIXME Needs to be generalized for Bayesian
  if (bayes) {
    combos_to_plot <- with(comps, lower.HPD > cutoff | upper.HPD < cutoff)
  } else {
    combos_to_plot$signif <- ifelse(combos_to_plot$p.value < (1 - alpha), '*', '')
  }
  
  ggplot2::ggplot(combos_to_plot, ggplot2::aes(x = denom, y = num, fill = estimate)) +
    ggplot2::geom_tile() +
    ggplot2::geom_text(ggplot2::aes(label = signif), color = asterisk_color, fontface = 'bold', size = 14, hjust = .5, vjust = .7) +
    fill_scale_fn(trans = fill_scale_trans, name = legend_label) +
    ggplot2::labs(x = axis_labels[1], y = axis_labels[2])
  
}
