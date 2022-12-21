
# rgnparser

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![cran
checks](https://cranchecks.info/badges/worst/rgnparser)](https://cranchecks.info/pkgs/rgnparser)
[![R-check](https://github.com/ropensci/rgnparser/workflows/R-check/badge.svg)](https://github.com/ropensci/rgnparser/actions/)
[![rstudio mirror
downloads](https://cranlogs.r-pkg.org/badges/rgnparser)](https://github.com/r-hub/cranlogs.app)
[![cran
version](https://www.r-pkg.org/badges/version/rgnparser)](https://cran.r-project.org/package=rgnparser)

**rgnparser**: Parse Scientific Names

Docs: <https://ropensci.github.io/rgnparser/>

## Installation

``` r
install.packages("rgnparser")
# OR
remotes::install_github("ropensci/rgnparser")
```

``` r
library("rgnparser")
```

## Install gnparser

The command line tool written in Go, gnparser, is required to use this
package.

If you want to install gnparser on your own, instructions can be found
at the gnparser repo (<https://github.com/gnames/gnparser>)

There is a helper function in **rgnparser** for downloading and
installing gnparser on major operating systems (macOS, Windows, Linux):

``` r
rgnparser::install_gnparser()
```

It installs the latest gnparser version by default, but you can specify
which version to install. You can also install gnparser outside of R
yourself (see above).

## Meta

- Please [report any issues or
  bugs](https://github.com/ropensci/rgnparser/issues).
- License: MIT
- Get citation information for `rgnparser` in R doing
  `citation(package = 'rgnparser')`
- Please note that this package is released with a [Contributor Code of
  Conduct](https://ropensci.org/code-of-conduct/). By contributing to
  this project, you agree to abide by its terms.
