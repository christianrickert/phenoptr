# Tests for read_components and read_maps
library(testthat)

test_that("read_components works", {
  # component_data files are big, even for our toy test data.
  # Use phenoptrExamples data here to keep the package size down a bit,
  # though it makes the test take longer...
  skip_if_not_installed('phenoptrExamples')
  path = system.file('extdata', 'samples',
                     'Set4_1-6plex_[16142,55840]_component_data.tif',
                     package='phenoptrExamples')

  images = read_components(path)

  expected_names = c("PDL1 (Opal 520)", "CD8 (Opal 540)", "FoxP3 (Opal 570)",
                     "CD68 (Opal 620)", "PD1 (Opal 650)", "CK (Opal 690)",
                     "DAPI", "Autofluorescence")
  expect_equal(names(images), expected_names)
  expect_equivalent(purrr::map(images, dim), rep(list(c(1400, 1868)), 8))
})

test_that('read_maps works', {
  path =
    file.path('test_data',
              'FIHC4__0929309_HP_IM3_2_binary_seg_maps.tif')
  maps = read_maps(path)

  expected_names = c("Nucleus", "Cytoplasm", "Membrane", "Tissue")
  expect_equal(names(maps), expected_names)
  expect_equivalent(purrr::map(maps, dim), rep(list(c(260, 348)), 4))
})