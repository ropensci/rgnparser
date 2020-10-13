skip_on_cran()

test_that("gn_parse_tidy", {
  x <- c("Quadrella steyermarkii (Standl.) Iltis &amp; Cornejo",
    "Parus major Linnaeus, 1788", "Helianthus annuus var. texanus")
  z <- gn_parse_tidy(x)

  expect_is(z, "data.frame")
  expect_is(z, "tbl")
  # names are all lowercase
  expect_equal(names(z), tolower(names(z)))
  expect_equal(sort(z$verbatim), sort(x))

  name <- "Parus major Linnaeus, 1788"
  w <- gn_parse_tidy(name)
  expect_equal(w$verbatim, name)
  expect_equal(w$authorship, "Linnaeus 1788")
})
