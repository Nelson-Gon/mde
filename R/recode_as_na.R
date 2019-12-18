#' Recode a value as NA
#' @description This provides a convenient way to convert a number/value that should indeed be an
#' "NA" to "NA". In otherwords, it converts a value to R's recognized NA.
#' @inheritParams get_na_counts
#' @param value The value to convert to `NA`. We can for instance change "n/a" to `NA` or any other value.
#' @param subset_df Logical. Use only specific columns? Defaults to FALSE. All "value"s everywhere are "recoded".
#' @param subset_cols Vector. If subset_df is TRUE, then this provides the columns for which changes are required.
#' @return An object of the same class as x with values changed to `NA`.
#' @examples
#' dummy_test <- data.frame(ID = c("A","B","B","A"),
#' values = c("n/a",NA,"Yes","No"))
#' # Replace n/a with "NA". We assume n/a is treated as missing(subjective)
#' recode_as_na(dummy_test,"n/a")
#' # Recode only at specific columns
#' another_dummy <- data.frame(ID = 1:5, Subject = 7:11,
#' Change = c("missing", "n/a", 2:4 ))
#' # Change missing and n/a to NA only for the column named Change.
#' recode_as_na(another_dummy, subset_df = TRUE,
#' subset_cols = "Change", value = c("n/a",
#'                               "missing"))
#' @export

recode_as_na <- function(x, value=NULL, subset_df = FALSE,
                         subset_cols = NULL){
  UseMethod("recode_as_na")
}

#' @export
recode_as_na.data.frame <- function(x, value=NULL, subset_df = FALSE,
                         subset_cols = NULL){
  if(subset_df){
    # Change values only at specific columns, not all
    # Currently uses contains, this might be a bad idea
    # Perhaps just use vars?
    if(!all(subset_cols %in% names(x))){
      stop("Some names not found in the dataset. Please check and try again.")
    }
else{
    x %>%
      dplyr::mutate_at(dplyr::vars(subset_cols),
                            function(x) ifelse(x %in% value, NA,
                                               x))
}

  }
  else{
    x %>%
      dplyr::mutate_all(list(function(x) ifelse(x %in% value, NA, x)))

  }
}
