% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lmetable.R
\name{lmetable}
\alias{lmetable}
\title{# This function extracts fixed effects, confidence intervals, and p-values
# from LME objects, and optionally saves the resulting data frame as a
# CSV file
# Summarize Fixed Effects components from mixed-effects models fitted using
# the lme() function in the nlme package}
\usage{
lmetable(model, CIroundval = 2, filename = NULL)
}
\arguments{
\item{model}{An lme object created using the lme function in the nlme package}

\item{CIroundval}{Number of decimal places for rounding confidence intervals}

\item{filename}{Optional. A CSV filename to save the dataframe. If 'NULL', no file is saved}
}
\value{
A data frame with fixed effects estimates, standard errors, 95% confidence intervals, and p-values
}
\description{
# This function extracts fixed effects, confidence intervals, and p-values
# from LME objects, and optionally saves the resulting data frame as a
# CSV file
# Summarize Fixed Effects components from mixed-effects models fitted using
# the lme() function in the nlme package
}
\examples{
library(nlme)

# Create example dataset
dataset <- data.frame(
group = rep(1:5, each = 10),
predictor = rnorm(50),
outcome = rnorm(50)
)
# fit an lme model
model <- lme(fixed = outcome ~ predictor, random = ~1 | group, data = dataset)
# use the lme table function
lmetable(model, CIroundval = 3, filename = "fixed.csv")
unlink("fixed.csv")
}
