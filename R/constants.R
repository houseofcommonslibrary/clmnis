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
CACHE_MPS_OTHER_PARLIAMENTS_RAW <- "mps_other_parliaments"
CACHE_MPS_CONTESTED_ELECTIONS_RAW <- "mps_contested_elections"

CACHE_LORDS_MEMBERSHIPS_RAW <- "lords_memberships"
CACHE_LORDS_GOVERNMENT_ROLES_RAW <- "lords_government_roles"
CACHE_LORDS_OPPOSITION_ROLES_RAW <- "lords_opposition_roles"
CACHE_LORDS_PARLIAMENTARY_ROLES_RAW <- "lords_parliamentary_roles"
CACHE_LORDS_MAIDEN_SPEECHES_RAW <- "lords_maiden_speeches"
CACHE_LORDS_OTHER_PARLIAMENTS_RAW <- "lords_other_parliaments"

# Library call - move to namespace --------------------------------------------

library(magrittr)
