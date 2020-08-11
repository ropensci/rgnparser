rgnparser
=========



[![R-check](https://github.com/ropensci/rgnparser/workflows/R-check/badge.svg)](https://github.com/ropensci/rgnparser/actions/)

rgnparser: Parse Scientific Names

Docs: <https://ropensci.github.io/rgnparser/>

## Install gnparser

gnparser is required to use this package.

Installation instructions can be found at the [gnparser repo][gnparser]. 

See the [gnparser repo][gnparser] for details on the various features of gnparser

## Installation


```r
remotes::install_github("ropensci/rgnparser")
```


```r
library("rgnparser")
```

## Examples

### gn_version

gnparser version


```r
gn_version()
#> $version
#> [1] "v0.14.1"
#> 
#> $build
#> [1] "2020-05-07_12:35:40UTC"
```

### gn_debug

debug output


```r
gn_debug("Helianthus annuus var. texanus")
#> <rgnparser debug>
#> 
#> *** Complete Syntax Tree ***
#> [34mSciName[m "Helianthus annuus var. texanus"
#>  [34mName[m "Helianthus annuus var. texanus"
#>   [34mSingleName[m "Helianthus annuus var. texanus"
#>    [34mNameSpecies[m "Helianthus annuus var. texanus"
#>     [34mGenusWord[m "Helianthus"
#>      [34mUninomialWord[m "Helianthus"
#>       [34mCapWord[m "Helianthus"
#>        [34mCapWord1[m "Helianthus"
#>         [34mNameUpperChar[m "H"
#>          [34mUpperChar[m "H"
#>           [34mUpperASCII[m "H"
#>         [34mNameLowerChar[m "e"
...
```

### gn_parse_tidy

output a data.frame with more minimal information


```r
x <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
  "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
gn_parse_tidy(x)
#> # A tibble: 3 x 9
#>   id    verbatim cardinality canonicalfull canonicalsimple canonicalstem
#>   <chr> <chr>          <dbl> <chr>         <chr>           <chr>        
#> 1 e571… Heliant…           3 Helianthus a… Helianthus ann… Helianthus a…
#> 2 fbd1… Quadrel…           2 Quadrella st… Quadrella stey… Quadrella st…
#> 3 e4e1… Parus m…           2 Parus major   Parus major     Parus maior  
#> # … with 3 more variables: authorship <chr>, year <dbl>, quality <dbl>
```

It's pretty fast, thanks to gnparser of course


```r
n <- 10000L
# get random scientific names from taxize
spp <- taxize::names_list(rank = "species", size = n)
timed <- system.time(gn_parse_tidy(spp))
timed
#>    user  system elapsed 
#>   0.971   0.153   0.454
```

Just 0.454 sec for 10000 names

### gn_parse

output a list of lists with more detailed information


```r
x <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
  "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
gn_parse(x)
#> [[1]]
#> [[1]]$parsed
#> [1] TRUE
#> 
#> [[1]]$quality
#> [1] 3
#> 
#> [[1]]$qualityWarnings
#>      [,1] [,2]                               
#> [1,] "3"  "HTML tags or entities in the name"
#> 
#> [[1]]$verbatim
#> [1] "Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo"
#> 
#> [[1]]$normalized
...
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rgnparser/issues).
* License: MIT
* Get citation information for `rgnparser` in R doing `citation(package = 'rgnparser')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

[gnparser]: https://gitlab.com/gogna/gnparser
