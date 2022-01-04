#' Make a heat map from contrasts between estimated marginal means
#' 
#' @export
emm_heatmap <- function(emms, level_plot_order, back_tran_fn = c, fill_scale_fn = scale_fill_viridis_c, fill_scale_trans = 'identity', asterisk_color = 'white') {
  
  contr <- emmeans::contrast(emms, 'tukey', type = 'link')
  contr_rev <- emmeans::contrast(emms, 'tukey', type = 'link', reverse = TRUE)
  
  rearranged_dat <- rbind(as.data.frame(contr), as.data.frame(contr_rev)) %>%
    tidyr::separate(contrast, into = c('num', 'denom'), sep = ' - ') %>%
    mutate(num = factor(num, levels = level_plot_order),
           denom = factor(denom, levels = level_plot_order))
  
  combos_to_plot <- t(combn(as.character(level_plot_order), 2)) %>% 
    as.data.frame() %>% 
    setNames(c('denom', 'num')) %>%
    mutate(num = factor(num, levels = level_plot_order),
           denom = factor(denom, levels = level_plot_order)) %>%
    left_join(rearranged_dat) %>%
    mutate(estimate = back_tran_fn(estimate)) %>%
    mutate(signif = if_else(p.value < 0.05, '*', ''))
  
  ggplot(combos_to_plot, aes(x = denom, y = num, fill = estimate)) +
    geom_tile() +
    geom_text(aes(label = signif), color = asterisk_color, fontface = 'bold', size = 14, hjust = .5, vjust = .7) +
    fill_scale_fn(trans = fill_scale_trans) 
  
}
