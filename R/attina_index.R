#' Calculating Attina's Index of Agreement
#'
#' This function allows you to easily calculate Attina´s Index of Agreement for a given vote.
#' @param votecounts A vector containing the number or share of votes for yes, no and abstain in any given order. If a vector of a shorter length than 3 is given, the count/frequency of the missing vote option(s) is assumed to be 0.
#' @param rescale Default: FALSE. If TRUE the result gets rescaled from its former range of -33.333 to 100 to a range of 0 to 1. A value of 0.25 now represents that 50\% of the values were casted for one of the options.
#' @keywords rollcall
#' @export
#' @examples
#' Examples of using calc_attina_index() :
#'
#'test_attina <- c(15, 2, 5)
#'
#'test_attina_shorter <- c(15,2)
#'
#'test_attina_longer <- c(15,2,5,6)
#'
#'calc_attina_index(test_attina)
#'
#'calc_attina_index(test_attina_shorter)
#'
#'calc_attina_index(test_attina_longer)




calc_attina_index <- function(votecounts, rescale=FALSE) {
  ifelse(length(votecounts)<4,
    ifelse(!rescale, AIScore <-((max(votecounts)-(sum(votecounts)-max(votecounts)))/sum(votecounts))*100,
           AIScore <-((( (max(votecounts) - (sum(votecounts)-max(votecounts)) )/ sum(votecounts))*100) +    (33+1/3)     ) / (133+1/3)    ),
  stop("Vector of No./Share of Yes, No and Abstain Votes longer than three."))
  return(AIScore)
}

