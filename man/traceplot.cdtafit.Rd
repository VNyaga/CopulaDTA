% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/traceplot.R
\name{traceplot.cdtafit}
\alias{traceplot.cdtafit}
\title{Trace plot using ggplot2.}
\usage{
traceplot.cdtafit(x, ...)
}
\arguments{
\item{x}{An cdtafit object from \link{fit}.}

\item{...}{additional options. See \link[rstan]{stan_trace} for more details.}
}
\value{
A ggplot object of the parameters of the models mean structure.
}
\description{
Trace plot using ggplot2.
}
\examples{
data(telomerase)
model1 <-  cdtamodel(copula = 'fgm')

model2 <- cdtamodel(copula = 'fgm',
               modelargs=list(param=2,
                              prior.lse='normal',
                              par.lse1=0,
                              par.lse2=5,
                              prior.lsp='normal',
                              par.lsp1=0,
                              par.lsp2=5))

model3 <-  cdtamodel(copula = 'fgm',
               modelargs = list(formula.se = StudyID ~ Test - 1))
\dontrun{
fit1 <- fit(model1,
                SID='ID',
                data=telomerase,
                iter=2000,
                warmup=1000,
                thin=1,
                seed=3)

traceplot(fit1)

traceplot(fit1) +
theme(axis.text.x = element_text(size=10, colour='black'),
      axis.text.y = element_text(size=10, colour='black'),
      axis.title.x = element_text(size=10, colour='black'),
      strip.text = element_text(size = 10, colour='black'),
      axis.title.y= element_text(size=10, angle=0, colour='black'),
      strip.text.y = element_text(size = 10, colour='black'),
      strip.text.x = element_text(size = 10, colour='black'),
      plot.background = element_rect(fill = "white", colour='white'),
      panel.grid.major = element_blank(),
      panel.background = element_blank(),
      strip.background = element_blank(),
      axis.line.x = element_line(color = 'black'),
      axis.line.y = element_line(color = 'black'))
}
}
\references{
{Nyaga VN, Arbyn M, Aerts M (2017). CopulaDTA: An R Package for Copula-Based Beta-Binomial Models for Diagnostic Test Accuracy
Studies in a Bayesian Framework. Journal of Statistical Software, 82(1), 1-27. doi:10.18637/jss.v082.c01}
}
\author{
Victoria N Nyaga
}
