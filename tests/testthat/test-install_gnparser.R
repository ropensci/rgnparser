skip_on_cran()

test_that("install_gnparser skip the nightly version", {
  skip_if_not_installed("curl")

  install_gnparser()
  json <- jsonlite::fromJSON('https://api.github.com/repos/gnames/gnparser/releases')
  nightly <- json$tag_name[1]
  latest <- json$tag_name[2]
  expect_equal(nightly, "nightly")
  expect_equal(gn_version()$version, latest)
})
