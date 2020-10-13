skip_on_cran()

test_that("gn_version", {
  expect_is(gn_version(), "list")
  expect_named(gn_version(), c("version", "build"))
  expect_is(gn_version()$version, "character")
  expect_is(gn_version()$build, "character")
})
