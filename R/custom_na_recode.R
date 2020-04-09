#' Recode NA as another value using a function or a custom equation
#' @inheritParams na_summary
#' @param func Function to use for the replacement e.g "mean"
#' @param across_columns A character vector specifying across which columns recoding should be done
#' @examples
#' #use all columns
#' head(custom_na_recode(airquality,func="mean"))
#' # use only a few columns
#' head(custom_na_recode(airquality,func="mean",across_columns = c("Solar.R","Ozone")))
#'
#' @export

custom_na_recode <- function(df,func="mean",grouping_cols=NULL,
                             across_columns=NULL){
  UseMethod("custom_na_recode")
}

#' @export

custom_na_recode.data.frame <- function(df,func="mean",grouping_cols=NULL,
                                        across_columns=NULL){



if(all(is.null(across_columns), is.null(grouping_cols))){
# use old mutate_*
# wait for dplyr release, move to across

  df %>%
        dplyr::mutate_all(~ifelse(is.na(.),do.call(func,list(na.omit(.))),.))

}

else if(!is.null(across_columns)){

  if(!all(across_columns %in% names(df))){
    stop("All columns in across_columns should exist in the dataset")
  }

  if(is.null(grouping_cols)){

     df %>%
      dplyr::mutate_at(dplyr::vars(!!!dplyr::syms(across_columns)),
                       ~ifelse(is.na(.),
                               do.call(func,list(na.omit(.))),.))

}


  }


}




