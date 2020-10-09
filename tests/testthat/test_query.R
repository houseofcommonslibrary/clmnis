### Test API query function
context("Query API function")

# Basic MP query columns

basic_query_cols <- c(
    "@Member_Id",
    "@Dods_Id",
    "@Pims_Id",
    "@Clerks_Id",
    "DisplayAs",
    "ListAs",
    "FullTitle",
    "LayingMinisterName",
    "DateOfBirth",
    "DateOfDeath",
    "Gender",
    "Party",
    "House",
    "MemberFrom",
    "HouseStartDate",
    "HouseEndDate",
    "CurrentStatus",
    "BasicDetails")

# Tests -----------------------------------------------------------------------

test_that("fetch_query_data sends and receives basic MP query", {

    # Create query
    query <- create_query(HOUSE_COMMONS, "BasicDetails")

    # Fetch data
    response <- httr::GET(query, httr::accept_json())
    check_query_status(response$status)
    query_text <- httr::content(response, as = "text")
    query_json <- suppressWarnings(jsonlite::fromJSON(query_text))
    query_data <- query_json$Members$Member

    expect_equal(response$status_code, 200)
    expect_equal(ncol(query_data), 18)
    expect_equal(colnames(query_data), basic_query_cols)

})

test_that("fetch_query_data sends and receives basic Lord query", {

    # Create query
    query <- create_query(HOUSE_LORDS, "BasicDetails")

    # Fetch data
    response <- httr::GET(query, httr::accept_json())
    check_query_status(response$status)
    query_text <- httr::content(response, as = "text")
    query_json <- suppressWarnings(jsonlite::fromJSON(query_text))
    query_data <- query_json$Members$Member

    expect_equal(response$status_code, 200)
    expect_equal(ncol(query_data), 18)
    expect_equal(colnames(query_data), basic_query_cols)

})


