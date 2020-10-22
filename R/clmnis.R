#' clmnis: A package for downloading data from the Parliamentary Members Name
#' Information Service
#'
#' The clmnis package provides a suite of functions for downloading data from
#' the data platform for the UK Parliament.
#'
#' @docType package
#' @name mnis
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom data.table :=
NULL

# Tell R CMD check about the rlang operators in pipelines
if(getRversion() >= "2.15.1") {
    utils::globalVariables(c(".", ":="))
}
