% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pipeline_functions.R
\name{bid}
\alias{bid}
\title{Calculate Differential Expression (DE) or Differential Activity (DA) by Using Bayesian Inference}
\usage{
bid(mat = NULL, use_obs_class = NULL, class_order = NULL,
  class_ordered = TRUE, method = "Bayesian", family = gaussian,
  pooling = "full", prior.V.scale = 0.02, prior.R.nu = 1,
  prior.G.nu = 2, nitt = 13000, burnin = 3000, thin = 10,
  std = TRUE, logTransformed = TRUE, log.base = 2,
  average.method = "geometric", pseudoCount = 0,
  return_model = FALSE, use_seed = 999, verbose = FALSE)
}
\arguments{
\item{mat}{matrix, the expression/activity matrix of IDs (gene/transcript/probe) from one gene. Rows are IDs, columns are samples.
It is strongly suggested to contain rownames of IDs and column names of samples. Example, geneA has two probes A1 and A2 across all 6 samples (Case-rep1, Case-rep2, Case-rep3, Control-rep1, Control-rep2 and Control-rep3).
The \code{mat} of geneA is a 2*6 numeric matrix. Likewise, if geneA has only one probe, the \code{mat} is a one-row matrix.}

\item{use_obs_class}{a vector of characters, the category of sample.
If the vector names are not available, the order of samples in \code{use_obs_class} must be the same as in \code{mat}.
Users can call \code{get_obs_label} to create this vector.}

\item{class_order}{a vector of characters, the order of the sample's category.
The first class in this vector will be considered as the control group by default.
If NULL, the order will be assigned using alphabetical order. Default is NULL.}

\item{class_ordered}{logical, if TRUE, the \code{class_order} will be ordered. And the order must be consistent with the phenotypic trend,
such as "low", "medium", "high". Default is TRUE.}

\item{method}{character, users can choose between "MLE" and "Bayesian".
"MLE", the maximum likelihood estimation, will call generalized linear model(glm/glmer) to perform data regression.
"Bayesian", will call Bayesian generalized linear model (bayesglm) or multivariate generalized linear mixed model (MCMCglmm) to perform data regression.
Default is "Bayesian".}

\item{family}{character or family function or the result of a call to a family function.
This parameter is used to define the model's error distribution. See \code{?family} for details.
Currently, options are gaussian, poisson, binomial(for two-group sample classes)/category(for multi-group sample classes)/ordinal(for multi-group sample classes with class_ordered=TRUE).
If set with gaussian or poission, the response variable in the regression model will be the expression level, and the independent variable will be the sample's phenotype.
If set with binomial, the response variable in the regression model will be the sample phenotype, and the independent variable will be the expression level.
For binomial, category and ordinal input, the family will be automatically reset, based on the sample's class level and the setting of \code{class_ordered}.
Default is gaussian.}

\item{pooling}{character, users can choose from "full","no" and "partial".
"full", use probes as independent observations.
"no", use probes as independent variables in the regression model.
"partial", use probes as random effect in the regression model.
Default is "full".}

\item{prior.V.scale}{numeric, the V in the parameter "prior" used in \code{MCMCglmm}.
It is meaningful to set when one choose "Bayesian" as method and "partial" as pooling.
Default is 0.02.}

\item{prior.R.nu}{numeric, the R-structure in the parameter "prior" used in \code{MCMCglmm}.
It is meaningful to set when one choose "Bayesian" as method and "partial" as pooling.
Default is 1.}

\item{prior.G.nu}{numeric, the G-structure in the parameter "prior" used in \code{MCMCglmm}.
It is meaningful to set when one choose "Bayesian" as method and "partial" as pooling.
Default is 2.}

\item{nitt}{numeric, the parameter "nitt" used in \code{MCMCglmm}.
It is meaningful to set when one choose "Bayesian" as method and "partial" as pooling.
Default is 13000.}

\item{burnin}{numeric, the parameter "burnin" used in \code{MCMCglmm}.
It is meaningful to set when one choose "Bayesian" as method and "partial" as pooling.
Default is 3000.}

\item{thin}{numeric, the parameter "thin" used in \code{MCMCglmm}.
It is meaningful to set when one choose "Bayesian" as method and "partial" as pooling.
Default is 10.}

\item{std}{logical, if TRUE, the expression matrix will be normalized by column. Default is TRUE.}

\item{logTransformed}{logical, if TRUE, log transformation will be performed. Default is TRUE.}

\item{log.base}{numeric, the base of log transformation when \code{do.logtransform} is set to TRUE. Default is 2.}

\item{average.method}{character, the method applied to calculate FC (fold change). Users can choose between "geometric" and "arithmetic".
Default is "geometric".}

\item{pseudoCount}{integer, the integer added to avoid "-Inf" showing up during log transformation in the FC (fold change) calculation.}

\item{return_model}{logical, if TRUE, the regression model will be returned; Otherwise, just return basic statistics from the model. Default is FALSE.}

\item{use_seed}{integer, the random seed. Default is 999.}

\item{verbose}{logical, if TRUE, print out additional information during calculation. Default is FALSE.}
}
\value{
Return a one-row data frame with calculated statistics for one gene/gene set if \code{return_model} is FALSE.
Otherwise, the regression model will be returned.
}
\description{
\code{bid} calculates the differential expression (DE) / differential activity (DA) by using Bayesian Inference method.
Users can choose different regression models and pooling strategies.
}
\details{
It is a core function inside \code{getDE.BID.2G}.
This function allows users to have access to more options when calculating the statistics using Bayesian Inference method.
In some cases, the input expression matrix could be at probe/transcript level, but DE/DA calculated at gene level is expected.
By setting pooling strategy, users can successfully solve the special cases.
The P-value is estimated by the posterior distribution of the coefficient.
}
\examples{
mat <- matrix(c(0.50099,1.2108,1.0524,-0.34881,-0.13441,-0.87112,
                1.84579,2.0356,2.6025,1.62954,1.88281,1.29604),
                nrow=2,byrow=TRUE)
rownames(mat) <- c('A1','A2')
colnames(mat) <- c('Case-rep1','Case-rep2','Case-rep3',
                  'Control-rep1','Control-rep2','Control-rep3')
res1 <- bid(mat=mat,
           use_obs_class = c(rep('Case',3),rep('Control',3)),
           class_order = c('Control','Case'))
\dontrun{
}
}
