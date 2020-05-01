#' Recode a value as NA
#' @description This provides a convenient way to convert a number/value that should indeed be an
#' "NA" to "NA". In otherwords, it converts a value to R's recognized NA.
#' @param df A data.frame object for which recoding is to be done.
#' @param value The value to convert to `NA`. We can for instance change "n/a" to `NA` or any other value.
#' @param subset_cols An optional character vector to define columns for which changes are required.
#' @param pattern_type One of contains', 'starts_with' or 'ends_with'.
#' @param pattern A character pattern to match
#' @param ... Other arguments to other functions
#' @return An object of the same class as x with values changed to `NA`.
#' @examples
#' dummy_test <- data.frame(ID = c("A","B","B","A"),
#' values = c("n/a",NA,"Yes","No"))
#' # Replace n/a with "NA". We assume n/a is treated as missing(subjective)
#' recode_as_na(dummy_test,"n/a")
#' # Recode only at specific columns
#' another_dummy <- data.frame(ID = 1:5, Subject = 7:11,
#' Change = c("missing", "n/a", 2:4 ), stringsAsFactors = FALSE)
#' # Change missing and n/a to NA only for the column named Change.
#' recode_as_na(another_dummy, subset_cols = "Change", value = c("n/a",
#'                               "missing"))
#'  head(recode_as_na(airquality,pattern_type="starts_with",
#' pattern="Solar"))

#' @export

recode_as_na <- function(df, value=NULL,
                         subset_cols = NULL,
                         pattern_type=NULL,
                         pattern=NULL,...){
  UseMethod("recode_as_na")
}

#' @export
recode_as_na.data.frame <-function(df, value=NULL,
                                   subset_cols = NULL,
                                   pattern_type=NULL,
                                   pattern=NULL,...){
  if(any(sapply(df,is.factor))){
    warning("Factor columns have been converted to character")
  }

  throw_both_subset_and_pattern_error()
  if(!is.null(subset_cols)){
    if(! all(subset_cols %in% names(df))){
      stop("Some names not found in the dataset. Please check and try again.")
    }

df %>%
        dplyr::mutate(across(subset_cols,
          ~ifelse(. %in% value, NA, as.character(.))))
  }

  if(!is.null(pattern_type)){
    if(any(!pattern_type %in% c("starts_with","ends_with","contains",
                                "regex"))){

      stop("pattern_type should be one of starts_with,ends_with,contains or regex")
    }
    if(is.null(pattern)) stop("A pattern must be supplied.")
    recode_helper(df,pattern_type=pattern_type,original_value=value,pattern=pattern,
                  new_value=NA)
  }



}


