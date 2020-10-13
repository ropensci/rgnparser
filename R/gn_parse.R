#' gn_parse
#' 
#' extract names using gnparser
#' 
#' @export
#' @param x (character) vector of scientific names
#' @param format (logical) one of "compact" (default) or "pretty"
#' @param threads (integer/numeric) nubmer of threads to run. CPU's threads number
#' is the default
#' @return a list
#' @examples
#' x <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
#'   "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
#' gn_parse(x[1])
#' gn_parse(x[2])
#' gn_parse(x[3])
#' gn_parse(x)
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
  res <- gn_parse_one(file, format, threads)
  lapply(strsplit(res, "\n")[[1]], jsonlite::fromJSON)
}