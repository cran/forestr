% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_pcl_multi.R
\name{read_pcl_multi}
\alias{read_pcl_multi}
\title{\code{read_pcl_multi} imports PCL or portable canopy LiDAR files into the workspace and formats them.}
\usage{
read_pcl_multi(data_directory, filename)
}
\arguments{
\item{data_directory}{directory where files are stored}

\item{filename}{name of file to be imported

  Zero-length vectors have sum 0 by definition. See
  \url{http://en.wikipedia.org/wiki/Empty_sum} for more details.}
}
\description{
This function specificially reads in PCL files that are in .csv format, standard format for that data type.
}
\examples{
\dontrun{
# This function runs internally right now.
read_pcl_multi(data_directory, filename)
}
}
