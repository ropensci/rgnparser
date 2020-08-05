rgnparser
=========



[![R-check](https://github.com/ropensci/rgnparser/workflows/R-check/badge.svg)](https://github.com/ropensci/rgnparser/actions/)

## Install gnparser

gnparser is required to use this package.

Installation instructions can be found at the [gnparser repo](https://gitlab.com/gogna/gnparser). 


## Installation


```r
remotes::install_github("ropensci/rgnparser")
```


```r
library("rgnparser")
```

## Examples

gnparser version


```r
gn_version()
#> 
#> version: v0.14.1
#> 
#> build:   2020-05-07_12:35:40UTC
```

gnparser version


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

output a data.frame with more minimal information


```r
x <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
  "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
gn_parse_tidy(x)
#> # A tibble: 3 x 9
#>   Id    Verbatim Cardinality CanonicalFull CanonicalSimple CanonicalStem
#>   <chr> <chr>          <dbl> <chr>         <chr>           <chr>        
#> 1 e571… Heliant…           3 Helianthus a… Helianthus ann… Helianthus a…
#> 2 fbd1… Quadrel…           2 Quadrella st… Quadrella stey… Quadrella st…
#> 3 e4e1… Parus m…           2 Parus major   Parus major     Parus maior  
#> # … with 3 more variables: Authorship <chr>, Year <dbl>, Quality <dbl>
```

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
#> [1] 1
#> 
#> [[1]]$verbatim
#> [1] "Helianthus annuus var. texanus"
#> 
#> [[1]]$normalized
#> [1] "Helianthus annuus var. texanus"
#> 
#> [[1]]$cardinality
#> [1] 3
...
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rgnparser/issues).
* License: MIT
* Get citation information for `rgnparser` in R doing `citation(package = 'rgnparser')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
