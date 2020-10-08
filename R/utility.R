### Utility functions used across the package

# API query funcitons ---------------------------------------------------------

#' Create query string
#'
#' @keywords internal

create_query <- function(house, data_output) {
   stringr::str_glue(
      "{MNIS_API}House={house}|Membership=all/{data_output}")
}

#' Fetch data from MNIS based on given query
#'
#' @keywords internal

fetch_query_data <- function(house, data_output) {

   # Create query
   query <- create_query(house, data_output)

   # Fetch data
   query_data <- httr::GET(query, httr::accept_json())
   check_query_status(query_data$status)
   query_data <- httr::content(query_data, as = "text")
   query_data <- suppressWarnings(jsonlite::fromJSON(query_data))
   query_data$Members$Member
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

#' Extract data output
#'
#' @keywords internal

extract_data_output <- function(data_output, col_section_a, col_section_b) {
   data_output <- purrr::map_df(data_output$`@Member_Id`, function(member) {
      mnis_id <- member
      data_output <- dplyr::filter(data_output, `@Member_Id` == mnis_id)
      data_output <- purrr::pluck(data_output[[{{ col_section_a }}]][[{{ col_section_b }}]])
      data_output[[1]][["mnis_id"]] <- mnis_id
      data_output <- purrr::discard(data_output[[1]], is.null)
      data_output
   })
   tibble::as_tibble(data_output)
}

#' Combine basic MP data with output table
#'
#' @keywords internal

process_mps_output <- function(output_table) {

   # Fetch basic details
   mps <- fetch_mps_raw() %>%
      dplyr::select(
         .data$mnis_id,
         .data$given_name,
         .data$family_name,
         .data$display_name)

   # Join tables and tidy
   output <- dplyr::left_join(output_table, mps, by = "mnis_id") %>%
      dplyr::select(
         .data$mnis_id,
         .data$given_name,
         .data$family_name,
         .data$display_name,
         dplyr::everything())
}

#' Combine basic Lords data with output table
#'
#' @keywords internal

process_lords_output <- function(output_table) {

   # Fetch basic details
   lords <- fetch_lords_raw() %>%
      dplyr::select(
         .data$mnis_id,
         .data$given_name,
         .data$family_name,
         .data$display_name)

   # Join tables and tidy
   output <- dplyr::left_join(output_table, lords, by = "mnis_id") %>%
      dplyr::select(
         .data$mnis_id,
         .data$given_name,
         .data$family_name,
         .data$display_name,
         dplyr::everything())
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
