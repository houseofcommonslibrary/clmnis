### Download data for unit testing Lords

# Imports ---------------------------------------------------------------------

source("tests/testthat/validate.R")

# Functions -------------------------------------------------------------------

#' Fetch mocks data for unit tests of Lords
#'
#' @keywords internal

fetch_lords_mocks_data <- function() {

    # Download Lords basic details
    l <- fetch_query_data(house = HOUSE_LORDS, "BasicDetails")
    write(l, "lords_basic_details")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords house memberships
    lhm <- fetch_query_data(house = HOUSE_LORDS, "HouseMemberships")
    write(lhm, "lords_house_memberships")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords party memberships
    lpm <- fetch_query_data(house = HOUSE_LORDS, "Parties")
    write(lpm, "lords_party_memberships")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords other parliaments
    lop <- fetch_query_data(house = HOUSE_LORDS, "OtherParliaments")
    write(lop, "lords_other_parliaments")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords contested elections
    lce <- fetch_query_data(house = HOUSE_LORDS, "ElectionsContested")
    write(lce, "lords_contested_elections")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords government roles
    lgr <- fetch_query_data(house = HOUSE_LORDS, "GovernmentPosts")
    write(lgr, "lords_government_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords opposition roles
    lor <- fetch_query_data(house = HOUSE_LORDS, "OppositionPosts")
    write(lor, "lords_opposition_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords parliamentary roles
    lpr <- fetch_query_data(house = HOUSE_LORDS, "ParliamentaryPosts")
    write(lpr, "lords_parliamentary_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords maiden speeches
    lms <- fetch_query_data(house = HOUSE_LORDS, "MaidenSpeeches")
    write(lms, "lords_maiden_speeches")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords addresses
    la <- fetch_query_data(house = HOUSE_LORDS, "Addresses")
    write(la, "lords_addresses")
    Sys.sleep(API_PAUSE_TIME)
}

#' Fetch validation data for unit tests of Lords
#'
#' @keywords internal

fetch_lords_validation_data <- function() {

    # Fetch Lords
    l <- fetch_lords()
    write(l, "fetch_lords")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords with from and to dates
    l <- fetch_lords(from_date = "2017-06-08", to_date = "2017-06-08")
    write(l, "fetch_lords_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords memberships
    lhm <- fetch_lords_memberships()
    write(lhm, "fetch_lords_memberships")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords memberships with from and to dates
    lhm <- fetch_lords_memberships(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(lhm, "fetch_lords_memberships_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords party memberships
    lpm <- fetch_lords_party_memberships()
    write(lpm, "fetch_lords_party_memberships")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords party memberships with from and to dates
    lpm <- fetch_lords_party_memberships(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(lpm, "fetch_lords_party_memberships_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords party memberships with while_lord
    lpm <- fetch_lords_party_memberships(while_lord = FALSE)
    write(lpm, "fetch_lords_party_memberships_while_lord")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords party memberships with collapse
    lpm <- fetch_lords_party_memberships(collapse = TRUE)
    write(lpm, "fetch_lords_party_memberships_collapse")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords other parliament memberships
    lop <- fetch_lords_other_parliaments()
    write(lop, "fetch_lords_other_parliaments")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords other parliament memberships with from and to dates
    lop <- fetch_lords_other_parliaments(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(lop, "fetch_lords_other_parliaments_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords contested elections
    lce <- fetch_lords_contested_elections()
    write(lce, "fetch_lords_contested_elections")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords contested elections with from and to dates
    lce <- fetch_lords_contested_elections(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(lce, "fetch_lords_contested_elections_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords government roles
    lgr <- fetch_lords_government_roles()
    write(lgr, "fetch_lords_government_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords government roles with from and to dates
    lgr <- fetch_lords_government_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(lgr, "fetch_lords_government_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords government roles with while_lord
    lgr <- fetch_lords_government_roles(while_lord = FALSE)
    write(lgr, "fetch_lords_government_roles_while_lord")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords opposition roles
    lor <- fetch_lords_opposition_roles()
    write(lor, "fetch_lords_opposition_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords opposition roles with from and to dates
    lor <- fetch_lords_opposition_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(lor, "fetch_lords_opposition_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords opposition roles with while_lord
    lor <- fetch_lords_opposition_roles(while_lord = FALSE)
    write(lor, "fetch_lords_opposition_roles_while_lord")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords parliamentary roles
    lpr <- fetch_lords_parliamentary_roles()
    write(lpr, "fetch_lords_parliamentary_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords parliamentary roles with from and to dates
    lpr <- fetch_lords_parliamentary_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(lpr, "fetch_lords_parliamentary_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords parliamentary roles with while_lord
    lpr <- fetch_lords_parliamentary_roles(while_lord = FALSE)
    write(lpr, "fetch_lords_parliamentary_roles_while_lord")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords maiden speeches
    lms <- fetch_lords_maiden_speeches()
    write(lms, "fetch_lords_maiden_speeches")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords maiden speeches with from and to dates
    lms <- fetch_lords_maiden_speeches(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(lms, "fetch_lords_maiden_speeches_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords addresses
    ma <- fetch_lords_addresses()
    write(ma, "fetch_lords_addresses")
    Sys.sleep(API_PAUSE_TIME)
}

# Fetch all data --------------------------------------------------------------

#' Fetch mocks and validation data for unit tests of Lords
#'
#' @keywords internal

fetch_lords_test_data <- function() {
    fetch_lords_mocks_data()
    fetch_lords_validation_data()
}
