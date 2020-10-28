#' gn_parse
#'
#' extract names using gnparser
#'
#' @export
#' @param x (character) vector of scientific names
#' @param format (logical) one of "compact" (default) or "pretty"
#' @param threads (integer/numeric) number of threads to run. CPU's
#' threads number is the default. default: 4
#' @return a list
#' @examples
#' trys <- function(x) try(x, silent=TRUE)
#' if (interactive()) {
#' x <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
#'   "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
#' trys(gn_parse(x[1]))
#' trys(gn_parse(x[2]))
#' trys(gn_parse(x[3]))
#' trys(gn_parse(x))
#' }
gn_parse <- function(x, format = "compact", threads = NULL) {
  gnparser_exists()

  assert(x, "character")
  assert(format, "character")
  assert(threads, c("integer", "numeric"))
  if (!format %in% c("compact", "pretty"))
    stop("'format' must be one of \"compact\" or \"pretty\"", call. = FALSE)

  file <- tempfile(fileext = ".txt")
  on.exit(unlink(file))
  cat(x, file = file, sep = "\n")
  res <- parse_one(file, format, threads)
  lapply(strsplit(res, "\n")[[1]], jsonlite::fromJSON)
}
