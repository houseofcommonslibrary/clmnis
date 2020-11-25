### Download all data for unit testing

# Imports ---------------------------------------------------------------------

source("tests/testthat/validate_mps.R")
source("tests/testthat/validate_lords.R")
source("tests/testthat/validate_contacts_mps.R")
source("tests/testthat/validate_contacts_lords.R")

# Fetch all data --------------------------------------------------------------
fetch_mps_test_data()
fetch_lords_test_data()
fetch_mps_contacts_test_data()
fetch_lords_contacts_test_data()
