#' gn_parse_tidy
#' 
#' extract names using gnparser
#' 
#' @export
#' @param x (character) vector of scientific names
#' @param threads (integer/numeric) xxx. default: 4
#' @return a data.frame
#' @examples
#' x <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
#'   "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
#' gn_parse_tidy(x)
gn_parse_tidy <- function(x, threads = 4) {
  gnparser_exists()

  assert(x, "character")
  assert(threads, c("integer", "numeric"))

  file <- tempfile(fileext = ".txt")
  on.exit(unlink(file))
  cat(x, file = file, sep = "\n")
  readcsv(gn_parse_one(file, threads = threads))
}

gn_parse_one <- function(x, format = NULL, threads = NULL) {
  args <- character(0)
  if (!is.null(format)) args <- c(args, "-f", format)
  if (!is.null(threads)) args <- c(args, "-j", threads)
  z <- sys::exec_internal("gnparser", c(args, x), error = FALSE)
  err_chk(z)
  return(rawToChar(z$stdout))
  # readr::read_csv(rawToChar(z$stdout))
}
