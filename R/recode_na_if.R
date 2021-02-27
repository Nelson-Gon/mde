# Grouped data recoding
# Currently less flexible and somewhat repetitive
# Need to use functions we already have to do the replacements
#' Recode NA as another value with some conditions
#' @param df A data.frame object with missing values
#' @param grouping_cols Character columns to use for grouping the data
#' @param target_groups Character Recode NA as if and only if the grouping 
#' column is
#' in this vector of values
#' @importFrom dplyr .data
#' @param replacement Values to use to replace NAs for IDs that meet the 
#' requirements.
#' Defaults to 0.
#' @examples
#' some_data <- data.frame(ID=c("A1","A2","A3", "A4"),
#' A=c(5,NA,0,8), B=c(10,0,0,1),C=c(1,NA,NA,25))
#' # Replace NAs with 0s only for IDs in A2 and A3
#' recode_na_if(some_data,"ID",c("A2","A3"),replacement=0)
#' @export
recode_na_if <- function(df,
                         grouping_cols = NULL,
                         target_groups = NULL,
                         replacement = 0){
  UseMethod("recode_na_if")
}
#' @export
recode_na_if.data.frame <- function(df,
                         grouping_cols = NULL,
                         target_groups = NULL,
                         replacement = 0){
  if(any(is.null(grouping_cols),is.null(target_groups))){
    stop("Need both grouping cols and target_groups.")
  }

check_column_existence(df, grouping_cols,"to group by")
  if(!all(target_groups %in% df[,grouping_cols])){
    stop("All target_groups should exist in grouping_cols")
  }

df %>%
      dplyr::group_by(!!!dplyr::syms(grouping_cols)) %>%
      dplyr::mutate(across(everything(),
               ~ifelse(.data[[grouping_cols]] %in% target_groups,
                       replace(.,is.na(.),replacement),.))) %>%
      dplyr::ungroup()

}



