#' Add columnwise counts of missing values
#' @param x A valid R `object` for which `na_counts` are needed.
#' @description This function takes a `data.frame` object as an input and returns the corresponding
#' `NA` counts. `NA` refers to R's builtin missing data holder.
#' @return An object of the same type as `x` showing the respective number of missing values.
#' @examples
#' get_na_counts(airquality)
#' @export

get_na_counts <- function(x){
  UseMethod("get_na_counts")
}

#' @export

get_na_counts.data.frame <- function(x){
  lengths(sapply(x,function(column) which(is.na(column))))
}
