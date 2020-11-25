### Download data for unit testing MPs contact details

# Imports -------------------------------------------------------------------

source("tests/testthat/validate.R")

# Functions -------------------------------------------------------------------

#' Fetch validation data for unit tests of MPs contact details
#'
#' @keywords internal

fetch_mps_contacts_validation_data <- function() {

    # Fetch MPs office addresses
    m <- fetch_mps_office_addresses()
    write(m, "fetch_mps_office_addresses")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs office addresses with from and to dates
    m <- fetch_mps_office_addresses(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_mps_office_addresses_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs email addresses
    m <- fetch_mps_email_addresses()
    write(m, "fetch_mps_email_addresses")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs email addresses with from and to dates
    m <- fetch_mps_email_addresses(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_mps_email_addresses_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs phone numbers
    m <- fetch_mps_phone_numbers()
    write(m, "fetch_mps_phone_numbers")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs phone numbers with from and to dates
    m <- fetch_mps_phone_numbers(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_mps_phone_numbers_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs fax numbers
    m <- fetch_mps_fax_numbers()
    write(m, "fetch_mps_fax_numbers")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs fax numbers with from and to dates
    m <- fetch_mps_fax_numbers(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_mps_fax_numbers_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs websites
    m <- fetch_mps_websites()
    write(m, "fetch_mps_websites")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs websites with from and to dates
    m <- fetch_mps_websites(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_mps_websites_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs blogs
    m <- fetch_mps_blogs()
    write(m, "fetch_mps_blogs")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs blogs with from and to dates
    m <- fetch_mps_blogs(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_mps_blogs_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs Twitter
    m <- fetch_mps_twitter()
    write(m, "fetch_mps_twitter")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs Twitter with from and to dates
    m <- fetch_mps_twitter(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_mps_twitter_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs Instagram
    m <- fetch_mps_instagram()
    write(m, "fetch_mps_instagram")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs Instagram with from and to dates
    m <- fetch_mps_instagram(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_mps_instagram_from_to")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs Facebook
    m <- fetch_mps_facebook()
    write(m, "fetch_mps_facebook")
    Sys.sleep(API_PAUSE_TIME)

    # Fetch MPs Facebook with from and to dates
    m <- fetch_mps_facebook(
        from_date = TEST_DATE, to_date = TEST_DATE)
    write(m, "fetch_mps_facebook_from_to")
    Sys.sleep(API_PAUSE_TIME)
}

# Fetch all data --------------------------------------------------------------

#' Fetch mocks and validation data for unit tests of MPs' contact details
#'
#' @keywords internal

fetch_mps_contacts_test_data <- function() {
    fetch_mps_contacts_validation_data()
}
