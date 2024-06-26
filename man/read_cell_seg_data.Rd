% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_cell_seg_data.R
\name{read_cell_seg_data}
\alias{read_cell_seg_data}
\title{Read and clean an inForm data file.}
\usage{
read_cell_seg_data(
  path = NA,
  pixels_per_micron = getOption("phenoptr.pixels.per.micron"),
  remove_units = TRUE,
  col_select = NULL
)
}
\arguments{
\item{path}{Path to the file to read, or NA to use a file chooser.}

\item{pixels_per_micron}{Conversion factor to microns
(default 2 pixels/micron, the resolution of 20x MSI fields
taken on Vectra Polaris and Vectra 3.).
Set to NA to skip conversion. Set to \code{'auto'} to read from
an associated \code{component_data.tif} file.}

\item{remove_units}{If TRUE (default),
remove the unit name from expression columns.}

\item{col_select}{Optional column selection expression, may be
\itemize{
\item NULL - retain all columns
\item \code{"phenoptrReports"} - retain only columns needed by functions
in the \code{phenoptrReports} package.
\item A quoted list of one or more selection expressions,
like in \code{\link[dplyr:select]{dplyr::select()}} (see example).
}}
}
\value{
A \code{\link[tibble]{tibble}}
containing the cleaned-up data set.
}
\description{
\code{read_cell_seg_data} makes it easier to use data from Akoya Biosciences'
inForm program. It reads data files written by inForm 2.0 and later and does
useful cleanup on the result.
}
\details{
\code{read_cell_seg_data} reads both single-field tables, merged tables
and consolidated tables
and does useful cleanup on the data:
\itemize{
\item Removes columns that are all NA.
These are typically unused summary columns.
\item Converts percent columns to numeric fractions.
\item Converts pixel distances to microns. The conversion factor may be
specified as a parameter, by setting
\code{options(phenoptr.pixels.per.micron)}, or by reading an associated
\code{component_data.tif} file.
\item Optionally removes units from expression names
\item If the file contains multiple sample names,
a \code{tag} column is created
containing a minimal, unique tag for each sample.
This is useful when a
short name is needed, for example in chart legends.
}

If \code{pixels_per_micron='auto'}, \code{read_cell_seg_data} looks for
a \code{component_data.tif} file in the same directory as \code{path}.
If found, \code{pixels_per_micron} is read from the file \strong{and}
the cell coordinates are offset to the correct spatial location.

If \code{col_select} is \code{"phenoptrReports"}, only columns normally needed by
\code{phenoptrReports} are read. This can dramatically reduce the time to
read a file and the memory required to store the results.

Specifically, passing \code{col_select='phenoptrReports'} will omit
\itemize{
\item Component stats other than mean expression
\item Shape stats other than area
\item \code{Path}, \verb{Processing Region ID}, \verb{Category Region ID},
\verb{Lab ID}, \code{Confidence}, and columns which are normally
blank.
}
}
\examples{
path <- sample_cell_seg_path()
csd <- read_cell_seg_data(path)

# count all the phenotypes in the data
table(csd$Phenotype)

# Read only columns needed by phenoptrReports
csd <- read_cell_seg_data(path, col_select='phenoptrReports')

# Read only position and phenotype columns
csd <- read_cell_seg_data(path,
         col_select=rlang::quo(list(dplyr::contains('Position'),
                                    dplyr::contains('Phenotype'))))
\dontrun{
# Use purrr::map_df to read all cell seg files in a directory
# and return a single tibble.
paths <- list_cell_seg_files(path)
csd <- purrr::map_df(paths, read_cell_seg_data)
}
}
\seealso{
Other file readers: 
\code{\link{get_field_info}()},
\code{\link{list_cell_seg_files}()},
\code{\link{read_components}()},
\code{\link{read_maps}()}
}
\concept{file readers}
