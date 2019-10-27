#' Recode a value as NA
#' @description This provides a convenient way to convert a number/value that should indeed be an 
#' "NA" to "NA". In otherwords, it converts a value to R's recognized NA.
#' @inheritParams get_na_counts
#' @param value The value to convert to `NA`. We can for instance change "n/a" to `NA` or any other value.
#' @param subset Logical. Use only specific columns? Defaults to FALSE. All "value"s everywhere are "recoded".
#' @param subset_cols Vector. If subset_df is TRUE, then this provides the columns for which changes are required.
#' @return An object of the same class as x with values changed to `NA`.
#' @export

recode_as_na <- function(x, value=NULL, subset = FALSE,
                         subset_cols = NULL){
  UseMethod("recode_as_na")
}

#' @export
recode_as_na <- function(x, value=NULL, subset_df = FALSE,
                         subset_cols = NULL){
  if(subset_df){
    # Change values only at specific columns, not all
    # Currently uses contains, this might be a bad idea
    # Perhaps just use vars?
    
    x %>% 
      dplyr::mutate_at(dplyr::vars(subset_cols),
                            function(x) ifelse(x == value, NA, x))
                       
  }
  else{
    x %>% 
      dplyr::mutate_all(list(function(x) ifelse(x == value, NA, x)))
    
  }
}
