### Manage test data for validation

# Read and write data ---------------------------------------------------------

#' Read a file from the data directory
#'
#' @keywords internal

read <- function(filename) {
    readRDS(stringr::str_glue("tests/testthat/data/{filename}.RData"))
}

#' Write a tibble to the data directory
#'
#' @keywords internal

write <- function(df, filename) {
    saveRDS(df, stringr::str_glue("tests/testthat/data/{filename}.RData"))
}

# Comparison function ---------------------------------------------------------

#' Compare two dataframes on structure and contents of selected columns
#'
#' @keywords internal

compare_obs_exp <- function(obs, exp, cols, sort_col) {

    obs <- obs %>% dplyr::arrange(.data[[sort_col]])
    exp <- exp %>% dplyr::arrange(.data[[sort_col]])

    expect_true(all(cols %in% colnames(exp)))
    expect_equal(nrow(obs), nrow(exp))
    expect_equal(ncol(obs), ncol(exp))
    expect_equal(colnames(obs), colnames(exp))

    for (col in cols) {
        expect_equal(obs[[col]], exp[[col]])
    }
}
