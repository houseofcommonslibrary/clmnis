### Test combine functions
context("Combine functions")

# Test data -------------------------------------------------------------------

pm_csv <- "
    mnis_id,    party_mnis_id,  start_date, end_date
    mi1,        pa1,            2001-01-01, 2001-12-31
    mi1,        pa2,            2002-01-01, 2002-12-31
    mi1,        pa1,            2003-01-01, 2003-12-31
    mi1,        pa1,            2004-01-01, 2004-12-31
    mi2,        pa1,            2002-01-01, 2002-12-31
    mi2,        pa2,            2004-01-01, NA
    mi2,        pa2,            2003-01-01, 2003-12-31
    mi2,        pa1,            2001-01-01, 2001-12-31
"

pm <- readr::read_csv(
    pm_csv,
    trim_ws = TRUE,
    col_types = readr::cols(
        party_mnis_id = readr::col_character(),
        start_date = readr::col_date(),
        end_date = readr::col_date()))

pm$party_membership_start_date = pm$start_date
pm$party_membership_end_date = pm$end_date
pm$given_name = pm$mnis_id
pm$family_name = pm$mnis_id
pm$display_name = pm$mnis_id
pm$party_name = ""

pm <- pm %>% dplyr::select(
    mnis_id,
    given_name,
    family_name,
    display_name,
    party_mnis_id,
    party_name,
    party_membership_start_date,
    party_membership_end_date)

# Test combine_party_memberships ----------------------------------------------

test_that("combine_party_memberships raises an error for incorrect columns.", {

    pm_missing_column <- pm %>% dplyr::select(-mnis_id)

    expect_error(
        combine_party_memberships(pm_missing_column),
        "pm does not have the expected columns")

    pm_wrong_column_names <- pm %>% dplyr::select(-mnis_id)
    pm_wrong_column_names$mid <- pm$mnis_id

    expect_error(
        combine_party_memberships(pm_wrong_column_names),
        "pm does not have the expected columns")
})

test_that("combine filters the correct memberships.", {

    cpm <- combine_party_memberships(pm)

    expect_equal(nrow(cpm), 5)
    expect_equal(cpm$mnis_id, c("mi1", "mi1", "mi1", "mi2", "mi2"))
    expect_equal(cpm$party_membership_start_date, c(
        as.Date("2001-01-01"),
        as.Date("2002-01-01"),
        as.Date("2003-01-01"),
        as.Date("2001-01-01"),
        as.Date("2003-01-01")))
    expect_equal(cpm$party_membership_end_date, c(
        as.Date("2001-12-31"),
        as.Date("2002-12-31"),
        as.Date("2004-12-31"),
        as.Date("2002-12-31"),
        NA))
})
