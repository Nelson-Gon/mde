#' Replace missing values with another value
#' @description This provides a convenient way to recode "NA" as another value for instance "NaN", "n/a" or
#' any other value a user wishes to use.
#' @inheritParams recode_as_na
#' @return An object of the same type as x with NAs replaced with the desired value.
#' @examples
#' head(recode_na_as(airquality, "n/a"))
#' head(recode_na_as(airquality, subset_cols = "Ozone", value = "N/A"))
#' head(recode_na_as(airquality, value=0, pattern_type="starts_with",
#' pattern="solar",ignore.case=TRUE))
#' @export

recode_na_as <-  function(df, value=0,
                          subset_cols = NULL,
                          pattern_type= NULL,
                          pattern=NULL,
                          ...) {
  UseMethod("recode_na_as")

}

#' @export

recode_na_as.data.frame <- function(df, value=0,
                                    subset_cols = NULL,
                                    pattern_type= NULL,
                                    pattern=NULL,
                                    ...){
  # Use a purely base solution, there are no trophies for that
  # but yeah
  if(!is.null(subset_cols)){

if(!all(subset_cols %in% names(df))){
   stop("Some names not found in the dataset. Please check and try again.")
    }

else{
    which_to_subset <- which(names(df) %in% subset_cols)
    # which is.na
  df[,which_to_subset] <-  sapply(df[,which_to_subset], function(column)
                replace(column,is.na(column),value))
  df
    }
  }

else if (!is.null(pattern_type)){

  if(all(!is.null(subset_cols), !is.null(pattern_type))){
    stop("Only one of pattern_type or subset_cols should be used but not both.")
  }
  switch(pattern_type,
         starts_with = recode_na_as_starts_with(x=df,
                                                pattern=pattern,
                                                value=value,
                                                ...),
         ends_with = recode_na_as_ends_with(x=df,
                                            pattern=pattern,
                                            value=value,
                                            ...),
         contains = recode_na_as_contains(x=df,
                                          pattern=pattern,
                                          value=value,
                                          ...))
}

  else{
    # Can use dplyr, this looks a bit ugly

    as.data.frame(sapply(df, function(column)
      replace(column,is.na(column),value)))
  }


}
