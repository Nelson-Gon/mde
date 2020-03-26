#' Drop columns for which all values are NA
#' @inheritParams percent_missing
#' @examples 
#' test <- data.frame(ID= c("A","A","B","A",NA), Vals = rep(NA,5))
#' drop_all_na(test)
#' @export
drop_all_na <- function(df, grouping_cols = NULL){
  if(is.null(grouping_cols)){
    
    Filter(function(x) !all(is.na(x)), df)
    
  }
  
 

}
                                                                                                                                                                                            


