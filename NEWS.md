---
title: 'Missing Data Explorer'
author: "Nelson Gonzabato"
date: "11/06/2020"
output: html_document
---

# mde 0.2.1

* Patch Fix to skip tests on old R releases that were failing tests.

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

