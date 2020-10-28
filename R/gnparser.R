#' @noRd
#' @param ... Arguments to be passed to `sys::exec_internal('gnparser', ...)`
gnparser_cmd = function(...) {
  sys::exec_internal(find_gnparser(), ...)
}

# find an executable from PATH, APPDATA, system.file(), ~/bin, etc
find_exec = function(cmd, dir, info = '') {
  for (d in bin_paths(dir)) {
    exec = if (is_windows()) paste0(cmd, ".exe") else cmd
    path = file.path(d, exec)
    if (utils::file_test("-x", path)) break else path = ''
  }
  path2 = Sys.which(cmd)
  if (path == '' || same_path(path, path2)) {
    if (path2 == '') stop(cmd, ' not found. ', info, call. = FALSE)
    return(cmd)  # do not use the full path of the command
  } else {
    if (path2 != '') warning(
      'Found ', cmd, ' at "', path, '" and "', path2, '". The former will be used. ',
      "If you don't need both copies, you may delete/uninstall one."
    )
  }
  normalizePath(path)
}

gnpenv <- new.env()
find_gnparser = local({
  gnpenv$path = NULL  # cache the path to gnparser
  function() {
    if (is.null(gnpenv$path)) gnpenv$path <- find_exec(
      'gnparser', 'gnparser', 'You can install it via rgnparser::install_gnparser()'
    )
    gnpenv$path
  }
})

parse_one <- function(x, format = NULL, threads = NULL) {
  args <- character(0)
  if (!is.null(format)) args <- c(args, "-f", format)
  if (!is.null(threads)) args <- c(args, "-j", threads)
  z <- gnparser_cmd(c(args, x), error = FALSE)
  err_chk(z)
  return(rawToChar(z$stdout))
}

gnparser_exists <- function() {
  check_gnp <- gnparser_cmd()
  if (check_gnp$status != 0) stop("`gnparser` not found, see ?install_gnparser")
  return(TRUE)
}

# from xfun::same_path
same_path <- function(p1, p2, ...) {
  normalize_path(p1, ...) == normalize_path(p2, ...)
}
# from xfun::normalize_path
normalize_path <- function(path, winslash = "/", must_work = FALSE) {
  res = normalizePath(path, winslash = winslash, mustWork = must_work)
  if (is_windows()) res[is.na(path)] = NA
  res
}
