#' Columnwise missingness percentages
#' @param x A valid R `object` for which the percentage of missing values is required.
#' @param percent Logical. Should values be displayed as percentages? Defaults to `TRUE`, otherwise
#' results are shown in decimals.
#' @description A convenient way to obtain percent missingness columnwise.
#' @inheritParams get_na_counts
#' @return An object of the same class as x showing the percentage of missing values.
#' @examples
#' percent_missing(airquality)
#' # show decimals
#' percent_missing(airquality, percent = FALSE)
#' @export

percent_missing <- function(x, percent = TRUE, grouped = FALSE,
                            grouping_cols = NULL){
  UseMethod("percent_missing")
}

#' @export
percent_missing.data.frame <- function(x, percent = TRUE,
                                       grouped = FALSE,
                                       grouping_cols = NULL
                                       ){

# Check that user actually provides grouping columns
  if(grouped & is.null(grouping_cols)){
    warning("You chose to do grouping but no grouping columns were provided.")
  }

  if(percent){
    if(grouped){
      # Probably better exported to avoid repetition
      # Can leave as is for now
      x %>%
        dplyr::group_by(!!!dplyr::syms(grouping_cols)) %>%
        dplyr::summarise_all(list(function(x)
          sum(is.na(x))/length(x) * 100))
    }
    else{
      purrr::map_dbl(x, ~sum(is.na(.x))/ length(.x) * 100)

    }

  }
  else{
    if(grouped){
      x %>%
        dplyr::group_by(!!!dplyr::syms(grouping_cols)) %>%
        dplyr::summarise_all(list(function(x) sum(is.na(x))/length(x)))
    }
    purrr::map_dbl(x, ~sum(is.na(.x))/ length(.x))
  }
}
