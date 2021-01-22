#' Install gnparser
#'
#' Downloads the appropriate gnparser executable for your platform and
#' tries to copy it to a system directory so \pkg{rgnparser} can run the
#' `gnparser` command.
#'
#' This function tries to install gnparser to `Sys.getenv('APPDATA')` on
#' Windows, `~/Library/Application Support` on macOS, and `~/bin/` on
#' other platforms (such as Linux). If these directories are not writable, the
#' package directory `gnparser` of \pkg{rgnparser} will be used. If it
#' still fails, you have to install gnparser by yourself and make sure it can
#' be found via the environment variable `PATH`.
#'
#' This is just a helper function and may fail to choose the correct gnparser
#' executable for your operating system, especially if you are not on Windows
#' or Mac or a major Linux distribution. When in doubt, read the gnparser
#' documentation and install it yourself:
#' https://github.com/gnames/gnparser#installation
#' @export
#' @param version The gnparser version number, e.g., `1.0.0`; the default
#' `latest` means the latest version (fetched from GitLab releases).
#' Alternatively, this argument can take a file path of the zip archive or
#' tarball of gnparser that has already been downloaded from GitLab,
#' in which case it will not be downloaded again. The minimum version
#' is `v1.0.0` because gnparser v1 introduced breaking changes - and 
#' we don't support older versions of gnparser here.
#' @param force Whether to install gnparser even if it has already been
#' installed. This may be useful when upgrading gnparser.
#' @note modified from `blogdown::install_hugo`
install_gnparser = function(version = 'latest', force = FALSE) {
  if (Sys.which('gnparser') != '' && !force) {
    message('gnparser is already installed; force=TRUE to reinstall/upgrade')
    return(invisible())
  }

  local_file = if (grepl('[.](zip|tar[.]gz)$', version) && file.exists(version))
    normalizePath(version)

  if (version == 'latest') {
    json <- jsonlite::fromJSON(
      'https://api.github.com/repos/gnames/gnparser/releases')
    version <- json$tag_name[1]
    urls <- json$assets[[1]]$browser_download_url
    message('The latest gnparser version is ', version)
  }

  # FIXME: not modified yet for gnparser
  if (!is.null(local_file)) {
    version <- gsub('^gnparser_([0-9.]+)_.*', '\\1', basename(local_file))
  }

  version <- gsub('^[vV]', '', version)  # pure version number
  version2 <- as.numeric_version(version)
  owd <- setwd(tempdir())
  on.exit(setwd(owd), add = TRUE)
  # unlink(sprintf('gnparser_%s*', version), recursive = TRUE)

  download_file = function(os, ext = '.tar.gz') {
    if (is.null(local_file)) {
      file <- sprintf('gnparser-v%s-%s%s', version, os, ext)
      utils::download.file(grep(os, urls, value = TRUE), file, mode = 'wb')
    } else {
      file <- local_file
      ext <- strextract(file, "\\.tar\\.gz|\\.zip")[[1]]
    }
    switch(ext, .zip = utils::unzip(file), .tar.gz = {
      files <- utils::untar(file, list = TRUE)
      utils::untar(file)
      files
    })
  }

  files = if (is_windows()) {
    download_file('win', '.zip')
  } else if (is_macos()) {
    download_file("mac", '.tar.gz')
  } else {
    download_file('linux', '.tar.gz')
  }

  exec <- files[grep('gnparser', files)]
  if (is_windows()) {
    file.rename(exec, 'gnparser.exe')
    exec <- 'gnparser.exe'
  } else {
    file.rename(exec, 'gnparser')
    exec <- 'gnparser'
    Sys.chmod(exec, '0755') # chmod +x
  }

  install_gnparser_bin(exec)
}

install_gnparser_bin = function(exec) {
  success <- FALSE
  dirs <- bin_paths()
  for (destdir in dirs) {
    dir.create(destdir, showWarnings = FALSE)
    success <- file.copy(exec, destdir, overwrite = TRUE)
    if (success) break
  }
  if (!success) stop(
    'Unable to install gnparser to any of these dirs: ',
    paste(dirs, collapse = ', ')
  )
  message('gnparser has been installed to ', normalizePath(destdir))
}

is_windows <- function() .Platform$OS.type == "windows"
is_macos <- function() unname(Sys.info()["sysname"] == "Darwin")
is_linux <- function() unname(Sys.info()["sysname"] == "Linux")
dir_exists <- function(x) utils::file_test("-d", x)
pkg_file = function(..., mustWork = TRUE) {
  system.file(..., package = 'rgnparser', mustWork = mustWork)
}

bin_paths = function(dir = 'gnparser') {
  if (is_windows()) {
    path = Sys.getenv('APPDATA', '')
    path = if (dir_exists(path)) file.path(path, dir)
  } else if (is_macos()) {
    path = '~/Library/Application Support'
    path = if (dir_exists(path)) file.path(path, dir)
    path = c('/usr/local/bin', path)
  } else {
    path = c('~/bin', '/snap/bin', '/var/lib/snapd/snap/bin')
  }
  path = c(path, pkg_file(dir, mustWork = FALSE))
  path
}
