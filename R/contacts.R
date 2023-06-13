### Functions for extracting contact details from the Members addresses table

# Office addresses ------------------------------------------------------------

#' Fetch office addresses for Members
#'
#' @keywords internal

fetch_members_office_addresses <- function(
    fetch_members,
    fetch_addresses,
    address_func,
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Fetch members for the given dates
    members <- fetch_members(
        from_date = from_date,
        to_date = to_date,
        on_date = on_date) %>%
        dplyr::select(.data$mnis_id)

    # Fetch office addresses for members
    offices <- fetch_addresses() %>%
        dplyr::filter(address_is_physical) %>%
        dplyr::filter(! is.na(address_1)) %>%
        dplyr::select(
            .data$mnis_id,
            .data$given_name,
            .data$family_name,
            .data$display_name,
            .data$address_type,
            .data$address_is_preferred,
            .data$address_1,
            .data$address_2,
            .data$address_3,
            .data$address_4,
            .data$address_5,
            .data$postcode)

    # Filter office addresses for the given members
    offices %>% dplyr::filter(mnis_id %in% members$mnis_id)
}

# Email addresses -------------------------------------------------------------

#' Fetch email addresses for Members
#'
#' @keywords internal

fetch_members_email_addresses <- function(
    fetch_members,
    fetch_addresses,
    address_func,
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Fetch members for the given dates
    members <- fetch_members(
            from_date = from_date,
            to_date = to_date,
            on_date = on_date) %>%
        dplyr::select(.data$mnis_id)

    # Fetch email addresses for members
    emails <- fetch_addresses() %>%
        dplyr::filter(address_is_physical) %>%
        dplyr::filter(! is.na(email)) %>%
        dplyr::select(
            .data$mnis_id,
            .data$given_name,
            .data$family_name,
            .data$display_name,
            .data$address_type,
            .data$email)

    # Filter email addresses for the given members
    emails %>% dplyr::filter(mnis_id %in% members$mnis_id)
}

# Phone numbers ---------------------------------------------------------------

#' Fetch phone numbers for Members
#'
#' @keywords internal

fetch_members_phone_numbers <- function(
    fetch_members,
    fetch_addresses,
    address_func,
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Fetch members for the given dates
    members <- fetch_members(
        from_date = from_date,
        to_date = to_date,
        on_date = on_date) %>%
        dplyr::select(.data$mnis_id)

    # Fetch phone numbers for members
    phones <- fetch_addresses() %>%
        dplyr::filter(address_is_physical) %>%
        dplyr::filter(! is.na(phone)) %>%
        dplyr::select(
            .data$mnis_id,
            .data$given_name,
            .data$family_name,
            .data$display_name,
            .data$address_type,
            .data$phone)

    # Filter phone numbers for the given members
    phones %>% dplyr::filter(mnis_id %in% members$mnis_id)
}

# Fax numbers -----------------------------------------------------------------

#' Fetch fax numbers for Members
#'
#' @keywords internal

fetch_members_fax_numbers <- function(
    fetch_members,
    fetch_addresses,
    address_func,
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Fetch members for the given dates
    members <- fetch_members(
        from_date = from_date,
        to_date = to_date,
        on_date = on_date) %>%
        dplyr::select(.data$mnis_id)

    # Fetch fax numbers for members
    faxes <- fetch_addresses() %>%
        dplyr::filter(address_is_physical) %>%
        dplyr::filter(! is.na(fax)) %>%
        dplyr::select(
            .data$mnis_id,
            .data$given_name,
            .data$family_name,
            .data$display_name,
            .data$address_type,
            .data$fax)

    # Filter fax numbers for the given members
    faxes %>% dplyr::filter(mnis_id %in% members$mnis_id)
}

# Websites --------------------------------------------------------------------

#' Fetch websites for Members
#'
#' @keywords internal

fetch_members_websites <- function(
    fetch_members,
    fetch_addresses,
    address_func,
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Fetch members for the given dates
    members <- fetch_members(
        from_date = from_date,
        to_date = to_date,
        on_date = on_date) %>%
        dplyr::select(.data$mnis_id)

    # Fetch websites for members
    websites <- fetch_addresses() %>%
        #dplyr::filter(.data$address_type_mnis_id == 6) %>%
        dplyr::filter(address_type_mnis_id == 6) %>%
      #  dplyr::filter(! is.na(.data$address_1)) %>%
        dplyr::filter(! is.na(address_1)) %>%
        dplyr::select(
            .data$mnis_id,
            .data$given_name,
            .data$family_name,
            .data$display_name,
            .data$address_type,
            url = .data$address_1)

    # Filter websites for the given members
    websites %>% dplyr::filter(mnis_id %in% members$mnis_id)
}

# Blogs -----------------------------------------------------------------------

#' Fetch blogs for Members
#'
#' @keywords internal

fetch_members_blogs <- function(
    fetch_members,
    fetch_addresses,
    address_func,
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Fetch members for the given dates
    members <- fetch_members(
        from_date = from_date,
        to_date = to_date,
        on_date = on_date) %>%
        dplyr::select(.data$mnis_id)

    # Fetch blogs for members
    blogs <- fetch_addresses() %>%
        dplyr::filter(address_type_mnis_id == 10) %>%
        dplyr::filter(! is.na(address_1)) %>%
        dplyr::select(
            .data$mnis_id,
            .data$given_name,
            .data$family_name,
            .data$display_name,
            .data$address_type,
            url = .data$address_1)

    # Filter blogs for the given members
    blogs %>% dplyr::filter(mnis_id %in% members$mnis_id)
}

# Twitter ---------------------------------------------------------------------

#' Fetch Twitter accounts for Members
#'
#' @keywords internal

fetch_members_twitter <- function(
    fetch_members,
    fetch_addresses,
    address_func,
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Fetch members for the given dates
    members <- fetch_members(
        from_date = from_date,
        to_date = to_date,
        on_date = on_date) %>%
        dplyr::select(.data$mnis_id)

    # Fetch Twitter accounts for members
    accounts <- fetch_addresses() %>%
        dplyr::filter(address_type_mnis_id == 7) %>%
        dplyr::filter(! is.na(address_1)) %>%
        dplyr::select(
            .data$mnis_id,
            .data$given_name,
            .data$family_name,
            .data$display_name,
            .data$address_type,
            url = .data$address_1)

    # Extract username: the last or penultimate token ignoring query strings
    accounts$username <- stringr::str_split(accounts$url, "/") %>%
        purrr::map_chr(function(url_parts){
            last_token <- url_parts[length(url_parts)]
            if (last_token == "" || stringr::str_starts(last_token, "\\?")) {
                username <- url_parts[length(url_parts) - 1]
            } else if (stringr::str_detect(last_token, "\\?")) {
                username <- stringr::str_split(last_token, "\\?")[[1]][1]
            } else {
                username <- last_token
            }
            username
        })

    # Filter Twitter accounts for the given members
    accounts %>% dplyr::filter(mnis_id %in% members$mnis_id)
}

# Instagram -------------------------------------------------------------------

#' Fetch Instagram accounts for Members
#'
#' @keywords internal

fetch_members_instagram <- function(
    fetch_members,
    fetch_addresses,
    address_func,
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Fetch members for the given dates
    members <- fetch_members(
        from_date = from_date,
        to_date = to_date,
        on_date = on_date) %>%
        dplyr::select(.data$mnis_id)

    # Fetch Instagram accounts for members
    accounts <- fetch_addresses() %>%
        dplyr::filter(address_type_mnis_id == 12) %>%
        dplyr::filter(! is.na(address_1)) %>%
        dplyr::select(
            .data$mnis_id,
            .data$given_name,
            .data$family_name,
            .data$display_name,
            .data$address_type,
            url = .data$address_1) %>%
        dplyr::mutate(username = stringr::str_glue(
            "@{stringr::str_sub(.data$url, 27, -2)}"))

    # Extract username: the last or penultimate token ignoring query strings
    accounts$username <- stringr::str_split(accounts$url, "/") %>%
        purrr::map_chr(function(url_parts){
            last_token <- url_parts[length(url_parts)]
            if (last_token == "" || stringr::str_starts(last_token, "\\?")) {
                username <- url_parts[length(url_parts) - 1]
            } else if (stringr::str_detect(last_token, "\\?")) {
                username <- stringr::str_split(last_token, "\\?")[[1]][1]
            } else {
                username <- last_token
            }
            username
        })

    # Filter Instagram accounts for the given members
    accounts %>% dplyr::filter(mnis_id %in% members$mnis_id)
}

# Facebook --------------------------------------------------------------------

#' Fetch Facebook accounts for Members
#'
#' @keywords internal

fetch_members_facebook <- function(
    fetch_members,
    fetch_addresses,
    address_func,
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Fetch members for the given dates
    members <- fetch_members(
        from_date = from_date,
        to_date = to_date,
        on_date = on_date) %>%
        dplyr::select(.data$mnis_id)

    # Fetch Facebook accounts for members
    accounts <- fetch_addresses() %>%
       # dplyr::filter(.data$address_type_mnis_id == 8) %>%
    #    dplyr::filter(! is.na(.data$address_1)) %>%
        dplyr::filter(address_type_mnis_id == 8) %>%
        dplyr::filter(!is.na(address_1)) %>%
        dplyr::select(
            .data$mnis_id,
            .data$given_name,
            .data$family_name,
            .data$display_name,
            .data$address_type,
            url = .data$address_1)

    # Extract username: the last or penultimate token ignoring query strings
    accounts$username <- stringr::str_split(accounts$url, "/") %>%
        purrr::map_chr(function(url_parts){
            last_token <- url_parts[length(url_parts)]
            if (last_token == "" || stringr::str_starts(last_token, "\\?")) {
                username <- url_parts[length(url_parts) - 1]
            } else if (stringr::str_detect(last_token, "\\?")) {
                username <- stringr::str_split(last_token, "\\?")[[1]][1]
            } else {
                username <- last_token
            }
            username
        })

    # Filter Facebook accounts for the given members
    accounts %>% dplyr::filter(mnis_id %in% members$mnis_id)
}
