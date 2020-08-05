#' gn_parse
#' 
#' extract names using gnparser
#' 
#' @export
#' @param x (character) vector of scientific names
#' @param format (logical) xxx. default: "compact"
#' @param threads (integer/numeric) xxx. default: 4
#' @return list of two data.frames:
#' 
#' - meta: metadata
#' - names: names and their parts, varies based on function parameters
#' 
#' @examples
#' x <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
#'   "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
#' gn_parse(x[1])
#' gn_parse(x[2])
#' gn_parse(x[3])
gn_parse <- function(x, format = "compact", threads = 4) {
  gnparser_exists()

  assert(x, "character")
  assert(format, "character")
  assert(threads, c("integer", "numeric"))

  args <- character(0)
  if (!is.null(format)) args <- c(args, "-f", format)
  if (!is.null(threads)) args <- c(args, "-j", threads)

  z <- sys::exec_internal("gnparser", c(args, x), error = FALSE)
  err_chk(z)
  parsed <- jsonlite::fromJSON(rawToChar(z$stdout))
  readr::read_csv(rawToChar(z$stdout))
  parsed$names <- tibble::as_tibble(parsed$names)
  return(parsed)
}
