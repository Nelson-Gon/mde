#' Columnwise missingness percentages
#' @param x A valid R `object` for which the percentage of missing values is required.
#' @param percent Logical. Should values be displayed as percentages? Defaults to `TRUE`, otherwise
#' results are shown in decimals.
#' @description A convenient way to obtain percent missingness columnwise.
#' @return An object of the same class as x showing the percentage of missing values.
#' @examples
#' percent_missing(airquality)
#' # show decimals
#' percent_missing(airquality, percent = FALSE)
#' @export

percent_missing <- function(x, percent = TRUE){
  UseMethod("percent_missing")
}

#' @export
percent_missing.data.frame <- function(x, percent = TRUE){

  if(percent){
    purrr::map_dbl(x, ~sum(is.na(.x))/ length(.x) * 100)
  }
  else{
    purrr::map_dbl(x, ~sum(is.na(.x))/ length(.x))
  }
}
