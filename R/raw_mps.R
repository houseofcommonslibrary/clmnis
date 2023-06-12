### Functions for downloading raw query data

# Raw MP queries --------------------------------------------------------------

#' Fetch key details: MPs
#'
#' @keywords internal

fetch_mps_raw <- function() {

    # Fetch raw
    mps_raw <- fetch_query_data(house = HOUSE_COMMONS, "BasicDetails")

    # Extract data
    mps <- tibble::tibble(
        mnis_id = mps_raw$`@Member_Id`,
        given_name = mps_raw$BasicDetails$GivenForename,
        family_name = mps_raw$BasicDetails$GivenSurname,
        display_name = mps_raw$DisplayAs,
        full_title = mps_raw$FullTitle,
        current_status = mps_raw$CurrentStatus$Name,
        current_status_reason = mps_raw$CurrentStatus$Reason,
        gender = mps_raw$Gender,
        date_of_death = mps_raw$DateOfDeath)

    # Tidy and return
    mps <- process_missing_values(mps, "date_of_death")
    mps$date_of_death <- as.Date(unlist(mps$date_of_death))
    mps
}

#' Fetch memberships: MPs
#'
#' @keywords internal

fetch_commons_memberships_raw <- function() {

    # Fetch raw
    memberships_raw <- fetch_query_data(house = HOUSE_COMMONS, "Constituencies")

    # Define a function to extract data
    extract_commons_memberships <- function(memberships) {
        memberships <- purrr::map_df(memberships$`@Member_Id`, function(member) {
            mnis_id <- member
            memberships <- dplyr::filter(memberships, .data$`@Member_Id` == mnis_id)
            memberships <- purrr::map_df(memberships$Constituencies$Constituency, function(member) {
                memberships <- tibble::tibble(
                    constituency_mnis_id = member$`@Id`,
                    constituency_name = member$Name,
                    seat_incumbency_start_date = member$StartDate,
                    seat_incumbency_end_date = as.character(member$EndDate))
            })
            memberships$mnis_id <- mnis_id
            memberships
        })
    }

    # Extract data
    memberships <- extract_commons_memberships(memberships_raw)

    # Tidy
    memberships <- process_missing_values(memberships, "seat_incumbency_end_date")
    memberships$seat_incumbency_start_date <- as.Date(memberships$seat_incumbency_start_date)
    memberships$seat_incumbency_end_date <- as.Date(memberships$seat_incumbency_end_date)

    #  Combine
    memberships <- process_mps_output(memberships)

    # Cache
    assign(CACHE_COMMONS_MEMBERSHIPS_RAW, memberships, envir = cache)

    # Return
    memberships
}

#' Fetch party memberships: MPs
#'
#' @keywords internal

fetch_mps_party_memberships_raw <- function() {

    # Fetch raw party membership data
    party_memberships_raw <- fetch_query_data(house = HOUSE_COMMONS, "Parties")

    # Define a function to extract data output for each MP
    extract_party_memberships <- function(memberships) {
        memberships <- purrr::map_df(memberships$`@Member_Id`, function(member) {
            mnis_id <- member
           # memberships <- dplyr::filter(memberships, .data$`@Member_Id` == mnis_id)
            memberships <- dplyr::filter(memberships, `@Member_Id` == mnis_id)
            memberships <- purrr::map_df(memberships$Parties$Party, function(member) {
                memberships <- tibble::tibble(
                    party_mnis_id = member$`@Id`,
                    party_name = member$Name,
                    party_membership_start_date = member$StartDate,
                    party_membership_end_date = as.character(member$EndDate))
            })
            memberships$mnis_id <- mnis_id
            memberships
        })
    }

    # Call extract function
    memberships <- extract_party_memberships(party_memberships_raw)

    # Tidy
    memberships <- process_missing_values(memberships, "party_membership_end_date")
    memberships$party_membership_start_date <- as.Date(memberships$party_membership_start_date)
    memberships$party_membership_end_date <- as.Date(memberships$party_membership_end_date)

    #  Combine
    memberships <- process_mps_output(memberships)

    # Cache memberships
    assign(CACHE_COMMONS_PARTY_MEMBERSHIPS_RAW, memberships, envir = cache)

    # Return
    memberships
}

#' Fetch other parliaments: MPs
#'
#' @keywords internal

fetch_mps_other_parliaments_raw <- function() {

    # Fetch raw
    other_parliaments_raw <- fetch_query_data(house = HOUSE_COMMONS, "OtherParliaments")

    # Remove NULL
    other_parliaments_raw <- dplyr::filter(other_parliaments_raw, !.data$OtherParliaments == "NULL")

    # Define a function to extract data
    extract_other_parliaments <- function(other_parliaments) {
        other_parliaments <- purrr::map_df(other_parliaments$`@Member_Id`, function(member) {
            mnis_id <- member
           # other_parliaments <- dplyr::filter(other_parliaments, .data$`@Member_Id` == mnis_id)
            other_parliaments <- dplyr::filter(other_parliaments, `@Member_Id` == mnis_id)
            other_parliaments <- purrr::map_df(other_parliaments$OtherParliaments$OtherParliament, function(member) {
                other_parliaments <- tibble::tibble(
                    other_parliaments_mnis_id = member$`@Id`,
                    other_parliaments_name = member$Name,
                    other_parliaments_incumbency_start_date = member$StartDate,
                    other_parliaments_incumbency_end_date = as.character(member$EndDate))
            })
            other_parliaments$mnis_id <- mnis_id
            other_parliaments
        })
    }

    # Extract data
    other_parliaments <- extract_other_parliaments(other_parliaments_raw)

    # Tidy
    other_parliaments <- process_missing_values(other_parliaments, "other_parliaments_incumbency_end_date")
    other_parliaments$other_parliaments_incumbency_start_date <- as.Date(other_parliaments$other_parliaments_incumbency_start_date)
    other_parliaments$other_parliaments_incumbency_end_date <- as.Date(other_parliaments$other_parliaments_incumbency_end_date)

    # Combine
    other_parliaments <- process_mps_output(other_parliaments)

    # Cache
    assign(CACHE_MPS_OTHER_PARLIAMENTS_RAW, other_parliaments, envir = cache)

    # Return
    other_parliaments
}

#' Fetch contested elections: MPs
#'
#' @keywords internal

fetch_mps_contested_elections_raw <- function() {

    # Fetch raw
    contested_elections_raw <-  fetch_query_data(house = HOUSE_COMMONS, "ElectionsContested")

    # Remove NULL
    contested_elections_raw <- dplyr::filter(contested_elections_raw, !.data$ElectionsContested == "NULL")

    # Define a function to extract data
    extract_contested_elections <- function(contested_elections) {
        contested_elections <- purrr::map_df(contested_elections$`@Member_Id`, function(member) {
            mnis_id <- member
            #contested_elections <- dplyr::filter(contested_elections, .data$`@Member_Id` == mnis_id)
            contested_elections <- dplyr::filter(contested_elections,`@Member_Id` == mnis_id)
            contested_elections <- purrr::map_df(contested_elections$ElectionsContested$ElectionContested, function(member) {
                contested_elections <- tibble::tibble(
                    contested_election_mnis_id = member$Election$`@Id`,
                    contested_election_name = member$Election$Name,
                    contested_election_date = member$Election$Date,
                    contested_election_type = member$Election$Type,
                    contested_election_constituency = member$Constituency)
            })
            contested_elections$mnis_id <- mnis_id
            contested_elections
        })
    }

    # Extract data
    contested_elections <- extract_contested_elections(contested_elections_raw)

    # Tidy
    contested_elections <- process_missing_values(contested_elections, "contested_election_date")
    contested_elections$contested_election_date <- as.Date(contested_elections$contested_election_date)

    # Combine
    contested_elections <- process_mps_output(contested_elections)

    # Cache
    assign(CACHE_MPS_CONTESTED_ELECTIONS_RAW, contested_elections, envir = cache)

    # Return
    contested_elections
}

#' Fetch government roles: MPs
#'
#' @keywords internal

fetch_mps_government_roles_raw <- function() {

    # Fetch raw
    government_roles_raw <-  fetch_query_data(house = HOUSE_COMMONS, "GovernmentPosts")

    # Remove NULL
    government_roles_raw <- dplyr::filter(government_roles_raw, !GovernmentPosts == "NULL")

    # Extract data
    government_roles <- extract_data_output(
        government_roles_raw,
        "GovernmentPosts",
        "GovernmentPost") %>%
        dplyr::select(
            .data$mnis_id,
            government_role_mnis_id = .data$`@Id`,
            government_role_name = .data$Name,
            government_role_incumbency_start_date = .data$StartDate,
            government_role_incumbency_end_date = .data$EndDate,
            government_role_unpaid = .data$IsUnpaid)

    #  Tidy
    government_roles$government_role_incumbency_start_date <- as.Date(government_roles$government_role_incumbency_start_date)
    government_roles$government_role_incumbency_end_date <- as.Date(government_roles$government_role_incumbency_end_date)

    #  Combine
    government_roles <- process_mps_output(government_roles)

    # Cache
    assign(CACHE_MPS_GOVERNMENT_ROLES_RAW, government_roles, envir = cache)

    # Return
    government_roles
}

#' Fetch opposition roles: MPs
#'
#' @keywords internal

fetch_mps_opposition_roles_raw <- function() {

    # Fetch raw
    opposition_roles_raw <-  fetch_query_data(house = HOUSE_COMMONS, "OppositionPosts")

    # Remove NULL
    #opposition_roles_raw <- dplyr::filter(opposition_roles_raw, !.data$OppositionPosts == "NULL")
    opposition_roles_raw <- dplyr::filter(opposition_roles_raw, !OppositionPosts == "NULL")

    # Extract data
    opposition_roles <- extract_data_output(
        opposition_roles_raw,
        "OppositionPosts",
        "OppositionPost") %>%
        dplyr::select(
            .data$mnis_id,
            opposition_role_mnis_id = .data$`@Id`,
            opposition_role_name = .data$Name,
            opposition_role_incumbency_start_date = .data$StartDate,
            opposition_role_incumbency_end_date = .data$EndDate,
            opposition_role_unpaid = .data$IsUnpaid)

    # Tidy
    opposition_roles$opposition_role_incumbency_start_date <- as.Date(opposition_roles$opposition_role_incumbency_start_date)
    opposition_roles$opposition_role_incumbency_end_date <- as.Date(opposition_roles$opposition_role_incumbency_end_date)

    # Combine
    opposition_roles <- process_mps_output(opposition_roles)

    # Cache
    assign(CACHE_MPS_OPPOSITION_ROLES_RAW, opposition_roles, envir = cache)

    # Return
    opposition_roles
}

#' Fetch parliamentary roles: MPs
#'
#' @keywords internal

fetch_mps_parliamentary_roles_raw <- function() {

    # Fetch raw
    parliamentary_roles_raw <-  fetch_query_data(house = HOUSE_COMMONS, "ParliamentaryPosts")

    # Remove NULL
    parliamentary_roles_raw <- dplyr::filter(parliamentary_roles_raw, !.data$ParliamentaryPosts == "NULL")

    # Extract data
    parliamentary_roles <- extract_data_output(
        parliamentary_roles_raw,
        "ParliamentaryPosts",
        "ParliamentaryPost") %>%
        dplyr::select(
            .data$mnis_id,
            parliamentary_role_mnis_id = .data$`@Id`,
            parliamentary_role_name = .data$Name,
            parliamentary_role_incumbency_start_date = .data$StartDate,
            parliamentary_role_incumbency_end_date = .data$EndDate,
            parliamentary_role_unpaid = .data$IsUnpaid)

    # Tidy
    parliamentary_roles$parliamentary_role_incumbency_start_date <- as.Date(parliamentary_roles$parliamentary_role_incumbency_start_date)
    parliamentary_roles$parliamentary_role_incumbency_end_date <- as.Date(parliamentary_roles$parliamentary_role_incumbency_end_date)

    # Combine
    parliamentary_roles <- process_mps_output(parliamentary_roles)

    # Cache
    assign(CACHE_MPS_PARLIAMENTARY_ROLES_RAW, parliamentary_roles, envir = cache)

    # Return
    parliamentary_roles
}

#' Fetch maiden speeches: MPs
#'
#' @keywords internal

fetch_mps_maiden_speeches_raw <- function() {

    # Fetch raw
    maiden_speeches_raw <-  fetch_query_data(house = HOUSE_COMMONS, "MaidenSpeeches")

    # Remove NULL
    #maiden_speeches_raw <- dplyr::filter(maiden_speeches_raw, !.data$MaidenSpeeches == "NULL")
    maiden_speeches_raw <- dplyr::filter(maiden_speeches_raw, !MaidenSpeeches == "NULL")

    # Extract data
    maiden_speeches <- extract_data_output(
        maiden_speeches_raw,
        "MaidenSpeeches",
        "MaidenSpeech") %>%
        dplyr::select(
            .data$mnis_id,
            maiden_speech_house = .data$House,
            maiden_speech_date = .data$SpeechDate,
            maiden_speech_hansard_reference = .data$Hansard,
            maiden_speech_subject = .data$Subject)

    # Tidy
    maiden_speeches$maiden_speech_date <- as.Date(maiden_speeches$maiden_speech_date)
    maiden_speeches <- maiden_speeches %>% dplyr::filter(.data$maiden_speech_house == "Commons")

    # Combine
    maiden_speeches <- process_mps_output(maiden_speeches)

    # Cache
    assign(CACHE_MPS_MAIDEN_SPEECHES_RAW, maiden_speeches, envir = cache)

    # Return
    maiden_speeches
}

#' Fetch addresses: MPs
#'
#' @keywords internal

fetch_mps_addresses_raw <- function() {

    # Fetch raw
    addresses_raw <-  fetch_query_data(house = HOUSE_COMMONS, "Addresses")

    # Remove NULL
    #addresses_raw <- dplyr::filter(addresses_raw, !.data$Addresses == "NULL")
    addresses_raw <- dplyr::filter(addresses_raw, !Addresses == "NULL")

    # Extract data
    addresses <- extract_data_output(
        addresses_raw,
        "Addresses",
        "Address") %>%
        dplyr::select(
            .data$mnis_id,
            address_type_mnis_id = .data$`@Type_Id`,
            address_type  = .data$Type,
            address_is_preferred  = .data$IsPreferred,
            address_is_physical  = .data$IsPhysical,
            address_note  = .data$Note,
            address_1  = .data$Address1,
            address_2  = .data$Address2,
            address_3  = .data$Address3,
            address_4  = .data$Address4,
            address_5  = .data$Address5,
            postcode  = .data$Postcode,
            phone  = .data$Phone,
            fax  = .data$Fax,
            email  = .data$Email,
            address_other = .data$OtherAddress)

    # Tidy
    addresses$address_is_preferred <- as.logical(addresses$address_is_preferred)
    addresses$address_is_physical <- as.logical(addresses$address_is_physical)

    # Combine
    addresses <- process_mps_output(addresses)

    # Cache
    assign(CACHE_MPS_ADDRESSES_RAW, addresses, envir = cache)

    # Return
    addresses
}
