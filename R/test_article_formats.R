#' Test R Markdown output formats
#'
#' Most article formats are based on \code{rmarkdown::pdf_document()}, with a
#' custom Pandoc LaTeX template and different default values for other arguments
#' (e.g., \code{keep_tex = TRUE}).
#'
#' @section Details: You can find more details about each output format below.
#' @name testicles_formats
#' @rdname test_article_formats
NULL

#' @section \code{test_oup_article}: Format for creating submissions to many Oxford University Press
#'   journals. Adapted from
#'   \url{https://academic.oup.com/journals/pages/authors/preparing_your_manuscript}
#'   and \url{https://academic.oup.com/icesjms/pages/General_Instructions}.
#' @export
#' @rdname test_article_formats
test_oup_article <- function(
  ..., keep_tex = TRUE,
  md_extensions = c("-autolink_bare_uris")
) {
  pdf_document_format(
    "test_oup",
    keep_tex = keep_tex, md_extensions = md_extensions, ...
  )
}
