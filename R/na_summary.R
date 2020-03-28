#' An all-in-one missingness report
#' @inheritParams percent_missing
#' @importFrom stats "aggregate" "as.formula" "na.pass"
#' @param ... Arguments to other functions
#' @examples
#' na_summary(airquality)
#' # grouping
#' test2 <- data.frame(ID= c("A","A","B","A","B"),
#' Vals = c(rep(NA,4),"No"),ID2 = c("E","E","D","E","D"))
#' na_summary(test2,grouping_cols = c("ID","ID2"))
#'
#'
#' @export

na_summary <- function(df,grouping_cols=NULL,...){
  UseMethod("na_summary")


}

#' @export

na_summary.data.frame <- function(df,grouping_cols=NULL,...){
  # stick to(with?) base as much as possible
  # get total NAs columnwise
if(is.null(grouping_cols)){


  all_counts <-stack(get_na_counts(df))
  # percents
  all_percents <- stack(percent_missing(df,...))
  names(all_counts) <- c("missing","variable")

  names(all_percents) <- c("percent_missing","variable")

  all_counts$complete <- ifelse(all_counts$missing==0,nrow(df),
                                nrow(df) - all_counts$missing)

  all_counts$percent_complete <- ifelse(all_percents$percent_missing==0,
                                       100,
                                        100 - all_percents$percent_missing)

  merge(all_counts,all_percents,by="variable")

}


  # base grouping, may fail
else{
    non_grouping = setdiff(names(df), grouping_cols)
    if(length(non_grouping) > 1){
      warning("All non grouping values used. Using select non groups is currently not supported")
    }
    grouping_cols = paste0(grouping_cols,collapse="+")
    agg_formula <- as.formula(paste0(".~",
                                     grouping_cols))
    res<-do.call(data.frame,aggregate(agg_formula,data=df,
                                      function(x)
               c(missing = sum(is.na(x)),
        complete = length(x) - sum(is.na(x)),
        percent_complete = sum(!is.na(x)) / length(x) * 100,
        percent_missing = sum(is.na(x)) / length(x) * 100
        ) ,
      na.action = na.pass))

  res
}
}



