include: "//@{CONFIG_PROJECT_NAME}/covid_block/covid_tracking_project.view.lkml"

#This data was brought in to show testing data from the COVID19 Tracing project - https://covidtracking.com/

view: covid_tracking_project {
  extends: [covid_tracking_project_config]
}

###################################################


view: covid_tracking_project_core {
  derived_table: {
    datagroup_trigger: covid_data
    sql:
      WITH ctp AS (
          SELECT
            state,
            date as measurement_date,
            total as total_cumulative,
            total - coalesce(LAG(total, 1) OVER (PARTITION BY state  ORDER BY date ASC),0) as total_new_cases,
            death as death_cumulative,
            death - coalesce(LAG(death, 1) OVER (PARTITION BY state  ORDER BY date ASC),0) as death_new_cases,
            recovered as recovered_cumulative,
            recovered - coalesce(LAG(recovered, 1) OVER (PARTITION BY state  ORDER BY date ASC),0) as recovered_new_cases,
            hospitalizedCumulative as hospitalized_cumulative,
            hospitalizedCumulative - coalesce(LAG(hospitalizedCumulative, 1) OVER (PARTITION BY state  ORDER BY date ASC),0) as hospitalized_new_cases,
            hospitalizedCurrently,
            inIcuCumulative as inIcu_Cumulative,
            inIcuCumulative - coalesce(LAG(inIcuCumulative, 1) OVER (PARTITION BY state  ORDER BY date ASC),0) as inIcu_new_cases,
            inIcuCurrently,
            onVentilatorCumulative as onVentilator_Cumulative,
            onVentilatorCumulative - coalesce(LAG(onVentilatorCumulative, 1) OVER (PARTITION BY state  ORDER BY date ASC),0) as onVentilator_new_cases,
            onVentilatorCurrently,
            positive as positive_cumulative,
            positive - coalesce(LAG(positive, 1) OVER (PARTITION BY state  ORDER BY date ASC),0) as positive_new_cases,
            pending as pending_cumulative,
            pending - coalesce(LAG(pending, 1) OVER (PARTITION BY state  ORDER BY date ASC),0) as pending_new_cases,
            negative as negative_cumulative,
            negative - coalesce(LAG(negative, 1) OVER (PARTITION BY state  ORDER BY date ASC),0) as negative_new_cases,

          FROM `lookerdata.covid19_block.covid19_tracking_project`)
        SELECT * FROM ctp
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23;;
  }

####################
#### Original Dimensions ####
####################

### PK

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: concat(${state}, ${measurement_raw}) ;;
  }

## Date & Location

  dimension: state_code {
    hidden: yes
    sql: ${TABLE}.state ;;
  }

  dimension: state {
    hidden: yes
    map_layer_name: us_states
    type: string
    sql: ${state_region.state} ;;
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
    sql: parse_date('%Y%m%d',cast(${TABLE}.measurement_date as string));;
  }

### KPIs

  dimension: death_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.death_cumulative ;;
  }

  dimension: death_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.death_new_cases ;;
  }

  dimension: hospitalized_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.hospitalized_cumulative ;;
  }

  dimension: hospitalized_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.hospitalized_new_cases ;;
  }

  dimension: negative_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.negative_cumulative ;;
  }

  dimension: negative_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.negative_new_cases ;;
  }

  dimension: pending_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.pending_cumulative ;;
  }

  dimension: pending_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.pending_new_cases ;;
  }

  dimension: positive_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.positive_cumulative ;;
  }

  dimension: positive_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.positive_new_cases ;;
  }

  dimension: total_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.total_cumulative ;;
  }

  dimension: total_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.total_new_cases ;;
  }

####################
#### Derived Dimensions ####
####################

  dimension: total_tests_cumulative {
    hidden: yes
    type: number
    sql: ${positive_cumulative} + ${pending_cumulative} + ${negative_cumulative} ;;
  }

  dimension: total_tests_new_cases {
    hidden: yes
    type: number
    sql: ${positive_new_cases} + ${pending_new_cases} + ${negative_new_cases} ;;
  }

  dimension: is_max_date {
    hidden: yes
    type: yesno
    sql: ${measurement_raw} = ${max_date_tracking_project.max_date_raw} ;;
  }

####################
#### Measures ####
####################

## Based on new_vs_running_total parameter chosen, return new or running total hospitalizations
  measure: hospitalizations {
    group_label: "Dynamic (Testing - US Only)"
    description: "Use with New vs Running Total Filter, can be useful for creating a Look or Dashboard where you toggle between the two  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    label: "Hospitalizations"
    type: number
    hidden: yes
    sql:
        {% if covid_combined.new_vs_running_total._parameter_value == 'new_cases' %} ${hospitalized_new}
        {% elsif covid_combined.new_vs_running_total._parameter_value == 'running_total' %} ${hospitalized_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

## Based on new_vs_running_total parameter chosen, return new or running total negative test results
  measure: negative_test {
    group_label: "Dynamic (Testing - US Only)"
    description: "Use with New vs Running Total Filter, can be useful for creating a Look or Dashboard where you toggle between the two **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    label: "Negative Test Results"
    hidden: yes
    type: number
    sql:
        {% if covid_combined.new_vs_running_total._parameter_value == 'new_cases' %} ${negative_new}
        {% elsif covid_combined.new_vs_running_total._parameter_value == 'running_total' %} ${negative_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

## Based on new_vs_running_total parameter chosen, return new or running total pending test results
  measure: pending_test {
    group_label: "Dynamic (Testing - US Only)"
    description: "Use with New vs Running Total Filter, can be useful for creating a Look or Dashboard where you toggle between the two. **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    label: "Pending Test Results"
    hidden: yes
    type: number
    sql:
        {% if covid_combined.new_vs_running_total._parameter_value == 'new_cases' %} ${pending_new}
        {% elsif covid_combined.new_vs_running_total._parameter_value == 'running_total' %} ${pending_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

## Based on new_vs_running_total parameter chosen, return new or running total positive test results
  measure: positive_test {
    group_label: "Dynamic (Testing - US Only)"
    description: "Use with New vs Running Total Filter, can be useful for creating a Look or Dashboard where you toggle between the two  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    label: "Positive Test Results"
    hidden: yes
    type: number
    sql:
        {% if covid_combined.new_vs_running_total._parameter_value == 'new_cases' %} ${positive_new}
        {% elsif covid_combined.new_vs_running_total._parameter_value == 'running_total' %} ${positive_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

## Based on new_vs_running_total parameter chosen, return new or running total of tests
  measure: total {
    group_label: "Dynamic (Testing - US Only)"
    description: "Use with New vs Running Total Filter, can be useful for creating a Look or Dashboard where you toggle between the two  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    label: "Total Tests"
    type: number
    hidden: yes
    sql:
        {% if covid_combined.new_vs_running_total._parameter_value == 'new_cases' %} ${total_new}
        {% elsif covid_combined.new_vs_running_total._parameter_value == 'running_total' %} ${total_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: hospitalized_new {
    group_label: "New Cases (Testing - US Only)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the most recent record will be used  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    label: "Hospitalizations"
    hidden: yes
    type: sum
    sql: ${hospitalized_new_cases} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: hospitalized_option_1 {
    hidden: yes
    type: sum
    sql: ${hospitalized_cumulative} ;;
  }

  measure: hospitalized_option_2 {
    hidden: yes
    type: sum
    sql: ${hospitalized_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

## If date in query, show running total of hospitalizations for given date(s), otherwise show running total hospitalizations for most recent date
  measure: hospitalized_running_total {
    group_label: "Running Total (Testing - US Only)"
    label: "Hospitalizations (Running Total)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used.  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: number
    hidden: yes
    sql:
    {% if covid_combined.measurement_date._in_query %} ${hospitalized_option_1}
    {% else %}  ${hospitalized_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: negative_new {
    group_label: "New Cases (Testing - US Only)"
    label: "Negative Test Results (New)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the most recent record will be used  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: sum
    hidden: yes
    sql: ${negative_new_cases} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: negative_option_1 {
    hidden: yes
    type: sum
    sql: ${negative_cumulative} ;;
  }

  measure: negative_option_2 {
    hidden: yes
    type: sum
    sql: ${negative_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

## If date in query, show running total of negative test results for given date(s), otherwise show running total of negative test results for most recent date
  measure: negative_running_total {
    group_label: "Running Total (Testing - US Only)"
    label: "Negative Test Results (Running Total)"
    type: number
    hidden: yes
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used.  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    sql:
    {% if covid_combined.measurement_date._in_query %} ${negative_option_1}
    {% else %}  ${negative_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: pending_new {
    group_label: "New Cases (Testing - US Only)"
    label: "Pending Test Results (New)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the most recent record will be used  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: sum
    hidden: yes
    sql: ${pending_new_cases} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: pending_option_1 {
    hidden: yes
    type: sum
    sql: ${pending_cumulative} ;;
  }

  measure: pending_option_2 {
    hidden: yes
    type: sum
    sql: ${pending_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

## If date in query, show running total of pending test results for given date(s), otherwise show running total of pending test results for most recent date
  measure: pending_running_total {
    group_label: "Running Total (Testing - US Only)"
    label: "Pending Test Results (Running Total)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used.  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: number
    hidden: yes
    sql:
    {% if covid_combined.measurement_date._in_query %} ${pending_option_1}
    {% else %}  ${pending_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: positive_new {
    group_label: "New Cases (Testing - US Only)"
    label: "Positive Test Results (New)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the most recent record will be used  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: sum
    hidden: yes
    sql: ${positive_new_cases} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: positive_option_1 {
    hidden: yes
    type: sum
    sql: ${positive_cumulative} ;;
  }

  measure: positive_option_2 {
    hidden: yes
    type: sum
    sql: ${positive_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

## If date in query, show running total of positive test results for given date(s), otherwise show running total of positive test results for most recent dat
  measure: positive_running_total {
    group_label: "Running Total (Testing - US Only)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used.  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    label: "Positive Test Results (Running Total)"
    type: number
    hidden: yes
    sql:
    {% if covid_combined.measurement_date._in_query %} ${positive_option_1}
    {% else %}  ${positive_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: total_new {
    group_label: "New Cases (Testing - US Only)"
    label: "Total Tests (New)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the most recent record will be used  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: sum
    hidden: yes
    sql: ${total_new_cases} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: total_option_1 {
    hidden: yes
    type: sum
    sql: ${total_cumulative} ;;
  }

  measure: total_option_2 {
    hidden: yes
    type: sum
    sql: ${total_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

## If date in query, show running total of total tests for given date(s), otherwise show running total of total test results for most recent date
  measure: total_running_total {
    group_label: "Running Total (Testing - US Only)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used.  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    label: "Total Tests (Running Total)"
    type: number
    hidden: yes
    sql:
    {% if covid_combined.measurement_date._in_query %} ${total_option_1}
    {% else %}  ${total_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: positive_rate {
    group_label: "Rates (Testing - US Only)"
    description: "Of all tests, how many are positive?  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: number
    hidden: yes
    sql: 1.0 * ${positive_running_total} / nullif((${total_running_total}),0);;
    value_format_name: percent_1
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: pending_rate {
    group_label: "Rates (Testing - US Only)"
    description: "Of all tests, how many are pending?  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: number
    hidden: yes
    sql: 1.0 * ${pending_running_total} / nullif((${total_running_total}),0);;
    value_format_name: percent_1
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: negative_rate {
    group_label: "Rates (Testing - US Only)"
    description: "Of all tests, how many are negative?  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: number
    hidden: yes
    sql: 1.0 * ${negative_running_total} / nullif((${total_running_total}),0);;
    value_format_name: percent_1
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: case_hospitalization_rate {
    group_label: "Rates (Testing - US Only)"
    description: "What percent of infections have resulted in hospitalization?  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: number
    hidden: yes
    sql: 1.0 * ${hospitalized_running_total}/NULLIF(${positive_running_total}, 0);;
    value_format_name: percent_1
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }

  measure: max_date {
    hidden: yes
    type: date
    sql: max(${measurement_raw}) ;;
  }

#### REDUNDANT FROM JHU DATA

## Based on new_vs_running_total parameter chosen, return new or running total of deaths
  measure: deaths {
    hidden: yes
    group_label: "Dynamic (Testing - US Only)"
    label: "Deaths"
    type: number
    sql:
        {% if covid_combined.new_vs_running_total._parameter_value == 'new_cases' %} ${death_new}
        {% elsif covid_combined.new_vs_running_total._parameter_value == 'running_total' %} ${death_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: death_new {
    hidden: yes
    group_label: "New Cases (Testing - US Only)"
    label: "Deaths (New)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the most recent record will be used"
    type: sum
    sql: ${death_new_cases} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: death_option_1 {
    hidden: yes
    type: sum
    sql: ${death_cumulative} ;;
  }

  measure: death_option_2 {
    hidden: yes
    type: sum
    sql: ${death_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

## If date in query, show running total of deaths for given date(s), otherwise show runnning total of deaths for most recent date
  measure: death_running_total {
    hidden: yes
    group_label: "Running Total (Testing - US Only)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."

    label: "Deaths (Running Total)"
    type: number
    sql:
    {% if covid_combined.measurement_date._in_query %} ${death_option_1}
    {% else %}  ${death_option_2}
    {% endif %} ;;
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: case_fatality_rate {
    hidden: yes
    group_label: "Rates (Testing - US Only)"
    description: "What percent of infections have resulted in death?  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: number
    sql: 1.0 * ${death_running_total}/NULLIF(${positive_running_total}, 0);;
    value_format_name: percent_1
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  measure: case_fatality_or_hospitalization_rate {
    hidden: yes
    group_label: "Rates (Testing - US Only)"
    description: "What percent of infections have resulted in hospitalization or death?  **This field was deprecated on March 7 2021 by the Covid Tracking Project**"
    type: number
    sql: 1.0 * (${death_running_total} + ${hospitalized_running_total}) /NULLIF(${positive_running_total}, 0);;
    value_format_name: percent_1
    link: {
      label: "Data Source - COVID Tracking Project"
      url: "https://covidtracking.com/data"
      icon_url: "https://pbs.twimg.com/profile_images/1245385527701811200/YmXglGxq_400x400.jpg"
    }
  }

  set: drill {
    fields: [
      state,
      measurement_date,
      total,
      positive_test,
      pending_test,
      negative_test,
      deaths,
      hospitalizations
    ]
  }
}
