### Test MPs functions
context("MPs functions")

# Imports ---------------------------------------------------------------------

source("validate.R")

# Mocks -----------------------------------------------------------------------

mock_fetch_mps_raw <- function() {
    read("mps_raw")
}

mock_fetch_mps_memberships_raw <- function() {
    read("mps_memberships_raw")
}

mock_fetch_mps_party_memberships_raw <- function() {
    read("mps_party_memberships_raw")
}

mock_fetch_mps_other_parliaments_raw <- function() {
    read("mps_other_parliaments_raw")
}

mock_fetch_mps_contested_elections_raw <- function() {
    read("mps_contested_elections_raw")
}

mock_fetch_mps_government_roles_raw <- function() {
    read("mps_government_roles_raw")
}

mock_fetch_mps_opposition_roles_raw <- function() {
    read("mps_opposition_roles_raw")
}

mock_fetch_mps_parliamentary_roles_raw <- function() {
    read("mps_parliamentary_roles_raw")
}

mock_fetch_mps_maiden_speeches_raw <- function() {
    read("mps_maiden_speeches_raw")
}

# Tests -----------------------------------------------------------------------

test_that("fetch_mps processes results correctly.", {
    with_mock(
        "mnis::fetch_mps_raw" = mock_fetch_mps_raw,
        "mnis::fetch_mps_memberships" = mock_fetch_mps_memberships_raw, {

            cols <- c(
                "mnis_id",
                "given_name",
                "family_name",
                "display_name",
                "full_title",
                "gender",
                "current_age",
                "date_of_birth",
                "date_of_death")

            obs <- fetch_mps()
            exp <- read("fetch_mps")
            compare_obs_exp(obs, exp, cols, "mnis_id")

            obs <- fetch_mps(from_date = "2017-06-08", to_date = "2017-06-08")
            exp <- read("fetch_mps_from_to")
            compare_obs_exp(obs, exp, cols, "mnis_id")
        })
})

test_that("fetch_mps_memberships processes results correctly.", {
    with_mock(
        "mnis::fetch_mps_memberships_raw" =
            mock_fetch_mps_memberships_raw, {

                cols <- c(
                    "mnis_id",
                    "given_name",
                    "family_name",
                    "display_name",
                    "seat_incumbency_id",
                    "seat_incumbency_start_date")

                obs <- fetch_mps_memberships()
                exp <- read("fetch_mps_memberships")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_mps_memberships(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_mps_memberships_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_mps_party_memberships processes results correctly.", {
    with_mock("mnis::fetch_mps_party_memberships_raw" =
                  mock_fetch_mps_party_memberships_raw, {

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
                      exp <- read("fetch_mps_party_memberships")
                      compare_obs_exp(obs, exp, cols, "mnis_id")

                      obs <- fetch_mps_party_memberships(
                          from_date = "2017-06-08",
                          to_date = "2017-06-08")
                      exp <- read("fetch_mps_party_memberships_from_to")
                      compare_obs_exp(obs, exp, cols, "mnis_id")

                      obs <- fetch_mps_party_memberships(while_mp = FALSE)
                      exp <- read("fetch_mps_party_memberships_while_mp")
                      compare_obs_exp(obs, exp, cols, "mnis_id")

                      obs <- fetch_mps_party_memberships(collapse = TRUE)
                      exp <- read("fetch_mps_party_memberships_collapse")
                      compare_obs_exp(obs, exp, cols, "mnis_id")
                  })
})

test_that("fetch_mps_other_parliaments processes results correctly.", {
    with_mock(
        "mnis::fetch_mps_other_parliaments_raw" =
            mock_fetch_mps_other_parliaments_raw, {

                cols <- c(
                    "mnis_id",
                    "given_name",
                    "family_name",
                    "display_name",
                    "other_parliaments_mnis_id",
                    "other_parliaments_name",
                    "other_parliaments_seat_incumbency_start_date",
                    "other_parliaments_seat_incumbency_end_date")

                obs <- fetch_mps_other_parliaments()
                exp <- read("fetch_mps_other_parliaments")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_mps_other_parliaments(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_mps_other_parliaments_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_mps_contested_elections processes results correctly.", {
    with_mock(
        "mnis::fetch_mps_contested_elections_raw" =
            mock_fetch_mps_contested_elections_raw, {

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
                exp <- read("fetch_mps_contested_elections")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_mps_contested_elections(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_mps_contested_elections_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_mps_government_roles processes results correctly.", {
    with_mock(
        "mnis::fetch_mps_government_roles_raw" =
            mock_fetch_mps_government_roles_raw, {

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
                exp <- read("fetch_mps_government_roles")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_mps_government_roles(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_mps_government_roles_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_mps_government_roles(while_mp = FALSE)
                exp <- read("fetch_mps_government_roles_while_mp")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_mps_opposition_roles processes results correctly.", {
    with_mock(
        "mnis::fetch_mps_opposition_roles_raw" =
            mock_fetch_mps_opposition_roles_raw, {

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
                exp <- read("fetch_mps_opposition_roles")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_mps_opposition_roles(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_mps_opposition_roles_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_mps_opposition_roles(while_mp = FALSE)
                exp <- read("fetch_mps_opposition_roles_while_mp")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_mps_parliamentary_roles processes results correctly.", {
    with_mock(
        "mnis::fetch_mps_parliamentary_roles_raw" =
            mock_fetch_mps_parliamentary_roles_raw, {

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
                exp <- read("fetch_mps_opposition_roles")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_mps_parliamentary_roles(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_mps_parliamentary_roles_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_mps_parliamentary_roles(while_mp = FALSE)
                exp <- read("fetch_mps_parliamentary_roles_while_mp")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_mps_maiden_speeches processes results correctly.", {
    with_mock(
        "mnis::fetch_mps_maiden_speeches_raw" =
            mock_fetch_mps_maiden_speeches_raw, {

                cols <- c(
                    "mnis_id",
                    "given_name",
                    "family_name",
                    "display_name",
                    "maiden_speech_house",
                    "maiden_speech_date",
                    "maiden_speech_hansard_reference",
                    "maiden_speech_subject")

                obs <- fetch_mps_maide_speeches()
                exp <- read("fetch_mps_maiden_speeches")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_mps_maiden_speeches(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_mps_maiden_speeches_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})
