# clmnis

__clmnis__ is an R package for downloading data from the UK Parliament's [Members Names Information Service](http://data.parliament.uk/membersdataplatform/memberquery.aspx) (MNIS). 

__Please note that this package is in active development. You should check the accuracy of the data against external sources when using it for research.__

## Overview
The MNIS API is the public interface to the UK Parliament's Members Names Information Service, a comprehensive database of all Members sitting in either the House of Commons or House of Lords. The API is flexible and powerful, but it's not very easy to use. The __clmnis__ package is a toolkit that allows you to download and manipulate useful data from the API through a high-level interface, comprising families of functions for downloading specific datasets.

## Installation
Install from Github with using remotes.

```r
install.packages("remotes")
remotes::install_github("houseofcommonslibrary/clmnis")
```

## MNIS API
The MNIS API provides access to data on Members of both Houses of Parliament. It provides similar functions for downloading data on both MPs and Lords, but the structure of the data returned in each case may differ to reflect differences between Commons and Lords memberships.

Many of these functions can take optional arguments for a ```from_date``` and a ```to_date```, which can be used to filter the rows returned based on a period of activity related to each row. The ```on_date``` argument is a convenience that sets the ```from_date``` and ```to_date``` to the same given date. The ```on_date``` has priority: if the ```on_date``` is set, the ```from_date``` and ```to_date``` are ignored. The values for these arguments can be either a Date or a string specifying a date in ISO 8601 format ("YYYY-MM-DD").

The filtering performed using these arguments is inclusive: a row is returned if any part of the activity in question falls within the period specified with the from and to dates. If the activity in question has not yet ended, the end date will have a value of NA.

---

## MPs

### MPs core datasets
These are functions that return core datasets on Members of the House of Commons (MPs) from the MNIS API. Use `fetch_mps` to fetch the MPs and the other functions to fetch data on their house memberships, parties, roles etc. There is a one-to-many relationship between the data returned from `fetch_mps` and the data returned from the other functions. You can synthesise a single dataset that you need for a particular analysis by joining across these tables. 

Some MP functions have an optional argument called ```while_mp```, which filters the data to include only those rows that coincide with the period when the individual was serving in the House of Commons. This is sometimes necessary because someone who serves in the House of Commons may later serve in the House of Lords and may hold different roles while serving in both Houses. When this argument is set to *FALSE* these functions will return all relevant records for each individual, even if the records themselves relate to periods when the individual was not an MP.

---

__fetch_mps__

Fetch a dataframe of key details about each MP, with one row per MP. This dataframe contains summary details for each MP, such as names, gender, and dates of birth and death.

```r
clmnis::fetch_mps(from_date = NA, to_date = NA, on_date = NA)
```

The ```from_date```, ```to_date``` and ```on_date``` arguments can be used to filter the MPs returned based on the dates of their Commons memberships. Note that in this particular case the filtering does not rely on dates shown in the dataframe but uses Commons membership records to calculate whether an MP was serving on the dates in question. While breaks in service are therefore accounted for, this function does not yet have an option to exclude serving Members who are prevented from sitting for some reason.

---

__fetch_commons_memberships__

Fetch a dataframe of Commons memberships for each MP, with one row per Commons membership.

```r
clmnis::fetch_commons_memberships(from_date = NA, to_date = NA, on_date = NA)
```

The memberships dates are processed to impose consistent rules on the start and end dates for memberships. Specifically, Commons memberships are taken to end at the dissolution of each Parliament, rather than on the date of the general election at which an MP was defeated.

--- 

__fetch_mps_party_memberships__

Fetch a dataframe of party memberships for each MP, with one row per party membership.

```r
clmnis::fetch_mps_party_memberships(from_date = NA, to_date = NA, on_date = NA, while_mp = TRUE, collapse = FALSE)
```

The ```collapse``` argument determines whether to collapse consecutive memberships within the same party into a single period of continuous party membership. The default value of this argument is *FALSE*, but it can be useful sometimes because some Members' party memberships have been recorded separately for each Parliament, even when they haven't changed party. Setting this value to *TRUE* is helpful when you want to identify Members who have changed party allegiance.

Note that party memberships are not necessarily closed when an individual stops being an MP.

--- 

__fetch_mps_other_parliaments__

Fetch a dataframe of memberships of other parliaments for each MP, with one row per other parliament membership.

```r
clmnis::fetch_mps_other_parliaments(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_mps_contested_elections__

Fetch a dataframe of contested parliamentary elections for each MP, with one row per contested election.

```r
clmnis::fetch_mps_contested_elections(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_mps_government_roles__

Fetch a dataframe of government roles for each MP, with one row per government role.

```r
clmnis::fetch_mps_government_roles(from_date = NA, to_date = NA, on_date = NA, while_mp = TRUE)
```

--- 

__fetch_mps_opposition_roles__

Fetch a dataframe of opposition roles for each MP, with one row per opposition role.

```r
clmnis::fetch_mps_opposition_roles(from_date = NA, to_date = NA, on_date = NA, while_mp = TRUE)
```

---

__fetch_mps_parliamentary_roles__

Fetch a dataframe of parliamentary roles for each MP, with one row per parliamentary role.

```r
clmnis::fetch_mps_parliamentary_roles(from_date = NA, to_date = NA, on_date = NA, while_mp = TRUE)
```

---

__fetch_mps_maiden_speeches__

Fetch a dataframe of maiden speeches for each MP, with one row per maiden speech.

```r
clmnis::fetch_mps_maiden_speeches(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_mps_addresses__

Fetch a dataframe of addresses showing contact details for each MP, with one row per address.

```r
clmnis::fetch_mps_addresses()
```

Addresses can represent contact information of different types, including phsyical addresses, phone, fax, email, website, and social media. These addresses are not time bound in MNIS so date filtering is not available for this function.

---

### MPs contact details

These functions extract specific sets of contact details from the addresses data returned by `fetch_mps_addresses`. This data can also be extracted from the addresses table manually, but these functions provide a more conventient way to get contact details of a particular type.

Data in the addresses table is not time bound, so the time filtering arguments for these functions are used to request data for MPs serving during a particular period. Specifically, the functions call `fetch_mps` with these arguments and then filters the addresses returned from `fetch_addresses` to include contact details for just those MPs. The filtering rules are therefore the same as those described for `fetch_mps`.

Contact information stored in MNIS is adminstrative data and may contain data errors or other unexpected formatting. If you are using this data for computational analysis you should be prepared to catch and handle errors.

---

__fetch_mps_office_addresses__

Fetch a dataframe of physical addresses for each MP, with one row per combination of MP and address.

```r
clmnis::fetch_mps_office_addresses(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_mps_email_addresses__

Fetch a dataframe of email addresses for each MP, with one row per combination of MP and email address.

```r
clmnis::fetch_mps_email_addresses(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_mps_phone_numbers__

Fetch a dataframe of phone numbers for each MP, with one row per combination of MP and phone number.

```r
clmnis::fetch_mps_phone_numbers(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_mps_fax_numbers__

Fetch a dataframe of fax numbers for each MP, with one row per combination of MP and fax number.

```r
clmnis::fetch_mps_fax_numbers(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_mps_websites__

Fetch a dataframe of websites for each MP, with one row per combination of MP and website.

```r
clmnis::fetch_mps_websites(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_mps_blogs__

Fetch a dataframe of blogs for each MP, with one row per combination of MP and blog.

```r
clmnis::fetch_mps_blogs(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_mps_twitter__

Fetch a dataframe of twitter accounts for each MP, with one row per combination of MP and twitter account.

```r
clmnis::fetch_mps_twitter(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_mps_instagram__

Fetch a dataframe of instagram accounts for each MP, with one row per combination of MP and instagram account.

```r
clmnis::fetch_mps_instagram(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_mps_facebook__

Fetch a dataframe of facebook accounts for each MP, with one row per combination of MP and facebook account.

```r
clmnis::fetch_mps_facebook(from_date = NA, to_date = NA, on_date = NA)
```

---

## Lords

### Lords core datasets
These are functions that return core datasets on Members of the House of Lords from the MNIS API. Use `fetch_lords` to fetch the Lords and the other functions to fetch data on their house memberships, parties, roles etc. There is a one-to-many relationship between the data returned from `fetch_lords` and the data returned from the other functions. You can synthesise a single dataset that you need for a particular analysis by joining across these tables. 

Some Lords functions have an optional argument called ```while_lord```, which filters the rows to include only those records that coincide with the period when the individual was serving in the House of Lords. This is sometimes necessary because someone who serves in the House of Lords may previously have served in the House of Commons and may have held different roles while serving in both Houses. When this argument is set to *FALSE* these functions will return all relevant records for each individual, even if the records themselves relate to periods when the individual was not a Lord.

---

__fetch_lords__

Fetch a dataframe of key details about each Lord, with one row per Lord. This dataframe contains summary details for each Lord, such as names, gender, and dates of birth and death.

```r
clmnis::fetch_lords(from_date = NA, to_date = NA, on_date = NA)
```

The ```from_date```, ```to_date``` and ```on_date``` arguments can be used to filter the Lords returned based on the dates of their Lords memberships. Note that in this particular case the filtering does not rely on dates shown in the dataframe but uses Lords membership records to calculate whether a Lord was serving on the dates in question. While breaks in service are therefore accounted for, this function does not yet have an option to exclude serving Lords who are prevented from sitting for some reason.

---

__fetch_lords_memberships__

Fetch a dataframe of Lords memberships for each Lord, with one row per Lords membership.

```r
clmnis::fetch_lords_memberships(from_date = NA, to_date = NA, on_date = NA)
```

--- 

__fetch_lords_party_memberships__

Fetch a dataframe of party memberships for each Lord, with one row per party membership.

```r
clmnis::fetch_lords_party_memberships(from_date = NA, to_date = NA, on_date = NA, while_lord = TRUE, collapse = FALSE)
```

The ```collapse``` argument determines whether to collapse consecutive memberships within the same party into a single period of continuous party membership. The default value of this argument is *FALSE*, but it can be useful sometimes because some Members' party memberships have been recorded separately for each Parliament, even when they haven't changed party. Setting this value to *TRUE* is helpful when you want to identify Members who have changed party allegiance.

Note that party memberships are not necessarily closed when an individual stops being a Lord.

--- 

__fetch_lords_other_parliaments__

Fetch a dataframe of memberships of other parliaments for each Lord, with one row per other parliament membership.

```r
clmnis::fetch_lords_other_parliaments(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_lords_contested_elections__

Fetch a dataframe of contested parliamentary elections for each Lord, with one row per contested election.

```r
clmnis::fetch_lords_contested_elections(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_lords_government_roles__

Fetch a dataframe of government roles for each Lord, with one row per government role.

```r
clmnis::fetch_lords_government_roles(from_date = NA, to_date = NA, on_date = NA, while_lord = TRUE)
```

--- 

__fetch_lords_opposition_roles__

Fetch a dataframe of opposition roles for each Lord, with one row per opposition role.

```r
clmnis::fetch_lords_opposition_roles(from_date = NA, to_date = NA, on_date = NA, while_lord = TRUE)
```

---

__fetch_lords_parliamentary_roles__

Fetch a dataframe of parliamentary roles for each Lord, with one row per parliamentary role.

```r
clmnis::fetch_lords_parliamentary_roles(from_date = NA, to_date = NA, on_date = NA, while_lord = TRUE)
```

---

__fetch_lords_maiden_speeches__

Fetch a dataframe of maiden speeches for each Lord, with one row per maiden speech.

```r
clmnis::fetch_lords_maiden_speeches(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_lords_addresses__

Fetch a dataframe of addresses showing contact details for each Lord, with one row per address.

```r
clmnis::fetch_lords_addresses()
```

Addresses can represent contact information of different types, including phsyical addresses, phone, fax, email, website, and social media. These addresses are not time bound in MNIS so date filtering is not available for this function.

---

### Lords contact details

These functions extract specific sets of contact details from the addresses data returned by `fetch_lords_addresses`. This data can also be extracted from the addresses table manually, but these functions provide a more conventient way to get contact details of a particular type.

Data in the addresses table is not time bound, so the time filtering arguments for these functions are used to request data for Lords serving during a particular period. Specifically, the functions call `fetch_lords` with these arguments and then filters the addresses returned from `fetch_addresses` to include contact details for just those Lords. The filtering rules are therefore the same as those described for `fetch_lords`.

Contact information stored in MNIS is adminstrative data and may contain data errors or other unexpected formatting. If you are using this data for computational analysis you should be prepared to catch and handle errors.

---

__fetch_lords_office_addresses__

Fetch a dataframe of physical addresses for each Lord, with one row per combination of Lord and address.

```r
clmnis::fetch_lords_office_addresses(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_lords_email_addresses__

Fetch a dataframe of email addresses for each Lord, with one row per combination of Lord and email address.

```r
clmnis::fetch_lords_email_addresses(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_lords_phone_numbers__

Fetch a dataframe of phone numbers for each Lord, with one row per combination of Lord and phone number.

```r
clmnis::fetch_lords_phone_numbers(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_lords_fax_numbers__

Fetch a dataframe of fax numbers for each Lord, with one row per combination of Lord and fax number.

```r
clmnis::fetch_lords_fax_numbers(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_lords_websites__

Fetch a dataframe of websites for each Lord, with one row per combination of Lord and website.

```r
clmnis::fetch_lords_websites(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_lords_blogs__

Fetch a dataframe of blogs for each Lord, with one row per combination of Lord and blog.

```r
clmnis::fetch_lords_blogs(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_lords_twitter__

Fetch a dataframe of twitter accounts for each Lord, with one row per combination of Lord and twitter account.

```r
clmnis::fetch_lords_twitter(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_lords_instagram__

Fetch a dataframe of instagram accounts for each Lord, with one row per combination of Lord and instagram account.

```r
clmnis::fetch_lords_instagram(from_date = NA, to_date = NA, on_date = NA)
```

---

__fetch_lords_facebook__

Fetch a dataframe of facebook accounts for each Lord, with one row per combination of Lord and facebook account.

```r
clmnis::fetch_lords_facebook(from_date = NA, to_date = NA, on_date = NA)
```

---
