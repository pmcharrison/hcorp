context("legacy_consistency")

library(magrittr)
library(hrep)

test_that("examples from reading json", {
  test <- function(old, new) {
    x <- old %>% lapply(function(x) x %% 12L) %>%
      lapply(pc_chord)
    y <- new %>% decode %>% as.list
    expect_equal(x, y)
  }

  # Classical beginning of composition 1
  test(old = list(c(55,62,71),c(52,60,67,71),c(54,62,69),c(55,62,71)),
       new = hcorp::classical_1[[1]][1:4])

  # Popular beginning of composition 1
  test(old = list(c(57,60,64),c(48,64,67),c(57,60,64),c(48,64,67)),
       new = hcorp::popular_1[[1]][1:4])

  # Jazz beginning of composition 1
  test(old = list(c(53,60,64,69),c(56,60,63,66),c(49,60,65,68),c(52,62,68,71)),
       new = hcorp::jazz_1[[1]][1:4])
})
