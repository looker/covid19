include: "//@{CONFIG_PROJECT_NAME}/covid_block/open_data_main.view.lkml"

# open_data_main (New!) Pulls in data from the [COVID-19 Open Data project](https://github.com/GoogleCloudPlatform/covid-19-open-data)
# and reports on testing, hospitalizations, and vaccination progress in the US.

view: open_data_main {
  extends: [open_data_main_config]
}

###################################################


view: open_data_main_core {
  derived_table: {
    datagroup_trigger: covid_data
    cluster_keys: ["state_name"]
    partition_keys: ["measurement_date"]
    sql:
      WITH odm AS (
          SELECT
            location_key,
            SUBSTR(SPLIT(location_key, "US_")[OFFSET(1)],0,2) as state,
            subregion1_name as state_name,
            subregion2_name,
            date as measurement_date,
            new_confirmed,
            cumulative_confirmed,
            new_tested,
            cumulative_tested,
            cumulative_hospitalized_patients as hospitalized_cumulative,
            new_hospitalized_patients,
            current_hospitalized_patients,
            new_ventilator_patients,
            cumulative_ventilator_patients,
            current_ventilator_patients,
            new_persons_vaccinated,
            cumulative_persons_vaccinated,
            new_persons_fully_vaccinated,
            cumulative_persons_fully_vaccinated,
            new_vaccine_doses_administered,
            cumulative_vaccine_doses_administered,
          FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
          WHERE location_key LIKE 'US_%')
        SELECT * FROM odm
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 ;;
  }

  dimension_group: measurement {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: parse_date('%Y-%m-%d',cast(${TABLE}.measurement_date as string));;
  }

  dimension: location_key {
    hidden: yes
    type: string
    sql: ${TABLE}.location_key ;;
  }

  dimension: state_name {
    hidden: yes
    type: string
    sql: ${TABLE}.state_name ;;
  }

  dimension: state_code {
    hidden: yes
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${TABLE}.location_key, ${measurement_date}) ;;
  }

  measure: max_date {
    hidden: yes
    type: date
    sql: max(${measurement_date}) ;;
  }

  dimension: is_max_date {
    hidden: yes
    type: yesno
    sql: ${measurement_date} = ${max_date_tracking_project.max_date_raw} ;;
  }

  measure: hospitalized_option_1 {
    hidden: yes
    type: sum
    sql: ${TABLE}.hospitalized_cumulative ;;
  }

  measure: hospitalized_option_2 {
    hidden: yes
    type: sum
    sql: ${TABLE}.current_hospitalized_patients ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }
  measure: new_persons_hospitalized {
    group_label: "CDC Measures (US Only)"
    label: "Hospitalizations (New)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the most recent record will be used"
    type: sum
    sql: ${TABLE}.new_hospitalized_patients ;;
    link: {
      label: "Data Source - COVID19 Open Data"
      url: "https://github.com/GoogleCloudPlatform/covid-19-open-data"
    }
  }

  measure: hospitalized_running_total {
    group_label: "CDC Measures (US Only)"
    label: "Hospitalizations (Running Total)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."
    type: number
    sql:
    {% if covid_combined.measurement_date._in_query %} ${hospitalized_option_1}
    {% else %}  ${hospitalized_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - COVID19 Open Data"
      url: "https://github.com/GoogleCloudPlatform/covid-19-open-data"
    }
  }
  measure: new_persons_vaccinated {
    group_label: "CDC Measures (US Only)"
    label: "Persons Vaccinated (New)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the most recent record will be used"
    type: sum
    sql: ${TABLE}.new_persons_vaccinated ;;
    link: {
      label: "Data Source - COVID19 Open Data"
      url: "https://github.com/GoogleCloudPlatform/covid-19-open-data"
    }
  }
  measure: cumulative_persons_vaccinated_option_1 {
    hidden: yes
    type: sum
    sql: ${TABLE}.cumulative_persons_vaccinated ;;
  }

  measure: cumulative_persons_vaccinated_option_2 {
    hidden: yes
    type: sum
    sql: ${TABLE}.cumulative_persons_vaccinated ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: cumulative_persons_vaccined_running_total {
    group_label: "CDC Measures (US Only)"
    label: "Persons Vaccinated (Running Total)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."
    type: number
    sql:
    {% if covid_combined.measurement_date._in_query %} ${cumulative_persons_vaccinated_option_1}
    {% else %}  ${cumulative_persons_vaccinated_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - COVID19 Open Data"
      url: "https://github.com/GoogleCloudPlatform/covid-19-open-data"
    }
  }
  measure: new_persons_fully_vaccinated {
    group_label: "CDC Measures (US Only)"
    label: "Persons Fully Vaccinated (New)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the most recent record will be used"
    type: sum
    sql: ${TABLE}.new_persons_fully_vaccinated ;;
    link: {
      label: "Data Source - COVID19 Open Data"
      url: "https://github.com/GoogleCloudPlatform/covid-19-open-data"
    }
  }
  measure: cumulative_persons_fully_vaccinated_option_1 {
    hidden: yes
    type: sum
    sql: ${TABLE}.cumulative_persons_fully_vaccinated ;;
  }

  measure: cumulative_persons_fully_vaccinated_option_2 {
    hidden: yes
    type: sum
    sql: ${TABLE}.cumulative_persons_fully_vaccinated ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: cumulative_persons_fully_vaccined_running_total {
    group_label: "CDC Measures (US Only)"
    label: "Persons Fully Vaccinated (Running Total)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."
    type: number
    sql:
    {% if covid_combined.measurement_date._in_query %} ${cumulative_persons_fully_vaccinated_option_1}
    {% else %}  ${cumulative_persons_fully_vaccinated_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - COVID19 Open Data"
      url: "https://github.com/GoogleCloudPlatform/covid-19-open-data"
    }
  }
  measure: tests_new {
    group_label: "CDC Measures (US Only)"
    label: "Tests (New)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the most recent record will be used"
    type: sum
    sql: ${TABLE}.new_tested ;;
    link: {
      label: "Data Source - COVID19 Open Data"
      url: "https://github.com/GoogleCloudPlatform/covid-19-open-data"
    }
  }
  measure: cumulative_tested_option_1 {
    hidden: yes
    type: sum
    sql: ${TABLE}.cumulative_tested ;;
  }

  measure: cumulative_tested_option_2 {
    hidden: yes
    type: sum
    sql: ${TABLE}.cumulative_tested ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: cumulative_tested_running_total {
    group_label: "CDC Measures (US Only)"
    label: "Tests (Running Total)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."
    type: number
    sql:
    {% if covid_combined.measurement_date._in_query %} ${cumulative_tested_option_1}
    {% else %}  ${cumulative_tested_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - CDC"
    }
  }
  measure: confirmed_new {
    group_label: "CDC Measures (US Only)"
    label: "Confirmed Cases (New)"
    hidden: yes
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the most recent record will be used"
    type: sum
    sql: ${TABLE}.new_confirmed ;;
    link: {
      label: "Data Source - CDC"
    }
  }
  measure: cumulative_confirmed_option_1 {
    hidden: yes
    type: sum
    sql: ${TABLE}.cumulative_confirmed ;;
  }

  measure: cumulative_confirmed_option_2 {
    hidden: yes
    type: sum
    sql: ${TABLE}.cumulative_confirmed ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: cumulative_confirmed_running_total {
    group_label: "CDC Measures (US Only)"
    label: "Cumulative Confirmed (Running Total)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."
    type: number
    hidden: yes
    sql:
    {% if covid_combined.measurement_date._in_query %} ${cumulative_confirmed_option_1}
    {% else %}  ${cumulative_confirmed_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - CDC"
    }
  }
  measure: death_cumulative_option_1 {
    hidden: yes
    type: sum
    sql: ${TABLE}.cumulative_tested ;;
  }

  measure: death_cumulative_option_2 {
    hidden: yes
    type: sum
    sql: ${TABLE}.cumulative_tested ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: death_cumulative_running_total {
    group_label: "CDC Measures (US Only)"
    hidden: yes
    label: "Death Cumulative (Running Total)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."
    type: number
    sql:
    {% if covid_combined.measurement_date._in_query %} ${death_cumulative_option_1}
    {% else %}  ${death_cumulative_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - COVID19 Open Data"
      url: "https://github.com/GoogleCloudPlatform/covid-19-open-data"
    }
  }
  measure: positive_rate {
    group_label: "CDC Measures (US Only)"
    description: "Of all tests, how many are positive?"
    type: number
    hidden: no
    sql: 1.0 * ${cumulative_confirmed_running_total} / nullif((${cumulative_tested_running_total}),0);;
    value_format_name: percent_1
    link: {
      label: "Data Source - COVID19 Open Data"
      url: "https://github.com/GoogleCloudPlatform/covid-19-open-data"
    }
  }

  measure: case_hospitalization_rate {
    group_label: "CDC Measures (US Only)"
    description: "What percent of infections have resulted in hospitalization?"
    type: number
    hidden: no
    sql: 1.0 * ${hospitalized_running_total}/NULLIF(${cumulative_confirmed_running_total}, 0);;
    value_format_name: percent_1
    link: {
      label: "Data Source - COVID19 Open Data"
      url: "https://github.com/GoogleCloudPlatform/covid-19-open-data"
    }
  }

  set: drill {
    fields: [
      state_name,
      measurement_date,
    ]
  }
}
