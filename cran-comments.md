## Test environments
* local R installation, R 4.2.0
* ubuntu 16.04 (on GitHub Actions), R release
* win-builder (release and devel)

## R CMD check results

0 errors | 0 warnings | 0 notes

-----

This submission fixes a bug in the function 'install_gnparser()'.
It downloads appropriate binaries for the Go language gnparser software.
After a change in the GitHub repo, the function version on CRAN could
not decide which binary to download anymore.

Thanks!
Joel Nitta, Alban Sagouis
