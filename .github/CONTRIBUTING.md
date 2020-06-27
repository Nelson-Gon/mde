# Contributing to mde

This document provides guidelines for contributions to mde.

**Kinds of contribution**

* Typo fixes
* Documentantion enhancements
* Pull requests


**Fixing typos and enhancing documentation**

To fix typos and/or grammatical errors, please edit the corresponding `.R` or `.md` file that generates the documentation. 

If edited via an `.R` file, please also update the docs using `roxygen2` to generate the associated `.Rd` file.

**Pull Requests**

* Please raise an issue for discussion and reproducibility checks at [issues](https://github.com/Nelson-Gon/mde/issues)

* Once the bug/enhancement is approved, please create a Git branch for the pull request.

* Make changes and ensure that builds are passing the necessary checks on Travis.

* Update `NEWS.md` to reflect the changes made.

* Update examples in `README.rmd` and knit it to make the relevant `README.md`

* Copy `README.rmd` to `vignettes/mde_vignette.rmd` 

* Perform tests and checks locally.

* PR or push to branch not **master**

**Release checklist**

* Check as CRAN with `devtools::checK()`


* Check old releases with `devtools::check_win_oldrelease()`


* Update changes in `NEWS.md`


* Update version in `Description`.

* Update `README.rmd`, knit to make `README.md`. 


* Perform a spelling check.


* Rebuild site if necessary with `pkgdown::build_site`


* Update `cran-comments.md`

* Release package with `devtools::release` if all steps above are fulfilled. 

Please note that the 'mde' project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.
