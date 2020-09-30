#' Exporting Plots for use in LaTeX
#'
#'
#' @param plot_object Plot to save. Defaults to last_plot()
#' @param filenames name of the .tex and .pdf files
#' @param pdfwidth Width of the .pdf file in inches
#' @param pdfheight Height of the .pdf file in inches
#' @param latexwidth Proportion of the linewidth to use in LaTeX. Defaults to 1
#' @param latexlabel LaTeX label for referencing the plot in the LaTeX document
#' @param latexcaption Figure Caption in LaTeX
#' @keywords strings string utility
#' @export






save_plot_template <- function(plot_object = ggplot2::last_plot(), filenames, pdfwidth, pdfheight, latexwidth=1, latexlabel, latexcaption) {

  grDevices::cairo_pdf(filename = here::here("output", "figures", paste0(filenames, ".pdf")), width = pdfwidth, height = pdfheight)

  print(plot_object)

  grDevices::dev.off()

  tmptbbl <-c("\\begin{figure}[!t]",
              "\\centering",
              paste0("\\includegraphics[width=", latexwidth, "\\linewidth]{../output/figures/", filenames, ".pdf}"),
              paste0("\\caption{", latexcaption, "\\label{", latexlabel, "}}"),
              "\\end{figure}"
  )

  readr::write_lines(tmptbbl, here::here("output", "figures", paste0(filenames, ".tex")))

}
