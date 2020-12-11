# Tidy recoding: Hardcoded(dplyr less flexible)

# This is for use with na_summary
# Will need to figure out how to avoid it, later
# metric here is just a name that actually means nothing
utils::globalVariables(c("all_of","metric","value","name", ":="))
# .....

#' @title Helper functions in package mde
#' @inheritParams recode_na_as
#' @param x data.frame object
#' @param column_check If TRUE, pattern search is performed columnwise. Defaults to FALSE.
#' @export
recode_selectors <- function(x,column_check=TRUE,pattern_type=NULL,pattern=NULL,case_sensitive=FALSE,...){
# If using for column checks, use names


if (!is.null(pattern_type)) {
  if (!pattern_type %in% c("starts_with","ends_with","contains","regex")){
stop("pattern_type should be one of starts_with,ends_with,contains or regex")
  }
if(is.null(pattern)) stop("Both a pattern type and pattern should be provided..")

}


use_pattern <- switch(pattern_type,
                        ends_with = paste0(pattern,"$",collapse = ""),
                        starts_with = paste0("^",pattern,collapse=""),
                        contains = pattern,
                        regex = pattern)
  if (column_check) {

    grep(use_pattern,names(x),ignore.case = !case_sensitive,...)

  }

  else{
    grepl(use_pattern,x,ignore.case = !case_sensitive,...)
  }

}


# make changes
#' @title Helper functions in package mde
#' @param x A data.frame object
#' @param original_value Value to replace
#' @param new_value Replacement value.
#' @inheritParams recode_selectors
#' @export

recode_helper <- function(x,pattern_type=NULL,pattern=NULL,original_value, new_value,case_sensitive=FALSE,...){
x %>%
  mutate(across(recode_selectors(x,column_check=TRUE,
                                 pattern=pattern,pattern_type=pattern_type,case_sensitive = case_sensitive,
                                 ...),~ifelse(. %in% original_value, new_value,.)))

}

#' Checks that all values are NA
#' @param x A vector or data.frame column
#' @description This is a helper function to check if all column/vector values are NA
#' @return Boolean TRUE or FALSE depending on the nature of the column/vector
#' @examples
#' test <- data.frame(A=c(NA, 2), B= c(NA, NA))
#' all_na(test)
#' test_vec <- c("NA",NA,"nope")
#' test_numeric <- c(NA, 2)
#' all_na(test_vec)
#' all_na(test_numeric)
#' @export


all_na <- function(x) UseMethod("all_na")

#' @export

all_na.data.frame <- function(x){
  sapply(x, all_na)
}

#' @export

all_na.default <- function(x) all(is.na(x))

# skip tests on old releases

skip_on_oldrel <- function(version="3.6.3", msg = NULL) {
  current_version <- utils::packageVersion("base")
  if (current_version <= version) {
    msg <- paste("R version",current_version,
                 "not supported. Please upgrade to R> 3.6.3")
    testthat::skip(msg)
  }
}


get_na_means <- function(x, as_percent=TRUE) UseMethod("get_na_means")



get_na_means.numeric <- function(x, as_percent=TRUE){
  res <-mean(is.na(x))
  if(as_percent) res<-res * 100
  res
}



get_na_means.character <- get_na_means.numeric

get_na_means.factor <- get_na_means.numeric


get_na_means.data.frame <- function(x, as_percent=TRUE){
  res <- colMeans(is.na(x))
  if(as_percent) res <- res * 100
  res
}

check_column_existence <- function(df, target_columns=NULL, unique_name=NULL){


if(!all(target_columns %in% names(df))) stop(paste0("All columns ", unique_name, " should exist in the data set."))



}

switches <- function(target_value=NULL,sign,percent_na = 50){
  UseMethod("switches")
}

switches.data.frame <- function(target_value=NULL,sign, percent_na = 50){

available_options <- c("gteq","lteq","gt","lt","eq")

if(! sign %in% available_options ) { stop(paste(paste(c("I was expecting one of ",available_options),collapse=" "), "not",sign))

}

 res<- switch(sign,
                   gteq = which(target_value >=percent_na),
                   lteq =  which(target_value <=percent_na),
                   gt =  which(target_value >percent_na),
                   lt = which(target_value <percent_na),
                   eq = which(target_value == percent_na))
 res
}

switches.numeric <- function(target_value=NULL,sign, percent_na = 50){

available_options <- c("gteq","lteq","gt","lt","eq")

if(! sign %in% available_options ) stop(paste(paste(c("I was expecting one of ",available_options),collapse=" "), "not",sign))

res<- switch(sign,
             gteq = target_value >=percent_na,
             lteq =  target_value <=percent_na,
             gt =  target_value >percent_na,
             lt = target_value <percent_na,
             eq = target_value == percent_na)

res
}




