#' Calculating the Rice Index
#'
#' This function allows you to easily enumerate content of a vector to one long string, including an "and" at the end.
#' @param itemsvector Your vector to be enumerated.
#' @param german Default==F If set to True enumerate() prints "und" instead of "and".
#' @param oxford Default==F If set to True enumerate() includes an oxford comma.
#' @keywords strings string
#' @export
#' @examples
#' Examples of using enumerate():
#'
#'examplevector <- c("Germany", "Italy", "Spain")
#'
#'enumerate(examplevector)
#'
#'enumerate(examplevector, german=T, oxford=T)



enumerate <- function(itemvector, german=F, oxford=F){

  strcount <- length(itemvector)

  coordinatingconjunction <- " and "
  if (german==T) {coordinatingconjunction <- " und "}

  if (oxford==T) {coordinatingconjunction <-  paste0(",", coordinatingconjunction)}





  if (length(itemvector)>1) {
    liste_items <- itemvector
    anzahl_items <- length(liste_items)

    items_string <- liste_items[1]

    if (anzahl_items==2) {
      items_string <- paste0(items_string, coordinatingconjunction, liste_items[length(liste_items)])
    } else {
      for (i in 2:(anzahl_items-1)) {
        items_string <- paste0(items_string,", ", liste_items[i])
      }
      items_string <- paste0(items_string, coordinatingconjunction , liste_items[length(liste_items)])

    }
  } else {items_string <- itemvector}

  print(items_string)

}



