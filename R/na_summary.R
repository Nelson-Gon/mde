#' An all-in-one missingness report
#' @inheritParams drop_na_at
#' @examples 
#' na_summary(airquality)
#' @export

na_summary <- function(df,...){
  UseMethod("na_summary")
  
  
}

#' @export

na_summary.data.frame <- function(df,...){
  # stick to(with?) base as much as possible
  # get total NAs columnwise
 
  all_counts <-stack(get_na_counts(df,...))
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



