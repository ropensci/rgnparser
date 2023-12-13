#' Install gnparser
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' ### Reason for deprecating
#' The function used to download the appropriate `gnparser` executable for your
#' platform and try to copy it to a system directory so \pkg{rgnparser} can run
#' the `gnparser` command.
#' This function was deprecated to stay in compliance with CRAN policies
#' ("Packages should not write in the user’s home filespace, nor anywhere else
#' on the file system apart from the R session’s temporary directory")
#'
#' ### Solution
#' Please install `gnparser` by hand.
#' For Linux and Mac users, installing with your usual package manager such as
#' homebrew is the easiest, see `gnparser` documentation for more details:
#' \url{https://github.com/gnames/gnparser#installation}
#' @param version The gnparser version number, e.g., `1.0.0`; the default
#' `latest` means the latest version (fetched from GitLab releases).
#' Alternatively, this argument can take a file path of the zip archive or
#' tarball of gnparser that has already been downloaded from GitLab,
#' in which case it will not be downloaded again. The minimum version
#' is `v1.0.0` because gnparser v1 introduced breaking changes - and
#' we don't support older versions of gnparser here.
#' @param force Whether to install gnparser even if it has already been
#' installed. This may be useful when upgrading gnparser.
#' @export

install_gnparser = function(version, force) {
   lifecycle::deprecate_stop(
      when = "0.3.0",
      what = "install_gnparser()",
      details = "Please see help page for deprecation reason and solution.")
}
