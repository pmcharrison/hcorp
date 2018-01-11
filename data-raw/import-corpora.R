library(HarmonyUtils)
library(hash)
library(magrittr)
library(jsonlite)
library(plyr)
library(devtools)

collapse_chords <- function(x) {
  lapply(x, function(piece) {
    lapply(piece, unlist)
  })
}

message("Importing chord key")
chord_key <- get_alphabet(format = "list")
use_data(chord_key, overwrite = TRUE)

message("Importing classical dataset")
classical <- read_json("data-raw/classical.json") %>%
  collapse_chords %>%
  llply(., encode_chords, .progress = "text")
use_data(classical, overwrite = TRUE)

message("Importing popular dataset")
popular <- read_json("data-raw/popular.json") %>%
  collapse_chords %>%
  llply(., encode_chords, .progress = "text")
use_data(popular, overwrite = TRUE)

message("Importing jazz dataset")
jazz <- read_json("data-raw/jazz.json") %>%
  collapse_chords %>%
  llply(., encode_chords, .progress = "text")
use_data(jazz, overwrite = TRUE)

for (i in seq_along(popular)) {
  composition <- popular[[i]]
  for (j in seq_along(composition)) {
    chord <- composition[[j]]
    pc <- chord %% 12
    if (anyDuplicated(pc)) browser()
  }
}
