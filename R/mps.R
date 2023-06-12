### Functions for downloading and analysing data on MPs

#' Fetch key details for all MPs
#'
#' \code{fetch_mps} fetches data from the Members Names platform showing
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
           # dplyr::filter(.data$mnis_id %in% matching_memberships$mnis_id)
             dplyr::filter(mnis_id %in% matching_memberships$mnis_id)
    }

    # Tidy up and return
    mps %>% dplyr::arrange(.data$family_name) %>%
        dplyr::mutate_if(is.character, stringr::str_trim)
}

#' Fetch Commons memberships for all MPs
#'
#' \code{fetch_commons_memberships} fetches data from the Members Names platform
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

    # Check cache
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
#' \code{fetch_mps_party_memberships} fetches data from the Members Names platform
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

fetch_mps_party_memberships <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA,
    while_mp = TRUE,
    collapse = FALSE) {

    # Set from_date and to_date to on_date if set
    if (!is.na(on_date)) {
        from_date <- on_date
        to_date <- on_date
    }

    # Check cache
    if (!exists(CACHE_COMMONS_PARTY_MEMBERSHIPS_RAW, envir = cache)) {
        party_memberships <- fetch_mps_party_memberships_raw()
    } else {
        party_memberships <- get(CACHE_COMMONS_PARTY_MEMBERSHIPS_RAW, envir = cache)
    }

    # Filter on dates if requested
    if (!is.na(from_date) || !is.na(to_date)) {
        party_memberships <- filter_dates(
            party_memberships,
            start_col = "party_membership_start_date",
            end_col = "party_membership_end_date",
            from_date = from_date,
            to_date = to_date)
    }

    # Filter on memberships if requested
    if (while_mp) {
        commons_memberships <- fetch_commons_memberships()
        party_memberships <- filter_memberships(
            tm = party_memberships,
            fm = commons_memberships,
            tm_id_col = "party_mnis_id",
            tm_start_col = "party_membership_start_date",
            tm_end_col = "party_membership_end_date",
            fm_start_col = "seat_incumbency_start_date",
            fm_end_col = "seat_incumbency_end_date",
            join_col = "mnis_id")
    }

    # Collapse consecutive memberships and return if requested
    if (collapse) {
        party_memberships <- combine_party_memberships(party_memberships)
    }

    # Otherwise tidy up and return
    party_memberships %>%
        dplyr::arrange(
            .data$family_name,
            .data$party_membership_start_date) %>%
        dplyr::mutate_if(is.character, stringr::str_trim)

}

#' Fetch other parliament memberships for all MPs
#'
#' \code{fetch_mps_other_parliaments} fetches data from the Members Names platform
#' showing other parliamentary memberships for each MP.
#'
#' The from_date and to_date arguments can be used to filter the speeches
#' returned. The on_date argument is a convenience that sets the from_date and
#' to_date to the same given date. The on_date has priority: if the on_date is
#' set, the from_date and to_date are ignored.
#'
#' The filtering is inclusive: a other parliamentary membership is returned if
#' the date of it falls within the period specified with the from and to dates.
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
#' @return A tibble of other parliamentary incumbencies for each MP, with one
#' row per membership.
#' @export

fetch_mps_other_parliaments <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Set from_date and to_date to on_date if set
    if (!is.na(on_date)) {
        from_date <- on_date
        to_date <- on_date
    }

    # Check cache
    if (!exists(CACHE_MPS_OTHER_PARLIAMENTS_RAW, envir = cache)) {
        other_parliaments <- fetch_mps_other_parliaments_raw()
    } else {
        other_parliaments <- get(CACHE_MPS_OTHER_PARLIAMENTS_RAW, envir = cache)
    }

    # Filter on dates if requested
    if (!is.na(from_date) || !is.na(to_date)) {
        other_parliaments <- filter_dates(
            other_parliaments,
            start_col = "other_parliaments_incumbency_start_date",
            end_col = "other_parliaments_incumbency_end_date",
            from_date = from_date,
            to_date = to_date)
    }

    # Tidy up and return
    other_parliaments %>%
        dplyr::arrange(
            .data$family_name,
            .data$other_parliaments_incumbency_start_date) %>%
        dplyr::ungroup() %>%
        dplyr::mutate_if(is.character, stringr::str_trim)
}

#' Fetch contested elections for all MPs
#'
#' \code{fetch_mps_contested_elections} fetches data from the Members Names
#' platform showing contested elections for each MP.
#'
#' The from_date and to_date arguments can be used to filter the contested
#' elections returned. The on_date argument is a convenience that sets the
#' from_date and to_date to the same given date. The on_date has priority:
#' if the on_date is set, the from_date and to_date are ignored.
#'
#' The filtering is inclusive: a contested election is returned if
#' the date of it falls within the period specified with the from and to dates.
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

#' @return A tibble of contested elections for each MP, with one row per
#' contested election.
#' @export

fetch_mps_contested_elections <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Set from_date and to_date to on_date if set
    if (!is.na(on_date)) {
        from_date <- on_date
        to_date <- on_date
    }

    # Check cache
    if (!exists(CACHE_MPS_CONTESTED_ELECTIONS_RAW, envir = cache)) {
        contested_elections <- fetch_mps_contested_elections_raw()
    } else {
        contested_elections <- get(CACHE_MPS_CONTESTED_ELECTIONS_RAW, envir = cache)
    }

    # Filter on dates if requested
    if (!is.na(from_date) || !is.na(to_date)) {
        contested_elections <- filter_dates(
            contested_elections,
            start_col = "contested_election_date",
            end_col = "contested_election_date",
            from_date = from_date,
            to_date = to_date)
    }

    # Tidy up and return
    contested_elections %>%
        dplyr::arrange(
            .data$family_name,
            .data$contested_election_date) %>%
        dplyr::ungroup() %>%
        dplyr::mutate_if(is.character, stringr::str_trim)
}

#' Fetch government roles for all MPs
#'
#' \code{fetch_mps_government_roles} fetches data from the Members Names platform
#' showing government roles for each MP.
#'
#' The from_date and to_date arguments can be used to filter the roles
#' returned. The on_date argument is a convenience that sets the from_date and
#' to_date to the same given date. The on_date has priority: if the on_date is
#' set, the from_date and to_date are ignored.
#'
#' The while_mp argument can be used to filter the roles to include only those
#' that occurred during the period when each individual was an MP.
#'
#' The filtering is inclusive: a role is returned if any part of it falls
#' within the period specified with the from and to dates.
#'
#' Note that a role with an NA end date is still open.
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
#' @param while_mp A boolean indicating whether to filter the government roles
#'   to include only those roles that were held while each individual was serving
#'   as an MP. The default value is TRUE.
#' @return A tibble of government roles for each MP, with one row per
#'   government role.
#' @export

fetch_mps_government_roles <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA,
    while_mp = TRUE) {

    # Set from_date and to_date to on_date if set
    if (!is.na(on_date)) {
        from_date <- on_date
        to_date <- on_date
    }

    # Check cache
    if (!exists(CACHE_MPS_GOVERNMENT_ROLES_RAW, envir = cache)) {
        government_roles <- fetch_mps_government_roles_raw()
    } else {
        government_roles <- get(CACHE_MPS_GOVERNMENT_ROLES_RAW, envir = cache)
    }

    # Filter on dates if requested
    if (!is.na(from_date) || !is.na(to_date)) {
        government_roles <- filter_dates(
            government_roles,
            start_col = "government_role_incumbency_start_date",
            end_col = "government_role_incumbency_end_date",
            from_date = from_date,
            to_date = to_date)
    }

    # Filter on memberships if requested
    if (while_mp) {
        commons_memberships <- fetch_commons_memberships()
        government_roles <- filter_memberships(
            tm = government_roles,
            fm = commons_memberships,
            tm_id_col = "government_role_mnis_id",
            tm_start_col = "government_role_incumbency_start_date",
            tm_end_col = "government_role_incumbency_end_date",
            fm_start_col = "seat_incumbency_start_date",
            fm_end_col = "seat_incumbency_end_date",
            join_col = "mnis_id")
    }

    # Tidy up and return
    government_roles %>%
        dplyr::arrange(
            .data$family_name,
            .data$government_role_incumbency_start_date) %>%
        dplyr::ungroup() %>%
        dplyr::mutate_if(is.character, stringr::str_trim)

}

#' Fetch opposition roles for all MPs
#'
#' \code{fetch_mps_opposition_roles} fetches data from the Members Names platform
#' showing opposition roles for each MP.
#'
#' The from_date and to_date arguments can be used to filter the roles
#' returned. The on_date argument is a convenience that sets the from_date and
#' to_date to the same given date. The on_date has priority: if the on_date is
#' set, the from_date and to_date are ignored.
#'
#' The while_mp argument can be used to filter the roles to include only those
#' that occurred during the period when each individual was an MP.
#'
#' The filtering is inclusive: a role is returned if any part of it falls
#' within the period specified with the from and to dates.
#'
#' Note that a role with an NA end date is still open.
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
#' @param while_mp A boolean indicating whether to filter the opposition roles
#'   to include only those roles that were held while each individual was serving
#'   as an MP. The default value is TRUE.
#' @return A tibble of opposition roles for each MP, with one row per
#'   opposition role.
#' @export

fetch_mps_opposition_roles <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA,
    while_mp = TRUE) {

    # Set from_date and to_date to on_date if set
    if (!is.na(on_date)) {
        from_date <- on_date
        to_date <- on_date
    }

    # Check cache
    if (!exists(CACHE_MPS_OPPOSITION_ROLES_RAW, envir = cache)) {
        opposition_roles <- fetch_mps_opposition_roles_raw()
    } else {
        opposition_roles <- get(CACHE_MPS_OPPOSITION_ROLES_RAW, envir = cache)
    }

    # Filter on dates if requested
    if (!is.na(from_date) || !is.na(to_date)) {
        opposition_roles <- filter_dates(
            opposition_roles,
            start_col = "opposition_role_incumbency_start_date",
            end_col = "opposition_role_incumbency_end_date",
            from_date = from_date,
            to_date = to_date)
    }

    # Filter on memberships if requested
    if (while_mp) {
        commons_memberships <- fetch_commons_memberships()
        opposition_roles <- filter_memberships(
            tm = opposition_roles,
            fm = commons_memberships,
            tm_id_col = "opposition_role_mnis_id",
            tm_start_col = "opposition_role_incumbency_start_date",
            tm_end_col = "opposition_role_incumbency_end_date",
            fm_start_col = "seat_incumbency_start_date",
            fm_end_col = "seat_incumbency_end_date",
            join_col = "mnis_id")
    }

    # Tidy up and return
    opposition_roles %>%
        dplyr::arrange(
            .data$family_name,
            .data$opposition_role_incumbency_start_date) %>%
        dplyr::ungroup() %>%
        dplyr::mutate_if(is.character, stringr::str_trim)
}

#' Fetch parliamentary roles for all MPs
#'
#' \code{fetch_mps_parliamentary_roles} fetches data from the Members Names platform
#' showing parliamentary roles for each MP.
#'
#' The from_date and to_date arguments can be used to filter the roles
#' returned. The on_date argument is a convenience that sets the from_date and
#' to_date to the same given date. The on_date has priority: if the on_date is
#' set, the from_date and to_date are ignored.
#'
#' The while_mp argument can be used to filter the roles to include only those
#' that occurred during the period when each individual was an MP.
#'
#' The filtering is inclusive: a role is returned if any part of it falls
#' within the period specified with the from and to dates.
#'
#' Note that a role with an NA end date is still open.
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
#' @param while_mp A boolean indicating whether to filter the parliamentary roles
#'   to include only those roles that were held while each individual was serving
#'   as an MP. The default value is TRUE.
#' @return A tibble of parliamentary roles for each MP, with one row per
#'   parliamentary role.
#' @export

fetch_mps_parliamentary_roles <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA,
    while_mp = TRUE) {

    # Set from_date and to_date to on_date if set
    if (!is.na(on_date)) {
        from_date <- on_date
        to_date <- on_date
    }

    # Check cache
    if (!exists(CACHE_MPS_PARLIAMENTARY_ROLES_RAW, envir = cache)) {
        parliamentary_roles <- fetch_mps_parliamentary_roles_raw()
    } else {
        parliamentary_roles <- get(CACHE_MPS_PARLIAMENTARY_ROLES_RAW, envir = cache)
    }

    # Filter on dates if requested
    if (!is.na(from_date) || !is.na(to_date)) {
        parliamentary_roles <- filter_dates(
            parliamentary_roles,
            start_col = "parliamentary_role_incumbency_start_date",
            end_col = "parliamentary_role_incumbency_end_date",
            from_date = from_date,
            to_date = to_date)
    }

    # Filter on memberships if requested
    if (while_mp) {
        commons_memberships <- fetch_commons_memberships()
        parliamentary_roles <- filter_memberships(
            tm = parliamentary_roles,
            fm = commons_memberships,
            tm_id_col = "parliamentary_role_mnis_id",
            tm_start_col = "parliamentary_role_incumbency_start_date",
            tm_end_col = "parliamentary_role_incumbency_end_date",
            fm_start_col = "seat_incumbency_start_date",
            fm_end_col = "seat_incumbency_end_date",
            join_col = "mnis_id")
    }

    # Tidy up and return
    parliamentary_roles %>%
        dplyr::arrange(
            .data$family_name,
            .data$parliamentary_role_incumbency_start_date) %>%
        dplyr::ungroup() %>%
        dplyr::mutate_if(is.character, stringr::str_trim)
}

#' Fetch maiden speeches for all MPs
#'
#' \code{fetch_mps_maiden_speeches} fetches data from the Members Names platform
#' showing maiden speeches for each MP.
#'
#' The from_date and to_date arguments can be used to filter the speeches
#' returned. The on_date argument is a convenience that sets the from_date and
#' to_date to the same given date. The on_date has priority: if the on_date is
#' set, the from_date and to_date are ignored.
#'
#' The filtering is inclusive: a speech is returned if the date of it falls
#' within the period specified with the from and to dates.
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
#' @return A tibble of maiden speeches for each MP, with one row per
#'   maiden speech.
#' @export

fetch_mps_maiden_speeches <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    # Set from_date and to_date to on_date if set
    if (!is.na(on_date)) {
        from_date <- on_date
        to_date <- on_date
    }

    # Check cache
    if (!exists(CACHE_MPS_MAIDEN_SPEECHES_RAW, envir = cache)) {
        maiden_speeches <- fetch_mps_maiden_speeches_raw()
    } else {
        maiden_speeches <- get(CACHE_MPS_MAIDEN_SPEECHES_RAW, envir = cache)
    }

    # Filter on dates if requested
    if (!is.na(from_date) || !is.na(to_date)) {
        maiden_speeches <- filter_dates(
            maiden_speeches,
            start_col = "maiden_speech_date",
            end_col = "maiden_speech_date",
            from_date = from_date,
            to_date = to_date)
    }

    # Tidy up and return
    maiden_speeches %>%
        dplyr::arrange(
            .data$family_name,
            .data$maiden_speech_date) %>%
        dplyr::ungroup() %>%
        dplyr::mutate_if(is.character, stringr::str_trim)
}

#' Fetch addresses for all MPs
#'
#' \code{fetch_mps_addresses} fetches data from the Members Names platform
#' showing contact details for each MP.
#'
#' Addresses can represent contact information of different types, including
#' phsyical addresses, phone, fax, email, website, and social media. These
#' addresses are not time bound in MNIS so date filtering is not available for
#' this function.
#'
#' @return A tibble of addresses for each MP, with one row per address.
#' @export

fetch_mps_addresses <- function() {

    # Check cache
    if (!exists(CACHE_MPS_ADDRESSES_RAW, envir = cache)) {
        addresses <- fetch_mps_addresses_raw()
    } else {
        addresses <- get(CACHE_MPS_ADDRESSES_RAW, envir = cache)
    }

    # Tidy up and return
    addresses %>%
        dplyr::arrange(
            .data$family_name,
            .data$address_type_mnis_id) %>%
        dplyr::ungroup() %>%
        dplyr::mutate_if(is.character, stringr::str_trim)
}
