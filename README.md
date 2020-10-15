# clmnis
clmnis is an R package for downloading data from the UK Parliament's [Members Names Information Service](http://data.parliament.uk/membersdataplatform/memberquery.aspx) (MNIS). 

## Overview
The MNIS API is the public interface to the UK Parliament's Members Names database, a comprehensive database of all Members sitting in either the House of Commons or House of Lords. The API is flexible and powerful, but it's not very easy to use. The mnis package is a toolkit that makes it easier to download and manipulate useful data from the API through a high level interface comprising families of functions for downloading specific datasets.

## Installation
Install from Github with using remotes.

```r
install.packages("remotes")
remotes::install_github("houseofcommonslibrary/clmnis")
```

## MNIS API
The MNIS API provides access to data on Members of both Houses of Parliament. It provides similar functions for downloading data on both MPs and Lords, but the structure of the data returned in each case may differ to reflect differences between Commons and Lords memberships.

Each of these Member functions can take optional arguments for a ```from_date``` and a ```to_date```, which can be used to filter the rows returned based on a period of activity related to each row. The ```on_date``` argument is a convenience that sets the ```from_date``` and ```to_date``` to the same given date. The ```on_date``` has priority: if the ```on_date``` is set, the ```from_date``` and ```to_date``` are ignored. The values for these arguments can be either a Date or a string specifying a date in ISO 8601 format ("YYYY-MM-DD").

The filtering performed using these arguments is inclusive: a row is returned if any part of the activity in question falls within the period specified with the from and to dates. If the activity in question has not yet ended, the end date will have a value of NA.

---

## MPs
Some MP functions have an optional argument called ```while_mp```, which filters the data to include only those rows that coincide with the period when the individual was serving in the House of Commons. This is sometimes necessary because someone who serves in the House of Commons may later serve in the House of Lords and may hold different roles while serving in both Houses. When this argument is set to *FALSE* these functions will return all relevant records for each individual, even if the records themselves relate to periods when the individual was not an MP.

---

```r
clmnis::fetch_mps(from_date = NA, to_date = NA, on_date = NA)
```

Fetch a dataframe of key details about each MP, with one row per MP.

This dataframe contains summary details for each MP, such as names, gender, and dates of birth and death.

The ```from_date```, ```to_date``` and ```on_date``` arguments can be used to filter the MPs returned based on the dates of their Commons memberships. Note that in this particular case the filtering does not rely on dates shown in the dataframe but uses Commons membership records to calculate whether an MP was serving on the dates in question. While breaks in service are therefore accounted for, this function does not yet have an option to exclude serving Members who are prevented from sitting for some reason.

---

```r
clmnis::fetch_commons_memberships(from_date = NA, to_date = NA, on_date = NA)
```

Fetch a dataframe of Commons memberships for each MP, with one row per Commons membership.

The memberships dates are processed to impose consistent rules on the start and end dates for memberships. Specifically, Commons memberships are taken to end at the dissolution of each Parliament, rather than on the date of the general election at which an MP was defeated.

--- 

```r
clmnis::fetch_mps_party_memberships(from_date = NA, to_date = NA, on_date = NA, while_mp = TRUE, collapse = FALSE)
```

Fetch a dataframe of party memberships for each MP, with one row per party membership.

The ```collapse``` argument determines whether to collapse consecutive memberships within the same party into a single period of continuous party membership. The default value of this argument is *FALSE*, but it can be useful sometimes because some Members' party memberships have been recorded separately for each Parliament, even when they haven't changed party. Setting this value to *TRUE* is helpful when you want to identify Members who have changed party allegiance.

Note that party memberships are not necessarily closed when an individual stops being an MP.

--- 

```r
clmnis::fetch_mps_other_parliaments(from_date = NA, to_date = NA, on_date = NA)
```

Fetch a dataframe of memberships of other parliaments for each MP, with one row per other parliament membership.

---

```r
clmnis::fetch_mps_contested_elections(from_date = NA, to_date = NA, on_date = NA)
```

Fetch a dataframe of contested parliamentary elections for each MP, with one row per contested election.

---

```r
clmnis::fetch_mps_government_roles(from_date = NA, to_date = NA, on_date = NA, while_mp = TRUE)
```

Fetch a dataframe of government roles for each MP, with one row per government role.

--- 

```r
clmnis::fetch_mps_opposition_roles(from_date = NA, to_date = NA, on_date = NA, while_mp = TRUE)
```

Fetch a dataframe of opposition roles for each MP, with one row per opposition role.

---

```r
clmnis::fetch_mps_parliamentary_roles(from_date = NA, to_date = NA, on_date = NA, while_mp = TRUE)
```

Fetch a dataframe of parliamentary roles for each MP, with one row per parliamentary role.

---

```r
clmnis::fetch_mps_maiden_speeches(from_date = NA, to_date = NA, on_date = NA)
```

Fetch a dataframe of maiden speeches for each MP, with one row per maiden speech.

---

## Lords
Some Lords functions have an optional argument called ```while_lord```, which filters the rows to include only those records that coincide with the period when the individual was serving in the House of Lords. This is sometimes necessary because someone who serves in the House of Lords may previously have served in the House of Commons and may have held different roles while serving in both Houses. When this argument is set to *FALSE* these functions will return all relevant records for each individual, even if the records themselves relate to periods when the individual was not a Lord.

---

```r
clmnis::fetch_lords(from_date = NA, to_date = NA, on_date = NA)
```

Fetch a dataframe of key details about each Lord, with one row per Lord.

This dataframe contains summary details for each Lord, such as names, gender, and dates of birth and death.

The ```from_date```, ```to_date``` and ```on_date``` arguments can be used to filter the Lords returned based on the dates of their Lords memberships. Note that in this particular case the filtering does not rely on dates shown in the dataframe but uses Lords membership records to calculate whether a Lord was serving on the dates in question. While breaks in service are therefore accounted for, this function does not yet have an option to exclude serving Lords who are prevented from sitting for some reason.

---

```r
clmnis::fetch_lords_memberships(from_date = NA, to_date = NA, on_date = NA)
```

Fetch a dataframe of Lords memberships for each Lord, with one row per Lords membership.

--- 

```r
clmnis::fetch_lords_party_memberships(from_date = NA, to_date = NA, on_date = NA, while_lord = TRUE, collapse = FALSE)
```

Fetch a dataframe of party memberships for each Lord, with one row per party membership.

The ```collapse``` argument determines whether to collapse consecutive memberships within the same party into a single period of continuous party membership. The default value of this argument is *FALSE*, but it can be useful sometimes because some Members' party memberships have been recorded separately for each Parliament, even when they haven't changed party. Setting this value to *TRUE* is helpful when you want to identify Members who have changed party allegiance.

Note that party memberships are not necessarily closed when an individual stops being a Lord.

--- 

```r
clmnis::fetch_lords_other_parliaments(from_date = NA, to_date = NA, on_date = NA)
```

Fetch a dataframe of memberships of other parliaments for each Lord, with one row per other parliament membership.

---

```r
clmnis::fetch_lords_contested_elections(from_date = NA, to_date = NA, on_date = NA)
```

Fetch a dataframe of contested parliamentary elections for each Lord, with one row per contested election.

---

```r
clmnis::fetch_lords_government_roles(from_date = NA, to_date = NA, on_date = NA, while_lord = TRUE)
```

Fetch a dataframe of government roles for each Lord, with one row per government role.

--- 

```r
clmnis::fetch_lords_opposition_roles(from_date = NA, to_date = NA, on_date = NA, while_lord = TRUE)
```

Fetch a dataframe of opposition roles for each Lord, with one row per opposition role.

---

```r
clmnis::fetch_lords_parliamentary_roles(from_date = NA, to_date = NA, on_date = NA, while_lord = TRUE)
```

Fetch a dataframe of parliamentary roles for each Lord, with one row per parliamentary role.

---

```r
clmnis::fetch_lords_maiden_speeches(from_date = NA, to_date = NA, on_date = NA)
```

Fetch a dataframe of maiden speeches for each Lord, with one row per maiden speech.

---








