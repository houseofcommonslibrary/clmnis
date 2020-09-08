# process_missing_date_values <- function(column) {
#    tibble::as_tibble_col(unlist(column)) %>%
#       dplyr::filter(value != "http://www.w3.org/2001/XMLSchema-instance") %>%
#       dplyr::mutate(value = ifelse(value == "true", NA, value))
# }


# # THIS WORKS!!!!!!!!! YAAYYYYYYY!!!
# my_func <- function(memberships) {
#     mnis_ids <- memberships$`@Member_Id`
#     my_list <- list()
#
#     for (id in mnis_ids) {
#         id <- id
#         df <- dplyr::filter(memberships, `@Member_Id` == id)
#         df <- purrr::map_df(df$Constituencies$Constituency, function(member) {
#             df <- tibble::tibble(
#                 mnis_constituency_code = member$`@Id`,
#                 constituency_name = member$Name,
#                 seat_incumbency_start_date = member$StartDate,
#                 seat_incumbency_end_date = as.character(member$EndDate))})
#         df$mnis_id <- id
#         my_list[[id]] <- df
#     }
#     my_list
# }


# my_func_two <- function(memberships) {
#     df <- purrr::map(memberships$`@Member_Id`, function(member) {
#         mnis_id <- member
#         df <- dplyr::filter(memberships, `@Member_Id` == mnis_id)
#         df <- purrr::map_df(df$Constituencies$Constituency, function(member) {
#             df <- tibble::tibble(
#                 mnis_constituency_code = member$`@Id`,
#                 constituency_name = member$Name,
#                 seat_incumbency_start_date = member$StartDate,
#                 seat_incumbency_end_date = as.character(member$EndDate))
#         })
#         df$mnis_id <- mnis_id
#         df
#     })
# }



# check_output_length <- function(output) {
#     if (length(output) > 3) {
#         stop(stringr::str_c(
#             "Only 3 additional sets of data may be requested for any given ",
#             "call to the API."))
#     }
# }
