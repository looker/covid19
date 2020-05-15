connection: "@{CONNECTION_NAME}"

include: "/covid_block/*.view.lkml"
include: "/explores/*.explore.lkml"
include: "/dashboards/*.dashboard.lookml"

include: "//@{CONFIG_PROJECT_NAME}/*.model.lkml"
# include: "//@{CONFIG_PROJECT_NAME}/*.dashboard"
include: "//@{CONFIG_PROJECT_NAME}/covid_block/*.view.lkml"

#map layers
include: "map_layers.lkml"

############ Explores ############

explore: covid_combined {
  extends: [covid_combined_config]
}

explore: kpis_by_entity_by_date {
  extends: [kpis_by_entity_by_date_config]
}

explore: italy {
  extends: [italy_config]
}

explore: mobility_dev {
  from: mobility_data
  sql_always_where: ${geo_level_output} = ${geo_level};;
  always_filter: {
    filters: [geography_level: "country"]
  }

  join: max_date_mobility {
    sql_on: ${mobility_dev.country_region_code} = ${max_date_mobility.country_region_code}
            AND IFNULL(${mobility_dev.sub_region_1}, '') = ${max_date_mobility.province_state}
            AND IFNULL(${mobility_dev.sub_region_2}, '') = ${max_date_mobility.county};;
    relationship: many_to_one
  }
}


############ Caching Logic ############

persist_with: covid_data

### PDT Timeframes

datagroup: covid_data {
  max_cache_age: "12 hours"
  sql_trigger:
    SELECT min(max_date) as max_date
    FROM
    (
      SELECT max(cast(date as date)) as max_date FROM `bigquery-public-data.covid19_nyt.us_counties`
      UNION ALL
      SELECT max(cast(date as date)) as max_date FROM `bigquery-public-data.covid19_jhu_csse.summary`
    ) a
  ;;
}
