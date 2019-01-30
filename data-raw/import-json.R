library(hrep)
library(magrittr)
library(jsonlite)
library(plyr)
library(devtools)

make_composition <- function(x, type, encode) {
  x$chords %>%
    lapply(unlist) %>%
    lapply(get(type, mode = "function")) %>%
    vec(type, metadata = list(description = x$description)) %>%
    {if (encode) encode(.) else .}
}

make_corpus <- function(x, description, type) {
  corpus(x, type = type, metadata = list(description = description))
}

import <- function(label, description, type = "pc_chord", encode = TRUE) {
  env <- new.env()
  env[[label]] <- paste0(label, ".json") %>%
    file.path("data-raw", "json", .) %>%
    read_json() %>%
    llply(make_composition, type = type, encode = encode, .progress = "text") %>%
    make_corpus(description, type = type)
  save(list = label,
       envir = env,
       file = file.path("data", paste0(label, ".rda")))
}

import("classical_1",
       "A selection of common-practice Western tonal music")

import("popular_1",
       "The McGill Billboard corpus")

import("jazz_1",
       "The iRb jazz corpus")

import("bach_chorales_1",
       "A collection of four-part chorales by J. S. Bach",
       type = "pi_chord",
       encode = FALSE)
