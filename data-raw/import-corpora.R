library(hrep)
library(magrittr)
library(jsonlite)
library(plyr)
library(devtools)

make_composition <- function(x) {
  x$chords %>%
    lapply(unlist) %>%
    lapply(pc_chord) %>%
    vec("pc_chord", metadata = list(description = x$description)) %>%
    encode
}

make_corpus <- function(x, description) {
  corpus(x, type = "pc_chord", metadata = list(description = description))
}

corpora <- character()
import <- function(label, description) {
  env <- new.env()
  env[[label]] <- paste0(label, ".json") %>%
    file.path("data-raw", "json", .) %>%
    read_json() %>%
    llply(make_composition, .progress = "text") %>%
    make_corpus(description)
  save(list = label,
       envir = env,
       file = file.path("data", paste0(label, ".rda")))
  corpora <<- append(corpora, label)
}

unlink("data", recursive = TRUE)
dir.create("data")

import("classical_1",
       "A selection of common-practice Western tonal music")

import("popular_1",
       "The McGill Billboard corpus")

import("jazz_1",
       "The iRb jazz corpus")

use_data(corpora, overwrite = TRUE)
