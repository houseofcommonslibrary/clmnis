### Package constants

# API url ---------------------------------------------------------------------

MNIS_API <- "http://data.parliament.uk/membersdataplatform/services/mnis/members/query/"

# House within Parliament -----------------------------------------------------

HOUSE_COMMONS <- "Commons"
HOUSE_LORDS <- "Lords"

# XML missing data string -----------------------------------------------------

MISSING_VALUE_STRING <- 'list(`@xsi:nil` = "true", `@xmlns:xsi` = "http://www.w3.org/2001/XMLSchema-instance")'

# Cache constants -------------------------------------------------------------

cache <- new.env(parent = emptyenv())
CACHE_COMMONS_MEMBERSHIPS_RAW <- "commons_memberships"
CACHE_COMMONS_PARTY_MEMBERSHIPS_RAW <- "commons_party_memberships"
CACHE_MPS_GOVERNMENT_ROLES_RAW <- "mps_government_roles"
CACHE_MPS_OPPOSITION_ROLES_RAW <- "mps_opposition_roles"
CACHE_MPS_PARLIAMENTARY_ROLES_RAW <- "mps_parliamentary_roles"
CACHE_MPS_MAIDEN_SPEECHES_RAW <- "mps_maiden_speeches"

# Library call - move to namespace --------------------------------------------

library(magrittr)
