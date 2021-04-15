# COVID19 Data Block

**[For a summary of this Block's Dashboards, Explores & the project on Github click here](https://covid19response.cloud.looker.com/embed/dashboards-next/51)**

  This COVID-19 Block consists of LookML models, pre-built dashboards, and explores, built off of data from the Johns Hopkins Center for Systems Science and Engineering (JHU CSSE), the New York Times, the COVID Tracking Project, Definitive Healthcare, the Kaiser Family Foundation, and Italy’s Dipartimento della Protezione Civile. The data that powers the block is currently only available in BigQuery and will work with any Looker instance with an existing BigQuery connection.


##### *Views that pull data from BQ Public Datasets program (details on the data can be found [here](https://cloud.google.com/blog/products/data-analytics/free-public-datasets-for-covid19)):*


• [nyt_data](/projects/covid/files/covid_block/nyt_data.view.lkml) Light modifications to the NYT dataset so that we can merge with other data sources

• [covid_combined](/projects/covid/files/covid_block/covid_combined.view.lkml) Combines the JHU and NYT datasets, and houses core calculations at the State level (internationally) and the county level (US Only)

• [covid_combined_pdts](/projects/covid/files/covid_block/covid_combined_pdts.view.lkml) Stores PDTs built off of covid_combined for calculations looking back in time or comparing aginst other geographies

• [italy_province](/projects/covid/files/covid_block/italy_province.view.lkml) and [italy_region](/projects/covid/files/covid_block/italy_regions.view.lkml) Calculates COVID19 metrics based on the data provided by Presidenza del Consiglio dei Ministri - Dipartimento della Protezione Civil

• [mobility](/projects/data-block-covid19/files/covid_block/mobility.view.lkml) compares communities' mobility (as measured via anonymized cell phone location data) visiting different types of locations. Data is compared to baseline values computed as the median in the 5‑week period Jan 3 – Feb 6, 2020 by day of the week. Data is updated regularly, but not daily. For more information, we strongly encourage you to read [the full documentation](https://www.google.com/covid19/mobility/).


##### *Views that pull data from datasets we've made available in BigQuery - the ETL for these has not been fully tested, and data should be treated with somewhat less certainty:*

• [covid_tracking_project](/projects/covid/files/covid_block/covid_tracking_project.view.lkml) Pulls in data from the [COVID-19 Tracking project](https://github.com/COVID19Tracking/covid-tracking-data/blob/master/data/states_daily_4pm_et.csv  ) and houses calculations on testing in the US. ** The Covid Tracking Project stopped reporting updates on March 7, 2021. Similiar measures were introduced with open_data_main.**

• [open_data_main](/projects/covid/files/covid_block/open_data_main.view.lkml) (New!) Pulls in data from the [COVID-19 Open Data project](https://github.com/GoogleCloudPlatform/covid-19-open-data) and reports on testing, hospitalizations, and vaccination progress in the US.

• [policies_by_state](/projects/covid/files/covid_block/policies_by_state.view.lkml) Pulls in data from the [Kaiser Family Foundation](https://s3-us-west-1.amazonaws.com/starschema.covid/) on policies that states have implemented in response to COVID-19

• [hospital_bed_summary](/projects/covid/files/covid_block/hospital_bed_summary.view.lkml) Pulls in data from [Definitive Healthcare](https://opendata.arcgis.com/datasets/1044bb19da8d4dbfb6a96eb1b4ebf629_0.csv) on average hospital bed availability for hospitals within the US


##### *Views that pull data from Mapping / Population tables we've created (based on Census + Wikipedia data):*

• [country_region](/projects/covid/files/covid_block/country_region.view.lkml) Maps countries to global regions

• [state_region](/projects/covid/files/covid_block/state_region.view.lkml) Maps states to global regions

• [population_by_county_state_country](/projects/covid/files/covid_block/population_by_county_state_country.view.lkml) Calculated the total estimated population for each geographical region for US counties and International States

• [italy_province_stats](/projects/covid/files/covid_block/italy_province_stats.view.lkml) Population estimates and Area by Italy Province

• [italy_region_stats](/projects/covid/files/covid_block/italy_region_stats.view.lkml) Population estimates and Area by Italy Region


#### *In order to extend the LookML from this block and join it with your own proprietery data sources please use this [guide](https://docs.looker.com/data-modeling/marketplace/customize-blocks).*

---------


### What We're Reading
> Looking at the coronavirus data is like looking at funhouse mirrors. Everything is distorted in some direction or another; some things look much bigger than they really are, others much smaller. - Nate Silver, [Twitter](https://twitter.com/NateSilver538/status/1241064789738217473?s=20)

With that in mind, here are some of the articles that have informed our understanding around how to explore, present, and share COVID-19 data.

[**Ten Considerations Before You Create Another Chart About COVID-19** by Amanda Makulec](https://medium.com/nightingale/ten-considerations-before-you-create-another-chart-about-covid-19-27d3bd691be8)

[**Coronavirus Case Counts Are Meaningless*** by Nate Silver](https://fivethirtyeight.com/features/coronavirus-case-counts-are-meaningless/)

[**Improve Your COVID-19 Cases Map** by Jim Herries](https://storymaps.arcgis.com/stories/1cbce9094e88438fa75148cb35f99caf)

[**Mapping coronavirus, responsibly** by Kenneth Field](https://www.esri.com/arcgis-blog/products/product/mapping/mapping-coronavirus-responsibly/)


### Have another database besides BQ?
Checkout our instructions on how to leverage this block with other databases [**here**](/other_dialects.md)
