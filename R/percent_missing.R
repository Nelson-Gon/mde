#' Columnwise missingness percentages
#' @param df A valid R `object` for which the percentage of missing values is required.
#' @param exclude_cols A character vector indicating columns to exclude when returning results.
#' @description A convenient way to obtain percent missingness columnwise.
#' @inheritParams get_na_counts
#' @return An object of the same class as x showing the percentage of missing values.
#' @examples
#' test <- data.frame(ID= c("A","B","A","B","A","B","A"), Vals = c(NA,25,34,NA,67,NA,45))
#' percent_missing(test,grouping_cols = "ID")
#' percent_missing(airquality)
#' percent_missing(airquality,exclude_cols = c("Day","Temp"))
#' @export

percent_missing <- function(df,  grouping_cols = NULL,
                            exclude_cols = NULL){
  UseMethod("percent_missing")
}

#' @export
percent_missing.data.frame <- function(df,  grouping_cols = NULL,
                                       exclude_cols = NULL
                                       ){


if(!is.null(grouping_cols)){
  if(!all(grouping_cols %in% names(df))){
    stop("All grouping columns should exist in the dataset")
  }

  df <-   df %>%
    dplyr::group_by(!!!dplyr::syms(grouping_cols))

}

if(! is.null(exclude_cols)){
  if(any(!exclude_cols %in% names(df))){
    stop("Can only exclude columns that exist in the dataset.")
  }

  df <- df %>%
        dplyr::select(-exclude_cols)


}

  df %>%
    dplyr::summarise(across(everything(),~ sum(is.na(.))/length(.) * 100)) %>%
    dplyr::ungroup()



}





