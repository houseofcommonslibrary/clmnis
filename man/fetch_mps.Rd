% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mps.R
\name{fetch_mps}
\alias{fetch_mps}
\title{Fetch key details for all MPs}
\usage{
fetch_mps(from_date = NA, to_date = NA, on_date = NA)
}
\arguments{
\item{from_date}{A string or Date representing a date. If a string is used
it should specify the date in ISO 8601 date format e.g. '2000-12-31'. The
default value is NA, which means no records are excluded on the basis of
the from_date.}

\item{to_date}{A string or Date representing a date. If a string is used
it should specify the date in ISO 8601 date format e.g. '2000-12-31'. The
default value is NA, which means no records are excluded on the basis of
the to_date.}

\item{on_date}{A string or Date representing a date. If a string is used
it should specify the date in ISO 8601 date format e.g. '2000-12-31'. The
default value is NA, which means no records are excluded on the basis of
the on_date.}
}
\value{
A tibble of key details for each MP, with one row per MP.
}
\description{
\code{fetch_mps} fetches data from the Members Names platform showing
key details about each MP, with one row per MP.
}
\details{
The from_date and to_date arguments can be used to filter MPs returned based
on the dates of their Commons memberships. The on_date argument is a
convenience that sets the from_date and to_date to the same given date. The
on_date has priority: if the on_date is set, the from_date and to_date are
ignored.

The filtering is inclusive: an MP is returned if any part of one of their
Commons memberships falls within the period specified with the from and to
dates.
}
