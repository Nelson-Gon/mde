#' @title  Recode Missing Values Dictionary-Style
#' @inheritParams recode_na_as 
#' @param patterns A vector containing patterns to use for pattern_type
#' @param values A vector containing values to match to the patterns vector
#' @return A `data.frame` object with replacements as required. 
#' @examples 
#' head(dict_recode(airquality, pattern_type="starts_with",
#' patterns = c("Solar", "Ozone"), values = c(420, 42)))
#' @export

dict_recode <- function(df, 
                        pattern_type="starts_with", 
                        patterns,
                        values){
  UseMethod("dict_recode")
}

#' @export

dict_recode.data.frame <- function(df, 
                                   pattern_type="starts_with",
                                   patterns,
                                   values){
 

  
# Perform replacement with column-value pair 
  
dict_recoded <- Map(function(pat, val) {
# Get the current column   
cur_col <-recode_selectors(names(df),
                    pattern_type = pattern_type,
                   pattern=pat, 
                   column_check=FALSE)

recode_na_as(df,
             pattern_type = pattern_type,
             pattern = pat, 
             value= val)[cur_col]}, patterns, values)


# Convert to a data.frame object from a list of vectors 

final_res <- do.call("data.frame", dict_recoded)

# replace these in the original dataset 

df[names(final_res)] <- final_res 

df  

}



