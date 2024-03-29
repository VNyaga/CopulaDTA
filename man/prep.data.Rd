% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{prep.data}
\alias{prep.data}
\title{Prepare the data}
\usage{
prep.data(data, SID, formula.se, formula.sp, formula.omega)
}
\arguments{
\item{data}{A data-frame with no missing values containing TP, TN, FP, FN, 'SID' and co-variables(if necessary).}

\item{SID}{A string indicating the name of the column with the study ID.}

\item{formula.se}{An optional object of class "formula": A symbolic description of a linear model to be fitted to mean E(x) of sensitivity in the logit scale.
the default (when no covariates are included) symbolic description is SID ~ 1 corresponds to the model formula E(x) = mu = exp(a)/(1 + exp(a)) where a is the intercept.
When the covariates are categorical and the relative measures are needed it is important to remove the intercept from the model to obtain meaningful parameters. EG for
a covariate 'Test' with two levels(A and B) and relative sensitivity of B versus A is needed, then the correct formula is SID ~ Test - 1. See **** .
Further information on interpretation of parameters in logistic regression see ***}

\item{formula.sp}{An optional object of class "formula": A symbolic description of a linear model to be fitted to specificity data.
When no covariates are included, the formula is not necessary. By default the covariate information for sensitivity is used.}

\item{formula.omega}{An optional object of class "formula": A symbolic description of a linear model to be fitted to the copula function.
When no covariates are included, the formula is not necessary. By default the covariate information for sensitivity is used.}
}
\description{
Prepare the data
}
\author{
Victoria N Nyaga
}
\keyword{internal}
