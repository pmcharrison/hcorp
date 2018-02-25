#' @export
setClass(
  "harmony_corpus",
  slots = list(
    compositions = "list"
  )
)

#' @export
setGeneric("declass", function(x) standardGeneric("declass"))
setMethod("declass", signature(x = "harmony_corpus"),
          function(x) {
            l <- x@compositions
            for (i in seq_along(l)) {
              l[[i]] <- declass(l[[i]])
            }
            l
          })

#' @export
setMethod(
  "show", signature(object = "harmony_corpus"),
  function(object) {
    cat("---\n")
    cat("A harmony corpus\n\n")
    cat("Num. compositions =", num_compositions(object), "\n")
    cat("Num. events =", num_events(object), "\n")
    cat("---\n")
  }
  )

#' @export
setGeneric("as.harmony_corpus", function(x) standardGeneric("as.harmony_corpus"))
setMethod("as.harmony_corpus", signature(x = "harmony_corpus"), function(x) x)
setMethod(
  "as.harmony_corpus", signature(x = "list"),
  function(x) {
    for (i in seq_along(x)) {
      x[[i]] <- as.composition(x[[i]])
    }
    new("harmony_corpus", compositions = x)
  }
)

#' @export
setGeneric("num_compositions", function(x) standardGeneric("num_compositions"))
setMethod("num_compositions", signature(x = "harmony_corpus"), function(x) length(x@compositions))

#' @export
setMethod(
  "as.list", signature(x = "harmony_corpus"),
  function(x, ...) x@compositions
)

#' @export
setClass(
  "composition",
  slots = list(
    events = "integer"
  )
)

#' @export
setMethod(
  "show", signature(object = "composition"),
  function(object) {
    cat("---\n")
    cat("A harmony composition\n\n")
    cat("Num. events =", num_events(object), "\n")
    cat("---\n")
  }
)

#' @export
setMethod(
  "as.integer", signature(x = "composition"),
  function(x, ...) x@events
)

#' @export
setGeneric("as.composition", function(x) standardGeneric("as.composition"))
setMethod("as.composition", signature(x = "composition"), function(x) x)
setMethod("as.composition", signature(x = "numeric"),
          function(x) {
            if (!all(x == round(x))) stop("All elements of <x> must be integers")
            new("composition", events = as.integer(x))
          })
setMethod("as.composition", signature(x = "list"),
          function(x) {
            if (!all(sapply(x, HarmonyUtils::is.Chord))) stop("All elements of <x> must be chords")
            x %>% (HarmonyUtils::encode_chords) %>% as.composition
          })

#' @export
setGeneric("num_events", function(x) standardGeneric("num_events"))
setMethod("num_events", signature(x = "composition"), function(x) length(x@events))
setMethod("num_events", signature(x = "harmony_corpus"),
          function(x) {
            sum(vapply(x@compositions, num_events, integer(1)))
          })

setMethod("declass", signature(x = "composition"),
          function(x) as.integer(x))

#' @export
combine_corpora <- function(...) {
  x <- list(...)
  assertthat::assert_that(
    is.list(x),
    all(sapply(x, function(y) is(y, "harmony_corpus")))
  )
  lapply(x, function(y) y@compositions) %>%
    (function(z) do.call(c, z)) %>%
    as.harmony_corpus
}
