#' mnis: A package for downloading data from the Parliamentary Members Name
#' Information Service
#'
#' The mnis package provides a suite of functions for downloading data from
#' the data platform for the UK Parliament.
#'
#' @docType package
#' @name mnis
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom data.table :=
NULL

# Tell R CMD check about the dot operator in pipelines
if(getRversion() >= "2.15.1") {
    utils::globalVariables(c(
        ".",
        ":=",
        "date_of_birth",
        "date_of_death",
        "seat_incumbency_end_date",
        "party_membership_end_date",
        "other_parliaments_incumbency_end_date",
        "contested_election_date",
        "@Member_Id"))
}
