# Tidy recoding
recode_starts_with <- function(x,pattern,original_value,
                               new_value,...){
x %>%
    dplyr::mutate_at(dplyr::vars(dplyr::starts_with(match = pattern,
                                        ignore.case = TRUE,
                                                    ...)),
                     function(y) ifelse(y %in% original_value ,
                                        new_value,
                                        y))
}
recode_ends_with <- function(x,pattern,original_value,new_value,
                             ...){
  x %>%
    dplyr::mutate_at(dplyr::vars(dplyr::ends_with(match = pattern,
                                                    ignore.case = TRUE,
                                                    ...)),
            function(y) ifelse(y %in% original_value ,new_value,
                                        y))
}
recode_contains<- function(x,pattern,original_value,new_value,
                           ...){
  x %>%
    dplyr::mutate_at(dplyr::vars(dplyr::contains(match = pattern,
                                        ignore.case = TRUE,
                                                    ...)),
              function(y) ifelse(y %in% original_value ,new_value,
                                        y))
}

# NA replacements at given columns
# No idea how this could have been done under recode_*
# Maybe someday I'll figure it out, for now I'll go "manual"
recode_na_as_starts_with <- function(x,pattern,
                                     value,...){
  x %>%
    dplyr::mutate_at(dplyr::vars(dplyr::starts_with(pattern,
                                                    ...)),
                     function(x_data) replace(x_data,
                                              is.na(x_data),
                                              value))
}

recode_na_as_ends_with <- function(x,pattern,
                                     value,...){
  x %>%
    dplyr::mutate_at(dplyr::vars(dplyr::ends_with(pattern,
                                                  ...)),
                     function(x_data) replace(x_data,
                                              is.na(x_data),
                                              value))
}
recode_na_as_contains <- function(x,pattern,
                                     value,...){
  x %>%
    dplyr::mutate_at(dplyr::vars(dplyr::contains(pattern,
                                                 ...)),
                     function(x_data) replace(x_data,
                                              is.na(x_data),
                                              value))
}

