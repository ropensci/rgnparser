cl <- function(l) Filter(Negate(is.null), l)

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
        paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

file_type <- function(x) {
  if (grepl("\\.pdf$", x)) return("pdf")
  if (grepl("\\.xml$", x)) return("xml")
  return(last(strsplit(x, "\\.")[[1]]))
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

strextract <- function(str, pattern) regmatches(str, gregexpr(pattern, str))
