#' @export
setGeneric("get_chord_counts", function(x) standardGeneric("get_chord_counts"))
setMethod("get_chord_counts", signature(x = "harmony_corpus"),
          function(x) {
            x2 <- declass(x)
            events <- do.call(c, x2)
            table(events, dnn = NULL)
          })
