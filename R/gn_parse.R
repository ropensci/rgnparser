#' gn_parse
#'
#' extract names using gnparser
#'
#' @export
#' @param x (character) vector of scientific names. required
#' @param threads (integer/numeric) number of threads to run for parallel
#'   processing. Setting to `NULL` will use all threads available. default: `1`
#' @param batch_size (integer/numeric) maximum number of names in a
#' batch send for processing. default: `NULL`
#' @param cultivar (logical) adds support for botanical cultivars like
#'   `Sarracenia flava 'Maxima'` and graft-chimaeras like `+ Crataegomespilus`.
#'   default: `FALSE`
#' @param capitalize (logical) capitalizes the first letter of name-strings.
#'   default: `FALSE`
#' @param diaereses (logical) preserves diaereses within names, e.g.
#'   `Leptochloöpsis virgata`. The stemmed canonical name will be generated
#'   without diaereses. default: `FALSE`
#' @param ignore_tags (logical) ignore HTML entities and tags when
#' parsing. default: `FALSE`
#' @param details (logical) Return more details for a parsed name
#' @return a list
#' @examples
#' trys <- function(x) try(x, silent=TRUE)
#' if (interactive()) {
#' x <- c("Quadrella steyermarkii (Standl.) Iltis & Cornejo",
#'   "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
#' trys(gn_parse(x[1]))
#' trys(gn_parse(x[2]))
#' trys(gn_parse(x[3]))
#' trys(gn_parse(x))
#' # details
#' w <- trys(gn_parse(x, details = TRUE))
#' w[[1]]$details # details for one name
#' lapply(w, "[[", "details") # details for all names
#' z <- trys(gn_parse(x, details = FALSE)) # compared to regular
#' z
#' }
gn_parse <- function(
  x,
  threads = 1,
  batch_size = NULL,
  ignore_tags = FALSE,
  cultivar = FALSE,
  capitalize = FALSE,
  diaereses = FALSE,
  details = FALSE) {

  gnparser_exists()
  ver_check(1)
  assert(x, "character")
  file <- tempfile(fileext = ".txt")
  on.exit(unlink(file))
  cat(x, file = file, sep = "\n")
  res <- parse_one(file, "compact", threads, batch_size,
    ignore_tags, cultivar, capitalize, diaereses, details)
  lapply(strsplit(res, "\n")[[1]], jsonlite::fromJSON)
}
