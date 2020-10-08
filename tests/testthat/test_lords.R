### Test Lords functions
context("Lords functions")

# Imports ---------------------------------------------------------------------

source("validate.R")

# Mocks -----------------------------------------------------------------------

mock_fetch_lords_raw <- function() {
    read("lords_raw")
}

mock_fetch_lords_memberships_raw <- function() {
    read("lords_memberships_raw")
}

mock_fetch_lords_party_memberships_raw <- function() {
    read("lords_party_memberships_raw")
}

mock_fetch_lords_other_parliaments_raw <- function() {
    read("lords_other_parliaments_raw")
}

mock_fetch_lords_contested_elections_raw <- function() {
    read("lords_contested_elections_raw")
}

mock_fetch_lords_government_roles_raw <- function() {
    read("lords_government_roles_raw")
}

mock_fetch_lords_opposition_roles_raw <- function() {
    read("lords_opposition_roles_raw")
}

mock_fetch_lords_parliamentary_roles_raw <- function() {
    read("lords_parliamentary_roles_raw")
}

mock_fetch_lords_maiden_speeches_raw <- function() {
    read("lords_maiden_speeches_raw")
}

# Tests -----------------------------------------------------------------------

test_that("fetch_lords processes results correctly.", {
    with_mock(
        "mnis::fetch_lords_raw" = mock_fetch_lords_raw,
        "mnis::fetch_lords_memberships" = mock_fetch_lords_memberships_raw, {

            cols <- c(
                "mnis_id",
                "given_name",
                "family_name",
                "display_name",
                "full_title",
                "lord_type",
                "gender",
                "current_age",
                "date_of_birth",
                "date_of_death")

            obs <- fetch_lords()
            exp <- read("fetch_lords")
            compare_obs_exp(obs, exp, cols, "mnis_id")

            obs <- fetch_lords(from_date = "2017-06-08", to_date = "2017-06-08")
            exp <- read("fetch_lords_from_to")
            compare_obs_exp(obs, exp, cols, "mnis_id")
        })
})

test_that("fetch_lords_memberships processes results correctly.", {
    with_mock(
        "mnis::fetch_lords_memberships_raw" =
            mock_fetch_lords_memberships_raw, {

                cols <- c(
                    "mnis_id",
                    "given_name",
                    "family_name",
                    "display_name",
                    "seat_incumbency_id",
                    "seat_incumbency_start_date")

                obs <- fetch_lords_memberships()
                exp <- read("fetch_lords_memberships")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_lords_memberships(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_lords_memberships_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_lords_party_memberships processes results correctly.", {
    with_mock("mnis::fetch_lords_party_memberships_raw" =
                  mock_fetch_lords_party_memberships_raw, {

                        cols <- c(
                          "mnis_id",
                          "given_name",
                          "family_name",
                          "display_name",
                          "party_mnis_id",
                          "party_name",
                          "party_membership_start_date",
                          "party_membership_end_date")

                      obs <- fetch_lords_party_memberships()
                      exp <- read("fetch_lords_party_memberships")
                      compare_obs_exp(obs, exp, cols, "mnis_id")

                      obs <- fetch_lords_party_memberships(
                        from_date = "2017-06-08",
                          to_date = "2017-06-08")
                      exp <- read("fetch_lords_party_memberships_from_to")
                      compare_obs_exp(obs, exp, cols, "mnis_id")

                      obs <- fetch_lords_party_memberships(while_lord = FALSE)
                      exp <- read("fetch_lords_party_memberships_while_lord")
                      compare_obs_exp(obs, exp, cols, "mnis_id")

                      obs <- fetch_lords_party_memberships(collapse = TRUE)
                      exp <- read("fetch_lords_party_memberships_collapse")
                      compare_obs_exp(obs, exp, cols, "mnis_id")
                  })
})

test_that("fetch_lords_other_parliaments processes results correctly.", {
    with_mock(
        "mnis::fetch_lords_other_parliaments_raw" =
            mock_fetch_lords_other_parliaments_raw, {

                cols <- c(
                    "mnis_id",
                    "given_name",
                    "family_name",
                    "display_name",
                    "other_parliaments_mnis_id",
                    "other_parliaments_name",
                    "other_parliaments_seat_incumbency_start_date",
                    "other_parliaments_seat_incumbency_end_date")

                obs <- fetch_lords_other_parliaments()
                exp <- read("fetch_lords_other_parliaments")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_lords_other_parliaments(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_lords_other_parliaments_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_lords_contested_elections processes results correctly.", {
    with_mock(
        "mnis::fetch_lords_contested_elections_raw" =
            mock_fetch_lords_contested_elections_raw, {

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

                obs <- fetch_lords_contested_elections()
                exp <- read("fetch_lords_contested_elections")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_lords_contested_elections(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_lords_contested_elections_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_lords_government_roles processes results correctly.", {
    with_mock(
        "mnis::fetch_lords_government_roles_raw" =
            mock_fetch_lords_government_roles_raw, {

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

                obs <- fetch_lords_government_roles()
                exp <- read("fetch_lords_government_roles")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_lords_government_roles(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_lords_government_roles_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_lords_government_roles(while_lord = FALSE)
                exp <- read("fetch_lords_government_roles_while_lord")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_lords_opposition_roles processes results correctly.", {
    with_mock(
        "mnis::fetch_lords_opposition_roles_raw" =
            mock_fetch_lords_opposition_roles_raw, {

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

                obs <- fetch_lords_opposition_roles()
                exp <- read("fetch_lords_opposition_roles")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_lords_opposition_roles(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_lords_opposition_roles_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_lords_opposition_roles(while_lord = FALSE)
                exp <- read("fetch_lords_opposition_roles_while_lord")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_lords_parliamentary_roles processes results correctly.", {
    with_mock(
        "mnis::fetch_lords_parliamentary_roles_raw" =
            mock_fetch_lords_parliamentary_roles_raw, {

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

                obs <- fetch_lords_parliamentary_roles()
                exp <- read("fetch_lords_opposition_roles")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_lords_parliamentary_roles(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_lords_parliamentary_roles_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_lords_parliamentary_roles(while_lord = FALSE)
                exp <- read("fetch_lords_parliamentary_roles_while_lord")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})

test_that("fetch_lords_maiden_speeches processes results correctly.", {
    with_mock(
        "mnis::fetch_lords_maiden_speeches_raw" =
            mock_fetch_lords_maiden_speeches_raw, {

                cols <- c(
                    "mnis_id",
                    "given_name",
                    "family_name",
                    "display_name",
                    "maiden_speech_house",
                    "maiden_speech_date",
                    "maiden_speech_hansard_reference",
                    "maiden_speech_subject")

                obs <- fetch_lords_maide_speeches()
                exp <- read("fetch_lords_maiden_speeches")
                compare_obs_exp(obs, exp, cols, "mnis_id")

                obs <- fetch_lords_maiden_speeches(
                    from_date = "2017-06-08",
                    to_date = "2017-06-08")
                exp <- read("fetch_lords_maiden_speeches_from_to")
                compare_obs_exp(obs, exp, cols, "mnis_id")
            })
})
