#' @title  Recode Missing Values Dictionary-Style
#' @inheritParams recode_na_as 
#' @param patterns A vector containing patterns to use for pattern_type
#' @param values A vector containing values to match to the patterns vector
#' @param use_func Function to use for the recoding. One of the various 
#' `recode_*` functions in package `mde`. 
#' @return A `data.frame` object with replacements as required.
#' @examples 
#' head(dict_recode(airquality, pattern_type="starts_with",
#' patterns = c("Solar", "Ozone"), values = c(190, 41),
#' use_func="recode_as_na"))
#'  head(dict_recode(airquality, pattern_type="starts_with",
#' patterns = c("Solar", "Ozone"), values = c(42, 420),
#' use_func="recode_na_as"))
#' @export

dict_recode <- function(df, 
                        use_func= "recode_na_as",
                        pattern_type="starts_with", 
                        patterns,
                        values){
 
  UseMethod("dict_recode")
}

#' @export

dict_recode.data.frame <- function(df, 
                                   use_func = "recode_na_as",
                                   pattern_type="starts_with",
                                   patterns,
                                   values){

# Check that provided function is actually a function 
if(!exists(use_func, where = "package:mde")){
  
# This assumes that we load mde first.
# It may be possible to use getfromNamespace or get or some other variant
# tryCatch would be best but it fails if used inside a function. 
stop(paste0(use_func, " is not a valid function in package mde."))
  
}
 
  


dict_recoded <- Map(function(pat, val) {
 

cur_col <-recode_selectors(names(df),
                    pattern_type = pattern_type,
                   pattern=pat, 
                   column_check=FALSE)

do.call(use_func, list(df=df, pattern_type=pattern_type,
                             pattern=pat,value=val))[cur_col]

}, 
patterns, values)


# Convert to a data.frame object from a list of vectors 

final_res <- do.call("data.frame", dict_recoded)

# replace these in the original dataset 

df[names(final_res)] <- final_res 

df  
}
 




