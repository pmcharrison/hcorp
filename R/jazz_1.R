#' Jazz corpus 1
#'
#' This dataset provides chord sequences for 1,186 pieces from the iRB corpus
#' \insertCite{Broze2013}{hcorp}.
#' This is a publicly available dataset of jazz compositions
#' sourced from an online forum for jazz musicians.
#'
#' @details
#' While the original dataset comprises notated chord symbols,
#' this version of the dataset provides a more explicit representation,
#' where each chord is represented as a pitch class set and a labelled
#' bass pitch class.
#' This dataset was used in
#' \insertCite{Harrison2018;textual}{hcorp}.
#'
#' The dataset uses S3 classes from the \code{hrep} package,
#' specifically:
#' \code{\link[hrep]{pc_chord}},
#' for representing chord symbols;
#' \code{\link[hrep]{coded_vec}},
#' for coding chord sequences as integer vectors;
#' \code{\link[hrep]{corpus}},
#' for representing the corpus.
#'
#' Each chord is represented as a 'pitch-class chord':
#' this is defined as a pitch class set with a known bass pitch class.
#' @note \insertCite{Harrison2018;textual}{hcorp}
#' discarded inversion information when modelling this dataset.
#' @name jazz_1
#' @docType data
#' @references
#' \insertAllCited{}
#' @keywords data
NULL
