### Main Covid Explore ######

explore: covid_combined_core {
  from: covid_combined
  extension: required
  description: "This explore has the core metrics for the COVID19 datasets, international data is available at the state level through JHU and county level data is available for the United States through NYT"
  group_label: "COVID 19"
  label: "COVID - Main"
  view_label: " COVID19"

## Testing Data by State (US Only) ##

  join: state_region {
    view_label: " COVID19"
    relationship: many_to_one
    sql_on: ${covid_combined.province_state} = ${state_region.state} ;;
  }

  join: open_data_main {
    view_label: " COVID19"
    relationship: many_to_many
    sql_on: ${state_region.state} = ${open_data_main.state_name}
    AND ${covid_combined.measurement_date} = ${open_data_main.measurement_date} ;;
  }

  join: covid_tracking_project {
    view_label: " COVID19"
    relationship: many_to_one
    sql_on:${state_region.state_code} = ${covid_tracking_project.state_code}
            AND ${covid_combined.measurement_raw} = ${covid_tracking_project.measurement_raw}
    ;;
  }

## Hospital Bed Data ##

  join: hospital_bed_summary {
    view_label: " COVID19"
    relationship: many_to_many
    sql_on: ${covid_combined.fips} = ${hospital_bed_summary.fips} ;;
  }

## State Policy Reactions ##

  join: policies_by_state {
    view_label: "State Policy"
    relationship: many_to_one
    sql_on: ${covid_combined.province_state} = ${policies_by_state.state} ;;
  }

## Max Date for Running Total Logic ##

  join: max_date_covid {
    relationship: one_to_one
    sql_on: 1 = 1  ;;
  }

  join: max_date_tracking_project {
    relationship: one_to_one
    sql_on: 1 = 1  ;;
  }

## Rank ##

  join: country_rank {
    fields: []
    relationship: many_to_one
    sql_on: ${covid_combined.country_raw} = ${country_rank.country_raw} ;;
  }

  join: state_rank {
    fields: []
    relationship: many_to_one
    sql_on: ${covid_combined.province_state} = ${state_rank.province_state} ;;
  }

  join: fips_rank {
    fields: []
    relationship: many_to_one
    sql_on: ${covid_combined.fips} = ${fips_rank.fips} ;;
  }

## Growth Rate / Days to Double ##

  join: prior_days_cases_covid {
    view_label: " COVID19"
    relationship: one_to_one
    sql_on:
        ${covid_combined.measurement_date} = ${prior_days_cases_covid.measurement_date}
    AND ${covid_combined.pre_pk} = ${prior_days_cases_covid.pre_pk};;
  }

## Add in state & country region & population ##

  join: population_by_county_state_country {
    view_label: "Vulnerable Populations"
    relationship: many_to_one
    sql_on: ${covid_combined.pre_pk} = ${population_by_county_state_country.pre_pk} ;;
  }

  join: country_region {
    view_label: " COVID19"
    relationship: many_to_one
    sql_on: ${covid_combined.country_region} = ${country_region.country} ;;
  }
}
