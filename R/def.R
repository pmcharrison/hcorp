#' @export
setClass(
  "Dataset",
  slots = list(
    compositions = "list"
  )
)

#' @export
setMethod(
  "as.list", signature(x = "Dataset"),
  function(x, ...) x@compositions
)

#' @export
setClass(
  "Composition",
  slots = list(
    chords = "integer"
  )
)

#' @export
setMethod(
  "as.integer", signature(x = "Composition"),
  function(x, ...) x@chords
)
