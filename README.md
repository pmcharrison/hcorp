
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hcorp: Music corpora for harmonic analysis

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

This R package provides several datasets of chord sequences as used in
Harrison & Pearce (2018). These datasets are expressly for research
purposes only.

  - `classical_1`: 1,022 pieces compiled from KernScores
    (<http://kern.humdrum.org/>), converted to chord sequences using the
    algorithm of Pardo & Birmingham (2002).
  - `popular_1`: 739 pieces from the McGill Billboard corpus (Burgoyne,
    2011), converted from chord symbols to pitch-class sets by Harrison
    & Pearce (2018).
  - `jazz_1`: 1,186 pieces from the iRB corpus (Broze & Shanahan, 2013),
    converted from chord symbols to pitch-class sets by Harrison &
    Pearce (2018).

For more details, see the package’s documentation (e.g. `?classical_1`).

## Installation

You can install the current version of `hcorp` from Github by entering
the following commands into R:

``` r
if (!require(devtools)) install.packages("devtools")
devtools::install_github("hcorp")
```

## Example usage

The `hcorp` package is best used in tandem with the `hrep` package. The
`hrep` package provides the underlying representations for the corpora
in `hcorp`, as well as methods for manipulating and visualising them.

You can load these packages into the global namespace as follows:

``` r
library(hcorp)
library(hrep)
library(magrittr) # Provides the pipe operator, %>%
```

The `hrep` package currently contains three corpora:

``` r
classical_1
#> 
#> A corpus of 1022 sequences 
#>   total size = 199254 symbols 
#>   symbol type = 'pc_chord'
#>   coded = true 
#>  (Metadata available)

popular_1
#> 
#> A corpus of 739 sequences 
#>   total size = 74093 symbols 
#>   symbol type = 'pc_chord'
#>   coded = true 
#>  (Metadata available)

jazz_1
#> 
#> A corpus of 1186 sequences 
#>   total size = 42822 symbols 
#>   symbol type = 'pc_chord'
#>   coded = true 
#>  (Metadata available)
```

Internally, a corpus is a list of encoded vectors.

``` r
classical_1[1:3] %>% as.list
#> [[1]]
#> Encoded vector of type 'pc_chord', length = 53 (metadata available)
#> 
#> [[2]]
#> Encoded vector of type 'pc_chord', length = 47 (metadata available)
#> 
#> [[3]]
#> Encoded vector of type 'pc_chord', length = 39 (metadata available)
```

Encoded vectors are objects of class `coded_vec`.

``` r
classical_1[[1]] %>% class
#> [1] "coded_vec" "integer"
```

Internally, encoded vectors are sequences of integers. This is good for
memory efficiency, and useful for certain modelling approaches.

``` r
classical_1[[1]] %>% as.integer %>% head
#> [1] 14375  8298 12325 14375  4317  8253
```

These vectors can be decoded with the function `decode`.

``` r
classical_1[[1]][1:3] %>% decode
#> Vector of type 'pc_chord', length = 3 (metadata available)

classical_1[[1]][1:3] %>% decode %>% as.list
#> [[1]]
#> Pitch-class chord: [7] 2 11
#> 
#> [[2]]
#> Pitch-class chord: [4] 0 7 11
#> 
#> [[3]]
#> Pitch-class chord: [6] 2 9
```

Corpora and sequences can optionally store metadata.

``` r
metadata(classical_1)
#> $description
#> [1] "A selection of common-practice Western tonal music"

metadata(classical_1[[1]])
#> $description
#> [1] "bach-chor001"
```

Corpora and sequences can be subsetted and combined like lists.

``` r
classical_1[1:3]
#> 
#> A corpus of 3 sequences 
#>   total size = 139 symbols 
#>   symbol type = 'pc_chord'
#>   coded = true 
#>  (Metadata available)

classical_1[[1]]
#> Encoded vector of type 'pc_chord', length = 53 (metadata available)

classical_1[[1]][1:3]
#> Encoded vector of type 'pc_chord', length = 3 (metadata available)

c(classical_1[1:3],
  popular_1[1:3])
#> 
#> A corpus of 6 sequences 
#>   total size = 313 symbols 
#>   symbol type = 'pc_chord'
#>   coded = true
```

## References

Broze, Y., & Shanahan, D. (2013). Diachronic changes in jazz harmony: A
cognitive perspective. Music Perception, 31(1), 32–45.
<https://doi.org/10.1525/rep.2008.104.1.92>

Harrison, P. M. C., & Pearce, M. T. (2018). An energy-based generative
sequence model for testing sensory theories of Western harmony. In
Proceedings of the 19th International Society for Music Information
Retrieval Conference (pp. 160–167). Paris, France.

Pardo, B., & Birmingham, W. P. (2002). Algorithms for chordal analysis.
Computer Music Journal, 26(2), 27–49.
<https://doi.org/10.1162/014892602760137167>
