# `ExtremalDep`: Extremal Dependence Models

[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/ExtremalDep?color=2ED968)](https://cranlogs.r-pkg.org/)
[![cran version](https://www.r-pkg.org/badges/version/ExtremalDep)](https://cran.r-project.org/package=ExtremalDep)

A set of procedures for parametric and non-parametric modelling of the dependence structure of multivariate extreme-values is provided. The statistical inference is performed with non-parametric estimators, likelihood-based estimators and Bayesian techniques. It adapts the methodologies of Beranger and Padoan (2015) <doi:10.48550/arXiv.1508.05561>, Marcon et al. (2016) <doi:10.1214/16-EJS1162>, Marcon et al. (2017) <doi:10.1002/sta4.145>, Marcon et al. (2017) <doi:10.1016/j.jspi.2016.10.004> and Beranger et al. (2021) <doi:10.1007/s10687-019-00364-0>. This package also allows for the modelling of spatial extremes using flexible max-stable processes. It provides simulation algorithms and fitting procedures relying on the Stephenson-Tawn likelihood as per Beranger at al. (2021) <doi:10.1007/s10687-020-00376-1>.

# Version 0.0.4-2 updates:

- Fixes a typo in `dExtDep()` for in the Asymetric Logistic model;
- Replaces the `Calloc()` and `Free()` calls in the .C files by the R_* prefixed counterparts since STRICT_R_HEADERS=1 becomes the default with R 4.5.0;
- Improved some entries in the manual. 
