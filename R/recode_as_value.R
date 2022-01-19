#' Recode a value as another value 
#' @description This provides a convenient way to convert a number/value to 
#' another value. 
#' @param df A data.frame object for which recoding is to be done.
#' @param value The value/vector of values to convert. 
#' @param replacement_value New value. 
#' @param subset_cols An optional character vector to define columns for which changes 
#' are required.
#' @param pattern_type One of contains', 'starts_with' or 'ends_with'.
#' @param pattern A character pattern to match
#' @param case_sensitive Defaults to FALSE. Patterns are case insensitive if TRUE
#' @param ... Other arguments to other functions
#' @return An object of the same class as x with values changed to `NA`.
#' @examples
#' head(recode_as_value(airquality,
#' value=c(67,118),replacement=NA, pattern_type="starts_with",pattern="S|O"))


#' @export

recode_as_value <- function(df, value=NULL,
                          replacement_value = NULL, 
                         subset_cols = NULL,
                         pattern_type=NULL,
                         pattern=NULL,case_sensitive=FALSE,...){
  UseMethod("recode_as_value")
}

#' @export
recode_as_value.data.frame <-function(df, value=NULL,
                                   replacement_value = NULL,
                                   subset_cols = NULL,
                                   pattern_type=NULL,
                                   pattern=NULL,case_sensitive=FALSE,...){
  
  recode_df <- function(x){
    if(is.factor(x)){
      warning("Factor columns converted to character.")
      x <- as.character(x)
    }
    ifelse(x %in% value, replacement_value, x)
  }
  
  final_res <- data.frame(sapply(df, function(x) recode_df(x)))
  
  if(all(!is.null(subset_cols), !is.null(pattern_type))){
    
    stop("Only one of pattern_type or subset_cols should be used but not both.")
  }
  
  if(!is.null(subset_cols)){
    
    check_column_existence(df, subset_cols, unique_name = "to subset")
    
    make_pattern <-paste(subset_cols,collapse="|")
    
    final_res<-recode_helper(df,pattern_type="contains",original_value=value,
                             pattern=make_pattern,
                             new_value=replacement_value,
                             case_sensitive=case_sensitive,...)
  }
  
  if(!is.null(pattern_type)){
    
    if(any(!pattern_type %in% c("starts_with","ends_with","contains",
                                "regex"))){
      
      stop("pattern_type should be one of starts_with,ends_with,contains or regex")
    }
    
    if(is.null(pattern)) stop("A pattern must be supplied.")
    
    final_res<-recode_helper(df,pattern_type=pattern_type,
                             original_value=value,
                             pattern=pattern,
                             new_value=replacement_value,
                             case_sensitive=case_sensitive,...)
  }
  
  
  
  final_res
  
}


