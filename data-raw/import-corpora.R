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


import <- function(label, description) {
  env <- new.env()
  paste0(label, ".json") %>%
    file.path("data-raw", .) %>%
    read_json() %>%
    llply(make_composition, .progress = "text") %>%
    make_corpus(description) %>%
    save(file = file.path("data", paste0(label, ".rda")))
}

unlink("data", recursive = TRUE)
dir.create("data")

import("classical1",
       "A selection of common-practice Western tonal music")

import("popular1",
       "The McGill Billboard corpus")

import("jazz1",
       "The iRb jazz corpus")
