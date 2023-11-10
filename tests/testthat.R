library(testthat)
library(phenoptr)
library(rstudioapi)

# set path to current script directory
setwd(dirname(getSourceEditorContext()$path))

test_check("phenoptr")