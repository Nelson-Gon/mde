#' Drop columns for which all values are NA
#' @inheritParams percent_missing
#' @examples
#' test <- data.frame(ID= c("A","A","B","A","B"), Vals = c(rep(NA,4),2))
#' test2 <- data.frame(ID= c("A","A","B","A","B"), Vals = rep(NA, 5))
#' # drop columns where all values are NA
#' drop_all_na(test2)
#' # drop NAs only if all are NA for a given group, drops group too.
#' drop_all_na(test, "ID")
#' @export

drop_all_na <- function(df, grouping_cols=NULL){
  UseMethod("drop_all_na")
}

#' @export

drop_all_na.data.frame <- function(df, grouping_cols = NULL){
  if(!is.null(grouping_cols)){
check_column_existence(df, grouping_cols, unique_name = "to group by")
    
   df %>%
         dplyr::group_by(!!!dplyr::syms(grouping_cols)) %>%
     dplyr::filter(dplyr::across(everything(),~!all_na(.))) %>%
     dplyr::ungroup()


  }
else{

  Filter(function(x) !all_na(x), df)

}



}






