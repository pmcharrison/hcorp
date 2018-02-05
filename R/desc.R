#' @export
setGeneric("get_chord_freqs", function(x) standardGeneric("get_chord_freqs"))
setMethod("get_chord_freqs", signature(x = "Corpus"),
          function(x) {
            x2 <- declass(x)
            events <- do.call(c, x2)
            table(events, dnn = NULL)
          })
