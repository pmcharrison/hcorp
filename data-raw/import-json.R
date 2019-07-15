library(hrep)
library(magrittr)
library(jsonlite)
library(plyr)
library(devtools)

make_composition <- function(x, type, encode, get_description) {
  x$chords %>%
    lapply(unlist) %>%
    lapply(get(type, mode = "function")) %>%
    vec(type, metadata = list(description = get_description(x),
                              keysig = x$keysig,
                              mode = x$mode)) %>%
    {if (encode) encode(.) else .}
}

make_corpus <- function(x, description, type) {
  corpus(x, type = type, metadata = list(description = description))
}

import <- function(label,
                   description,
                   input_label = label,
                   type = "pc_chord",
                   encode = TRUE,
                   keep = plyr::true,
                   get_description = function(x) x$description) {
  env <- new.env()
  env[[label]] <- paste0(input_label, ".json") %>%
    file.path("data-raw", "json", .) %>%
    read_json() %>%
    Filter(keep, .) %>%
    llply(make_composition,
          type = type,
          encode = encode,
          get_description = get_description,
          .progress = "time") %>%
    make_corpus(description, type = type)
  save(list = label,
       envir = env,
       file = file.path("data", paste0(label, ".rda")),
       compress = "bzip2")
}

import("classical_1",
       "A selection of common-practice Western tonal music")

import("classical_1b",
       "A selection of common-practice Western tonal music",
       type = "pi_chord",
       encode = FALSE)

import("popular_1",
       "The McGill Billboard corpus")

import("jazz_1",
       "The iRb jazz corpus")

import("bach_chorales_1",
       "A collection of four-part chorales by J. S. Bach",
       input_label = "classical_1b",
       keep = function(x) grepl("^bach-chor", x$description),
       get_description = function(x) gsub("^bach-", "", x$description),
       type = "pi_chord",
       encode = FALSE)

import("bach_chorales_1b",
       "A collection of four-part chorales by J. S. Bach",
       input_label = "classical_1",
       keep = function(x) grepl("^bach-chor", x$description),
       get_description = function(x) gsub("^bach-", "", x$description),
       type = "pc_chord",
       encode = TRUE)
