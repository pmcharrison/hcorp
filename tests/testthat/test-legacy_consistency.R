context("legacy_consistency")

library(magrittr)

test_that("examples from reading json", {
  # Classical beginning of composition 1
  target <- list(c(55,62,71),c(52,60,67,71),c(54,62,69),c(55,62,71)) %>%
    lapply(function(x) x %% 12L)
  current <- HarmonyUtils::decode_chords(HarmonyCorpora::classical[[1]][1:4]) %>%
    lapply(as.integer)
  expect_equal(target, current)

  # Popular beginning of composition 1
  target <- list(c(57,60,64),c(48,64,67),c(57,60,64),c(48,64,67)) %>%
    lapply(function(x) x %% 12L)
  current <- HarmonyUtils::decode_chords(HarmonyCorpora::popular[[1]][1:4]) %>%
    lapply(as.integer)
  expect_equal(target, current)

  # Jazz beginning of composition 1
  target <- list(c(53,60,64,69),c(56,60,63,66),c(49,60,65,68),c(52,62,68,71)) %>%
    lapply(function(x) x %% 12L)
  current <- HarmonyUtils::decode_chords(HarmonyCorpora::jazz[[1]][1:4]) %>%
    lapply(as.integer)
  expect_equal(target, current)
})
