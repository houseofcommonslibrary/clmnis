### Functions for downloading raw query data

# Raw MP queries --------------------------------------------------------------

#' Fetch key details for all MPs
#'
#' @keywords internal

fetch_mps_raw <- function() {

    # Fetch raw members data
    mps_raw <- fetch_query_data(house = HOUSE_COMMONS, "BasicDetails")

    # Extract data into a tibble
    mps <- tibble::tibble(
        mnis_id = mps_raw$`@Member_Id`,
        given_name = mps_raw$BasicDetails$GivenForename,
        family_name = mps_raw$BasicDetails$GivenSurname,
        display_name = mps_raw$DisplayAs,
        full_title = mps_raw$FullTitle,
        gender = mps_raw$Gender,
        current_age = "",
        date_of_birth = mps_raw$DateOfBirth,
        date_of_death = mps_raw$DateOfDeath)

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
    memberships_raw <- fetch_query_data(house = HOUSE_COMMONS, "Constituencies")

    # Define a function to extract data output for each MP
    extract_commons_memberships <- function(memberships) {
        memberships <- purrr::map_df(memberships$`@Member_Id`, function(member) {
            mnis_id <- member
            memberships <- dplyr::filter(memberships, `@Member_Id` == mnis_id)
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

    # Call extract function
    memberships <- extract_commons_memberships(memberships_raw)

    # Tidy
    memberships <- process_missing_values(memberships, seat_incumbency_end_date)
    memberships$seat_incumbency_start_date <- as.Date(memberships$seat_incumbency_start_date)
    memberships$seat_incumbency_end_date <- as.Date(memberships$seat_incumbency_end_date)

    #  Combine
    memberships <- process_mps_output(memberships)

    # Cache memberships
    assign(CACHE_COMMONS_MEMBERSHIPS_RAW, memberships, envir = cache)

    # Return
    memberships
}

#' Fetch government roles for all MPs
#'
#' @keywords internal

fetch_mps_government_roles_raw <- function() {

    # Fetch raw government roles data
    government_roles_raw <-  fetch_query_data(house = HOUSE_COMMONS, "GovernmentPosts")

    # Remove MPs that have never held a government role
    government_roles_raw <- dplyr::filter(government_roles_raw, !GovernmentPosts == "NULL")

    # Extract data output for each MP
    government_roles <- extract_data_output(
        government_roles_raw,
        "GovernmentPosts",
        "GovernmentPost") %>%
        dplyr::select(
            mnis_id,
            government_role_mnis_id = `@Id`,
            government_role_name = Name,
            government_role_incumbency_start_date = StartDate,
            government_role_incumbency_end_date = EndDate,
            government_role_unpaid = IsUnpaid)

    #  Tidy
    government_roles$government_role_incumbency_start_date <- as.Date(government_roles$government_role_incumbency_start_date)
    government_roles$government_role_incumbency_end_date <- as.Date(government_roles$government_role_incumbency_end_date)

    #  Combine
    government_roles <- process_mps_output(government_roles)

    # Cache government roles
    assign(CACHE_MPS_GOVERNMENT_ROLES_RAW, government_roles, envir = cache)

    # Return
    government_roles
}

#' Fetch opposition roles for all MPs
#'
#' @keywords internal

fetch_mps_opposition_roles_raw <- function() {

    # Fetch raw opposition roles data
    opposition_roles_raw <-  fetch_query_data(house = HOUSE_COMMONS, "OppositionPosts")

    # Remove MPs that have never held a opposition role
    opposition_roles_raw <- dplyr::filter(opposition_roles_raw, !OppositionPosts == "NULL")

    # Extract data output for each MP
    opposition_roles <- extract_data_output(
        opposition_roles_raw,
        "OppositionPosts",
        "OppositionPost") %>%
        dplyr::select(
            mnis_id,
            opposition_role_mnis_id = `@Id`,
            opposition_role_name = Name,
            opposition_role_incumbency_start_date = StartDate,
            opposition_role_incumbency_end_date = EndDate,
            opposition_role_unpaid = IsUnpaid)

    # Tidy
    opposition_roles$opposition_role_incumbency_start_date <- as.Date(opposition_roles$opposition_role_incumbency_start_date)
    opposition_roles$opposition_role_incumbency_end_date <- as.Date(opposition_roles$opposition_role_incumbency_end_date)

    # Combine
    opposition_roles <- process_mps_output(opposition_roles)

    # Cache opposition roles
    assign(CACHE_MPS_OPPOSITION_ROLES_RAW, opposition_roles, envir = cache)

    # Return
    opposition_roles
}

#' Fetch parliamentary roles for all MPs
#'
#' @keywords internal

fetch_mps_parliamentary_roles_raw <- function() {

    # Fetch raw opposition roles data
    parliamentary_roles_raw <-  fetch_query_data(house = HOUSE_COMMONS, "ParliamentaryPosts")

    # Remove MPs that have never held a opposition role
    parliamentary_roles_raw <- dplyr::filter(parliamentary_roles_raw, !ParliamentaryPosts == "NULL")

    # Extract data output for each MP
    parliamentary_roles <- extract_data_output(
        parliamentary_roles_raw,
        "ParliamentaryPosts",
        "ParliamentaryPost") %>%
        dplyr::select(
            mnis_id,
            parliamentary_role_mnis_id = `@Id`,
            parliamentary_role_name = Name,
            parliamentary_role_incumbency_start_date = StartDate,
            parliamentary_role_incumbency_end_date = EndDate,
            parliamentary_role_unpaid = IsUnpaid)

    # Tidy
    parliamentary_roles$parliamentary_role_incumbency_start_date <- as.Date(parliamentary_roles$parliamentary_role_incumbency_start_date)
    parliamentary_roles$parliamentary_role_incumbency_end_date <- as.Date(parliamentary_roles$parliamentary_role_incumbency_end_date)

    # Combine
    parliamentary_roles <- process_mps_output(parliamentary_roles)

    # Cache opposition roles
    assign(CACHE_MPS_PARLIAMENTARY_ROLES_RAW, parliamentary_roles, envir = cache)

    # Return
    parliamentary_roles
}

#' Fetch maiden speeches for all MPs
#'
#' @keywords internal

fetch_mps_maiden_speeches_raw <- function() {

    # Fetch raw maiden speeches data
    maiden_speeches_raw <-  fetch_query_data(house = HOUSE_COMMONS, "MaidenSpeeches")

    # Remove MPs that have had a maiden speech
    maiden_speeches_raw <- dplyr::filter(maiden_speeches_raw, !MaidenSpeeches == "NULL")

    # Extract data output for each MP
    maiden_speeches <- extract_data_output(
        maiden_speeches_raw,
        "MaidenSpeeches",
        "MaidenSpeech") %>%
        dplyr::select(
            mnis_id,
            maiden_speech_house = House,
            maiden_speech_date = SpeechDate,
            maiden_speech_hansard_reference = Hansard,
            maiden_speech_subject = Subject)

    # Tidy
    maiden_speeches$maiden_speech_date <- as.Date(maiden_speeches$maiden_speech_date)
    maiden_speeches <- maiden_speeches %>% dplyr::filter(maiden_speech_house == "Commons")

    # Combine
    maiden_speeches <- process_mps_output(maiden_speeches)

    # Cache opposition roles
    assign(CACHE_MPS_MAIDEN_SPEECHES_RAW, maiden_speeches, envir = cache)

    # Return
    maiden_speeches
}

#' Fetch other parliament memberships MPs
#'
#' @keywords internal

fetch_mps_other_parliaments_raw <- function() {

    # Fetch raw committee data
    other_parliaments_raw <-  fetch_query_data(house = HOUSE_COMMONS, "OtherParliaments")

    # Remove MPs that have had a maiden speech
    other_parliaments_raw <- dplyr::filter(other_parliaments_raw, !OtherParliaments == "NULL")

    # Define a function to extract data output for each MP
    extract_other_parliaments <- function(other_parliaments) {
        other_parliaments <- purrr::map(other_parliaments$`@Member_Id`, function(member) {
            mnis_id <- member
            other_parliaments <- dplyr::filter(other_parliaments, `@Member_Id` == mnis_id)
            other_parliaments <- purrr::map_df(other_parliaments$OtherParliaments$OtherParliament, function(member) {
                other_parliaments <- tibble::tibble(
                    other_parliaments_mnis_id = member$`@Id`,
                    other_parliaments_name = member$Name,
                    other_parliaments_country = member$Country,
                    other_parliaments_incumbency_start_date = member$StartDate,
                    other_parliaments_incumbency_end_date = unlist(member$EndDate))
            })
            other_parliaments$mnis_id <- mnis_id
            other_parliaments
        })
    }

    # Call extract function
    other_parliaments <- extract_other_parliaments(other_parliaments_raw)

    # Tidy
    other_parliaments <- process_missing_values(other_parliaments, seat_incumbency_end_date)
    other_parliaments$other_parliaments_incumbency_start_date <- as.Date(other_parliaments$other_parliaments_incumbency_start_date)
    other_parliaments$other_parliaments_incumbency_end_date <- as.Date(other_parliaments$other_parliaments_incumbency_end_date)

    # Combine
    other_parliaments <- process_mps_output(other_parliaments)

    # Cache opposition roles
    assign(CACHE_MPS_OTHER_PARLIAMENTS_RAW, other_parliaments, envir = cache)

    # Return
    other_parliaments
}




# NOT COMPLETE / NOT WORKING --------------------------------------------------

#' Fetch party memberships for all MPs
#'
#' @keywords internal

fetch_mps_party_memberships_raw <- function() {

    # Fetch raw party membership data
    party_memberships_raw <- fetch_query_data(house = HOUSE_COMMONS, "Parties")

    # Define a function to extract data output for each MP
    extract_party_memberships <- function(memberships) {
        memberships <- purrr::map_df(memberships$`@Member_Id`, function(member) {
            mnis_id <- member
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
    memberships <- process_missing_values(memberships, party_membership_end_date)
    memberships$party_membership_start_date <- as.Date(memberships$party_membership_start_date)
    memberships$party_membership_end_date <- as.Date(memberships$party_membership_end_date)

    #  Combine
    memberships <- process_mps_output(memberships)

    # Cache memberships
    assign(CACHE_COMMONS_PARTY_MEMBERSHIPS_RAW, memberships, envir = cache)

    # Return
    memberships
}
