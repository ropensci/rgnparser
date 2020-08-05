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
#' z <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
#'   "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
#' x <- gn_debug(z[1])
#' x
#' unclass(x)
gn_debug <- function(x, threads = 4) {
  gnparser_exists()

  assert(x, "character")
  assert(threads, c("integer", "numeric"))

  args <- character(0)
  args <- c(args, "-f", "debug")
  if (!is.null(threads)) args <- c(args, "-j", threads)

  z <- sys::exec_internal("gnparser", c(args, x), error = FALSE)
  err_chk(z)
  parsed <- rawToChar(z$stdout)
  return(structure(parsed, class="gnparse_debug"))
}

#' @export
print.gnparse_debug <- function(x, ...) {
  cat("<rgnparser debug>", sep = "\n")
  cat(x)
}
