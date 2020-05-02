#' Replace missing values with another value
#' @description This provides a convenient way to recode "NA" as another value for instance "NaN", "n/a" or
#' any other value a user wishes to use.
#' @inheritParams recode_as_na
#' @return An object of the same type as x with NAs replaced with the desired value.
#' @examples
#' head(recode_na_as(airquality, "n/a"))
#' head(recode_na_as(airquality, subset_cols = "Ozone", value = "N/A"))
#' head(recode_na_as(airquality, value=0, pattern_type="starts_with",pattern="Solar"))
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



if(all(!is.null(subset_cols), !is.null(pattern_type))){
    stop("Only one of pattern_type or subset_cols should be used but not both.")
  }

final_res <-  df %>%
  mutate(across(everything(), ~ifelse(is.na(.),value,.)))

if(!is.null(subset_cols)){

if(!all(subset_cols %in% names(df))){
     stop("Some names not found in the dataset. Please check and try again.")
}

  make_pattern <-paste(subset_cols,collapse="|")

  final_res<-recode_helper(df,pattern_type="contains",original_value=NA,pattern=make_pattern,
                new_value=value)
  }

  if(!is.null(pattern_type)){
    if(any(!pattern_type %in% c("starts_with","ends_with","contains",
                                "regex"))){

      stop("pattern_type should be one of starts_with,ends_with,contains or regex")
    }
    if(is.null(pattern)) stop("A pattern must be supplied.")
    final_res<-recode_helper(df,pattern_type=pattern_type,original_value=NA,pattern=pattern,
                  new_value=value)
  }


 final_res



}




