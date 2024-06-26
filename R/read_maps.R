#' Read an inForm segmentation map file.
#'
#' Reads an inForm `binary_seg_maps.tif`` file and returns a named
#' list of images. The names reflect the content of the individual images.
#' Possible names are Nucleus, Cytoplasm, Membrane, Object,
#' TissueClassMap, and ProcessRegionImage; not every image file will include all
#' names.
#'
#' Images are oriented to match the coordinates in a cell seg data file,
#' i.e. (0, 0) at the top left and the row corresponding to Y and
#' column corresponding to X.
#'
#' @param map_path Path to the map file or a cell seg data file in the same
#' directory.
#' @return A named list of images, one for each map in the source file.
#' @export
#' @family file readers
#' @examples
#' path <- system.file("extdata", "sample",
#'                    "Set4_1-6plex_[16142,55840]_binary_seg_maps.tif",
#'                    package = "phenoptr")
#' maps <- read_maps(path)
#' names(maps)
#' @md
read_maps <- function(map_path) {
  # Allow a cell seg path to be passed in
  map_path = sub('cell_seg_data.txt', 'binary_seg_maps.tif', map_path)

  stopifnot(file.exists(map_path), endsWith(map_path, 'binary_seg_maps.tif'))

  # Read the mask file and get the image descriptions
  masks = tiff::readTIFF(map_path, all=TRUE, info=TRUE, as.is=TRUE)
  infos = purrr::map_chr(masks, ~attr(., 'description'))

  # All possible maps
  map_keys = c(Nucleus='Nucleus', Cytoplasm='Cytoplasm', Membrane='Membrane',
               Object='Object', Tissue='TissueClassMap',
               ROI='ProcessRegionImage')
  maps = list()
  for (n in names(map_keys)) {
    m = masks[stringr::str_detect(infos, map_keys[n])]
    if (length(m)>0)
      maps[[n]] = m[[1]]
  }

  maps
}

#' Get the path to the segmentation map file for a field
#'
#' @param field_name Name of the field of interest
#' @param export_path Path to the inForm export directory
#' @return The path to the `binary_seg_maps` file for the given field.
#' @export
get_map_path = function(field_name, export_path) {
  field_base = stringr::str_remove(field_name, '\\.im3')
  map_path = file.path(export_path, paste0(field_base,
                                                 '_binary_seg_maps.tif'))
  if(!file.exists(map_path)) {
    warning('File not found: "', map_path, '"')
    return(NULL)
  }

  map_path
}

