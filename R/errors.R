### Package errors

#' Report an error handling dataframes with missing columms
#'
#' @param colname The name of the column that could not be found.
#' @keywords internal

missing_column_error <- function(colname) {
    stringr::str_glue("Could not find a column called {colname}")
}

#' Report an error parsing a date string
#'
#' @param date_str The date string that could not be parsed.
#' @keywords internal

date_format_error <- function(date_str) {
    stringr::str_glue(stringr::str_c(
        "{date_str} is not a valid Date or ",
        "date string: use format \"YYYY-MM-DD\""))
}

#' Report an error from API call
#'
#' @param status The status from the API.
#' @keywords internal

check_query_status <- function(status) {
    if (status != 200) {
        stop(stringr::str_glue(
            "The response from the API had the following status: {status}"))
    }
}
