library(HarmonyUtils)
library(magrittr)
library(jsonlite)
library(plyr)
library(devtools)

make_composition <- function(x) {
  new_harmony_composition(
    x = x$chords %>%
      lapply(unlist) %>%
      lapply(function(y) mod(y, 12L)) %>%
      lapply(function(z) new_chord(bass_pc = z[1], non_bass_pc_set = z[- 1])),
    description = x$description
  )
}

message("Importing classical dataset")
classical <- read_json("data-raw/classical.json") %>%
  llply(make_composition, .progress = "text") %>%
  new_harmony_corpus("A selection of common-practice Western tonal music")
use_data(classical, overwrite = TRUE)

message("Importing popular dataset")
popular <- read_json("data-raw/popular.json") %>%
  llply(make_composition, .progress = "text") %>%
  new_harmony_corpus("The McGill Billboard corpus")
use_data(popular, overwrite = TRUE)

message("Importing jazz dataset")
jazz <- read_json("data-raw/jazz.json") %>%
  llply(make_composition, .progress = "text") %>%
  new_harmony_corpus("The iRb jazz corpus")
use_data(jazz, overwrite = TRUE)
