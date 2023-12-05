
assert <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
        paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

last <- function(x) x[length(x)]

err_chk <- function(z) {
  if (z$status != 0) {
    err <- rawToChar(z$stderr)
    err <- gsub("Error: ", "", err)
    # language replacement
    err <- gsub("-l detect", "language=\"detect\"", err)
    stop(err, call. = FALSE)
  }
}

readcsv <- function(x) {
  df <- readr::read_csv(x)
  stats::setNames(df, tolower(names(df)))
}

# from xfun
is_windows <- function() .Platform$OS.type == "windows"
is_macos <- function() unname(Sys.info()["sysname"] == "Darwin")
dir_exists <- function(x) utils::file_test("-d", x)
pkg_file = function(..., mustWork = TRUE) {
  system.file(..., package = 'rgnparser', mustWork = mustWork)
}

bin_paths <- function(dir = 'gnparser') {
  if (is_windows()) {
    path <- Sys.getenv('APPDATA', '')
    path <- if (dir_exists(path)) file.path(path, dir)
  } else if (is_macos()) {
    path <- '~/Library/Application Support'
    path <- if (dir_exists(path)) file.path(path, dir)
    path <- c('/usr/local/bin', path)
  } else {
    path <- c('~/bin', '/snap/bin', '/var/lib/snapd/snap/bin')
  }
  path <- c(path, pkg_file(dir, mustWork = FALSE))
  return(path)
}
