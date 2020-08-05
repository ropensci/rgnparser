#' gn_version
#' 
#' get gnparser version information
#' 
#' @export
#' @return named list, with `version` and `build`
#' @examples
#' gn_version()
gn_version <- function() {
  gnparser_exists()
  z <- sys::exec_internal("gnparser", "-v", error = FALSE)
  err_chk(z)
  txt <- rawToChar(z$stdout)
  txt <- strsplit(txt, "\n")[[1]]
  unlist(lapply(txt[nzchar(txt)], function(w) {
    tmp <- gsub("\\s", "", strsplit(w, ":\\s")[[1]])
    stats::setNames(list(tmp[2]), tmp[1])
  }), FALSE)
}
