skip_on_cran()

test_that("gn_debug", {
  z <- gn_debug("Parus major Linnaeus, 1788")

  expect_is(z, "gnparse_debug")
  expect_is(unclass(z), "character")
})
