#' Bach chorales (1)
#'
#' This dataset comprises 370 chorales by J. S. Bach.
#'
#' @details
#' This dataset was constructed from data downloaded from
#' [KernScores](http://kern.humdrum.org/cgi-bin/browse?l=/371chorales).
#' No harmonic reduction was performed;
#' the dataset includes all passing notes etc. from the original scores.
#'
#' According to KernScores, these chorales were collected
#' after J. S. Bach's death by his son C. P. E. Bach,
#' and finished by Kirnberger, a student of J. S. Bach,
#' after C. P. E. Bach's death.
#' The KernScores dataset was constructed from
#' the fourth edition of the chorales by Breitkopf & Hartel, c. 1875,
#' entitled "371 four-part chorale chants of Johann Sebastian Bach",
#' retypeset c. 1915 as Edition Breitkopf 10,
#' and reprinted by Associated Music Publishers, Inc., New York in c. 1940.
#'
#' The dataset uses S3 classes from the \code{hrep} package,
#' specifically:
#' \code{\link[hrep]{pi_chord}},
#' for representing chords;
#' \code{\link[hrep]{vec}},
#' for representing chord sequences;
#' \code{\link[hrep]{corpus}},
#' for representing the corpus.
#'
#' Each chord is represented as a 'pitch chord',
#' corresponding to a set of MIDI note numbers.
#'
#' @note
#' The dataset excludes number 150, the only chorale not in four parts.
#'
#' @md
#' @name bach_chorales_1
#' @docType data
#' @keywords data
NULL
