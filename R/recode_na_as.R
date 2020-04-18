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


if(!is.null(subset_cols)){

 if(!is.null(pattern_type)){
    stop("Only one of pattern_type or subset_cols should be used but not both.")
  }


if(!all(subset_cols %in% names(df))){
   stop("Some names not found in the dataset. Please check and try again.")
}


df %>%
      dplyr::mutate(across(!!!c(dplyr::syms(subset_cols)),
                           ~replace(.,is.na(.), value)))




}


else if(!is.null(pattern_type)){

  if(!pattern_type %in% c("starts_with", "ends_with","contains")){
    stop("pattern_type should be one of starts_with, ends_with or contains.")
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
  df %>%
    dplyr::mutate(across(everything(), ~replace(., is.na(.), value)))
}

}
