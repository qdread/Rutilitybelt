#' Custom function to plot three check model plots on one line with common title
#' @export
check_model_onerow <- function(fit, common_title) {
  check_plots <- plot(performance::check_model(fit, check = c('qq', 'normality', 'homogeneity'), panel = FALSE))
  plot_row <- cowplot::plot_grid(plotlist = cplot_plots, nrow = 1) 
  
  title <- cowplot::ggdraw() + 
    cowplot::draw_label(
      common_title,
      fontface = 'bold',
      x = 0,
      hjust = 0
    ) +
    ggplot2::theme(
      # add margin on the left of the drawing canvas,
      # so title is aligned with left edge of first plot
      plot.margin = margin(0, 0, 0, 7)
    )
  cowplot::plot_grid(
    title, plot_row,
    ncol = 1,
    # rel_heights values control vertical title margins
    rel_heights = c(0.1, 1)
  )
}