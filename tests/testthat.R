#remove.packages("phenoptr")
devtools::install_github("christianrickert/phenoptr")
#devtools::install_local("C:/Users/Christian Rickert/Documents/GitHub/phenoptr")

library(testthat)
library(phenoptr)
library(rstudioapi)

# set path to current script directory
setwd(dirname(getSourceEditorContext()$path))

test_check("phenoptr")