rgnparser 0.2.6
===============
### BUG FIX
`install_gnparser()` now downloads the correct binary file depending on the system it installs 'gnparser' on.

rgnparser 0.2.0
===============

### NEW FEATURES

* A new gnparser version (v1) is out. In addition, gnparser has moved from Gitlab to Github; which also required changes to `install_gnparser()` because we download Go binaries from the gnparser source repository (#7)
* As part of new gnparser version, arguments have changed in `gn_parse()` and `gn_parse_tidy()`: `format` has been removed. `batch_size` and `ignore_tags` were added to both functions, while `details` was added to `gn_parse()` only. See docs for details.  (#11)
* gnparser v1 or greater is now required (#10)

### DEFUNCT

* `gn_debug()` is now defunct. the gnparser command for this function was removed in gnparser v1 (#9)

### BUG FIXES

* `gn_version()` was broken with the new gnparser version, fixed now (#8)
* xxx (#xx)


rgnparser 0.1.0
===============

### NEW FEATURES

* First submission to CRAN.
