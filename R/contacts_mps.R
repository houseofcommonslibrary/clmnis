### Functions for extracting contact details for MPS

# Office addresses ------------------------------------------------------------

#' Fetch office addresses for MPs
#'
#' \code{fetch_mps_office_addresses} fetches data from the Members Names
#' platform on office addresses for each MP, with one row per combination of
#' MP and office address.
#'
#' The from_date and to_date arguments can be used to filter the MPs based
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
#' @return A tibble of known office addresses for each MP, with one row per
#'   combination of MP and office address.
#' @export

fetch_mps_office_addresses <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    fetch_members_office_addresses(
        fetch_mps,
        fetch_mps_addresses,
        from_date = from_date,
        to_date = to_date,
        on_date = on_date)
}

# Email addresses -------------------------------------------------------------

#' Fetch email addresses for MPs
#'
#' \code{fetch_mps_email_addresses} fetches data from the Members Names
#' platform on email addresses for each MP, with one row per combination of MP
#' and email address.
#'
#' The from_date and to_date arguments can be used to filter the MPs based
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
#' @return A tibble of known email addresses for each MP, with one row per
#'   combination of MP and email address.
#' @export

fetch_mps_email_addresses <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    fetch_members_email_addresses(
        fetch_mps,
        fetch_mps_addresses,
        from_date = from_date,
        to_date = to_date,
        on_date = on_date)
}

# Phone numbers ---------------------------------------------------------------

#' Fetch phone numbers for MPs
#'
#' \code{fetch_mps_phone_numbers} fetches data from the Members Names platform
#' on phone numbers for each MP, with one row per combination of MP and phone
#' number.
#'
#' The from_date and to_date arguments can be used to filter the MPs based
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
#' @return A tibble of known phone numbers for each MP, with one row per
#'   combination of MP and phone number.
#' @export

fetch_mps_phone_numbers <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    fetch_members_phone_numbers(
        fetch_mps,
        fetch_mps_addresses,
        from_date = from_date,
        to_date = to_date,
        on_date = on_date)
}

# Fax numbers -----------------------------------------------------------------

#' Fetch fax numbers for MPs
#'
#' \code{fetch_mps_fax_numbers} fetches data from the Members Names platform on
#' fax numbers for each MP, with one row per combination of MP and fax number.
#'
#' The from_date and to_date arguments can be used to filter the MPs based
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
#' @return A tibble of known fax numbers for each MP, with one row per
#'   combination of MP and fax number.
#' @export

fetch_mps_fax_numbers <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    fetch_members_fax_numbers(
        fetch_mps,
        fetch_mps_addresses,
        from_date = from_date,
        to_date = to_date,
        on_date = on_date)
}

# Websites --------------------------------------------------------------------

#' Fetch websites for MPs
#'
#' \code{fetch_mps_websites} fetches data from the Members Names platform on
#' websites for each MP, with one row per combination of MP and website.
#'
#' The from_date and to_date arguments can be used to filter the MPs based
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
#' @return A tibble of known websites for each MP, with one row per combination
#'   of MP and website.
#' @export

fetch_mps_websites <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    fetch_members_websites(
        fetch_mps,
        fetch_mps_addresses,
        from_date = from_date,
        to_date = to_date,
        on_date = on_date)
}

# Blogs -----------------------------------------------------------------------

#' Fetch blogs for MPs
#'
#' \code{fetch_mps_blogs} fetches data from the Members Names platform on blogs
#' for each MP, with one row per combination of MP and blog.
#'
#' The from_date and to_date arguments can be used to filter the MPs based
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
#' @return A tibble of known blogs for each MP, with one row per combination
#'   of MP and blog.
#' @export

fetch_mps_blogs <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    fetch_members_blogs(
        fetch_mps,
        fetch_mps_addresses,
        from_date = from_date,
        to_date = to_date,
        on_date = on_date)
}

# Twitter ---------------------------------------------------------------------

#' Fetch Twitter accounts for MPs
#'
#' \code{fetch_mps_twitter} fetches data from the Members Names platform on
#' Twitter accounts for each MP, with one row per combination of MP and Twitter
#' account.
#'
#' The from_date and to_date arguments can be used to filter the MPs based
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
#' @return A tibble of known Twitter accounts for each MP, with one row per
#'   combination of MP and Twitter account.
#' @export

fetch_mps_twitter <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    fetch_members_twitter(
        fetch_mps,
        fetch_mps_addresses,
        from_date = from_date,
        to_date = to_date,
        on_date = on_date)
}

# Instagram -------------------------------------------------------------------

#' Fetch Instagram accounts for MPs
#'
#' \code{fetch_mps_instagram} fetches data from the Members Names platform on
#' Instagram accounts for each MP, with one row per combination of MP and
#' Instagram account.
#'
#' The from_date and to_date arguments can be used to filter the MPs based
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
#' @return A tibble of known Instagram accounts for each MP, with one row per
#'   combination of MP and Instagram account.
#' @export

fetch_mps_instagram <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    fetch_members_instagram(
        fetch_mps,
        fetch_mps_addresses,
        from_date = from_date,
        to_date = to_date,
        on_date = on_date)
}

# Facebook --------------------------------------------------------------------

#' Fetch Facebook accounts for MPs
#'
#' \code{fetch_mps_facebook} fetches data from the Members Names platform on
#' Facebook accounts for each MP, with one row per combination of MP and
#' Facebook account.
#'
#' The from_date and to_date arguments can be used to filter the MPs based
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
#' @return A tibble of known Facebook accounts for each MP, with one row per
#'   combination of MP and Facebook account.
#' @export

fetch_mps_facebook <- function(
    from_date = NA,
    to_date = NA,
    on_date = NA) {

    fetch_members_facebook(
        fetch_mps,
        fetch_mps_addresses,
        from_date = from_date,
        to_date = to_date,
        on_date = on_date)
}
