library(HarmonyUtils)
library(magrittr)
library(jsonlite)
library(plyr)
library(devtools)

collapse_chords <- function(x) {
  lapply(x, function(piece) {
    lapply(piece, unlist)
  })
}

as_chords <- function(composition_list) {
  lapply(composition_list,
         function(composition) {
           lapply(composition,
                  function(chord) {
                    x <- chord %% 12L
                    new_chord(bass_pc = x[1], non_bass_pc_set = x[- 1])
                  })
         })
}

message("Importing classical dataset")
classical <- read_json("data-raw/classical.json") %>%
  collapse_chords %>%
  as_chords %>%
  llply(., encode_chords, .progress = "text") %>%
  as.harmony_corpus
use_data(classical, overwrite = TRUE)

message("Importing popular dataset")
popular <- read_json("data-raw/popular.json") %>%
  collapse_chords %>%
  as_chords %>%
  llply(., encode_chords, .progress = "text") %>%
  as.harmony_corpus
use_data(popular, overwrite = TRUE)

message("Importing jazz dataset")
jazz <- read_json("data-raw/jazz.json") %>%
  collapse_chords %>%
  as_chords %>%
  llply(., encode_chords, .progress = "text")  %>%
  as.harmony_corpus
use_data(jazz, overwrite = TRUE)
