#' Recode as NA based on string match
#' @inheritParams recode_as_na
#' @param df A data.frame object
#' @param ... Other arguments to grepl 
#' @seealso \code{\link{recode_as_na}} \code{\link{recode_as_na_if}} 
#' @examples 
#' partial_match <- data.frame(A=c("Hi","match_me","nope"), B=c(NA, "not_me","nah"))
#' # Replace all that end with "me" with NA
#' recode_as_na_str(partial_match,"ends_with","me")
#' # Do not recode, ie case-sensitive
#' recode_as_na_str(partial_match,"ends_with","ME", case_sensitive=TRUE)

#' @export

recode_as_na_str <- function(df, pattern_type="ends_with",pattern=NULL,case_sensitive=FALSE,...){
  UseMethod("recode_as_na_str")
}

#' @export

recode_as_na_str.data.frame <- function(df,pattern_type="ends_with",pattern=NULL,case_sensitive=FALSE,...){
  # This is currently not the best way, a prototype that JustWorks^^TM
  
data.frame(sapply(df, function(x) ifelse(recode_selectors(x,column_check = FALSE,pattern_type=pattern_type,
                                                          pattern=pattern,
                                                          case_sensitive = case_sensitive,
                                                          ...
                                                          ),NA,x)))
}