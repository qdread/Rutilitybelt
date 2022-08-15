#' Write list of ggplots to a PDF with multiple pages
#' @export
multiple_page_pdf <- function(plot_list, filename, height = 11, width = 8.5, rows_per_page, cols_per_page) {
  plots_per_page = rows_per_page * cols_per_page
  n_plots <- length(plot_list)
  n_pages <- ceiling(n_plots/plots_per_page)
  which_page <- rep(1:n_pages, each = plots_per_page)
  plot_list <- c(plot_list, replicate(n_pages*plots_per_page-n_plots, ggplot2::ggplot() + ggplot2::theme(panel.border = ggplot2::element_blank()), simplify = FALSE))
  ggsave(
    filename = filename, 
    plot = gridExtra::marrangeGrob(plot_list, nrow=rows_per_page, ncol=cols_per_page), 
    height = height, width = width
  )
}