#' Recode NA as another value using a function or a custom equation
#' @inheritParams na_summary
#' @param func Function to use for the replacement e.g "mean". Defaults to mean.
#' @param across_columns A character vector specifying across which columns recoding should be done
#' #use all columns
#' head(custom_na_recode(airquality,func="mean"))
#' # use only a few columns
#' head(custom_na_recode(airquality,func="mean",across_columns = c("Solar.R","Ozone")))
#' # use a function from another package
#' #head(custom_na_recode(airquality, func=dplyr::lead))
#' some_data <- data.frame(ID=c("A1","A1","A1","A2","A2", "A2"), A=c(5,NA,0,8,3,4), B=c(10,0,0,NA,5,6),C=c(1,NA,NA,25,7,8))
#' # grouping
#' head(custom_na_recode(some_data,func = "mean", grouping_cols = "ID", across_columns = c("C", "A")))
#' head(custom_na_recode(some_data,func = "mean", grouping_cols = "ID"))
#' @export

custom_na_recode <- function(df,func="mean",grouping_cols=NULL, across_columns=NULL){

  UseMethod("custom_na_recode")

}

#' @export

custom_na_recode.data.frame <- function(df,func="mean",grouping_cols=NULL, across_columns=NULL){


if(!is.null(grouping_cols)){

check_column_existence(df,grouping_cols,unique_name = "to group by")

df <- df %>% dplyr::group_by(!!!dplyr::syms(grouping_cols))

}

if(is.null(across_columns)){

  df %>%
    dplyr::mutate(dplyr::across(dplyr::everything(),
                                ~ifelse(is.na(.),
                                  do.call(func,list(na.omit(.))),.))) %>%
    dplyr::ungroup()
}

else{
check_column_existence(df, across_columns, unique_name = "in across_columns")

df %>%
dplyr::mutate(dplyr::across(c(!!!dplyr::syms(across_columns)), ~ifelse(is.na(.),
                              do.call(func,list(na.omit(.))),.))) %>%
  dplyr::ungroup()

}

}
























