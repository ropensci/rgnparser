skip_on_cran()

test_that("install_gnparser skip the nightly version", {
  skip_if_not_installed("curl")

  install_gnparser(force = TRUE)
  json <- jsonlite::fromJSON('https://api.github.com/repos/gnames/gnparser/releases')
  latest <- json$tag_name[1]
  expect_equal(gn_version()$version, latest)
})
