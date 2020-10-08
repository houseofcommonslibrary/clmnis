### Download data for unit testing MPs

# Imports -------------------------------------------------------------------

source("tests/testthat/validate.R")

# Functions -------------------------------------------------------------------

#' Fetch mocks data for unit tests of MPs
#'
#' @keywords internal

fetch_mps_mocks_data <- function() {

    # Download MPs
    l <- fetch_mps_raw()
    write(l, "mps_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs memberships
    cm <- fetch_commons_memberships_raw()
    write(cm, "mps_memberships_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs party memberships
    pm <- fetch_mps_party_memberships_raw()
    write(pm, "mps_party_memberships_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs other parliaments memberships
    op <- fetch_mps_other_parliaments_raw()
    write(op, "mps_other_parliaments_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs contested elections
    ce <- fetch_mps_contested_elections_raw()
    write(ce, "mps_contested_elections_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs government roles
    gor <- fetch_mps_government_roles_raw()
    write(gor, "mps_government_roles_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs opposition roles
    opr <- fetch_mps_opposition_roles_raw()
    write(opr, "mps_opposition_roles_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs parliamentary roles
    pmr <- fetch_mps_parliamentary_roles_raw()
    write(pmr, "mps_parliamentary_roles_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download MPs maiden speeches
    mds <- fetch_mps_maiden_speeches_raw()
    write(mds, "mps_maiden_speeches_raw")
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
    l <- fetch_mps(from_date = "2017-06-08", to_date = "2017-06-08")
    write(l, "fetch_mps_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Commons memberships
    lm <- fetch_commons_memberships()
    write(lm, "fetch_mps_memberships")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Commons memberships with from and to dates
    lm <- fetch_commons_memberships(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(lm, "fetch_mps_memberships_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs party memberships
    pm <- fetch_mps_party_memberships()
    write(pm, "fetch_mps_party_memberships")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs party memberships with from and to dates
    pm <- fetch_mps_party_memberships(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(pm, "fetch_mps_party_memberships_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs party memberships with while_mp
    pm <- fetch_mps_party_memberships(while_mp = FALSE)
    write(pm, "fetch_mps_party_memberships_while_mp")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs party memberships with collapse
    pm <- fetch_mps_party_memberships(collapse = TRUE)
    write(pm, "fetch_mps_party_memberships_collapse")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs other parliament memberships
    op <- fetch_mps_other_parliaments()
    write(op, "fetch_mps_other_parliaments")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs other parliament memberships with from and to dates
    op <- fetch_mps_other_parliaments(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(op, "fetch_mps_other_parliaments_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs contested elections
    ce <- fetch_mps_contested_elections()
    write(ce, "fetch_mps_contested_elections")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs contested elections with from and to dates
    ce <- fetch_mps_contested_elections(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(ce, "fetch_mps_contested_elections_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs government roles
    gor <- fetch_mps_government_roles()
    write(gor, "fetch_mps_government_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs government roles with from and to dates
    gor <- fetch_mps_government_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(gor, "fetch_mps_government_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs government roles with while_mp
    gor <- fetch_mps_government_roles(while_mp = FALSE)
    write(gor, "fetch_mps_government_roles_while_mp")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs opposition roles
    opr <- fetch_mps_opposition_roles()
    write(opr, "fetch_mps_opposition_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs opposition roles with from and to dates
    opr <- fetch_mps_opposition_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(opr, "fetch_mps_opposition_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs opposition roles with while_mp
    opr <- fetch_mps_opposition_roles(while_mp = FALSE)
    write(opr, "fetch_mps_opposition_roles_while_mp")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs parliamentary roles
    pmr <- fetch_mps_parliamentary_roles()
    write(pmr, "fetch_mps_parliamentary_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs parliamentary roles with from and to dates
    pmr <- fetch_mps_parliamentary_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(pmr, "fetch_mps_parliamentary_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs parliamentary roles with while_mp
    pmr <- fetch_mps_parliamentary_roles(while_mp = FALSE)
    write(pmr, "fetch_mps_parliamentary_roles_while_mp")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs maiden speeches
    mds <- fetch_mps_maiden_speeches()
    write(mds, "fetch_mps_maiden_speeches")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs maiden speeches with from and to dates
    mds <- fetch_mps_maiden_speeches(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(mds, "fetch_mps_maiden_speeches_from_to")
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
