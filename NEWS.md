---
title: 'Missing Data Explorer'
author: "Nelson Gonzabato"
date: "`r Sys.Date()`"
output: html_document
---

# mde 0.3.2

* Tests now use edition 3 of testthat. See https://github.com/r-lib/testthat/issues/1471 and https://github.com/Nelson-Gon/manymodelr/pull/22

* Vignettes no longer include URLs to avoid future issues with broken links on CRAN. 

* Exclusion or inclusion in `na_summary`via regular expressions is now possible via `regex_kind` and providing a `pattern_type` and `pattern`. 

* `exclusion` is now done entirely in `base` R instead of using `dplyr::select`. 

* `get_na_means` and `percent_missing` now support `POSIXct`. 

* `na_counts`  and `percent_na` are new vector focused functions to allow `get`ting `na_counts` and percent missingness for objects of classes like `POSIXct`.

# mde 0.3.1

* Fixed a bug that made `exclude_cols` result in non-exclusion in grouped `na.summary` outputs. 

* `na_summary` now includes a `round_to` parameter to control the number of digits to round to. Defaults to `options("digits")` in the user's settings. 

* `drop_na_at` no longer uses a `tibble` to avoid warnings with `tibble` `row.names`. 

* Tests in `dict_recode` were extended to ensure that we get what is expected particularly with respect to the `use_func` argument. 

* `dict_recode` now supports the use of different `NA` recoding functions. These
can be provided via the argument `use_func`. 

* `dict_recode` is a new function to allow recoding with a pattern-values pair. 

* `drop_na_if` now supports keep certain columns when grouping. It also now
supports dropping only at certain columns. 

* `drop_na_if` now supports dropping groups that meet a set missing data
threshold. 

* `recode_as_na_str` updated to convert factors to character.

# mde 0.3.0


* `drop_row_if` arguments were changed. See docs for the new arguments. This was
done to allow new functionality that enables dropping rows based on counts. 

* Sorting strings in `na_summary` contained a minor bug that has now been fixed. 

* `recode_as_na_str` is a new function to `recode_as_na` based on string matching. 

* `recode_as_na_if` is a new function that allows deliberate addition of `NA`s to a column if it meets a pre-defined condition. This is essentially the reverse of `drop_na_if`. 

* `drop_row_if` is a new function similar to `drop_na_if` but for rows instead of columns. 

* `percent_missing` can now work independently for factors, characters, or numeric data. It previously was limited to `data.frame` objects. 

* Fixed issues with `drop_na_at` that resulted in failing data rebinding. 

* `get_na_counts` now includes an optional `exclude_cols` argument to exclude columns from the analysis. 


* `na_summary` has been fixed to allow exclusion of columns from the analysis.

* `all_na` is a new low level function to perform missingness boolean checks for columns(vectors). 

* Added a new function `column_based_recoode` that aims to allow `NA` recoding based on other columns. 

# mde 0.2.1

* Patch Fix to skip tests on old R releases.

* Only R versions above 3.6.3 are supported. 

# mde version 0.2.0

**Additions**

1. `na_summary` which provides a very quick overview of missingness. It also supports grouped summaries. 

2. `drop_na_if` allows easy dropping of columns where all values are missing.

3. `custom_na_recode` allows replacing missing values with common values such as mean, min, max, sd. 

**Major changes**

2. In `percent_missing`, the argument `grouped` was dropped in favour of simply providing a `grouping_cols` vector.

3. In `recode_as_na` , `subset_df` was dropped. It now simply accepts an optional `subset_cols` argument. The argument `tidy` was also dropped.One can simply provide an optional `pattern_type` and `pattern`.

4. Similar changes were made for `recode_na_as` as above.

5. The argument `x` was changed to `df` in `drop_na_at`. 





# mde version 0.1.0


Available functions

1. `get_na_counts`

2. `percent_missing`

3. `recode_as_na`

4. `sort_by_missingness`

5. `recode_na_as`

6. `drop_na_if`

7. `recode_na_if`

8. `drop_na_at`

9. `recode_as_na_for`

Key changes

10. Now supports tidy selection and exploration at specific columns

11. `percent_missing` supports grouping and exclusion of certain columns. The use of decimals was dropped. 

12. `drop_na_if` allows exclusion of columns. 

