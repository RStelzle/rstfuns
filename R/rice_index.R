#' Calculating the Rice Index
#'
#' This function allows you to easily calculate the Rice Index for a given vote.
#' @param votecounts A vector containing the number of votes for yes and no in any given order. If a vector of length 1 is given, it is assumed that all votes were casted for the same option.
#' @keywords rollcall
#' @export
#' @examples
#' Examples of using calc_rice_index():
#'
#' test_rice <- c(15,2)
#'
#'test_rice_shorter <- c(15)
#'
#'test_rice_longer <- c(15,2,5)
#'
#'calc_rice_index(test_rice)
#'
#'calc_rice_index(test_rice_shorter)
#'
#'calc_rice_index(test_rice_longer)



calc_rice_index <- function(votecounts) {
  ifelse(  length(votecounts)<3,
         ifelse(length(votecounts)==1, 1,  RiceScore <- abs(max(votecounts)-min(votecounts))/sum(votecounts)),
         stop("Vector of No./Share of Yes and No Votes longer than two."))
}




