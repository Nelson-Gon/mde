# conditional NA recoding
# Recode as NA or recode NA as if a value meets some conditions
# Equals not implemented because that is what recode_as_na does
#' Recode Values as NA if they meet defined criteria
#' @inheritParams recode_na_as
#' @param df A data.frame object to manipulate
#' @param subset_cols An optional character vector for columns to manipulate. 
#' @param criteria One of gt,gteq,lt,lteq to define greater than, greater than or equal to,
#' less than or less than or equal to.
#' @importFrom  dplyr mutate_all mutate_at
#' @return A data.frame object with the required changes.
#' @examples 
#' recode_as_na_for(airquality,value=36, criteria = "gteq",
#' subset_cols = c("Ozone","Solar.R"))
#' @export
recode_as_na_for <- function(df, criteria="gt",value=0,
                             subset_cols = NULL){
  UseMethod("recode_as_na_for")
}

#' @export

recode_as_na_for.data.frame <- function(df, criteria="gt",
                                     value=0,
                                     subset_cols=NULL){
  gt <-  df %>% 
    mutate_all(~ifelse(. > value,NA,.))
  gteq <-  df %>% 
    mutate_all(~ifelse(. >= value,NA,.))
  lteq <- df %>% 
    mutate_all(~ifelse(. <= value,NA,.))
  lt =  df %>% 
    mutate_all(~ifelse(. < value,NA,.))
  # Use specific columns
  # Find these columns
  # This is really too repetitive. There must be a simpler way. 
  use_columns_in <- which(names(df) %in% subset_cols)
  
  gteq_subset <- df %>% 
                 mutate_at(use_columns_in,~ifelse(. >= value,NA,
                                                  .))
  lteq_subset <- df %>% 
                 mutate_at(use_columns_in, ~ifelse(. <= value, NA,
                                                   .))
  lt_subset <- df %>% 
               mutate_at(use_columns_in, ~ifelse(. < value,
                                                 NA, .))
  gt_subset <- df %>% 
               mutate_at(use_columns_in, ~ifelse(. > value, 
                                                 NA, .))
  
  if(is.null(subset_cols)){
    switch(criteria,
           gt = gt,
           gteq = gteq,
           lteq = lteq,
           lt = lt)
  }
  
  else{
    switch(criteria,
           gt = gt_subset,
           gteq = gteq_subset,
           lt = lt_subset,
           lteq = lteq_subset)
  }
 
}



