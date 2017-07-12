# informr 0.1.1.9000

## Backwards incompatible change

- This version changed the order of arguments to `subset_distance_matrix`
  in a backwards-incompatible way. This was done to put the `csd` parameter
  first, matching other functions with a `csd` parameter.
  
## New features

- Add vignette "Reading and Displaying inForm Image Files"
- Add vignette "Computing Inter-cellular Distances"
- `spatial_distribution_report` creates an HTML report showing the 
  location and nearest-neighbor relations of cells in a single field.
- `read_components` reads component image files.
- `count_within` counts the number of `from` cells having a `to` cell
   within a given radius.
- `list_cell_seg_files` lists all cell seg data files in a folder.

## Bug fixes

- Better handling of `NA` values in distance columns of cell seg tables.
  Previously `NA` values could cause the column to be read as character data.
  
## Other changes

- `read_maps` will find the correct path when given a cell seg table path.
- Many documentation improvements.
- Internal cleanup using `lintr` and `goodpractices`.
- zlib license

# informr 0.1.0.9001

## New features

- `compute_all_nearest_distance` is a convenience functien which reads a
  cell seg table, adds `Distance to <phenotype>` columns, and writes it out
  again.