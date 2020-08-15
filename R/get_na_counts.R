#' Add columnwise/groupwise counts of missing values
#' @param x A valid R `object` for which `na_counts` are needed.
#' @param grouping_cols A character vector. If supplied, one can provide the columns by which to group the
#' data.
#' @param exclude_cols Columns to exclude from the analysis.
#' @description This function takes a `data.frame` object as an input and returns the corresponding
#' `NA` counts. `NA` refers to R's builtin missing data holder.
#' @importFrom dplyr %>%
#' @importFrom dplyr starts_with ends_with contains across everything
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

get_na_counts <- function(x, grouping_cols = NULL, exclude_cols=NULL){
  UseMethod("get_na_counts")
}

#' @export

get_na_counts.data.frame <- function(x, grouping_cols = NULL, exclude_cols = NULL){

if(! is.null(grouping_cols)){
if(any(!grouping_cols %in% names(x))){
  stop("All grouping columns must exist in the data set")
}
  x <- x %>%
    dplyr::group_by(!!!dplyr::syms(grouping_cols))

}

if(! is.null(exclude_cols)){
    if(any(!exclude_cols %in% names(x))){
      stop("Can only exclude columns that exist in the dataset.")
    }

    x <- x %>%
      dplyr::select(-all_of(exclude_cols))


  }

  x %>%
  dplyr::summarise(dplyr::across(dplyr::everything(),
                                 ~sum(is.na(.))))


}

