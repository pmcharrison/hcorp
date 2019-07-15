#' Classical corpus 1
#'
#' This dataset represents 1,022 pieces compiled from KernScores
#' (\url{http://kern.humdrum.org/}),
#' including keyboard and ensemble from several major composers
#' of common-practice tonal music
#' (specifically Bach, Haydn, Mozart, Beethoven, Chopin).
#' This dataset was used in
#' \insertCite{Harrison2018;textual}{hcorp}.
#'
#' @details
#' The original KernScores data comprises full polyphonic scores.
#' These scores were converted to chord sequences
#' using the algorithm of
#' \insertCite{Pardo2002;textual}{hcorp},
#' with an expanded chord dictionary,
#' and colocating segment boundaries with metrical beat locations
#' as estimated from time signatures.
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
#' @name classical_1
#' @docType data
#' @references
#' \insertAllCited{}
#' @keywords data
NULL

#' Classical corpus 1b
#'
#' Equivalent to \code{\link{classical_1}} but without applying
#' any chord labelling algorithm
#' (i.e. instead applying full expansion, a.k.a. salami slicing).
#' The dataset has a 'pitch chord' representation (\code{\link[hrep]{pi_chord}});
#' a pitch chord corresponds to the set of MIDI note numbers in the sonority.
#'
#' @name classical_1b
#' @docType data
#' @keywords data
NULL

