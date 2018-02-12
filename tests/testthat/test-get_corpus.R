context("get_corpus")

test_that("works", {
  expect_equal(
    get_corpus("classical"),
    HarmonyCorpora::classical
  )
  expect_equal(
    get_corpus("popular"),
    HarmonyCorpora::popular
  )
  expect_equal(
    get_corpus("jazz"),
    HarmonyCorpora::jazz
  )
})
