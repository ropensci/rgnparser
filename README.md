rgnparser
=========



[![R-check](https://github.com/ropensci/rgnparser/workflows/R-check/badge.svg)](https://github.com/ropensci/rgnparser/actions/)

**rgnparser**: Parse Scientific Names

Docs: https://ropensci.github.io/rgnparser/

## Installation


```r
install.packages("rgnparser")
# OR
remotes::install_github("ropensci/rgnparser")
```


```r
library("rgnparser")
```

## Install gnparser

The command line tool written in Go, gnparser, is required to use this package.

If you want to install gnparser on your own, instructions can be found at the
gnparser repo (https://gitlab.com/gogna/gnparser)

There is a helper function in **rgnparser** for downloading and installing
gnparser on major operating systems (macOS, Windows, Linux):


```r
rgnparser::install_gnparser()
```

It installs the latest gnparser version by default, but you can specify which 
version to install. You can also install gnparser outside of R yourself
(see above).


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rgnparser/issues).
* License: MIT
* Get citation information for `rgnparser` in R doing `citation(package = 'rgnparser')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
