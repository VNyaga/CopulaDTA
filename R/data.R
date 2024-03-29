#' Telomerase dataset
#'
#' Glas et al. (2003) systematically reviewed the sensitivity and specificity of cytology and other
#' markers including telomerase for primary diagnosis of bladder cancer.
#'
#' @format A data frame of ten observations and five variables:
#' \describe{
#'  \item{ID}{Study identifier}
#'  \item{TP}{Number of true positives}
#'  \item{FN}{number of false negatives}
#'  \item{TN}{number of true negatives}
#'  \item{FP}{number of false positives}
#' }
#' @docType data
#' @name telomerase
#' @usage data(telomerase)
#' @references {Glas AS, Roos D, Deutekom M, Zwinderman AH, Bossuyt PMM, Kurth KH (2003). Tumor Markers in the Diagnosis of Primary Bladder Cancer.
#' A Systematic Review. The Journal of Urology, 169(6), 1975-1982.}
#'@references {Nyaga VN, Arbyn M, Aerts M (2017). CopulaDTA: An R Package for Copula-Based Beta-Binomial Models for Diagnostic Test Accuracy
#'Studies in a Bayesian Framework. Journal of Statistical Software, 82(1), 1-27. doi:10.18637/jss.v082.c01}
NULL

#' ASCUS dataset
#'
#' Arbyn et al. (2013) performed a Cochrane review on the accuracy of human papillomavirus
#' testing (HC2)and repeat cytology (RepC) to triage of women with an equivocal Pap smear to diagnose cervical precancer.
#'
#' @format A data frame of 20 observations and six variables:
#' \describe{
#'  \item{StudyID}{Study identifier}
#'  \item{Test}{Type of diagnostic test}
#'  \item{TP}{Number of true positives}
#'  \item{FN}{number of false negatives}
#'  \item{TN}{number of true negatives}
#'  \item{FP}{number of false positives}
#' }
#' @docType data
#' @name ascus
#' @usage data(ascus)
#' @references {Arbyn M, Roelens J, Simoens C, Buntinx F, Paraskevaidis E, Martin-Hirsch PPL, Prendiville W (2013). Human Papillomavirus Testing Versus Repeat
#' Cytology for Triage of Minor Cytological Cervical Lesions." Cochrane Database of Systematic Reviews, pp. 31-201.}
#'@references {Nyaga VN, Arbyn M, Aerts M (2017). CopulaDTA: An R Package for Copula-Based Beta-Binomial Models for Diagnostic Test Accuracy
#'Studies in a Bayesian Framework. Journal of Statistical Software, 82(1), 1-27. doi:10.18637/jss.v082.c01}
NULL
