#' Plotting Turnout from ParlGov Data
#'
#' This function allows you to easily plot election turnout for european countries. It plots turnout at elections for the national parliament as well as for the european parliaments if available. Data is sourced from the great ParlGov Dataset: Döring, Holger and Philip Manow. 2019. Parliaments and governments database (ParlGov): Information on parties, elections and cabinets in modern democracies. Development version. URL: http://www.parlgov.org/
#' @param countryname A vector of strings containing the english names of countries to be plotted.
#' @param german Default=False. If True text in the plot will be printed in German.
#' @keywords elections turnout
#' @export
#' @examples
#'
#' plot_turnout_parlgov("Spain")
#'
#' plot_turnout_parlgov(c("Poland","Germany"), german=T)


plot_turnout_parlgov <- function(countryname, german=F) {
  print(paste("Preparing turnout-plot for", countryname))

  ParlGovParties <- readr::read_csv("http://www.parlgov.org/static/data/development-utf-8/view_election.csv")
  ParlGovElections <- readr::read_csv("http://www.parlgov.org/static/data/development-utf-8/viewcalc_election_parameter.csv")


  df_election_dates <- ParlGovParties %>%
    dplyr::filter(country_name%in%countryname) %>%
    dplyr::select(election_id, election_date, election_type, country_name) %>%
    dplyr::distinct() %>%
    dplyr::mutate(election_type=dplyr::case_when(election_type=="ep"~"EP",
                                   election_type=="parliament"~"NP"))

  df_turnout <- ParlGovElections %>%
    dplyr::inner_join(df_election_dates) %>%
    dplyr::select(election_type, election_date, turnout, country_name)

  if (german==T) {

    if (length(countryname)>1) {
      df_turnout <- df_turnout %>%
        dplyr::mutate(country_name= countrycode::countrycode(country_name,  origin= "country.name", destination = "country.name.de"))



      liste_laender <- countrycode::countrycode(countryname, origin = "country.name", destination = "country.name.de")
      anzahl_laender <- length(liste_laender)

      laender_string <- liste_laender[1]

      if (anzahl_laender==2) {
        laender_string <- paste0(laender_string," und ", liste_laender[length(liste_laender)])
      } else {
        for (i in 2:(anzahl_laender-1)) {
          laender_string <- paste0(laender_string,", ", liste_laender[i])
        }
        laender_string <- paste0(laender_string," und ", liste_laender[length(liste_laender)])

      }
    } else {laender_string <-countrycode::countrycode(countryname, origin = "country.name", destination = "country.name.de")}


  } else {

    if (length(countryname)>1) {
  liste_laender <- countryname
  anzahl_laender <- length(liste_laender)

  laender_string <- liste_laender[1]

  if (anzahl_laender==2) {
    laender_string <- paste0(laender_string," and ", liste_laender[length(liste_laender)])
  } else {
    for (i in 2:(anzahl_laender-1)) {
      laender_string <- paste0(laender_string,", ", liste_laender[i])
    }
    laender_string <- paste0(laender_string," and ", liste_laender[length(liste_laender)])

  }
    } else {laender_string <- countryname}

  }



  print(laender_string)



  if (length(countryname)==1) {


  plot <- df_turnout %>%
    ggplot2::ggplot(ggplot2::aes(x=election_date, y=turnout, col=election_type))+
    ggplot2::geom_line(size=2) +
    ggplot2::geom_point(size=3) +
    ggplot2::scale_y_continuous(labels = function(x) paste0(x, "%"))+
    directlabels::geom_dl(ggplot2::aes(label = election_type), method = list(directlabels::dl.trans(x = x-0.2),
                                                      "first.points", cex = 1.2))

  } else {



   plot <-  df_turnout %>%
     ggplot2::ggplot(ggplot2::aes(x=election_date, y=turnout, col=election_type))+
     ggplot2::geom_line(size=2) +
     ggplot2::geom_point(size=3) +
     ggplot2::scale_y_continuous(labels = function(x) paste0(x, "%"))+
      directlabels::geom_dl(ggplot2::aes(label = election_type), method = list(directlabels::dl.trans(x = x-0.2),
                                                        "first.points", cex = 1.2))+
     ggplot2::facet_wrap(~country_name, scales = "free_x")

  }

  if (german==T) {
    plot <- plot +
      ggplot2::ylab("Wahlbeteiligung")+
      ggplot2::xlab("Jahr")+
      ggplot2::labs(title = paste("Wahlbeteiligung bei Wahlen zum nationalen Parlament (NP)\n und zum Europaparlament (EP) in",
                         laender_string),
           caption="Datenquelle:\nDöring, Holger und Philip Manow. 2019.
       Parliaments and governments database (ParlGov): Information on parties, elections and
       cabinets in modern democracies. Development version.
       URL: http://www.parlgov.org/data/table/viewcalc_election_parameter/")
  } else {

    plot <- plot +
      ggplot2::ylab("Turnout")+
      ggplot2::xlab("Year")+
      ggplot2::labs(title = paste("Turnout at elections for the national parliament (NP)\n and for the european parliament (EP) in",
                         laender_string),
           caption="Data source:\nDöring, Holger and Philip Manow. 2019.
       Parliaments and governments database (ParlGov): Information on parties, elections and
       cabinets in modern democracies. Development version.
       URL: http://www.parlgov.org/data/table/viewcalc_election_parameter/")

  }

  plot +
    ggplot2::scale_color_manual(values=c("blue", "red")) +
    ggthemes::theme_clean()+
    ggplot2::theme(legend.position = "none")+
    ggplot2::theme(text=ggplot2::element_text(size=16))+
    ggplot2::theme(axis.text.y=ggplot2::element_text(size = 14))+
    ggplot2::theme(axis.text.x=ggplot2::element_text(size = 14))+
    ggplot2::theme(plot.caption = ggplot2::element_text(hjust = 0))

  }
