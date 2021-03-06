#' Creates summary matrix
#'
#' \code{make_summary_matrix} creates a summary matrix of data through data wrangling
#' the VAI data frame.
#'
#' This makes a dataframe that is as long as a transect is. If the
#' transect is 40 m, this data frame has 40 rows. As input,
#' \code{make_summary_matrix} requires a data frame of values
#' from \code{split_transects_from_pcl} first, and second,
#' the data frame of VAI from the function \code{calc_vai}.
#'
#'#' This function allows you to express your love of cats.
#' @param df sorted data frame of processed PCL data
#' @param m matrix of PCL hit density with x and z coordinates
#'
#' @keywords summary matrix
#' @return a matrix of summary stats by each x and z coordinate position
#'
#' @export
#' @examples
#'
#' pcl_summary <- make_summary_matrix(pcl_split, pcl_vai)
#'

make_summary_matrix <- function(df, m) {
  #declaring global varieties
  return_distance <- NULL

  df <- subset(df, return_distance > 0)

  # mean height
  a <- stats::setNames(stats::aggregate(return_distance ~ xbin, data = df, FUN = mean, na.rm = FALSE, na.action = 'na.pass'), c("xbin", "mean.ht"))

  # standard deviation of column height
  b <- stats::setNames(stats::aggregate(return_distance ~ xbin, data = df, FUN = stats::sd, na.rm = FALSE, na.action = 'na.pass'), c("xbin", "sd.ht"))

  # max height in column
  c <- stats::setNames(stats::aggregate(return_distance ~ xbin, data = df, FUN = max, na.rm = FALSE, na.action = 'na.pass'), c("xbin", "max.ht"))

  # maximum value of VAI in the column
  d <- stats::setNames(stats::aggregate(vai ~ xbin, data = m, FUN = max, na.rm = FALSE, na.action = 'na.pass'), c("xbin", "max.vai"))

  # sum of VAI in column
  e <- stats::setNames(stats::aggregate(vai ~ xbin, data = m, FUN = sum, na.rm = FALSE, na.action = 'na.pass'), c("xbin", "sum.vai"))
  # standard deviation of VAI for column
  f <- stats::setNames(stats::aggregate(vai ~ xbin, data = m, FUN = stats::sd, na.rm = FALSE, na.action = 'na.pass'), c("xbin", "sd.vai"))

  # this is height at which max vai occurs
  g <- m$zbin[match(d$max.vai, m$vai)]
  g <- data.frame(g)
  colnames(g) <- c("max.vai.z")
  #print(g)

  #mean column leaf height that is the "heightBin" from Matlab code
  # first we make el
  #m$el <- (m$vai / m$sum.vai) * 100
  m$vai.z <- m$vai * (m$zbin + 0.5)
  h <- stats::setNames(stats::aggregate(vai.z ~ xbin, data = m, FUN = sum, na.rm = FALSE,  na.action = 'na.pass'), c("xbin", "vai.z.sum"))


  # this section joins all these guys together
  p <- plyr::join_all(list(a, b, c, d, e, f, h), by = "xbin", type = "full")
  p <- p[with(p, order(xbin)), ]
  p <- cbind(p, g)




  p$mean.ht[is.na(p$mean.ht)] <- 0
  p$sd.ht[is.na(p$sd.ht)] <- 0
  p$max.ht[is.na(p$max.ht)] <- 0

  p$height.bin <- p$vai.z.sum / p$sum.vai
  p[is.na(p)] <- 0

  # replace overestimate of VAI in first column
  p$sum.vai[p$sum.vai > 8] <- 8


  return(p)
}
