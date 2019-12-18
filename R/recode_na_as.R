#' Replace missing values with another value
#' @description This provides a convenient way to recode "NA" as another value for instance "NaN", "n/a" or
#' any other value a user wishes to use.
#' @inheritParams recode_as_na
#' @return An object of the same type as x with NAs replaced with the desired value.
#' @examples
#' recode_na_as(airquality, "n/a")
#' recode_na_as(airquality, subset_df = TRUE,
#' subset_cols = "Ozone", value = "N/A")
#' @export

recode_na_as <- function(x,value=0,subset_df = FALSE,
                         subset_cols=NULL) {
  UseMethod("recode_na_as")

}

#' @export

recode_na_as.data.frame <- function(x, value=0,
                                    subset_df = FALSE,
                                    subset_cols = NULL){
  # Use a purely base solution, there are no trophies for that
  # but yeah
  if(subset_df){
    if(!all(subset_cols %in% names(x))){
      stop("Some names not found in the dataset. Please check and try again.")
    }
    else{
    which_to_subset <- which(names(x) %in% subset_cols)
    # which is.na
  x[,which_to_subset] <-  sapply(x[,which_to_subset], function(column)
                replace(column,is.na(column),value))
  x
    }
  }
  else{
    as.data.frame(sapply(x, function(column)
      replace(column,is.na(column),value)))
  }


}
