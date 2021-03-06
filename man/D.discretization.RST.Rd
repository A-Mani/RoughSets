% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/Discretization.R
\name{D.discretization.RST}
\alias{D.discretization.RST}
\title{The wrapper function for discretization methods}
\usage{
D.discretization.RST(decision.table, type.method = "unsupervised.quantiles",
  ...)
}
\arguments{
\item{decision.table}{an object inheriting from the \code{"DecisionTable"} class, which represents a decision system.
See \code{\link{SF.asDecisionTable}}.}

\item{type.method}{a character representing a discretization method to be used in the computations.
Currently it can be one of the following methods:
 \itemize{
   \item \code{"global.discernibility"}: See \code{\link{D.global.discernibility.heuristic.RST}}.
   \item \code{"local.discernibility"}: See \code{\link{D.local.discernibility.heuristic.RST}}.
   \item \code{"unsupervised.intervals"}: See \code{\link{D.discretize.equal.intervals.RST}}.
   \item \code{"unsupervised.quantiles"}: See \code{\link{D.discretize.quantiles.RST}}.
}}

\item{...}{parameters that are passed to the discretization methods. See the manual of particular functions.}
}
\value{
An object of a class \code{"Discretization"} which stores cuts for each conditional attribute. It contains the following components:
\itemize{
  \item \code{cut.values}: a list representing cut values for each of numeric attributes. NULL value means that
        no cut was selected for a given attribute.
  \item \code{type.method}: the type of method which is used to define cut values.
  \item \code{type.task}: the type of task which is \code{"discretization"}.
  \item \code{model}: the type of model which is \code{"RST"}.
}
}
\description{
It is a wrapper function for all discretization methods based on RST.
It provides an interface that allows users to use the discretization methods easily.
}
\details{
The discretization is used to convert numeric attributes into nominal ones
in an information system. It is usually a preliminary step for the most of methods based on the rough set theory, which
need nominal attributes, for exemple, to compute the indiscernibility relation.

Output of this function is an object of a class \code{Discretization} which
contains cut values. The function \code{\link{SF.applyDecTable}} can be used
to generate a new (discretized) decision table from the computed cuts. Type of
all attributes in the resulting table will be changed into nominal (i.e. ordered factors).

All implemented supervised discretization methods need a nominal decision attribute.
Furthermore, especially for the method type \code{"global.discernibility"}, all conditional attributes
must be numeric. A different method needs to be chosen in a case when
a data set contains attributes of mixed types (numeric and nominal).
}
\examples{
#################################################################
## Example: Determine cut values and generate new decision table
#################################################################
data(RoughSetData)
wine.data <- RoughSetData$wine.dt
cut.values1 <- D.discretization.RST(wine.data,
                                   type.method = "unsupervised.quantiles",
                                   nOfIntervals = 3)

## generate a new decision table
wine.discretized1 <- SF.applyDecTable(wine.data, cut.values1)
dim(wine.discretized1)
lapply(wine.discretized1, unique)

cut.values2 <- D.discretization.RST(wine.data,
                                    type.method = "global.discernibility")

wine.discretized2 <- SF.applyDecTable(wine.data, cut.values2)
dim(wine.discretized2)
lapply(wine.discretized2, unique)
}
\author{
Andrzej Janusz
}
\seealso{
\code{\link{BC.LU.approximation.RST}}, \code{\link{FS.reduct.computation}}, \code{\link{SF.applyDecTable}}.
}

