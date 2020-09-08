### Package constants

# API url ---------------------------------------------------------------------

MNIS_API <- "http://data.parliament.uk/membersdataplatform/services/mnis/members/query/"

# House within Parliament -----------------------------------------------------

HOUSE_COMMONS <- "commons"
HOUSE_LORDS <- "lords"

# XML missing data string -----------------------------------------------------

MISSING_VALUE_STRING <- 'list(`@xsi:nil` = "true", `@xmlns:xsi` = "http://www.w3.org/2001/XMLSchema-instance")'

# Cache constants -------------------------------------------------------------

cache <- new.env(parent = emptyenv())
CACHE_COMMONS_MEMBERSHIPS_RAW <- "commons_memberships"
CACHE_COMMONS_PARTY_MEMBERSHIPS_RAW <- "commons_party_memberships"

# Library call - move to namespace --------------------------------------------

library(magrittr)
