## Test environments
* local - Darwin, R 4.2.0
* GitHub Actions - ubuntu 16.04, R release
* win-builder (release and devel)
* r hub - Ubuntu Linux 20.04.1 LTS, R-release, GCC
* r hub - Fedora Linux, R-devel, clang, gfortran

## R CMD check results

0 errors | 0 warnings | 0 notes

-----

This submission fixes a bug in the function 'install_gnparser()'.
It downloads appropriate binaries for the Go language gnparser software.
After a change in the gnparser GitHub repo, the 'install_gnparser()'
function version on CRAN could not decide which binary to download anymore.

We, Joel Nitta (main maintainer) and Alban Sagouis (co-maintainer), will be maintaining the package now, Scott Chamberlain gave his green light.

Thanks!
Joel Nitta, Alban Sagouis
