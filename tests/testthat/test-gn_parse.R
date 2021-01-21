skip_on_cran()

test_that("gn_parse", {
  x <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
    "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
  w <- gn_parse(x)
  vapply(w, "[[", "", "normalized")

  expect_is(w, "list")
  for (i in w) expect_is(i, "list")
  
  expect_is(w[[1]]$parsed, "logical")
  expect_is(w[[1]]$verbatim, "character")
  expect_is(w[[1]]$normalized, "character")
  expect_is(w[[1]]$cardinality, "integer")
  expect_is(w[[1]]$canonical, "list")
  expect_null(w[[1]]$details) # used to be a thing, removed at some point
})
