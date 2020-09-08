### Utility functions used across the package

# API functions ---------------------------------------------------------------

#' Fetch data from MNIS based on given query
#'
#' @keywords internal

fetch_query_data <- function(query) {
   query_data <- httr::GET(query, httr::accept_json())
   check_query_status(query_data$status)
   query_data <- httr::content(query_data, as = "text")
   query_data <- suppressWarnings(jsonlite::fromJSON(query_data))
}

# Data handling functions -----------------------------------------------------

#' Convert a column with lists representing missing values to NA
#'
#' @keywords internal

process_missing_values <- function(data, column) {
   data %>%
      dplyr::filter({{ column }} != "http://www.w3.org/2001/XMLSchema-instance") %>%
      dplyr::mutate({{ column }} := ifelse({{ column }} %in% c("true", MISSING_VALUE_STRING), NA, {{ column }}))
}

#' Calculate current age of member
#'
#' @keywords internal

process_member_age <- function(from, to) {
   to <- tidyr::replace_na(to, Sys.Date())
   floor(lubridate::decimal_date(to) - lubridate::decimal_date(from))
}

# Date handling functions -----------------------------------------------------

#' Cast a numeric value to a Date
#'
#' @keywords internal

cast_date <- function(date_num) {
   tryCatch(
      as.Date(date_num, origin = "1970-01-01"),
      error = function(e) stop("Could not cast numeric to date"))
}

#' Parse an ISO 8601 date from a string
#'
#' @keywords internal

parse_date <- function(date_str) {

   valid_pattern <- "^\\d{4}\\-(0[1-9]|1[012])\\-(0[1-9]|[12][0-9]|3[01])$"
   if (! grepl(valid_pattern, date_str)) stop(date_format_error(date_str))

   tryCatch(
      as.Date(date_str, origin = "1970-01-01"),
      error = function(e) stop(date_format_error(date_str)))
}
