context("get_corpus")

test_that("works", {
  expect_equal(
    get_corpus("classical_1"),
    hcorp::classical_1
  )
  expect_equal(
    get_corpus("popular_1"),
    hcorp::popular_1
  )
  expect_equal(
    get_corpus("jazz_1"),
    hcorp::jazz_1
  )
})
