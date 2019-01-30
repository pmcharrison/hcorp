library(tidyverse)
library(hrep)
loadNamespace("plyr")

df_to_composition <- function(x) {
  desc <- x$description
  stopifnot(length(unique(desc)) == 1L)
  split(x, x$onset) %>%
    map(df_to_chord) %>%
    set_names(NULL) %>%
    vec("pi_chord", metadata = list(label = desc))
}

df_to_chord <- function(x) {
  pi_chord(x$midi)
}

bach_chorales_1 <- read_csv("data-raw/bach-chorales-1.csv", col_types = "iiiic") %>%
  split(., .$composition_id) %>%
  set_names(NULL) %>%
  plyr::llply(df_to_composition, .progress = "text") %>%
  corpus("pi_chord",
         metadata = list(description = "A collection of four-part chorales by J. S. Bach"))

usethis::use_data(bach_chorales_1, overwrite = TRUE)
