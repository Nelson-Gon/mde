#' Recode a value as NA
#' @description This provides a convenient way to convert a number/value that should indeed be an
#' "NA" to "NA". In otherwords, it converts a value to R's recognized NA.
#' @param df A data.frame object for which recoding is to be done.
#' @param value The value to convert to `NA`. We can for instance change "n/a" to `NA` or any other value.
#' @param subset_cols An optional character vector to define columns for which changes are required.
#' @param pattern_type One of contains', 'starts_with' or 'ends_with'.
#' @param pattern A character pattern to match
#' @param case_sensitive Defaults to FALSE. Patterns are case insensitive if TRUE
#' @param ... Other arguments to other functions
#' @return An object of the same class as x with values changed to `NA`.
#' @examples
#' head(recode_as_na(airquality,value=c(67,118),pattern_type="starts_with",pattern="S|O"))
#' head(recode_as_na(airquality,value=c(41),pattern_type="ends_with",pattern="e"))
#' head(recode_as_na(airquality, value=41,subset_cols="Ozone"))

#' @export

recode_as_na <- function(df, value=NULL,
                         subset_cols = NULL,
                         pattern_type=NULL,
                         pattern=NULL,case_sensitive=FALSE,
                         ...){
  UseMethod("recode_as_na")
}

#' @export
recode_as_na.data.frame <-function(df, value=NULL,
                                   subset_cols = NULL,
                                   pattern_type=NULL,
                                   pattern=NULL,
                                   case_sensitive=FALSE,
                                  
                                   ...){
  
 
recode_as_value(df=df, value=value, 
                replacement_value = NA,
                subset_cols=subset_cols,
                pattern_type = pattern_type,
                pattern = pattern, 
                case_sensitive = case_sensitive,
                ...)
}


