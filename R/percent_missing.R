#' Column-wise missingness percentages
#' @param df A valid R `object` for which the percentage of missing values is 
#' required.
#' @param exclude_cols A character vector indicating columns to exclude when 
#' returning results.
#' @description A convenient way to obtain percent missingness column-wise.
#' @inheritParams get_na_counts
#' @return An object of the same class as x showing the percentage of missing 
#' values.
#' @examples
#' test <- data.frame(ID= c("A","B","A","B","A","B","A"), 
#' Vals = c(NA,25,34,NA,67,NA,45))
#' percent_missing(test,grouping_cols = "ID")
#' percent_missing(airquality)
#' percent_missing(airquality,exclude_cols = c("Day","Temp"))
#' @export

percent_missing <- function(df, grouping_cols = NULL,exclude_cols = NULL){
  UseMethod("percent_missing")
}

#' @export

percent_missing.default <- function(df, grouping_cols = NULL,exclude_cols = NULL){
  stop(paste0("percent_missing not available for objects of class ",
              class(df)[1], ". Try 'percent_na(x)' instead."))
}

#' @export
percent_missing.data.frame <- function(df,  grouping_cols = NULL,
                                       exclude_cols = NULL){


if(!is.null(grouping_cols)){

check_column_existence(df, grouping_cols, unique_name = "to group by")

df <-   df %>% dplyr::group_by(!!!dplyr::syms(grouping_cols))

}

if(! is.null(exclude_cols)){

check_column_existence(df, exclude_cols, "to exclude")


  df <- df %>% dplyr::select(-dplyr::all_of(exclude_cols))


}

  df %>% dplyr::summarise(across(everything(),
                                 ~ get_na_means(.))) %>% dplyr::ungroup()

}
#' percent missing but for vectors. 
#' @inheritParams get_na_means
#' @examples 
#' percent_na(airquality$Ozone)
#' @export

percent_na <- function(x) UseMethod("percent_na")
#' @export 
percent_na.numeric <- function(x) mean(is.na(x)) * 100
#' @export
percent_na.factor <- percent_na.numeric 
#' @export
percent_na.character <- percent_na.numeric 
#' @export
percent_na.POSIXct <- percent_na.numeric 




