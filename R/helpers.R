# Tidy recoding: Hardcoded(dplyr less flexible)

# This is for use with na_summary
# Will need to figure out how to avoid it, later
# metric here is just a name that actually means nothing
utils::globalVariables(c("all_of","metric","value","name"))
# .....
recode_selectors <- function(x,pattern_type=NULL,pattern=NULL,case_sensitive=FALSE,...){

 columns_start_with<-grep(paste0("^(",pattern,")",collapse = ""),names(x),ignore.case=case_sensitive)
 columns_end_with <- grep(paste0("(",pattern,")$",collapse = ""),names(x),ignore.case = case_sensitive)
 columns_contain <- grep(pattern,names(x),ignore.case = case_sensitive)
 regex <- grep(pattern,names(x),...)

final_selectors <- switch(pattern_type,
       starts_with = columns_start_with,
       ends_with = columns_end_with,
       contains = columns_contain,
       regex = columns_contain
       )
final_selectors
}
# make changes
recode_helper <- function(x,pattern_type=NULL,pattern=NULL,original_value,
                          new_value,case_sensitive=FALSE,...){
x %>%
  mutate(across(recode_selectors(x,pattern=pattern,pattern_type=pattern_type,case_sensitive = case_sensitive,
                                 ...),~ifelse(. %in% original_value, new_value,.)))

}


# skip tests on old releases

skip_on_oldrel <- function(version="3.6.3", msg = NULL) {
  current_version <- utils::packageVersion("base")
  if (current_version <= version) {
    msg <- paste("R version",current_version,
                 "not supported. Please upgrade to R> 3.6.3")
    testthat::skip(msg)
  }
}


