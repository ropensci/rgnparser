#' gn_version
#' 
#' get gnparser version information
#' 
#' @export
#' @return prints version information to console, nothing returned
#' @examples
#' gn_version()
gn_version <- function() {
  gnparser_exists()
  z <- sys::exec_internal("gnparser", "-v", error = FALSE)
  err_chk(z)
  cat(rawToChar(z$stdout))
}
