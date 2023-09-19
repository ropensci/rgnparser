skip_on_cran()
skip_on_ci()

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

test_that("cultivar arg works", {
  with_cult <- gn_parse("Sarracenia flava 'Maxima'", cultivar = TRUE)
  without_cult <- gn_parse("Sarracenia flava 'Maxima'", cultivar = FALSE)
  expect_equal(
    with_cult[[1]]$canonical$simple, "Sarracenia flava ‘Maxima’"
  )
  expect_equal(
    without_cult[[1]]$canonical$simple, "Sarracenia flava"
  )
})

test_that("capitalize arg works", {
  with_capital <- gn_parse("parus major", capitalize = TRUE)
  without_capital <- gn_parse(
    "parus major", capitalize = FALSE)
  expect_equal(
    with_capital[[1]]$canonical$simple, "Parus major"
  )
  # Without capitalization, name cannot be parsed
  expect_equal(
    without_capital[[1]]$parsed, FALSE
  )
})

test_that("diaereses arg works", {
  with_dia <- gn_parse("Leptochloöpsis virgata", diaereses = TRUE)
  without_dia <- gn_parse("Leptochloöpsis virgata", diaereses = FALSE)
  expect_equal(
    with_dia[[1]]$canonical$simple, "Leptochloöpsis virgata"
  )
  expect_equal(
    without_dia[[1]]$canonical$simple, "Leptochlooepsis virgata"
  )
})
