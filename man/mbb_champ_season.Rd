% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mbb_fns.R
\name{mbb_champ_season}
\alias{mbb_champ_season}
\title{Get NCAA championship winning seasons from a team's historical match data.}
\usage{
mbb_champ_season(df, type = "NCAA")
}
\arguments{
\item{df}{Input data frame containing a team's historical match data that are included in uncmbb package.}

\item{type}{Match type. NCAA (default).}
}
\value{
Team's championship (either NCAA or CTOURN) winning seasons (if any).
}
\description{
Get NCAA championship winning seasons from a team's historical match data.
}
\examples{
mbb_champ_season(unc)
}
