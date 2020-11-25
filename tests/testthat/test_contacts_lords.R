### Test Lords contact details functions
context("Contact details functions for Lords")

# Imports ---------------------------------------------------------------------

source("validate.R")

# Mocks -----------------------------------------------------------------------

mock_fetch_query_data <- function(house, data_output) {
    switch(data_output,
        "BasicDetails" = read("lords_basic_details"),
        "HouseMemberships" = read("lords_house_memberships"),
        "Addresses" = read("lords_addresses")
    )
}

# Tests -----------------------------------------------------------------------

test_that("fetch_lords_office_addresses processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "address_type",
            "address_is_preferred",
            "address_1",
            "address_2",
            "address_3",
            "address_4",
            "address_5",
            "postcode")

        obs <- fetch_lords_office_addresses()
        exp <- readRDS("data/fetch_lords_office_addresses.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_lords_office_addresses(
            from_date = TEST_DATE, to_date = TEST_DATE)
        exp <- readRDS("data/fetch_lords_office_addresses_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_lords_email_addresses processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "address_type",
            "email")

        obs <- fetch_lords_email_addresses()
        exp <- readRDS("data/fetch_lords_email_addresses.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_lords_email_addresses(
            from_date = TEST_DATE, to_date = TEST_DATE)
        exp <- readRDS("data/fetch_lords_email_addresses_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_lords_phone_numbers processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",

            "address_type",
            "phone")

        obs <- fetch_lords_phone_numbers()
        exp <- readRDS("data/fetch_lords_phone_numbers.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_lords_phone_numbers(
            from_date = TEST_DATE, to_date = TEST_DATE)
        exp <- readRDS("data/fetch_lords_phone_numbers_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_lords_fax_numbers processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "address_type",
            "fax")

        obs <- fetch_lords_fax_numbers()
        exp <- readRDS("data/fetch_lords_fax_numbers.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_lords_fax_numbers(
            from_date = TEST_DATE, to_date = TEST_DATE)
        exp <- readRDS("data/fetch_lords_fax_numbers_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_lords_websites processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "address_type",
            "url")

        obs <- fetch_lords_websites()
        exp <- readRDS("data/fetch_lords_websites.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_lords_websites(
            from_date = TEST_DATE, to_date = TEST_DATE)
        exp <- readRDS("data/fetch_lords_websites_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_lords_blogs processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "address_type",
            "url")

        obs <- fetch_lords_blogs()
        exp <- readRDS("data/fetch_lords_blogs.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_lords_blogs(
            from_date = TEST_DATE, to_date = TEST_DATE)
        exp <- readRDS("data/fetch_lords_blogs_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_lords_twitter processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "address_type",
            "url",
            "username")

        obs <- fetch_lords_twitter()
        exp <- readRDS("data/fetch_lords_twitter.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_lords_twitter (
            from_date = TEST_DATE, to_date = TEST_DATE)
        exp <- readRDS("data/fetch_lords_twitter_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_lords_instagram processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "address_type",
            "url",
            "username")

        obs <- fetch_lords_instagram()
        exp <- readRDS("data/fetch_lords_instagram.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_lords_instagram(
            from_date = TEST_DATE, to_date = TEST_DATE)
        exp <- readRDS("data/fetch_lords_instagram_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})

test_that("fetch_lords_facebook processes results correctly.", {
    with_mock("clmnis::fetch_query_data" = mock_fetch_query_data, {

        cols <- c(
            "mnis_id",
            "given_name",
            "family_name",
            "display_name",
            "address_type",
            "url",
            "username")

        obs <- fetch_lords_facebook()
        exp <- readRDS("data/fetch_lords_facebook.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")

        obs <- fetch_lords_facebook(
            from_date = TEST_DATE, to_date = TEST_DATE)
        exp <- readRDS("data/fetch_lords_facebook_from_to.RData")
        compare_obs_exp(obs, exp, cols, "mnis_id")
    })
})
