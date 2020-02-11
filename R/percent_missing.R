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
  if(is.null(exclude_cols)){

    df %>%
      dplyr::group_by(!!!dplyr::syms(grouping_cols)) %>%
      dplyr::summarise_all(~ sum(is.na(.))/length(.) * 100)

  }

  else{
    df %>%
      dplyr::group_by(!!!dplyr::syms(grouping_cols)) %>%
      dplyr::summarise_at(dplyr::vars(-exclude_cols),
                          ~ sum(is.na(.))/length(.) * 100)
  }


  }


else{
if(is.null(exclude_cols)){
  purrr::map_dbl(df, ~sum(is.na(.x))/ length(.x) * 100)
}
  else{
    to_remove <- which(names(df) %in% exclude_cols)
    purrr::map_dbl(df[-to_remove],
                  ~sum(is.na(.x))/ length(.x) * 100)
  }

}


}
