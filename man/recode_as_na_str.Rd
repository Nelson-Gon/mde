% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recode_as_na_str.R
\name{recode_as_na_str}
\alias{recode_as_na_str}
\title{Recode as NA based on string match}
\usage{
recode_as_na_str(
  df,
  pattern_type = "ends_with",
  pattern = NULL,
  case_sensitive = FALSE,
  ...
)
}
\arguments{
\item{df}{A data.frame object}

\item{pattern_type}{One of contains', 'starts_with' or 'ends_with'.}

\item{pattern}{A character pattern to match}

\item{case_sensitive}{Defaults to FALSE. Patterns are case insensitive if TRUE}

\item{...}{Other arguments to grepl}
}
\description{
Recode as NA based on string match
}
\examples{
partial_match <- data.frame(A=c("Hi","match_me","nope"), B=c(NA, "not_me","nah"))
# Replace all that end with "me" with NA
recode_as_na_str(partial_match,"ends_with","me")
# Do not recode, ie case-sensitive
recode_as_na_str(partial_match,"ends_with","ME", case_sensitive=TRUE)
}
\seealso{
\code{\link{recode_as_na}} \code{\link{recode_as_na_if}}
}
