# Taxis

## Data

Repo contains three datasets:

1. Medallion_Drivers_-_Active.csv: list of all active yellow cab drivers in nyc
2. nyc_13.csv: campaign finance data for 2013 election cycle, all nyc offices
3. nyc_17.csv: current campaign finance data for 2017 cycle, all nyc offices (downloaded as of 7/27/15)

## Code

taxis.R performs preliminary data cleaning and merging.  Name merging the taxi cab and $ data produces some clear matches but there appear to be many false positives.  Using self-reported occupations in the $ data directly seems cleaner, though it misses donors who don't state/misstate their occupations.
