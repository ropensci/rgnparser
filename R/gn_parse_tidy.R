#' gn_parse_tidy
#'
#' extract names using gnparser into a tidy tibble
#'
#' @export
#' @param x (character) vector of scientific names
#' @param threads (integer/numeric) number of threads to run. CPU's
#' threads number is the default. default: 4
#' @return a data.frame
#' @examples
#' trys <- function(x) try(x, silent=TRUE)
#' if (interactive()) {
#' x <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
#'   "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
#' trys(gn_parse_tidy(x))
#' }
gn_parse_tidy <- function(x, threads = 4) {
  gnparser_exists()

  assert(x, "character")
  assert(threads, c("integer", "numeric"))

  file <- tempfile(fileext = ".txt")
  on.exit(unlink(file))
  cat(x, file = file, sep = "\n")
  readcsv(parse_one(file, threads = threads))
}
