#' Conditionally change all column values to NA
#' @inheritParams drop_na_if
#' @return A `data.frame` with the target columns populated with `NA`s.
#' @examples
#' head(recode_as_na_if(airquality, sign="gt", percent_na=20))
#' @export
recode_as_na_if<-function(df,sign="gteq",percent_na=50,keep_columns=NULL,...){
  UseMethod("recode_as_na_if")
}
#' @export
recode_as_na_if.data.frame <- function(df, sign="gteq", percent_na=50,keep_columns=NULL,...){
  missing_percents <- percent_missing(df, ...)
  to_recode <- switches(target_value=missing_percents, sign, percent_na)
  if(!is.null(keep_columns)){
    check_column_existence(df,target_columns=keep_columns,unique_name="to keep")
    keep_columns <- which(names(df)%in%keep_columns)
  }
  to_recode <- setdiff(to_recode,keep_columns)
  df[to_recode]<- NA
  df
}



