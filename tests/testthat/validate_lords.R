### Download data for unit testing Lords

# Imports -------------------------------------------------------------------

source("tests/testthat/validate.R")

# Functions -------------------------------------------------------------------

#' Fetch mocks data for unit tests of Lords
#'
#' @keywords internal

fetch_lords_mocks_data <- function() {

    # Download Lords
    l <- fetch_lords_raw()
    write(l, "lords_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords memberships
    cm <- fetch_lords_memberships_raw()
    write(cm, "lords_memberships_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords party memberships
    pm <- fetch_lords_party_memberships_raw()
    write(pm, "lords_party_memberships_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords other parliaments memberships
    op <- fetch_lords_other_parliaments_raw()
    write(op, "lords_other_parliaments_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords contested elections
    ce <- fetch_lords_contested_elections_raw()
    write(ce, "lords_contested_elections_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords government roles
    gor <- fetch_lords_government_roles_raw()
    write(gor, "lords_government_roles_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords opposition roles
    opr <- fetch_lords_opposition_roles_raw()
    write(opr, "lords_opposition_roles_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords parliamentary roles
    pmr <- fetch_lords_parliamentary_roles_raw()
    write(pmr, "lords_parliamentary_roles_raw")
    Sys.sleep(API_PAUSE_TIME)

    # Download Lords maiden speeches
    mds <- fetch_lords_maiden_speeches_raw()
    write(mds, "lords_maiden_speeches_raw")
    Sys.sleep(API_PAUSE_TIME)
}

#' Fetch validation data for unit tests of Lords
#'
#' @keywords internal

fetch_lords_validation_data <- function() {

    # Fetch Lords
    m <- fetch_lords()
    write(m, "fetch_lords")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords with from and to dates
    l <- fetch_lords(from_date = "2017-06-08", to_date = "2017-06-08")
    write(l, "fetch_lords_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords memberships
    lm <- fetch_lords_memberships()
    write(lm, "fetch_lords_memberships")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords memberships with from and to dates
    lm <- fetch_lords_memberships(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(lm, "fetch_lords_memberships_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords party memberships
    pm <- fetch_lords_party_memberships()
    write(pm, "fetch_lords_party_memberships")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords party memberships with from and to dates
    pm <- fetch_lords_party_memberships(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(pm, "fetch_lords_party_memberships_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords party memberships with while_lord
    pm <- fetch_lords_party_memberships(while_lord = FALSE)
    write(pm, "fetch_lords_party_memberships_while_lord")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords party memberships with collapse
    pm <- fetch_lords_party_memberships(collapse = TRUE)
    write(pm, "fetch_lords_party_memberships_collapse")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords other parliament memberships
    op <- fetch_lords_other_parliaments()
    write(op, "fetch_lords_other_parliaments")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords other parliament memberships with from and to dates
    op <- fetch_lords_other_parliaments(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(op, "fetch_lords_other_parliaments_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords contested elections
    ce <- fetch_lords_contested_elections()
    write(ce, "fetch_lords_contested_elections")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords contested elections with from and to dates
    ce <- fetch_lords_contested_elections(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(ce, "fetch_lords_contested_elections_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords government roles
    gor <- fetch_lords_government_roles()
    write(gor, "fetch_lords_government_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords government roles with from and to dates
    gor <- fetch_lords_government_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(gor, "fetch_lords_government_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords government roles with while_lord
    gor <- fetch_lords_government_roles(while_lord = FALSE)
    write(gor, "fetch_lords_government_roles_while_lord")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords opposition roles
    opr <- fetch_lords_opposition_roles()
    write(opr, "fetch_lords_opposition_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords opposition roles with from and to dates
    opr <- fetch_lords_opposition_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(opr, "fetch_lords_opposition_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords opposition roles with while_lord
    opr <- fetch_lords_opposition_roles(while_lord = FALSE)
    write(opr, "fetch_lords_opposition_roles_while_lord")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords parliamentary roles
    pmr <- fetch_lords_parliamentary_roles()
    write(pmr, "fetch_lords_parliamentary_roles")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords parliamentary roles with from and to dates
    pmr <- fetch_lords_parliamentary_roles(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(pmr, "fetch_lords_parliamentary_roles_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords parliamentary roles with while_lord
    pmr <- fetch_lords_parliamentary_roles(while_lord = FALSE)
    write(pmr, "fetch_lords_parliamentary_roles_while_lord")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords maiden speeches
    mds <- fetch_lords_maiden_speeches()
    write(mds, "fetch_lords_maiden_speeches")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords maiden speeches with from and to dates
    mds <- fetch_lords_maiden_speeches(
        from_date = "2017-06-08", to_date = "2017-06-08")
    write(mds, "fetch_lords_maiden_speeches_from_to")
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
