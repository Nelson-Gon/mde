# Tidy recoding
recode_starts_with <- function(x,pattern=NULL,original_value,
                               new_value,...){
  if(is.null(pattern)){
    stop("A pattern must be supplied.")
  }
x %>%
    dplyr::mutate(across(starts_with(match = pattern,
                                        ignore.case = TRUE,
                                                    ...),
                     ~ ifelse(. %in% original_value ,
                                        new_value,
                                        .)))
}

recode_ends_with <- function(x,pattern=NULL,original_value,new_value,
                             ...){
  if(is.null(pattern)){
    stop("A pattern must be supplied.")
  }
  x %>%
    dplyr::mutate(across(ends_with(match = pattern,
                                                    ignore.case = TRUE,
                                                    ...),
            ~ifelse(. %in% original_value ,new_value,
                                        .)))
}
recode_contains<- function(x,pattern=NULL,original_value,new_value,
                           ...){
  if(is.null(pattern)){
    stop("A pattern must be supplied.")
  }
  x %>%
    dplyr::mutate(across(contains(match = pattern,
                                        ignore.case = TRUE,
                                                    ...),
              ~ifelse(. %in% original_value ,new_value,
                                        .)))
}

# NA replacements at given columns
# No idea how this could have been done under recode_*
# Maybe someday I'll figure it out, for now I'll go "manual"
recode_na_as_starts_with <- function(x,pattern=NULL,
                                     value,...){
  if(is.null(pattern)){
    stop("A pattern must be supplied.")
  }
  x %>%
    dplyr::mutate(across(starts_with(pattern,
                                          ...),
                     ~replace(., is.na(.), value)))
}

recode_na_as_ends_with <- function(x,pattern=NULL,
                                     value,...){
  if(is.null(pattern)){
    stop("A pattern must be supplied.")
  }
  x %>%
    dplyr::mutate(across(ends_with(pattern, ...),
                     ~ replace(., is.na(.), value)))
}
recode_na_as_contains <- function(x,pattern=NULL,
                                     value,...){
  if(is.null(pattern)){
    stop("A pattern must be supplied.")
  }
  x %>%
    dplyr::mutate(across(contains(pattern,...),
                     ~replace(., is.na(.), value)))
}

