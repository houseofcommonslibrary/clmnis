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
NULL

# Tell R CMD check about the dot operator in pipelines
if(getRversion() >= "2.15.1") {
    utils::globalVariables(c("."))
}
