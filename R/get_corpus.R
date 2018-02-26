#' @export
get_corpus <- function(name) {
  if (name == "classical") {
    HarmonyCorpora::classical
  } else if (name == "popular") {
    HarmonyCorpora::popular
  } else if (name == "jazz") {
    HarmonyCorpora::jazz
  } else stop("Unrecognised corpus!")
}
