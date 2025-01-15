# lmetable

## overview
'lmetable' is an R package that simplifies the process of summarizing
the fixed effects, confidence intervals, and p-values from linear mixed-effects
models fitted using the 'nlme' package

## Installation

'lmetable' can be installed from GitHub:

```R
# Install devtools if you haven't already
install.packages("devtools")

# Install the package
devtools::install_github("kaneobrm/lmetable")
```

## Example Usage
library(nlme)
library(lmetable)

dataset <- data.frame(
  group = rep(1:5, each =10),
  predictor = rnorm(50),
  outcome = rnorm(50)
)

# Fit a linear mixed-effects model using the 'nlme' package
model <- lme(outcome ~ predictor, random = ~1 | group, data = dataset)

# Use lmetable to summarize the fixed effects
lmetable(model, CIroundval = 3)

# License

This package is licensed under GPL-3. See the LICENSE file for details
