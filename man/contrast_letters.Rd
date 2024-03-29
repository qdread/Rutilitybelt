% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/contrast_letters.R
\name{contrast_letters}
\alias{contrast_letters}
\title{Create comparison letters manually from a contrast object}
\usage{
contrast_letters(
  contrasts,
  levels_ordered,
  scale = "additive",
  bayes = TRUE,
  alpha = 0.95
)
}
\arguments{
\item{contrasts}{Object of class emmGrid generated by
\code{\link[emmeans]{contrast}}.}

\item{levels_ordered}{Character vector of levels in the contrasts
ordered ascending (or descending if you are using reverse contrasts).}

\item{scale}{Either 'additive' or 'multiplicative', default 'additive'.}

\item{bayes}{if \code{TRUE}, uses limits of 95\% HPD of the contrast as a
decision rule (overlapping zero if additive, one if multiplicative). If
\code{FALSE}, uses the p-value of the contrasts.}

\item{alpha}{significance level. Default 0.95.}
}
\description{
This function requires an object of class \code{emmGrid} containing contrasts
generated by the function \code{\link[emmeans]{contrast}}. Uses the internal function
\code{multcomp:::insert_absorb}.
}
