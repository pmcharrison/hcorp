#' @export
setClass(
  "Corpus",
  slots = list(
    compositions = "list"
  )
)

#' @export
setGeneric("declass", function(x) standardGeneric("declass"))
setMethod("declass", signature(x = "Corpus"),
          function(x) {
            l <- x@compositions
            for (i in seq_along(l)) {
              l[[i]] <- declass(l[[i]])
            }
            l
          })

#' @export
setMethod(
  "show", signature(object = "Corpus"),
  function(object) {
    cat("---\n")
    cat("A harmony corpus\n\n")
    cat("Num. compositions =", num_compositions(object), "\n")
    cat("Num. events =", num_events(object), "\n")
    cat("---\n")
  }
  )

#' @export
setGeneric("as.Corpus", function(x) standardGeneric("as.Corpus"))
setMethod("as.Corpus", signature(x = "Corpus"), function(x) x)
setMethod(
  "as.Corpus", signature(x = "list"),
  function(x) {
    for (i in seq_along(x)) {
      x[[i]] <- as.Composition(x[[i]])
    }
    new("Corpus", compositions = x)
  }
)

#' @export
setGeneric("num_compositions", function(x) standardGeneric("num_compositions"))
setMethod("num_compositions", signature(x = "Corpus"), function(x) length(x@compositions))

#' @export
setMethod(
  "as.list", signature(x = "Corpus"),
  function(x, ...) x@compositions
)

#' @export
setClass(
  "Composition",
  slots = list(
    events = "integer"
  )
)

#' @export
setMethod(
  "show", signature(object = "Composition"),
  function(object) {
    cat("---\n")
    cat("A harmony composition\n\n")
    cat("Num. events =", num_events(object), "\n")
    cat("---\n")
  }
)

#' @export
setMethod(
  "as.integer", signature(x = "Composition"),
  function(x, ...) x@events
)

#' @export
setGeneric("as.Composition", function(x) standardGeneric("as.Composition"))
setMethod("as.Composition", signature(x = "Composition"), function(x) x)
setMethod("as.Composition", signature(x = "numeric"),
          function(x) {
            if (!all(x == round(x))) stop("All elements of <x> must be integers")
            new("Composition", events = as.integer(x))
          })
setMethod("as.Composition", signature(x = "list"),
          function(x) {
            if (!all(sapply(x, HarmonyUtils::is.Chord))) stop("All elements of <x> must be chords")
            x %>% (HarmonyUtils::encode_chords) %>% as.Composition
          })

#' @export
setGeneric("num_events", function(x) standardGeneric("num_events"))
setMethod("num_events", signature(x = "Composition"), function(x) length(x@events))
setMethod("num_events", signature(x = "Corpus"),
          function(x) {
            sum(vapply(x@compositions, num_events, integer(1)))
          })

setMethod("declass", signature(x = "Composition"),
          function(x) as.integer(x))

#' @export
combine_corpora <- function(...) {
  x <- list(...)
  assertthat::assert_that(
    is.list(x),
    all(sapply(x, function(y) is(y, "Corpus")))
  )
  lapply(x, function(y) y@compositions) %>%
    (function(z) do.call(c, z)) %>%
    as.Corpus
}
