#' Function to generate a summary  a cdtafit object.

#' @return The posterior mean and 95 percent credible intervals, n_eff, Rhat and WAIC.
#' @param object An object from \link{fit}.
#' @param digits An optional positive value to control the number of digits to print when printing numeric values.
#' @param ... other \link[rstan]{stan} options.
#' @examples
#' data(telomerase)
#' model1 <-  cdtamodel(copula = 'fgm')
#'
#' model2 <- cdtamodel(copula = 'fgm',
#'                modelargs=list(param=2,
#'                               prior.lse='normal',
#'                               par.lse1=0,
#'                               par.lse2=5,
#'                               prior.lsp='normal',
#'                               par.lsp1=0,
#'                               par.lsp2=5))
#'
#' model3 <-  cdtamodel(copula = 'fgm',
#'                modelargs = list(formula.se = StudyID ~ Test - 1))
#' \dontrun{
#'
#' fit1 <- fit(model1,
#'                 SID='ID',
#'                 data=telomerase,
#'                 iter=2000,
#'                 warmup=1000,
#'                 thin=1,
#'                 seed=3)
#'
#' ss <- summary(fit1)
#'
#' }
#'@references {Nyaga VN, Arbyn M, Aerts M (2017). CopulaDTA: An R Package for Copula-Based Beta-Binomial Models for Diagnostic Test Accuracy
#'Studies in a Bayesian Framework. Journal of Statistical Software, 82(1), 1-27. doi:10.18637/jss.v082.c01}
#' @references {Watanabe S (2010). Asymptotic Equivalence of Bayes Cross Validation and Widely Applicable Information Criterion in Singular
#' Learning Theory. Journal of Machine Learning Research, 11, 3571-3594.}
#' @references {Vehtari A, Gelman A (2014). WAIC and Cross-validation in Stan. Unpublished, pp. 1-14.}
#' @export
#' @author Victoria N Nyaga

summary.cdtafit <- function(object, digits=3, ...){


#=======================Extract Model Parameters ===================================#
   sm <- rstan::summary(object@fit, ...)

   mu <- data.frame(sm$summary[grepl('MU', rownames(sm$summary)), c("mean", "2.5%", "50%", "97.5%", "n_eff", "Rhat")])
   var <- data.frame(sm$summary[grepl('Vars', rownames(sm$summary)), c("mean", "2.5%", "50%", "97.5%", "n_eff", "Rhat")])

    if (nrow(mu) > 2){
        ktau <- data.frame(sm$summary[grepl('ktau', rownames(sm$summary)), c("mean", "2.5%", "50%", "97.5%", "n_eff", "Rhat")])
        rr <- data.frame(sm$summary[grepl('RR', rownames(sm$summary)), c("mean", "2.5%", "50%", "97.5%", "n_eff", "Rhat")])
    } else {
        ktau <- sm$summary[grepl('ktau', rownames(sm$summary)), c("mean", "2.5%", "50%", "97.5%", "n_eff", "Rhat")]
    }

	p <- data.frame(sm$summary[grepl('p_i', rownames(sm$summary)), c("mean", "2.5%", "50%", "97.5%")])
    names(p) <- c("Mean", "Lower", "Median", "Upper")
    p$ID <- rep(1:(nrow(p)/2), each=2)

    p$Parameter <- rep(c("Sensitivity", "Specificity"), length.out=nrow(p))
#==========================Tranform omega to ktau in FRANK =========================================#
    if (object@copula=="frank"){
        if (nrow(mu) > 2){
            omega <- data.frame(sm$summary[grepl('betaomega', rownames(sm$summary)), c("mean", "2.5%", "50%", "97.5%", "n_eff", "Rhat")])
            for(i in 1:nrow(ktau)){
                ktau[i,1] <- omega.to.ktau(omega[i,1])
                ktau[i,2] <- omega.to.ktau(omega[i,2])
                ktau[i,3] <- omega.to.ktau(omega[i,3])
            }
        } else {
            omega <- sm$summary[grepl('betaomega', rownames(sm$summary)), c("mean", "2.5%", "50%", "97.5%", "n_eff", "Rhat")]
            ktau[1] <- omega.to.ktau(omega[1])
            ktau[2] <- omega.to.ktau(omega[2])
            ktau[3] <- omega.to.ktau(omega[3])
        }
    }
#===================================    =======         ============================================#
    if (nrow(mu) > 2){
        Summary <- rbind(mu, rr, ktau, var)
    } else {
        Summary <- rbind(mu, ktau, var)
        row.names(Summary)[3] <- "ktau[1]"
    }
#========================== ============================= =========================================#
    if (nrow(mu) > 2){
        Summary$Parameter <- c(rep(c("Sensitivity", "Specificity"), each=nrow(mu)/2),
                               rep(c("Sensitivity", "Specificity"), each=nrow(rr)/2),
                               rep("Correlation", each=nrow(ktau)),
                               rep(c("Var(Sens)", "Var(Spec)"), each=nrow(var)/2))
    } else {

        Summary$Parameter <- c(rep(c("Sensitivity", "Specificity"), each=nrow(mu)/2),
                               "Correlation",
                               rep(c("Var(Sens)", "Var(Spec)"), each=nrow(var)/2))
    }

    names(Summary) <- c("Mean", "Lower", "Median", "Upper", "n_eff", "Rhat", "Parameter")

    Summary <- Summary[,c("Parameter", "Mean", "Lower", "Median", "Upper", "n_eff", "Rhat")]

    w <- waic(object@fit)

    out <- list(Summary=Summary, p.i=p, WAIC=w, allsm=sm)

	return(out)
}

