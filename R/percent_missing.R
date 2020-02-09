#' Columnwise missingness percentages
#' @param df A valid R `object` for which the percentage of missing values is required.
#' @description A convenient way to obtain percent missingness columnwise.
#' @inheritParams get_na_counts
#' @return An object of the same class as x showing the percentage of missing values.
#' @examples
#' test <- data.frame(ID= c("A","B","A","B","A","B","A"), Vals = c(NA,25,34,NA,67,NA,45))
#' percent_missing(test,grouping_cols = "ID")
#' percent_missing(airquality)
#' @export

percent_missing <- function(df,  grouping_cols = NULL){
  UseMethod("percent_missing")
}

#' @export
percent_missing.data.frame <- function(df,  grouping_cols = NULL
                                       ){


if(!is.null(grouping_cols)){
    df %>%
      dplyr::group_by(!!!dplyr::syms(grouping_cols)) %>%
      dplyr::summarise_all(~ sum(is.na(.))/length(.) * 100)

  }


else{

purrr::map_dbl(df, ~sum(is.na(.x))/ length(.x) * 100)
}


}
