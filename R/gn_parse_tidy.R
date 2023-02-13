#' gn_parse_tidy
#'
#' extract names using gnparser into a tidy tibble
#'
#' @export
#' @inheritParams gn_parse
#' @return a data.frame
#' @details This function focuses on a data.frame result that's easy
#' to munge downstream - note that this function does not do additional
#' details as does [gn_parse()].
#' @examples
#' trys <- function(x) try(x, silent=TRUE)
#' if (interactive()) {
#' x <- c("Quadrella steyermarkii (Standl.) Iltis & Cornejo",
#'   "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
#' trys(gn_parse_tidy(x))
#' }
gn_parse_tidy <- function(x, threads = 4, batch_size = NULL,
  ignore_tags = FALSE) {

  gnparser_exists()
  ver_check(1)
  assert(x, "character")
  file <- tempfile(fileext = ".txt")
  on.exit(unlink(file))
  cat(x, file = file, sep = "\n")
  readcsv(parse_one(file, threads = threads, batch_size = batch_size,
    ignore_tags = ignore_tags))
}
