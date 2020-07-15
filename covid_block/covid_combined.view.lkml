include: "//@{CONFIG_PROJECT_NAME}/covid_block/covid_combined.view.lkml"
include: "/dashboards/*.dashboard.lookml"

# The county level data shows NYT + JHU, NYT is used for US county level data and JHU data is used for international data

## NYT data: https://github.com/nytimes/covid-19-data
## JHU data: https://cloud.google.com/blog/products/data-analytics/free-public-datasets-for-covid19
## BQ Open Data: https://cloud.google.com/blog/products/data-analytics/free-public-datasets-for-covid19

view: covid_combined {
  extends: [covid_combined_config]
}

###################################################

view: covid_combined_core {
  derived_table: {
    datagroup_trigger: covid_data
    sql:
    --use the NYT data for all US data, but join with JHU to get lat/lon for the fips
   SELECT * FROM
    (SELECT
        cast(a.fips as int64) as fips,
        a.county,
        a.state_name as province_state,
        'US' as country_region,
        b.latitude,
        b.longitude,
        case
          when a.state_name is null then 'US'
          when a.state_name is not null AND a.county is null then concat(a.state_name,', US')
          when a.county is not null then concat(a.county, ', ', a.state_name, ', US')
        end as combined_key,
        cast(a.date as date) as measurement_date,
        --a.daily_confirmed_cases as confirmed_cumulative,
        a.confirmed_cases as confirmed_cumulative,
        a.confirmed_cases - coalesce(
        LAG(a.confirmed_cases, 1) OVER (
            PARTITION BY concat(coalesce(a.county,''), coalesce(a.state_name,''), 'US'
              ) ORDER BY a.date ASC),0) as confirmed_new_cases,
       --a.daily_confirmed_cases   as confirmed_new_cases,
        a.deaths as deaths_cumulative,
        a.deaths - coalesce(
         LAG(deaths, 1) OVER (
         PARTITION BY concat(coalesce(a.county,''), coalesce(a.state_name,''), 'US'
         )  ORDER BY date ASC),0) as deaths_new_cases
        --a.daily_deaths as deaths_new_cases
      FROM ${nyt_data.SQL_TABLE_NAME} as a
      LEFT JOIN (SELECT fips, max(latitude) as latitude, max(longitude) as longitude, count(*) as count FROM `bigquery-public-data.covid19_open_data.compatibility_view` WHERE fips is not null GROUP BY 1) as b
        ON cast(a.fips as string) = cast(b.fips as string)

      UNION ALL

-- --use the JHU data for non US
      SELECT
        NULL as fips,
        cast(NULL as string) as county,
        province_state,
        case when country_region = 'United Kingdom' then 'UK' else country_region end,
        latitude,
        longitude,
        case
          when province_state is null then case when country_region = 'Mainland China' then 'China' else country_region end
          when province_state is not null AND country_region is null then concat(province_state,
                            ', ',case when country_region = 'Mainland China' then 'China' else country_region end)
          end as combined_key,
        cast(date as date) as measurement_date,
        confirmed as confirmed_cumulative,
        confirmed - coalesce(
          LAG(confirmed, 1) OVER (
          PARTITION BY concat(coalesce(NULL,''), coalesce(province_state,''), coalesce(country_region,'')
          ) ORDER BY date ASC),0) as confirmed_new_cases,
        deaths as deaths_cumulative,
        deaths - coalesce(
          LAG(deaths, 1) OVER (
          PARTITION BY concat(coalesce(NULL,''), coalesce(province_state,''), coalesce(country_region,'')
          )  ORDER BY date ASC),0) as deaths_new_cases
        FROM `bigquery-public-data.covid19_open_data.compatibility_view`
        WHERE country_region <> 'United States of America'
      )
        WHERE cast(measurement_date as date) <= (SELECT min(max_date) as max_date FROM
        (
          SELECT max(cast(date as date)) as max_date FROM ${nyt_data.SQL_TABLE_NAME}
          UNION ALL
          SELECT max(cast(date as date)) as max_date FROM  `bigquery-public-data.covid19_open_data.compatibility_view`
        ) a);;
  }



####################
#### Original Dimensions ####
####################

  dimension: pre_pk {
    hidden: yes
    type: string
    sql: concat(coalesce(${county},''), coalesce(${province_state},''), coalesce(case when ${TABLE}.country_region in ('US','UK')
        then ${TABLE}.country_region else ${country_region} end,'')) ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${pre_pk},${measurement_raw}) ;;
  }

  dimension: combined_key {
    hidden: yes
    type: string
    sql: ${TABLE}.combined_key ;;
  }

  dimension_group: measurement {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.measurement_date ;;
  }

#### Location ####

  dimension: country_raw {
    hidden: yes
    type: string
    sql: ${TABLE}.country_region ;;
  }

  dimension: county {
    group_label: "Location"
    label: "County"
    type: string
    sql: ${TABLE}.county ;;
    link: {
      label: "{{ value }} - News Search"
      url: "https://news.google.com/search?q={{ value }}%20county%20{{ province_state._value}}%20covid"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.news.google.com"
    }
  }

  dimension: lat {
    hidden: yes
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: long {
    hidden: yes
    type: number
    sql: ${TABLE}.long ;;
  }

  #this dimension uses the lat/lon from the JHU data
  dimension: location {
    group_label: "Location"
    label: "County (Point Location)"
    description: "Lat / Lon point location, sourced from JHU for each county"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${long} ;;
  }

  dimension: fips {
    group_label: "Location"
    label: "County (Maps)"
    description: "Use this field to map cases by county"
    map_layer_name: us_counties_fips_nyc
    type: string
    sql: SUBSTR('00000' || IFNULL(SAFE_CAST(${TABLE}.fips AS STRING), ''), -5) ;;
#     html: {{ county._value }} ;;
  }

  dimension: province_state {
    group_label: "Location"
    description: "Map only configured for US states, but states from other countries are also present in the data"
    label: "State"
    map_layer_name: us_states
    type: string
    sql: ${TABLE}.province_state ;;
    drill_fields: [county]
    link: {
      label: "{{ value }} - News Search"
      url: "https://news.google.com/search?q={{ value }}%20covid"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.news.google.com"
    }
  }

#### KPIs ####

  dimension: confirmed_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.confirmed_cumulative ;;
  }

  dimension: confirmed_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.confirmed_new_cases ;;
  }

  dimension: deaths_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.deaths_cumulative ;;
  }

  dimension: deaths_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.deaths_new_cases ;;
  }

  dimension: x {
    hidden: yes
    type: string
    sql: '' ;;
    # sql: ${TABLE}.x ;;
  }

####################
#### Derived Dimensions ####
####################

#### Location ####

  dimension: country_region {
    group_label: "Location"
    label: "Country"
    type: string
    map_layer_name: countries
    sql:
      case
        when ${TABLE}.country_region = 'Korea, South' then 'South Korea'
        when ${TABLE}.country_region = 'US' then 'United States of America'
        when ${TABLE}.country_region = 'UK' then 'United Kingdom'
        when ${TABLE}.country_region = 'North Ireland' then 'Ireland'
        when ${TABLE}.country_region = 'Republic of Ireland' then 'Ireland'
        when ${TABLE}.country_region = 'Czech Republic' then 'Czechia'
        when ${TABLE}.country_region = 'Viet Nam' then 'Vietnam'
        when ${TABLE}.country_region = 'The Bahamas' then 'Bahamas'
        when ${TABLE}.country_region = 'Bahamas, The' then 'Bahamas'
        else ${TABLE}.country_region
      end ;;
    drill_fields: [province_state]
    link: {
      label: "{{ value }} - News Search"
      url: "https://news.google.com/search?q={{ value }}%20covid"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.news.google.com"
    }
  }

  dimension: county_non_null {
    hidden: yes
    type: string
    sql: coalesce(${county},${province_state},${country_region}) ;;
  }

  dimension: county_full {
    hidden: yes
    group_label: "Location"
    label: "County (Full)"
    sql: concat(coalesce(concat(${county},', '),''),coalesce(concat(${province_state},', ')),${country_region}) ;;
  }

  dimension: state_full {
    hidden: yes
    group_label: "Location"
    label: "State (Full)"
    sql: concat(coalesce(concat(${province_state},', ')),${country_region}) ;;
  }

  dimension: fips_as_string {
    hidden: yes
    type: string
    sql: CASE WHEN LENGTH(cast(${fips} as string)) = 4 THEN CONCAT('0',${fips})
      ELSE cast(${fips} as string) END;;
  }


#### Location Rank ####

  dimension: country_ordered {
    group_label: "Location"
    label: "Country (Ordered)"
    description: "Ordered by confirmed running total of cases"
    sql: concat(cast(${country_rank.rank} as string),'-',${country_raw}) ;;
    html: {{ country_region._value }} ;;
  }

  dimension: state_ordered {
    group_label: "Location"
    label: "State (Ordered)"
    description: "Ordered by confirmed running total of cases"
    sql: concat(cast(${state_rank.rank} as string),'-',${province_state}) ;;
    html: {{ province_state._value }} ;;
  }

  dimension: fips_ordered {
    group_label: "Location"
    label: "County (Ordered)"
    description: "Ordered by confirmed running total of cases"
    sql: concat(cast(${fips_rank.rank} as string),'-',${fips}) ;;
    html: {{ county._value }} ;;
  }

## Parameter allowing users to filter on top X countries, state, or counties - e.g. Top 5 countries based on total cases
  parameter: show_top_x_values {
    description: "Use this filter with the country, state and county top X dimensions to just focus on the regions with the highest confirmed running totals"
    type: number
    default_value: "10"
  }

## Only show countries where rank is less than or equal to show_top_x_values parameter chosen by users
  dimension: country_top_x {
    group_label: "Location"
    label: "Country (Show Top X)"
    description: "Use this field with the Show Top X Values filter, ordered by confirmed running total"
    sql: case when ${country_rank.rank} <= {% parameter show_top_x_values %} then ${country_region} else ' Other' end ;;
  }

## Only show states where rank is less than or equal to show_top_x_values parameter chosen by users
  dimension: state_top_x {
    group_label: "Location"
    description: "Use this field with the Show Top X Values filter, ordered by confirmed running total"
    label: "State (Show Top X)"
    sql: case when ${state_rank.rank} <= {% parameter show_top_x_values %} then ${province_state} else ' Other' end ;;
  }

 ## Only show counties where rank is less than or equal to show_top_x_values parameter chosen by users
 dimension: county_top_x {
    group_label: "Location"
    description: "Use this field with the Show Top X Values filter, ordered by confirmed running total"
    label: "County (Show Top X)"
    sql: case when ${fips_rank.rank} <= {% parameter show_top_x_values %} then ${county} else ' Other' end ;;
  }


#### Max Date ####

  dimension: is_max_date {
    label: "  Is Max Date"
    description: "Is this record from the most recent day in the dataset? The most recent day is the minimum of the most recent measurement date for both JHU and NYT data"
    #hidden: yes
    type: yesno
    sql: ${measurement_raw} = ${max_date_covid.max_date_raw} ;;
  }

  dimension: days_since_max_date {
    description: "The number of days that have passed since the maximum date in the dataset (i.e. how many days of data are we missing here)"
    type:  number
    sql: date_diff(${measurement_raw},${max_date_covid.max_date_raw},day) ;;
  }

#### Days since X Case ####

  parameter: minimum_number_cases {
    label: "Minimum Number of Cases (X)"
    description: "Modify your analysis to start counting days since outbreak to start with a minumum of X cases."
    type: number
    default_value: "1"
  }

  #this filed is calculated by taking the first day that the county hit the minimum number of cases
  dimension_group: county_outbreak_start {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: (SELECT CAST(MIN(foobar.measurement_date) AS TIMESTAMP)
      FROM ${covid_combined.SQL_TABLE_NAME} as foobar
      WHERE foobar.confirmed_cumulative >= {% parameter minimum_number_cases %}
      AND coalesce(${TABLE}.county, ${TABLE}.province_state, ${TABLE}.country_region) = coalesce(foobar.county,foobar.province_state,foobar.country_region )  )  ;;
  }

  #this filed is calculated by taking the first day that the state hit the minimum number of cases
  dimension_group: state_outbreak_start {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: (SELECT CAST(MIN(foobar.measurement_date) AS TIMESTAMP)
      FROM ${covid_combined.SQL_TABLE_NAME} as foobar
      WHERE foobar.confirmed_cumulative >= {% parameter minimum_number_cases %}
      AND coalesce(${TABLE}.province_state, ${TABLE}.country_region) = coalesce(foobar.province_state,foobar.country_region ) )  ;;
  }

  #this filed is calculated by taking the first day that the country hit the minimum number of cases
  dimension_group: country_outbreak_start {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: (SELECT CAST(MIN(foobar.measurement_date) AS TIMESTAMP)
      FROM ${covid_combined.SQL_TABLE_NAME} as foobar
      WHERE foobar.confirmed_cumulative >= {% parameter minimum_number_cases %}
      AND ${TABLE}.country_region = foobar.country_region ) ;;
  }

  dimension_group: system_outbreak_start {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: (SELECT CAST(MIN(foobar.measurement_date) AS TIMESTAMP)
      FROM ${covid_combined.SQL_TABLE_NAME} as foobar
      WHERE foobar.confirmed_cumulative >= {% parameter minimum_number_cases %} );;
  }

  dimension: days_since_first_outbreak_county {
    hidden: yes
    type:  number
    sql: date_diff(${measurement_raw},${county_outbreak_start_date},  day) + 1 ;;
  }

  dimension: days_since_first_outbreak_state {
    hidden: yes
    type:  number
    sql: date_diff(${measurement_raw},${state_outbreak_start_date},  day) + 1 ;;
  }

  dimension: days_since_first_outbreak_country {
    hidden: yes
    type:  number
    sql: date_diff(${measurement_raw},${country_outbreak_start_date},  day) + 1 ;;
  }

  dimension: days_since_first_outbreak_system {
    hidden: yes
    type:  number
    sql: date_diff(${measurement_raw},${system_outbreak_start_date},  day) + 1 ;;
  }

  dimension: days_since_first_outbreak {
    label: "Days Since X Cases"
    description: "Use with the minimum number of cases filter, if nothing is selected the default is X = 1"
    type:  number
    sql:
          {% if covid_combined.fips._in_query %} ${days_since_first_outbreak_county}
          {% elsif covid_combined.province_state._in_query %} ${days_since_first_outbreak_state}
          {% elsif covid_combined.country_region._in_query %} ${days_since_first_outbreak_country}
          {% else %}  ${days_since_first_outbreak_system}
          {% endif %} ;;
  }


####################
#### Measures ####
####################

## Let user choose between looking at new cases (active, confirmed, deaths, etc) or running total
  parameter: new_vs_running_total {
    hidden: yes
    description: "Use with the dynamic measures to see either new cases or the running total, can be used to easily toggle between the two on a Look or Dashboard"
    type: unquoted
    default_value: "new_cases"
    allowed_value: {
      label: "New Cases"
      value: "new_cases"
    }
    allowed_value: {
      label: "Running Total"
      value: "running_total"
    }
  }

## Based on new_vs_running_total parameter chosen, return new or running total confirmed cases
  measure: confirmed_cases {
    group_label: "  Dynamic"
    description: "Use with New vs Running Total Filter, can be useful for creating a Look or Dashboard where you toggle between the two"
    label: "Confirmed Cases"
    type: number
    sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${confirmed_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${confirmed_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

## Based on new_vs_running_total parameter chosen, return new or running total deaths
  measure: deaths {
    group_label: "  Dynamic"
    description: "Use with New vs Running Total Filter, can be useful for creating a Look or Dashboard where you toggle between the two"
    label: "Deaths"
    type: number
    sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${deaths_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${deaths_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: confirmed_new_option_1 {
    hidden: yes
    type: sum
    sql: ${confirmed_new_cases};;
#     sql: ${confirmed_new_cases}*${puma_conversion_factor} ;;
  }

  measure: confirmed_new_option_2 {
    hidden: yes
    type: sum
    sql: ${confirmed_new_cases};;
#     sql: ${confirmed_new_cases}*${puma_conversion_factor} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  #this field displays the new cases if a date filter has been applied, or else is gives the numbers from the most recent record
  measure: confirmed_new {
    group_label: "  New Cases"
    label: "Confirmed Cases (New)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the sum of all the new cases for each day will be displayed"
    type: number
    sql: ${confirmed_new_option_1};;
# code to instead default to most recenet new confirmed cases:
#       {% if covid_combined.measurement_date._in_query or covid_combined.days_since_first_outbreak._in_query or
#       covid_combined.days_since_max_date._in_query %} ${confirmed_new_option_1}
#        {% else %}  ${confirmed_new_option_2}
#       {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: confirmed_new_per_million {
    group_label: "  New Cases"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the sum of all the new cases for each day will be displayed"
    label: "Confirmed Cases per Million (New)"
    type: number
    sql: 1000000*${confirmed_new} / nullif(${population_by_county_state_country.sum_population},0) ;;
    value_format_name: decimal_0
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: confirmed_option_1 {
    hidden: yes
    type: sum
    sql: ${confirmed_cumulative};;
#     sql: ${confirmed_cumulative}*${puma_conversion_factor} ;;
  }

  measure: confirmed_option_2 {
    hidden: yes
    type: sum
    sql: ${confirmed_cumulative};;
#     sql: ${confirmed_cumulative}*${puma_conversion_factor} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  #this field displays the running total of cases if a date filter has been applied, or else is gives the numbers from the most recent record
  measure: confirmed_running_total {
    group_label: "  Running Total"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."
    label: "Confirmed Cases (Running Total)"
    type: number
    sql:
          {% if covid_combined.measurement_date._in_query or covid_combined.days_since_first_outbreak._in_query or covid_combined.days_since_max_date._in_query %} ${confirmed_option_1}
          {% else %}  ${confirmed_option_2}
          {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  #this field displays the running total of cases if a date filter has been applied, or else is gives the numbers from the most recent record but is does not have a drill path
  measure: confirmed_running_total_no_drill {
    hidden: yes
    group_label: "  Running Total "
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."
    label: "Confirmed Cases  [No Drill]"
    type: number
    sql:
          {% if covid_combined.measurement_date._in_query or covid_combined.days_since_first_outbreak._in_query or covid_combined.days_since_max_date._in_query %} ${confirmed_option_1}
          {% else %}  ${confirmed_option_2}
          {% endif %} ;;
    # drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: confirmed_running_total_per_million {
    group_label: "  Running Total"
    label: "Confirmed Cases per Million (Running Total)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."
    type: number
    sql: 1000000*${confirmed_running_total} / nullif(${population_by_county_state_country.sum_population},0) ;;
    value_format_name: decimal_0
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: confirmed_cases_per_icu_beds {
    group_label: " Hospital Capacity (US Only)"
    label: "Confirmed Cases per ICU Beds"
    type: number
    sql: 1.0*${confirmed_running_total}*${hospital_bed_summary.estimated_percent_of_covid_cases_of_county}/nullif(${hospital_bed_summary.sum_num_icu_beds},0) ;;
    value_format_name: decimal_2
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: confirmed_cases_per_staffed_beds {
    group_label: " Hospital Capacity (US Only)"
    label: "Confirmed Cases per Staffed Beds"
    type: number
    sql: 1.0*${confirmed_running_total}*${hospital_bed_summary.estimated_percent_of_covid_cases_of_county}/nullif(${hospital_bed_summary.sum_num_staffed_beds},0) ;;
    value_format_name: decimal_2
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: confirmed_cases_per_licensed_beds {
    group_label: " Hospital Capacity (US Only)"
    label: "Confirmed Cases per Licensed Beds"
    type: number
    sql: 1.0*${confirmed_running_total}*${hospital_bed_summary.estimated_percent_of_covid_cases_of_county}/nullif(${hospital_bed_summary.sum_num_licensed_beds},0) ;;
    value_format_name: decimal_2
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: deaths_new_option_1 {
    hidden: yes
    type: sum
    sql: ${deaths_new_cases} ;;
  }

  measure: deaths_new_option_2 {
    hidden: yes
    type: sum
    sql: ${deaths_new_cases} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }


  #this field displays the new deaths if a date filter has been applied, or else is gives the numbers from the most recent record
  measure: deaths_new {
    group_label: "  New Cases"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the sum of all the new cases for each day will be displayed"
    label: "Deaths (New)"
    type: number
    sql:${deaths_new_option_1};;
    # code to instead default to most recenet new confirmed cases:
#       {% if covid_combined.measurement_date._in_query or covid_combined.days_since_first_outbreak._in_query or covid_combined.days_since_max_date._in_query %} ${deaths_new_option_1}
#       {% else %}  ${deaths_new_option_2}
#       {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: deaths_new_per_million {
    group_label: "  New Cases"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the new cases during the selected timeframe, otherwise the sum of all the new cases for each day will be displayed"
    label: "Deaths per Million (New)"
    type: number
    sql: 1000000*${deaths_new} / nullif(${population_by_county_state_country.sum_population},0) ;;
    value_format_name: decimal_0
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: deaths_option_1 {
    hidden: yes
    type: sum
    sql: ${deaths_cumulative} ;;
  }

  measure: deaths_option_2 {
    hidden: yes
    type: sum
    sql: ${deaths_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  #this field displays the running total of deaths if a date filter has been applied, or else is gives the numbers from the most recent record
  measure: deaths_running_total {
    group_label: "  Running Total"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."
    label: "Deaths (Running Total)"
    type: number
    sql:
          {% if covid_combined.measurement_date._in_query or covid_combined.days_since_first_outbreak._in_query or covid_combined.days_since_max_date._in_query %} ${deaths_option_1}
          {% else %}  ${deaths_option_2}
          {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: deaths_running_total_per_million {
    group_label: "  Running Total"
    label: "Deaths per Million (Running Total)"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."

    type: number
    sql: 1000000*${deaths_running_total} / nullif(${population_by_county_state_country.sum_population},0) ;;
    value_format_name: decimal_0
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: case_fatality_rate {
    group_label: "  Running Total"
#     description: "What percent of infections have resulted in death?"
    description: "Filter on Measurement Date or Days Since First Outbreak to see the running total on a specific date, don't use with a range of dates or else the results will show the sum of the running totals for each day in that timeframe. If no dates are selected the most recent record will be used."

    type: number
    sql: 1.0 * ${deaths_running_total}/NULLIF(${confirmed_running_total}, 0);;
    value_format_name: percent_1
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: min_date {
    hidden: yes
    type: date
    sql: min(${measurement_raw}) ;;
  }

  measure: max_date {
    hidden: yes
    type: date
    sql: max(${measurement_raw}) ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }



##############
### Drills ###
##############

  set: drill {
    fields: [
      country_region,
      province_state,
      confirmed_cases,
      deaths
    ]
  }
}
