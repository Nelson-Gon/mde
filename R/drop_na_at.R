#' Drop missing values at columns that match a given pattern
#' @description Provides a simple yet efficient way to drop missing values("NA"s) at
#' columns that match a given pattern.
#' @param x A data.frame object
#' @param pattern_type One of "contains", "ends_with" or "starts_with"
#' @param pattern The type of pattern to use when matching the pattern_type. The pattern is case sensitive
#' @param ... Other params to other methods
#' @return A data.frame object containing only columns that match the given pattern with the missing values removed.
#' @examples 
#' drop_na_at(airquality,pattern_type = "starts_with","O")
#' @export

drop_na_at <- function(x, pattern_type="contains",pattern=NULL,
                       ...){
  UseMethod("drop_na_at")
}

#' @export

drop_na_at.data.frame <- function(x, pattern_type="contains",
                                  pattern=NULL,...){
 
  # First start with case sensitive
  # Of course you can do this with dplyr/rlang
  # Just trying to stick with base as much as possible
  # First check if all NA sums are equal
  
  column_ends_with <- function(df=x) {
    # Get columns that match this pattern
    # Check their NA counts
    # Check if counts are equal, proceed, do not otherwise
    
   columns_to_use <- df[endsWith(names(x),
                     pattern)]
   na_counts <- get_na_counts(columns_to_use)
   na_counts_test <- all(na_counts == unname(na_counts)[1])
   if(all(na_counts_test)){
     res <- stats::na.omit(columns_to_use)
     row.names(res) <- 1:nrow(res)
     res
   }
   else{
     stop("Unequal number of missing values, cannot rebind data. Please check with get_na_counts first")
   }
  
  }
  column_starts_with <- function(df=x){
    columns_to_use <- df[startsWith(names(x),
                                  pattern)]
    na_counts <- get_na_counts(columns_to_use)
    na_counts_test <- all(na_counts == unname(na_counts)[1])
    if(all(na_counts_test)){
      res <- stats::na.omit(columns_to_use)
      row.names(res) <- 1:nrow(res)
      res
    }
    else{
      stop("Unequal number of missing values, cannot rebind data. Please check with get_na_counts first")
    }

    
  }
  column_contains_string <-function(df = x,...){
    columns_to_use <- df[grepl(pattern,
                               names(x),...)]
    na_counts <- get_na_counts(columns_to_use)
    na_counts_test <- all(na_counts == unname(na_counts)[1])
    if(all(na_counts_test)){
      res <- stats::na.omit(columns_to_use)
      row.names(res) <- 1:nrow(res)
      res
    }
    else{
      stop("Unequal number of missing values, cannot rebind data. Please check with get_na_counts first")
    }
 
    
  }
  
  switch(pattern_type,
         ends_with = column_ends_with(),
         starts_with = column_starts_with(),
         contains = column_contains_string())
  
}