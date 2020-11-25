### Download data for unit testing Lords contact details

# Imports -------------------------------------------------------------------

source("tests/testthat/validate.R")

# Functions -------------------------------------------------------------------

#' Fetch validation data for unit tests of Lords contact details
#'
#' @keywords internal

fetch_lords_contacts_validation_data <- function() {

    # Fetch Lords office addresses
    m <- fetch_lords_office_addresses()
    write(m, "fetch_lords_office_addresses")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords office addresses with from and to dates
    m <- fetch_lords_office_addresses(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_lords_office_addresses_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords email addresses
    m <- fetch_lords_email_addresses()
    write(m, "fetch_lords_email_addresses")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords email addresses with from and to dates
    m <- fetch_lords_email_addresses(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_lords_email_addresses_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords phone numbers
    m <- fetch_lords_phone_numbers()
    write(m, "fetch_lords_phone_numbers")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords phone numbers with from and to dates
    m <- fetch_lords_phone_numbers(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_lords_phone_numbers_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords fax numbers
    m <- fetch_lords_fax_numbers()
    write(m, "fetch_lords_fax_numbers")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords fax numbers with from and to dates
    m <- fetch_lords_fax_numbers(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_lords_fax_numbers_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords websites
    m <- fetch_lords_websites()
    write(m, "fetch_lords_websites")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords websites with from and to dates
    m <- fetch_lords_websites(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_lords_websites_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords blogs
    m <- fetch_lords_blogs()
    write(m, "fetch_lords_blogs")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords blogs with from and to dates
    m <- fetch_lords_blogs(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_lords_blogs_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords Twitter
    m <- fetch_lords_twitter()
    write(m, "fetch_lords_twitter")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords Twitter with from and to dates
    m <- fetch_lords_twitter(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_lords_twitter_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords Instagram
    m <- fetch_lords_instagram()
    write(m, "fetch_lords_instagram")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords Instagram with from and to dates
    m <- fetch_lords_instagram(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_lords_instagram_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords Facebook
    m <- fetch_lords_facebook()
    write(m, "fetch_lords_facebook")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch Lords Facebook with from and to dates
    m <- fetch_lords_facebook(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_lords_facebook_from_to")
    Sys.sleep(API_PAUSE_TIME)
}

# Fetch all data --------------------------------------------------------------

#' Fetch mocks and validation data for unit tests of Lords' contact details
#'
#' @keywords internal

fetch_lords_contacts_test_data <- function() {
    fetch_lords_contacts_validation_data()
}
