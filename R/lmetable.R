# This file is part of the lmetable package.
#
# The lmetable package is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This package is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this package. If not, see <https://www.gnu.org/licenses/>.

#' # This function extracts fixed effects, confidence intervals, and p-values
#' # from LME objects, and optionally saves the resulting data frame as a
#' # CSV file

#' # Summarize Fixed Effects components from mixed-effects models fitted using
#' # the lme() function in the nlme package

#' @param model An lme object created using the lme function in the nlme package
#' @param CIroundval Number of decimal places for rounding confidence intervals
#' @param filename Optional. A CSV filename to save the dataframe. If 'NULL', no file is saved
#' @return A data frame with fixed effects estimates, standard errors, 95% confidence intervals, and p-values
#' @examples
#' library(nlme)
#'
#' # Create example dataset
#' dataset <- data.frame(
#' group = rep(1:5, each = 10),
#' predictor = rnorm(50),
#' outcome = rnorm(50)
#' )
#' # fit an lme model
#' model <- lme(fixed = outcome ~ predictor, random = ~1 | group, data = dataset)
#' # use the lme table function
#' lmetable(model, CIroundval = 3, filename = "fixed.csv")
#' unlink("fixed.csv")
#' @export

lmetable <- function(model, CIroundval = 2, filename = NULL) {

  if (!inherits(model, "lme")) {
    stop("Input model must be an object of class 'lme'.")
  }

  if (!is.null(filename) && !is.character(filename)) {
    stop("The 'filename' parameter must be a character string or NULL.")
  }

  # Extract the confidence intervals
  intervals <- nlme::intervals(model, which = "fixed")
  lower <- round(intervals$fixed[,1], CIroundval)
  upper <- round(intervals$fixed[,3], CIroundval)
  CIs <- paste0("[", lower, " ", upper, "]")

  # Extract the model summary
  modsum <- summary(model)
  tabsum <- modsum$tTable
  Estimates <- tabsum[,1]
  SE <-tabsum[,2]
  p <- ifelse(round(tabsum[,5], 4) == 0, "<0.0001", round(tabsum[,5],4))


  # Create a data frame for the results
  dataframe <- data.frame(Estimates, SE, CIs, p)
  colnames(dataframe)[colnames(dataframe) == "CIs"] <- "95% CI"

  # Optional: Save the data frame to file
  if(!is.null(filename)) {
    utils::write.csv(dataframe, filename)
  }

  return(dataframe)
}
