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
      'gnparser', 'gnparser', 'You need to install gnparser'
    )
    gnpenv$path
  }
})

parse_one <- function(x, format = NULL, threads = NULL, 
  batch_size = NULL, ignore_tags = NULL, cultivar = FALSE,
  capitalize = FALSE, diaereses = FALSE, details = FALSE) {

  assert(format, "character")
  assert(threads, c("integer", "numeric")) # NULL OK
  assert(batch_size, c("integer", "numeric"))
  assert(ignore_tags, "logical")
  assert(cultivar, "logical")
  assert(capitalize, "logical")
  assert(diaereses, "logical")
  assert(details, "logical")

  args <- character(0)
  if (!is.null(format)) args <- c(args, "--format", format)
  if (!is.null(threads)) args <- c(args, "--jobs", threads)
  if (!is.null(batch_size)) args <- c(args, "--batch_size", batch_size)
  if (ignore_tags) args <- c(args, "--ignore_tags")
  if (cultivar) args <- c(args, "--cultivar")
  if (capitalize) args <- c(args, "--capitalize")
  if (diaereses) args <- c(args, "--diaereses")
  if (details) args <- c(args, "--details")
  z <- gnparser_cmd(c(args, x), error = FALSE)
  err_chk(z)
  return(rawToChar(z$stdout))
}

gnparser_exists <- function() {
  check_gnp <- gnparser_cmd()
  if (check_gnp$status != 0) stop("You need to install gnparser")
  return(TRUE)
}

process_version_string <- function(x) {
  txt <- rawToChar(x)
  txt <- strsplit(txt, "\n")[[1]]
  unlist(lapply(txt[nzchar(txt)], function(w) {
    tmp <- gsub("\\s", "", strsplit(w, ":\\s")[[1]])
    stats::setNames(list(tmp[2]), tmp[1])
  }), FALSE)
}

ver_check <- function(version) {
  # ver <- gnparser_cmd("-V", error = FALSE)
  # if (ver$status != 0) ver <- gnparser_cmd("-v", error = FALSE)
  # ver <- process_version_string(ver$stdout)
  ver <- gn_version()
  ver_first_num <- as.numeric(substring(gsub("v|\\.", "", ver$version), 1, 1))
  if (ver_first_num < version) stop("you need to install `gnparser` v1 or greater")
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
