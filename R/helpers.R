# Tidy recoding: Hardcoded(dplyr less flexible)


recode_selectors <- function(x,pattern_type=NULL,pattern=NULL){

 columns_start_with<-grep(paste0("^(",pattern,")",collapse = ""),names(x))
 columns_end_with <- grep(paste0("(",pattern,")$",collapse = ""),names(x))
 columns_contain <- grep(pattern,names(x))
 regex <- columns_contain

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
                          new_value,...){
x %>%
  mutate(across(recode_selectors(x,pattern=pattern,pattern_type=pattern_type,
                                 ...),~ifelse(. %in% original_value, new_value,.)))

}




