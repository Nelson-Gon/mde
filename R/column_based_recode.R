#' Recode NA as based on Other Columns
#' @param  values_from Character. Name of column to get the original values from
#' @param criterion Currently supports one of all_na or any_na to index rows that are either all NA or contain any NA.
#' @param values_to  Character New column name for the newly recoded values. Defaults to the same name if none is supplied.
 #' @inheritParams recode_as_na 
#' @title Conditionally Recode NA values based on other Columns 
#' @return A `data.frame` object with target `NA` values replaced.
#' @examples 
#' df <- structure(list(id = 40:43, v1 = c(NA, 1L, 1L, 1L), v2 = c(NA, 1L, 1L, 1L), v3 = c(NA, 2L, NA, 1L), 
#' test = c(1L, 2L, 1L, 3L)), class = "data.frame", row.names = c(NA, -4L))
#' # recode test as 0 if all NA, return test otherwise
#'  column_based_recode(df,values_from = "test", pattern_type = "starts_with", pattern="v")
#'  @export

column_based_recode <- function(df, criterion="all_na", values_from=NULL, 
                                values_to=NULL, value=0, pattern_type="contains",pattern="Solar",
                                case_sensitive = FALSE){
  UseMethod("custom_based_recode")
  
}

#' @export

column_based_recode.data.frame <- function(df, criterion="all_na", values_from=NULL, 
                                values_to=NULL, value=0, pattern_type="contains",pattern="Solar",
                                case_sensitive = FALSE){

if(is.null(values_to)) values_to = values_from

use_these_columns <- recode_selectors(df, pattern_type = pattern_type, pattern = pattern, case_sensitive = case_sensitive)

df %>% 
    mutate(!!values_to := ifelse(apply(df[use_these_columns],1, function(x) all(is.na(x))),value, !!dplyr::sym(values_from)))
 


}
