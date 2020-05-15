#' An all-in-one missingness report
#' @inheritParams percent_missing
#' @inheritParams sort_by_missingness
#' @importFrom stats "aggregate" "as.formula" "na.pass"
#' @param ... Arguments to other functions
#' @examples
#' na_summary(airquality)
#' # grouping
#' test2 <- data.frame(ID= c("A","A","B","A","B"),
#' Vals = c(rep(NA,4),"No"),ID2 = c("E","E","D","E","D"))
#' na_summary(test2,grouping_cols = c("ID","ID2"))
#' # sort summary
#' na_summary(airquality,sort_by = "percent_missing",descending = TRUE)

#' na_summary(airquality,sort_by = "percent_complete")
#'
#' @export

na_summary <- function(df,grouping_cols=NULL,sort_by=NULL,descending=FALSE,...){
  UseMethod("na_summary")


}

#' @export

na_summary.data.frame <- function(df,grouping_cols=NULL,sort_by=NULL,descending=FALSE,...){
  # stick to(with?) base as much as possible
  # get total NAs columnwise
all_counts <-stack(get_na_counts(df))
all_percents <- stack(percent_missing(df,...))
names(all_counts) <- c("missing","variable")
names(all_percents) <- c("percent_missing","variable")
if(is.null(grouping_cols)){

if(nrow(all_counts) != nrow(all_percents)){
  stop("Binding of datasets failed. Please check using percent_missing and get_na_counts first")
}




  all_counts$complete <- ifelse(all_counts$missing==0,nrow(df),
                                nrow(df) - all_counts$missing)

  all_counts$percent_complete <- ifelse(all_percents$percent_missing==0,
                                       100,
                                        100 - all_percents$percent_missing)

  res <- merge(all_counts,all_percents,by="variable")

}


  # base grouping, may fail
else{
    non_grouping = setdiff(names(df), grouping_cols)
    if(length(non_grouping) > 1){
      warning("All non grouping values used. Using select non groups is currently not supported")
    }
    if(!all(grouping_cols %in% names(df))){
      stop("All grouping_cols should exist in the dataset.")
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


}
if(!is.null(sort_by)){
  stopifnot("sort_by should be a valid name in the output of na_summary" = sort_by %in% names(res))
  res <- res[sort(res[[sort_by]],decreasing=descending,index.return=TRUE)[[2]],]

}
res

}



