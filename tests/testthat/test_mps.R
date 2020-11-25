### Test MPs functions
context("MPs functions")

# Imports ---------------------------------------------------------------------

source("validate.R")

# Mocks -----------------------------------------------------------------------

mock_fetch_query_data <- function(house, data_output) {
    switch(data_output,
        "BasicDetails" = read("mps_basic_details"),
        "Constituencies" = read("mps_constituencies"),
        "Parties" = read("mps_party_memberships"),
        "OtherParliaments" = read("mps_other_parliaments"),
        "ElectionsContested" = read("mps_contested_elections"),
        "GovernmentPosts" = read("mps_government_roles"),
        "OppositionPosts" = read("mps_opposition_roles"),
        "ParliamentaryPosts" = read("mps_parliamentary_roles"),
        "MaidenSpeeches" = read("mps_maiden_speeches"),
        "Addresses" = read("mps_addresses")
    )
}

# Tests -----------------------------------------------------------------------

test_that("fetch_mps processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "full_title",
            "current_status",
            "current_status_reason",
            "gender",
            "date_of_birth",
            "date_of_death")

        obs <- fetch_mps()
        exp <- readRDS("data/fetch_mps.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps(from_date = TEST_DATE, to_date = TEST_DATE)
        exp <- readRDS("data/fetch_mps_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_mps_memberships processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "seat_incumbency_start_date",
            "seat_incumbency_end_date")

        obs <- fetch_commons_memberships()
        exp <- readRDS("data/fetch_mps_memberships.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_commons_memberships(
            from_date = TEST_DATE,
            to_date = TEST_DATE)
        exp <- readRDS("data/fetch_mps_memberships_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_mps_party_memberships processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
          "mnis_id",
          "given_name",
          "family_name",
          "display_name",
          "party_mnis_id",
          "party_name",
          "party_membership_start_date",
          "party_membership_end_date")

        obs <- fetch_mps_party_memberships()
        exp <- readRDS("data/fetch_mps_party_memberships.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_party_memberships(
            from_date = TEST_DATE,
            to_date = TEST_DATE)
        exp <- readRDS("data/fetch_mps_party_memberships_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_party_memberships(while_mp = FALSE)
        exp <- readRDS("data/fetch_mps_party_memberships_while_mp.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_party_memberships(collapse = TRUE)
        exp <- readRDS("data/fetch_mps_party_memberships_collapse.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_mps_other_parliaments processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "other_parliaments_mnis_id",
            "other_parliaments_name",
            "other_parliaments_incumbency_start_date",
            "other_parliaments_incumbency_end_date")

        obs <- fetch_mps_other_parliaments()
        exp <- readRDS("data/fetch_mps_other_parliaments.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_other_parliaments(
            from_date = TEST_DATE,
            to_date = TEST_DATE)
        exp <- readRDS("data/fetch_mps_other_parliaments_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_mps_contested_elections processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "contested_election_mnis_id",
            "contested_election_name",
            "contested_election_date",
            "contested_election_type",
            "contested_election_constituency")

        obs <- fetch_mps_contested_elections()
        exp <- readRDS("data/fetch_mps_contested_elections.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_contested_elections(
            from_date = TEST_DATE,
            to_date = TEST_DATE)
        exp <- readRDS("data/fetch_mps_contested_elections_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_mps_government_roles processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "government_role_mnis_id",
            "government_role_name",
            "government_role_incumbency_start_date",
            "government_role_incumbency_end_date",
            "government_role_unpaid")

        obs <- fetch_mps_government_roles()
        exp <- readRDS("data/fetch_mps_government_roles.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_government_roles(
            from_date = TEST_DATE,
            to_date = TEST_DATE)
        exp <- readRDS("data/fetch_mps_government_roles_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_government_roles(while_mp = FALSE)
        exp <- readRDS("data/fetch_mps_government_roles_while_mp.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_mps_opposition_roles processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "opposition_role_mnis_id",
            "opposition_role_name",
            "opposition_role_incumbency_start_date",
            "opposition_role_incumbency_end_date",
            "opposition_role_unpaid")

        obs <- fetch_mps_opposition_roles()
        exp <- readRDS("data/fetch_mps_opposition_roles.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_opposition_roles(
            from_date = TEST_DATE,
            to_date = TEST_DATE)
        exp <- readRDS("data/fetch_mps_opposition_roles_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_opposition_roles(while_mp = FALSE)
        exp <- readRDS("data/fetch_mps_opposition_roles_while_mp.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_mps_parliamentary_roles processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "parliamentary_role_mnis_id",
            "parliamentary_role_name",
            "parliamentary_role_incumbency_start_date",
            "parliamentary_role_incumbency_end_date",
            "parliamentary_role_unpaid")

        obs <- fetch_mps_parliamentary_roles()
        exp <- readRDS("data/fetch_mps_parliamentary_roles.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_parliamentary_roles(
            from_date = TEST_DATE,
            to_date = TEST_DATE)
        exp <- readRDS("data/fetch_mps_parliamentary_roles_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_parliamentary_roles(while_mp = FALSE)
        exp <- readRDS("data/fetch_mps_parliamentary_roles_while_mp.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_mps_maiden_speeches processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "maiden_speech_house",
            "maiden_speech_date",
            "maiden_speech_hansard_reference",
            "maiden_speech_subject")

        obs <- fetch_mps_maiden_speeches()
        exp <- readRDS("data/fetch_mps_maiden_speeches.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_mps_maiden_speeches(
            from_date = TEST_DATE,
            to_date = TEST_DATE)
        exp <- readRDS("data/fetch_mps_maiden_speeches_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_mps_addresses processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "address_type_mnis_id",
            "address_type",
            "address_is_preferred",
            "address_is_physical",
            "address_note",
            "address_1",
            "address_2",
            "address_3",
            "address_4",
            "address_5",
            "postcode",
            "phone",
            "fax",
            "email",
            "address_other")

        obs <- fetch_mps_addresses()
        exp <- readRDS("data/fetch_mps_addresses.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})
