[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

reeack
======



[![Build Status](https://travis-ci.org/ropensci/reeack.svg?branch=master)](https://travis-ci.org/ropensci/reeack)

## Install Riak

Go to <http://docs.basho.com/riak/kv/2.2.0/> for instructions.

## Start Riak

perhaps like:

```sh
bin/riak start
```

## Install reeack


```r
devtools::install_github("ropensci/reeack")
```


```r
library('reeack')
```

## Connect


```r
x <- riak()
```

## Ping the server


```r
x$ping()
#> [1] TRUE
```

## Get stats


```r
x$stats()[1:5]
#> $connected_nodes
#> list()
#> 
#> $consistent_get_objsize_100
#> [1] 0
#> 
#> $consistent_get_objsize_95
#> [1] 0
#> 
#> $consistent_get_objsize_99
#> [1] 0
#> 
#> $consistent_get_objsize_mean
#> [1] 0
```

## List keys


```r
x$keys()
#> $keys
#> list()
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/reeack/issues).
* License: MIT
* Get citation information for `reeack` in R doing `citation(package = 'reeack')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
