% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/distance_funcs.R
\name{find_nearest_distance_rtree}
\alias{find_nearest_distance_rtree}
\title{\code{rtree}-based implementation of \code{find_nearest_distance}.}
\usage{
find_nearest_distance_rtree(csd, phenotypes = NULL)
}
\arguments{
\item{csd}{A data frame with \verb{Cell X Position},
\verb{Cell Y Position} and \code{Phenotype} columns,
such as the result of calling
\link{read_cell_seg_data}.}

\item{phenotypes}{Optional list of phenotypes to include. If omitted,
\code{unique_phenotypes(csd)} will be used.}
}
\value{
A \code{tibble} containing a \verb{Distance to <phenotype>} column
and \verb{Cell ID <phenotype>} column for each phenotype.
Columns will contain \code{NA} values where there is no other cell
of the phenotype.
}
\description{
\code{rtree}-based implementation of \code{find_nearest_distance}.
}
\seealso{
find_nearest_distance
}
\keyword{internal}
