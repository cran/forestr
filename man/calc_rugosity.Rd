% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_rugosity.R
\name{calc_rugosity}
\alias{calc_rugosity}
\title{Calculate rugosity and other higher level complexity metrics}
\usage{
calc_rugosity(df, m, filename)
}
\arguments{
\item{df}{is a LiDAR summary matrix data frame}

\item{m}{matrix of light adjusted vai values.}

\item{filename}{the name of the file currently being processed.}
}
\value{
a series of metrics that describe canopy and
ecosystem height, density, openness, cover, etc.
}
\description{
\code{calc_rugosity} calculates canopy structural complexity
metrics from PCL data and prints them to the screen.
}
\details{
This is a specific function calculates canopy rugosity
and other metrics, including rumple, height metrics, etc.
}
\examples{
# Calculates metrics of canopy structural complexity.
calc_rugosity(pcl_summary, pcl_vai, filename = "")

}
\keyword{complexity}
