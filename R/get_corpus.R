#' Get corpus
#'
#' This function provides an alternative to accessing corpora
#' like \code{hcorp::classical_1}.
#' Instead, the same corpus can be accessed by calling
#' \code{get_corpus("classical")}.
#' @param name (Character scalar) Name of the corpus to access.
#' Available names are listed in \code{corpora}.
#' @export
get_corpus <- function(name) {
  checkmate::qassert(name, "S1")
  if (!name %in% hcorp::corpora) stop("unrecognised corpus: ", name)
  get(name)
}
