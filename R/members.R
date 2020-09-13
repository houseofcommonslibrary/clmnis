### Functions for downloading and analysing data on Members of either House

# Raw Members queries ---------------------------------------------------------

#' Fetch key details for Members
#'
#' @keywords internal

fetch_members_raw <- function(house) {
    query <- stringr::str_glue(
        "{MNIS_API}House={house}|Membership=all/BasicDetails")
    data <- fetch_query_data(query)
    data$Members$Member
}

#' Fetch Commons memberships on date
#'
#' @keywords internal

fetch_memberships_raw <- function(house) {
    query <- stringr::str_glue(
        "{MNIS_API}House={house}|Membership=all/Constituencies|Parties")
    data <- fetch_query_data(query)
    data$Members$Member
}

#' Fetch party memberships for Members
#'
#' @keywords internal
#
# fetch_party_memberships_raw <- function(house) {
#     query <- stringr::str_glue(
#         "{MNIS_API}House={house}|Membership=all/Constituencies|Parties")
#     data <- fetch_query_data(query)
#     data$Members$Member
# }

#' Fetch government roles for members
#'
#' @keywords internal

fetch_government_roles_raw <- function(house) {
    query <- stringr::str_glue(
        "{MNIS_API}House={house}|Membership=all/GovernmentPosts")
    data <- fetch_query_data(query)
    data$Members$Member
}

#' Fetch opposition roles for members
#'
#' @keywords internal

fetch_opposition_roles_raw <- function(house) {
    query <- stringr::str_glue(
        "{MNIS_API}House={house}|Membership=all/OppositionPosts")
    data <- fetch_query_data(query)
    data$Members$Member
}



