#' Add columnwise/groupwise counts of missing values
#' @param x A valid R `object` for which `na_counts` are needed.
#' @param grouping_cols A character vector. If supplied, one can provide the columns by which to group the
#' data.
#' @description This function takes a `data.frame` object as an input and returns the corresponding
#' `NA` counts. `NA` refers to R's builtin missing data holder.
#' @importFrom magrittr %>%
#' @return An object of the same type as `x` showing the respective number of missing values. If
#' grouped is set to `TRUE`, the results are returned by group.
#' @examples
#' get_na_counts(airquality)
#' # Grouped counts
#' test <- data.frame(Subject = c("A","A","B","B"), res = c(NA,1,2,3),
#' ID = c("1","1","2","2"))
#' get_na_counts(test,grouping_cols =
#'                         c("ID", "Subject"))
#' @export

get_na_counts <- function(x, grouping_cols = NULL){
  UseMethod("get_na_counts")
}

#' @export

get_na_counts.data.frame <- function(x, grouping_cols = NULL){

if(! is.null(grouping_cols)){

  x %>%
    dplyr::group_by(!!!dplyr::syms(grouping_cols)) %>%
    dplyr::summarise_all(list(function(column) sum(is.na(column))))

}

  else{

    lengths(sapply(x,function(column) which(is.na(column))))
  }

}
