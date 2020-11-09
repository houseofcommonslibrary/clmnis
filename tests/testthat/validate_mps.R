### Download data for unit testing MPs

# Imports -------------------------------------------------------------------

source("tests/testthat/validate.R")

# Functions -------------------------------------------------------------------

#' Fetch mocks data for unit tests of MPs
#'
#' @keywords internal

fetch_mps_mocks_data <- function() {

    # Download MPs basic details
    m <- fetch_query_data(house = HOUSE_COMMONS, "BasicDetails")
    write(m, "mps_basic_details")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs house memberships
    mhm <- fetch_query_data(house = HOUSE_COMMONS, "Constituencies")
    write(mhm, "mps_constituencies")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs party memberships
    mpm <- fetch_query_data(house = HOUSE_COMMONS, "Parties")
    write(mpm, "mps_party_memberships")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs other parliaments
    mop <- fetch_query_data(house = HOUSE_COMMONS, "OtherParliaments")
    write(mop, "mps_other_parliaments")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs contested elections
    mce <- fetch_query_data(house = HOUSE_COMMONS, "ElectionsContested")
    write(mce, "mps_contested_elections")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs government roles
    mgr <- fetch_query_data(house = HOUSE_COMMONS, "GovernmentPosts")
    write(mgr, "mps_government_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs opposition roles
    mor <- fetch_query_data(house = HOUSE_COMMONS, "OppositionPosts")
    write(mor, "mps_opposition_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs parliamentary roles
    mpr <- fetch_query_data(house = HOUSE_COMMONS, "ParliamentaryPosts")
    write(mpr, "mps_parliamentary_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs maiden speeches
    mms <- fetch_query_data(house = HOUSE_COMMONS, "MaidenSpeeches")
    write(mms, "mps_maiden_speeches")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs addresses
    ma <- fetch_query_data(house = HOUSE_COMMONS, "Addresses")
    write(ma, "mps_addresses")
    Sys.sleep(API_PAUSE_TIME)
}

#' Fetch validation data for unit tests of MPs
#'
#' @keywords internal

fetch_mps_validation_data <- function() {

    # Fetch MPs
    m <- fetch_mps()
    write(m, "fetch_mps")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs with from and to dates
    m <- fetch_mps(from_date = "2017-06-08", to_date = "2017-06-08")
    write(m, "fetch_mps_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Commons memberships
    mhm <- fetch_commons_memberships()
    write(mhm, "fetch_mps_memberships")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Commons memberships with from and to dates
    mhm <- fetch_commons_memberships(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(mhm, "fetch_mps_memberships_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs party memberships
    mpm <- fetch_mps_party_memberships()
    write(mpm, "fetch_mps_party_memberships")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs party memberships with from and to dates
    mpm <- fetch_mps_party_memberships(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(mpm, "fetch_mps_party_memberships_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs party memberships with while_mp
    mpm <- fetch_mps_party_memberships(while_mp = FALSE)
    write(mpm, "fetch_mps_party_memberships_while_mp")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs party memberships with collapse
    mpm <- fetch_mps_party_memberships(collapse = TRUE)
    write(mpm, "fetch_mps_party_memberships_collapse")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs other parliament memberships
    mop <- fetch_mps_other_parliaments()
    write(mop, "fetch_mps_other_parliaments")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs other parliament memberships with from and to dates
    mop <- fetch_mps_other_parliaments(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(mop, "fetch_mps_other_parliaments_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs contested elections
    mce <- fetch_mps_contested_elections()
    write(mce, "fetch_mps_contested_elections")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs contested elections with from and to dates
    mce <- fetch_mps_contested_elections(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(mce, "fetch_mps_contested_elections_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs government roles
    mgr <- fetch_mps_government_roles()
    write(mgr, "fetch_mps_government_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs government roles with from and to dates
    mgr <- fetch_mps_government_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(mgr, "fetch_mps_government_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs government roles with while_mp
    mgr <- fetch_mps_government_roles(while_mp = FALSE)
    write(mgr, "fetch_mps_government_roles_while_mp")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs opposition roles
    mor <- fetch_mps_opposition_roles()
    write(mor, "fetch_mps_opposition_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs opposition roles with from and to dates
    mor <- fetch_mps_opposition_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(mor, "fetch_mps_opposition_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs opposition roles with while_mp
    mor <- fetch_mps_opposition_roles(while_mp = FALSE)
    write(mor, "fetch_mps_opposition_roles_while_mp")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs parliamentary roles
    mpr <- fetch_mps_parliamentary_roles()
    write(mpr, "fetch_mps_parliamentary_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs parliamentary roles with from and to dates
    mpr <- fetch_mps_parliamentary_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(mpr, "fetch_mps_parliamentary_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs parliamentary roles with while_mp
    mpr <- fetch_mps_parliamentary_roles(while_mp = FALSE)
    write(mpr, "fetch_mps_parliamentary_roles_while_mp")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs maiden speeches
    mms <- fetch_mps_maiden_speeches()
    write(mms, "fetch_mps_maiden_speeches")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs maiden speeches with from and to dates
    mms <- fetch_mps_maiden_speeches(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(mms, "fetch_mps_maiden_speeches_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs addresses
    ma <- fetch_mps_addresses()
    write(ma, "fetch_mps_addresses")
    Sys.sleep(API_PAUSE_TIME)
}

# Fetch all data --------------------------------------------------------------

#' Fetch mocks and validation data for unit tests of MPs
#'
#' @keywords internal

fetch_mps_test_data <- function() {
    fetch_mps_mocks_data()
    fetch_mps_validation_data()
}
