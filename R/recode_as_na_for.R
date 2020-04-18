# conditional NA recoding
# Recode as NA or recode NA as if a value meets some conditions
# Equals not implemented because that is what recode_as_na does
#' Recode Values as NA if they meet defined criteria
#' @inheritParams recode_na_as
#' @param df A data.frame object to manipulate
#' @param subset_cols An optional character vector for columns to manipulate.
#' @param criteria One of gt,gteq,lt,lteq to define greater than, greater than or equal to,
#' less than or less than or equal to.
#' @importFrom  dplyr mutate
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



if(is.null(subset_cols)){
  if(! criteria %in% c("gt", "gteq","lt","lteq","eq")){
    stop("criteria should be one of gteq, lt, lteq,gteq or eq.")
  }
    gt <-  df %>%
      mutate(across(everything(),~replace(., .> value, NA)))
    gteq <-  df %>%
      mutate(across(everything(), ~replace(. , . >= value, NA)))
    lteq <- df %>%
      mutate(across(everything(), ~replace(. , . <= value, NA)))
    lt =  df %>%
      mutate(across(everything(), ~replace(., . < value, NA)))
    eq =  df %>%
      mutate(across(everything(), ~replace(., . == value, NA)))
    switch(criteria,
           gt = gt,
           gteq = gteq,
           lteq = lteq,
           lt = lt,
           eq = eq)
  }

  else{
  if(!all(subset_cols %in% names(df))){
    stop("All subset_cols should exist in the data set.")
  }
    gteq_subset <- df %>%
      mutate(across(subset_cols,~ifelse(. >= value,NA,
                                        .)))
    lteq_subset <- df %>%
      mutate(across(subset_cols, ~ifelse(. <= value, NA,
                                         .)))
    lt_subset <- df %>%
      mutate(across(subset_cols, ~ifelse(. < value,
                                         NA, .)))
    gt_subset <- df %>%
      mutate(across(subset_cols, ~ifelse(. > value,
                                         NA, .)))
    eq_subset <- df %>%
      mutate(across(subset_cols, ~ifelse(. == value,
                                         NA, .)))
    switch(criteria,
           gt = gt_subset,
           gteq = gteq_subset,
           lt = lt_subset,
           lteq = lteq_subset,
           eq = eq_subset)
  }

}



