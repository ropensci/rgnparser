## Test environments
* local - Darwin, R 4.3.1
* win-builder (release and devel)
* r hub - Ubuntu Linux 20.04.1 LTS, R-release, GCC
* r hub - Fedora Linux, R-devel, clang, gfortran

## R CMD check results

0 errors | 0 warnings | 0 notes

-----

Since last submission the most crucial change was deprecating the install_gnparser() function that did not respect CRAN rules ("Packages should not write in the user’s home filespace, nor anywhere else on the file system apart from the R session’s temporary directory"). The function is still exported but show a deprecation error message thanks to lifecycle::deprecate_stop(). Reverse dependencies were checked and raised no problem even if the package bdc uses rgnparser.

This submission also fixes a bug in the functions 'gn_parse()' and 'gn_parse_tidy()' that caused the argument `ignore_tags` to be... ignored.

We, Joel Nitta (main maintainer) and Alban Sagouis (co-maintainer), thank you for taking the time of reviewing 'rgnparser'.

Best wishes,
Joel Nitta, Alban Sagouis
