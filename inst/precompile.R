# Precompile vignettes (from .Rmd.orig to .Rmd)
# Need to do this locally because CI won't have gnparser

# Load package in working state
# not with library()
library(devtools)
library(knitr)
load_all()

knit("vignettes/rgnparser.Rmd.orig", "vignettes/rgnparser.Rmd")

build_vignettes()