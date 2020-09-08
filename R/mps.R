### Functions for downloading and analysing data on MPs

# Raw MP queries --------------------------------------------------------------

#' Fetch key details for all MPs
#'
#' @keywords internal

fetch_mps_raw <- function() {

    # Fetch raw members data
    mps <- fetch_members_raw(house = HOUSE_COMMONS)

    # Extract data into a tibble
    mps <- tibble::tibble(
        mnis_id = mps$`@Member_Id`,
        given_name = mps$BasicDetails$GivenForename,
        family_name = mps$BasicDetails$GivenSurname,
        display_name = mps$DisplayAs,
        full_title = mps$FullTitle,
        gender = mps$Gender,
        current_age = "",
        date_of_birth = mps$DateOfBirth,
        date_of_death = mps$DateOfDeath)

    # Tidy and return
    mps <- process_missing_values(mps, date_of_birth)
    mps <- process_missing_values(mps, date_of_death)
    mps$date_of_birth <- as.Date(unlist(mps$date_of_birth))
    mps$date_of_death <- as.Date(unlist(mps$date_of_death))
    mps$current_age <- process_member_age(mps$date_of_birth, mps$date_of_death)
    mps
}

#' Fetch Commons memberships for all MPs
#'
#' @keywords internal

fetch_commons_memberships_raw <- function() {

    # Fetch raw memberships data
    memberships <- fetch_memberships_raw(house = HOUSE_COMMONS)

    # Define a function to extract Commons memberships for each MP
    process_commons_memberships <- function(memberships) {
        memberships_raw <- purrr::map(memberships$`@Member_Id`, function(member) {
            mnis_id <- member
            memberships_raw <- dplyr::filter(memberships, `@Member_Id` == mnis_id)
            memberships_raw <- purrr::map_df(memberships_raw$Constituencies$Constituency, function(member) {
                memberships_raw <- tibble::tibble(
                    constituency_mnis_id = member$`@Id`,
                    constituency_name = member$Name,
                    seat_incumbency_start_date = member$StartDate,
                    seat_incumbency_end_date = as.character(member$EndDate))
            })
            memberships_raw$mnis_id <- mnis_id
            memberships_raw
        })
        dplyr::bind_rows(memberships_raw)
    }

    # Call process function and tidy
    memberships <- process_commons_memberships(memberships)
    memberships <- process_missing_values(memberships, seat_incumbency_end_date)
    memberships$seat_incumbency_start_date <- as.Date(memberships$seat_incumbency_start_date)
    memberships$seat_incumbency_end_date <- as.Date(memberships$seat_incumbency_end_date)

    # Fetch basic details
    mps <- fetch_mps_raw() %>%
        dplyr::select(
            mnis_id,
            given_name,
            family_name,
            display_name)

    # Join tables and tidy
    memberships <- dplyr::left_join(memberships, mps, by = "mnis_id") %>%
        dplyr::select(
            mnis_id,
            given_name,
            family_name,
            display_name,
            dplyr::everything())

    # Cache memberships
    assign(CACHE_COMMONS_MEMBERSHIPS_RAW, memberships, envir = cache)

    # Return
    memberships
}

#' Fetch party memberships for all MPs
#'
#' @keywords internal
#
# fetch_mps_party_memberships_raw <- function() {
#
#     # Fetch raw party membership data
#     memberships <- fetch_party_memberships_raw(house = HOUSE_COMMONS)
#
#     # Define a function to extract party memberships for each MP
#     process_party_memberships <- function(memberships) {
#         memberships_raw <- purrr::map(memberships$`@Member_Id`, function(member) {
#             mnis_id <- member
#             memberships_raw <- dplyr::filter(memberships, `@Member_Id` == mnis_id)
#             memberships_raw <- purrr::map_df(memberships_raw$Parties$Party, function(member) {
#                 memberships_raw <- tibble::tibble(
#                     party_mnis_id = member$`@Id`,
#                     party_name = member$Name,
#                     party_membership_start_date = member$StartDate,
#                     party_membership_end_date = as.character(member$EndDate))
#             })
#             memberships_raw$mnis_id <- mnis_id
#             memberships_raw
#         })
#         dplyr::bind_rows(memberships_raw)
#     }
#
#     # Call process function and tidy
#     memberships <- process_party_memberships(memberships)
#     memberships <- process_missing_values(memberships, party_membership_end_date)
#     memberships$party_membership_start_date <- as.Date(memberships$party_membership_start_date)
#     memberships$party_membership_end_date <- as.Date(memberships$party_membership_end_date)
#
#     # Fetch basic details
#     mps <- fetch_mps_raw() %>%
#         dplyr::select(
#             mnis_id,
#             given_name,
#             family_name,
#             display_name,
#             date_of_birth,
#             date_of_death)
#
#     # Join tables and tidy
#     memberships <- dplyr::left_join(memberships, mps, by = "mnis_id") %>%
#         dplyr::select(
#             mnis_id,
#             given_name,
#             family_name,
#             display_name,
#             dplyr::everything())
#
#     # Cache memberships
#     assign(CACHE_COMMONS_PARTY_MEMBERSHIPS_RAW, memberships, envir = cache)
#
#     # Return
#     memberships
# }




# Main MPs API ----------------------------------------------------------------

#' Fetch key details for all MPs
#'
#' \code{fetch_mps} fetches data from the Members Names data platform showing
#' key details about each MP, with one row per MP.
#'
#' The from_date and to_date arguments can be used to filter MPs returned based
#' on the dates of their Commons memberships. The on_date argument is a
#' convenience that sets the from_date and to_date to the same given date. The
#' on_date has priority: if the on_date is set, the from_date and to_date are
#' ignored.
#'
#' The filtering is inclusive: an MP is returned if any part of one of their
#' Commons memberships falls within the period specified with the from and to
#' dates.
#'
#' @param from_date A string or Date representing a date. If a string is used
#'   it should specify the date in ISO 8601 date format e.g. '2000-12-31'. The
#'   default value is NA, which means no records are excluded on the basis of
#'   the from_date.
#' @param to_date A string or Date representing a date. If a string is used
#'   it should specify the date in ISO 8601 date format e.g. '2000-12-31'. The
#'   default value is NA, which means no records are excluded on the basis of
#'   the to_date.
#' @param on_date A string or Date representing a date. If a string is used
#'   it should specify the date in ISO 8601 date format e.g. '2000-12-31'. The
#'   default value is NA, which means no records are excluded on the basis of
#'   the on_date.
#' @return A tibble of key details for each MP, with one row per MP.
#' @export

fetch_mps <- function(from_date = NA, to_date = NA, on_date = NA) {

    # Set from_date and to_date to on_date if set
    if (!is.na(on_date)) {
        from_date <- on_date
        to_date <- on_date
    }

    # Fetch key details
    mps <- fetch_mps_raw()

    # Filter on dates if requested
    if (!is.na(from_date) || !is.na(to_date)) {
        commons_memberships <- fetch_commons_memberships()
        matching_memberships <- filter_dates(
            commons_memberships,
            start_col = "seat_incumbency_start_date",
            end_col = "seat_incumbency_end_date",
            from_date = from_date,
            to_date = to_date)
        mps <- mps %>%
            dplyr::filter(.data$mnis_id %in% matching_memberships$mnis_id)
    }

    # Tidy up and return
    mps %>% dplyr::arrange(.data$family_name) %>%
        dplyr::mutate_if(is.character, stringr::str_trim)
}

#' Fetch Commons memberships for all MPs
#'
#' \code{fetch_commons_memberships} fetches data from the Members Names data platform
#' showing Commons memberships for each MP. The memberships are processed to
#' impose consistent rules on the start and end dates for memberships. A
#' membership with an NA end date is still open.
#'
#' The from_date and to_date arguments can be used to filter the memberships
#' returned. The on_date argument is a convenience that sets the from_date and
#' to_date to the same given date. The on_date has priority: if the on_date is
#' set, the from_date and to_date are ignored.
#'
#' The filtering is inclusive: a membership is returned if any part of it falls
#' within the period specified with the from and to dates.
#'
#' Note that a membership with an NA end date is still open.
#'
#' @param from_date A string or Date representing a date. If a string is used
#'   it should specify the date in ISO 8601 date format e.g. '2000-12-31'. The
#'   default value is NA, which means no records are excluded on the basis of
#'   the from_date.
#' @param to_date A string or Date representing a date. If a string is used
#'   it should specify the date in ISO 8601 date format e.g. 2000-12-31'. The
#'   default value is NA, which means no records are excluded on the basis
#'   of the to_date.
#' @param on_date A string or Date representing a date. If a string is used
#'   it should specify the date in ISO 8601 date format e.g. 2000-12-31'. The
#'   default value is NA, which means no records are excluded on the basis
#'   of the on_date.
#' @return A tibble of Commons memberships for each MP, with one row per
#'   Commons membership.
#' @export

fetch_commons_memberships <- function(from_date = NA, to_date = NA, on_date = NA) {

    # Set from_date and to_date to on_date if set
    if (!is.na(on_date)) {
        from_date <- on_date
        to_date <- on_date
    }

    # Check if Commons memberships raw is cached and fetch if not
    if (!exists(CACHE_COMMONS_MEMBERSHIPS_RAW, envir = cache)) {
        commons_memberships <- fetch_commons_memberships_raw()
    } else {
        commons_memberships <- get(CACHE_COMMONS_MEMBERSHIPS_RAW, envir = cache)
    }

    # Define a function to adjust end dates if they are incorrect
    adjust_date <- function(date, elections) {
        after_dissolution <- date > elections$dissolution
        to_election <- date <= elections$election
        match <- after_dissolution & to_election
        ifelse(sum(match), elections[match,]$dissolution, date)
    }

    # Get the elections
    general_elections <- get_general_elections()

    # Calculate the adjusted end dates
    adj_ends <- purrr::map_dbl(
        commons_memberships$seat_incumbency_end_date,
        adjust_date,
        general_elections)

    # Cast back to dates and reassign
    commons_memberships$seat_incumbency_end_date <- cast_date(adj_ends)

    # Filter on dates if requested
    if (!is.na(from_date) || !is.na(to_date)) {
        commons_memberships <- filter_dates(
            commons_memberships,
            start_col = "seat_incumbency_start_date",
            end_col = "seat_incumbency_end_date",
            from_date = from_date,
            to_date = to_date)
    }

    # Tidy up and return
    commons_memberships %>%
        dplyr::arrange(
            .data$family_name,
            .data$seat_incumbency_start_date) %>%
        dplyr::ungroup() %>%
        dplyr::mutate_if(is.character, stringr::str_trim)

}

#' Fetch party memberships for all MPs
#'
#' \code{fetch_mps_party_memberships} fetches data from the Members Names data platform
#' showing party memberships for each MP. The memberships are processed and
#' merged so that there is only one row for each period of continuous
#' membership within the same party. A membership with an NA end date is still
#' open.
#'
#' The from_date and to_date arguments can be used to filter the memberships
#' returned. The on_date argument is a convenience that sets the from_date and
#' to_date to the same given date. The on_date has priority: if the on_date is
#' set, the from_date and to_date are ignored.
#'
#' The while_mp argument can be used to filter the memberships to include only
#' those that occurred during the period when each individual was an MP.
#'
#' The filtering is inclusive: a membership is returned if any part of it falls
#' within the period specified with the from and to dates.
#'
#' The collapse argument controls whether memberships are combined so that
#' there is only one row for each period of continuous membership within the
#' same party. Combining the memberships in this way means that party
#' membership ids from the data platform are not included in the tibble
#' returned.
#'
#' Note that a membership with an NA end date is still open.
#'
#' @param from_date A string or Date representing a date. If a string is used
#'   it should specify the date in ISO 8601 date format e.g. '2000-12-31'. The
#'   default value is NA, which means no records are excluded on the basis of
#'   the from_date.
#' @param to_date A string or Date representing a date. If a string is used
#'   it should specify the date in ISO 8601 date format e.g. 2000-12-31'. The
#'   default value is NA, which means no records are excluded on the basis
#'   of the to_date.
#' @param on_date A string or Date representing a date. If a string is used
#'   it should specify the date in ISO 8601 date format e.g. 2000-12-31'. The
#'   default value is NA, which means no records are excluded on the basis
#'   of the on_date.
#' @param while_mp A boolean indicating whether to filter the party membership
#'   to include only those memberships that were held while each individual was
#'   serving as an MP. The default value is TRUE.
#' @param collapse A boolean which determines whether to collapse consecutive
#'   memberships within the same party into a single period of continuous party
#'   membership. Setting this to TRUE means that party membership ids are not
#'   returned in the dataframe. The default value is FALSE.
#' @return A tibble of party memberships for each MP, with one row per party
#'   membership.
#' @export

# fetch_mps_party_memberships <- function(
#     from_date = NA,
#     to_date = NA,
#     on_date = NA,
#     while_mp = TRUE,
#     collapse = FALSE) {
#
#     # Set from_date and to_date to on_date if set
#     if (!is.na(on_date)) {
#         from_date <- on_date
#         to_date <- on_date
#     }
#
#     # Check if Commons memberships raw is cached and fetch if not
#     if (!exists(CACHE_COMMONS_PARTY_MEMBERSHIPS_RAW, envir = cache)) {
#         party_memberships <- fetch_mps_party_memberships_raw()
#     } else {
#         party_memberships <- get(CACHE_COMMONS_PARTY_MEMBERSHIPS_RAW, envir = cache)
#     }
#
#     # # Define a function to adjust start dates so they are after date of birth
#     # adjust_date <- function(date_birth, date_party) {
#     #      <- date > elections$dissolution
#     #     to_election <- date <= elections$election
#     #     match <- after_dissolution & to_election
#     #     ifelse(sum(match), elections[match,]$dissolution, date)
#     # }
#
#
#     # Filter on dates if requested
#     if (!is.na(from_date) || !is.na(to_date)) {
#         party_memberships <- filter_dates(
#             party_memberships,
#             start_col = "party_membership_start_date",
#             end_col = "party_membership_end_date",
#             from_date = from_date,
#             to_date = to_date)
#     }
#
#     # Filter on Commons memberships if requested
#     if (while_mp) {
#         commons_memberships <- fetch_commons_memberships()
#         party_memberships <- filter_memberships(
#             tm = party_memberships,
#             fm = commons_memberships,
#             tm_id_col = "party_mnis_id",
#             tm_start_col = "party_membership_start_date",
#             tm_end_col = "party_membership_end_date",
#             fm_start_col = "seat_incumbency_start_date",
#             fm_end_col = "seat_incumbency_end_date",
#             join_col = "mnis_id")
#     }
#
#     # Collapse consecutive memberships and return if requested
#     if (collapse) {
#         return(combine_party_memberships(party_memberships))
#     }
#
#     # Otherwise tidy up and return
#     party_memberships %>%
#         dplyr::arrange(
#             .data$family_name,
#             .data$party_membership_start_date) %>%
#         dplyr::mutate_if(is.character, stringr::str_trim)
#
#     # pm_mnis %>%
#     #     dplyr::arrange(
#     #         mnis_id,
#     #         party_membership_start_date,
#     #         party_membership_end_date,
#     #         party_mnis_id) %>%
#     #     dplyr::group_by(mnis_id) %>%
#     #     dplyr::mutate(mid = paste0(mnis_id, "-", dplyr::row_number())) %>%
#     #     dplyr::ungroup()
#
#
# }

