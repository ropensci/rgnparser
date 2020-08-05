#' gn_parse_tidy
#' 
#' extract names using gnparser
#' 
#' @export
#' @param x (character) vector of scientific names
#' @param threads (integer/numeric) xxx. default: 4
#' @return list of two data.frames:
#' 
#' - meta: metadata
#' - names: names and their parts, varies based on function parameters
#' 
#' @examples
#' x <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
#'   "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
#' gn_parse_tidy(x[1])
#' gn_parse_tidy(x[2])
#' gn_parse_tidy(x[3])
gn_parse_tidy <- function(x, threads = 4) {
  gnparser_exists()

  assert(x, "character")
  assert(threads, c("integer", "numeric"))

  args <- character(0)
  if (!is.null(threads)) args <- c(args, "-j", threads)

  z <- sys::exec_internal("gnparser", c(args, x), error = FALSE)
  err_chk(z)
  readr::read_csv(rawToChar(z$stdout))
}
