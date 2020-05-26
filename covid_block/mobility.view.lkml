include: "//@{CONFIG_PROJECT_NAME}/covid_block/mobility.view.lkml"

view: mobility_data {
  extends: [mobility_data_config]
}

###################################################


# This derived table selects everything from mobility data, then joins it to the state and county data for the US

# This file contains logic to make sure that this mobility data is not aggregated in problematic ways.

view: mobility_data_core {
  derived_table: {
    datagroup_trigger: covid_data
    sql:  SELECT
            m.*
            , AVG(grocery_and_pharmacy_percent_change_from_baseline) OVER (
                        PARTITION BY CONCAT(country_region_code, IFNULL(sub_region_1, '-'), IFNULL(sub_region_2, '-'))
                        ORDER BY date
                        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
                      ) as grocery_and_pharmacy_7_day_moving_avg
            , AVG(parks_percent_change_from_baseline) OVER (
                        PARTITION BY CONCAT(country_region_code, IFNULL(sub_region_1, '-'), IFNULL(sub_region_2, '-'))
                        ORDER BY date
                        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
                      ) as parks_7_day_moving_avg
            , AVG(residential_percent_change_from_baseline) OVER (
                        PARTITION BY CONCAT(country_region_code, IFNULL(sub_region_1, '-'), IFNULL(sub_region_2, '-'))
                        ORDER BY date
                        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
                      ) as residential_7_day_moving_avg
            , AVG(retail_and_recreation_percent_change_from_baseline) OVER (
                        PARTITION BY CONCAT(country_region_code, IFNULL(sub_region_1, '-'), IFNULL(sub_region_2, '-'))
                        ORDER BY date
                        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
                      ) as retail_and_recreation_7_day_moving_avg
            , AVG(transit_stations_percent_change_from_baseline) OVER (
                        PARTITION BY CONCAT(country_region_code, IFNULL(sub_region_1, '-'), IFNULL(sub_region_2, '-'))
                        ORDER BY date
                        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
                      ) as transit_stations_7_day_moving_avg
            , AVG(workplaces_percent_change_from_baseline) OVER (
                        PARTITION BY CONCAT(country_region_code, IFNULL(sub_region_1, '-'), IFNULL(sub_region_2, '-'))
                        ORDER BY date
                        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
                      ) as workplaces_7_day_moving_avg
            , COALESCE(c.geo_id, s.state_fips_code) as geo_id
            , COALESCE(c_facts.total_pop, s_facts.total_pop) as total_pop
            , COALESCE(c_facts.households, s_facts.households) as households
            , COALESCE(c_facts.median_income, s_facts.median_income) as median_income
            , COALESCE(c_facts.pop_in_labor_force, s_facts.pop_in_labor_force) as pop_in_labor_force
            FROM
              `bigquery-public-data.covid19_google_mobility.mobility_report` m -- base mobility data
              LEFT JOIN `bigquery-public-data.census_utility.fips_codes_states` s ON
                s.state_name = m.sub_region_1
                AND country_region_code = 'US'
              LEFT JOIN `bigquery-public-data.geo_us_boundaries.counties` c
                ON country_region_code = 'US'
                AND c.state_fips_code = s.state_fips_code
                AND (CASE
                  WHEN m.sub_region_2 = 'Shannon County' AND m.sub_region_1 = 'South Dakota'
                  THEN 'Oglala Lakota County'
                  WHEN m.sub_region_2 = 'La Salle Parish'
                  THEN 'LaSalle Parish'
                  ELSE m.sub_region_2
                 END = c.lsad_name OR c.county_name = m.sub_region_2)
              LEFT JOIN `bigquery-public-data.census_bureau_acs.county_2018_5yr` c_facts
                ON c_facts.geo_id = c.geo_id
              LEFT JOIN `bigquery-public-data.census_bureau_acs.state_2018_1yr` s_facts
                ON s_facts.geo_id = s.state_fips_code;;

    }

    dimension: pk {
      primary_key: yes
      hidden: yes
      type: string
      sql: concat(${country_region_code}, ', ', ${sub_region_1}, ', ', ${sub_region_2}, ' ', ${mobility_date}) ;;
    }

### { Descriptive Dimensions
# Basic attributes, no mobility-calculation work

    dimension: county_fips {
      type: string
      sql: ${TABLE}.geo_id ;;
      hidden: yes
    }

    dimension: country_region {
      type: string
      sql: ${TABLE}.country_region ;;
      label: "1 - Country (Full name)"
    }

    dimension: country_region_code {
      type: string
      label: "1 - Country (ISO Code)"
      sql: ${TABLE}.country_region_code;;
      map_layer_name: countries
      html: {{ country_region._value }} ;;
    }

    dimension: sub_region_1 {
      label: "2 - State, Province, or Similar"
      type: string
      sql: ${TABLE}.sub_region_1 ;;
      map_layer_name: us_states
      drill_fields: [sub_region_2_fips]
    }

    dimension: sub_region_2 {
      type: string
      hidden: yes
      sql: ${TABLE}.sub_region_2 ;;
    }

    dimension: sub_region_2_fips {
      label: "3 - County (US Only)"
      type: string
      sql: ${county_fips} ;;
      map_layer_name: us_counties_fips
      html:  {{ sub_region_2._value }} ;;
    }

    dimension: geo_pk {
      hidden: yes
      sql: CONCAT(${country_region_code}, IFNULL(${sub_region_1}, '-'), IFNULL(${sub_region_2}, '-'))  ;;
    }

    dimension_group: mobility {
      type: time
      label: "Measurement"
      timeframes: [
        date,
        day_of_week,
        month,
        week
      ]
      convert_tz: no
      datatype: date
      sql: ${TABLE}.date ;;
    }


    dimension: is_max_date {
      type: yesno
      hidden: yes
      sql: ${mobility_date} = ${max_date_mobility.max_mobility_raw};;
    }

    dimension_group: most_recent_data {
      sql: TIMESTAMP(${max_date_mobility.max_mobility_raw}) ;;
      type: time
      timeframes: [date, day_of_week]

    }

### } Descriptive Dimensions

### { Geography Parameters

    parameter: geography_level {
      type: string
      allowed_value: {
        label: "Country"
        value: "0"
      }
      allowed_value: {
        label: "Sub-Country Region"
        value: "1"
      }
      allowed_value: {
        label: "County (US Only)"
        value: "2"
      }
      default_value: "country"
    }

    dimension: geo_level_output {
      sql: {% parameter geography_level %} ;;
      hidden: yes
    }

    dimension: geo_level {
      sql:
        CASE
          WHEN ${sub_region_2} IS NOT NULL
          THEN "2"
          WHEN ${sub_region_1} IS NOT NULL
          THEN "1"
          ELSE "0"
        END;;
      hidden: yes
      description: "Indicates if a row of data is about a country, sub-country region, or US County"
    }

### { Raw, Non-Weighted Dimensions
# Dividing these by 100 so they are stored in their base form as decimals, rather than percentages

    dimension: grocery_and_pharmacy_pcfb {
      hidden: yes
      type: number
      sql: ${TABLE}.grocery_and_pharmacy_percent_change_from_baseline/100 ;;
    }

    dimension: grocery_and_pharmacy_7dma {
      hidden: yes
      type: number
      sql: ${TABLE}.grocery_and_pharmacy_7_day_moving_avg/100 ;;
    }

    dimension: parks_pcfb {
      hidden: yes
      type: number
      sql: ${TABLE}.parks_percent_change_from_baseline/100 ;;
    }

    dimension: parks_7dma {
      hidden: yes
      type: number
      sql: ${TABLE}.parks_7_day_moving_avg/100 ;;
    }

    dimension: residential_pcfb {
      hidden: yes
      type: number
      sql: ${TABLE}.residential_percent_change_from_baseline/100 ;;
    }

    dimension: residential_7dma {
      hidden: yes
      type: number
      sql: ${TABLE}.residential_7_day_moving_avg/100 ;;
    }

    dimension: retail_and_recreation_pcfb {
      hidden: yes
      type: number
      sql: ${TABLE}.retail_and_recreation_percent_change_from_baseline/100 ;;
    }

    dimension: retail_and_recreation_7dma {
      hidden: yes
      type: number
      sql: ${TABLE}.retail_and_recreation_7_day_moving_avg/100 ;;
    }

    dimension: transit_stations_pcfb {
      hidden: yes
      type: number
      sql: ${TABLE}.transit_stations_percent_change_from_baseline/100 ;;
    }

    dimension: transit_stations_7dma {
      hidden: yes
      type: number
      sql: ${TABLE}.transit_stations_7_day_moving_avg/100 ;;
    }

    dimension: workplaces_pcfb {
      hidden: yes
      type: number
      sql: ${TABLE}.workplaces_percent_change_from_baseline/100 ;;
    }

    dimension: workplaces_7dma {
      hidden: yes
      type: number
      sql: ${TABLE}.workplaces_7_day_moving_avg/100 ;;
    }


### } Raw, Non-Weighted Dimensions

### { Date-logic Measures
    measure: avg_grocery_and_pharmacy_percent_change_from_baseline {
      group_item_label: "Daily % Change from Baseline"
      label: "Grocery and Pharmacy (Daily % Change from Baseline)"
      group_label: "Grocery and Pharmacy"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
            ${grocery_and_pharmacy_pcfb}
          {% else %}
            CASE WHEN ${is_max_date} THEN ${grocery_and_pharmacy_pcfb} ELSE NULL END
          {% endif %};;
      value_format_name: percent_1
    }

    measure: grocery_and_pharmacy_7_day_moving_avg {
      group_item_label: "7-Day Moving Avg"
      label: "Grocery and Pharmacy (7-Day Moving Avg)"
      group_label: "Grocery and Pharmacy"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
              ${grocery_and_pharmacy_7dma}
            {% else %}
              CASE WHEN ${is_max_date} THEN ${grocery_and_pharmacy_7dma} ELSE NULL END
            {% endif %};;
      value_format_name: percent_1
    }


    measure: avg_parks_percent_change_from_baseline {
      group_label: "Parks"
      label: "Parks (Daily % Change from Baseline)"
      group_item_label: "Daily % Change from Baseline"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
            ${parks_pcfb}
          {% else %}
            CASE WHEN ${is_max_date} THEN ${parks_pcfb} ELSE NULL END
          {% endif %};;
      value_format_name: percent_1
    }

    measure: parks_7_day_moving_avg {
      group_label: "Parks"
      label: "Parks (7-Day Moving Avg)"
      group_item_label: "7-Day Moving Avg"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
              ${parks_7dma}
            {% else %}
              CASE WHEN ${is_max_date} THEN ${parks_7dma} ELSE NULL END
            {% endif %};;
      value_format_name: percent_1
    }

    measure: avg_residential_percent_change_from_baseline {
      group_label: "Residential"
      label: "Residential (Daily % Change from Baseline)"
      group_item_label: "Daily % Change from Baseline"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
              ${residential_pcfb}
            {% else %}
              CASE WHEN ${is_max_date} THEN ${residential_pcfb} ELSE NULL END
            {% endif %};;
      value_format_name: percent_1
    }


    measure: residential_7_day_moving_avg {
      group_label: "Residential"
      label: "Residential (7-Day Moving Avg)"
      group_item_label: "7-Day Moving Avg"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
                ${residential_7dma}
              {% else %}
                CASE WHEN ${is_max_date} THEN ${residential_7dma} ELSE NULL END
              {% endif %};;
      value_format_name: percent_1
    }


    measure: avg_retail_and_recreation_percent_change_from_baseline {
      group_label: "Retail and Recreation"
      label: "Retail and Recreation (Daily % Change from Baseline)"
      group_item_label: "Daily % Change from Baseline"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
              ${retail_and_recreation_pcfb}
            {% else %}
              CASE WHEN ${is_max_date} THEN ${retail_and_recreation_pcfb} ELSE NULL END
            {% endif %};;
      value_format_name: percent_1
    }

    measure: retail_and_recreation_7_day_moving_avg {
      group_label: "Retail and Recreation"
      label: "Retail and Recreation (7-Day Moving Avg)"
      group_item_label: "7-Day Moving Avg"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
                ${retail_and_recreation_7dma}
              {% else %}
                CASE WHEN ${is_max_date} THEN ${retail_and_recreation_7dma} ELSE NULL END
              {% endif %};;
      value_format_name: percent_1
    }


    measure: avg_transit_stations_percent_change_from_baseline {
      group_label: "Transit Stations"
      label: "Transit Stations (Daily % Change from Baseline)"
      group_item_label: "Daily % Change from Baseline"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
            ${transit_stations_pcfb}
          {% else %}
            CASE WHEN ${is_max_date} THEN ${transit_stations_pcfb} ELSE NULL END
          {% endif %};;
      value_format_name: percent_1
    }

    measure: transit_stations_7_day_moving_avg {
      group_label: "Transit Stations"
      label: "Transit Stations (7-Day Moving Avg)"
      group_item_label: "7-Day Moving Avg"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
              ${transit_stations_7dma}
            {% else %}
              CASE WHEN ${is_max_date} THEN ${transit_stations_7dma} ELSE NULL END
            {% endif %};;
      value_format_name: percent_1
    }


    measure: avg_workplaces_percent_change_from_baseline {
      group_label: "Workplaces"
      label: "Workplaces (Daily % Change from Baseline)"
      group_item_label: "Daily % Change from Baseline"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
            ${workplaces_pcfb}
          {% else %}
          CASE WHEN ${is_max_date} THEN ${workplaces_pcfb} ELSE NULL END
          {% endif %};;
      value_format_name: percent_1
    }

    measure: workplaces_7_day_moving_avg {
      group_label: "Workplaces"
      label: "Workplaces (7-Day Moving Avg)"
      group_item_label: "7-Day Moving Avg"
      type: average
      sql: {% if mobility_date._in_query or mobility_week._in_query or mobility_day_of_week._in_query or mobility_month._in_query %}
              ${workplaces_7dma}
            {% else %}
            CASE WHEN ${is_max_date} THEN ${workplaces_7dma} ELSE NULL END
            {% endif %};;
      value_format_name: percent_1
    }

### } Date-logic Measures

### { Dynamic 7-day or Daily Measures

    parameter: daily_or_avg {
      allowed_value: {
        label: "Daily Measures"
        value: "daily"
      }
      allowed_value: {
        label: "7-Day Moving Avg"
        value: "mov_avg"
      }
    }

    measure: grocery_and_pharmacy_dynamic {
      sql: CASE WHEN {% parameter daily_or_avg %} = 'daily'
           THEN ${avg_grocery_and_pharmacy_percent_change_from_baseline}
           WHEN {% parameter daily_or_avg %} = 'mov_avg'
           THEN ${grocery_and_pharmacy_7_day_moving_avg}
           ELSE 0
           END;;
      html: {% if daily_or_avg._parameter_value == "'daily'" or daily_or_avg._parameter_value == "'mov_avg'" %}
              {{ rendered_value }}
            {% else %}
              You must choose daily values or moving average.
            {% endif %};;
      group_item_label: "Dynamic"
      label: "Grocery and Pharmacy (Dynamic)"
      group_label: "Grocery and Pharmacy"
      value_format_name: percent_1
      type: number
    }

  measure: parks_dynamic {
    sql: CASE WHEN {% parameter daily_or_avg %} = 'daily'
           THEN ${avg_parks_percent_change_from_baseline}
           WHEN {% parameter daily_or_avg %} = 'mov_avg'
           THEN ${parks_7_day_moving_avg}
           ELSE 0
           END;;
    html: {% if daily_or_avg._parameter_value == "'daily'" or daily_or_avg._parameter_value == "'mov_avg'" %}
              {{ rendered_value }}
            {% else %}
              You must choose daily values or moving average.
            {% endif %};;
    group_item_label: "Dynamic"
    label: "Parks (Dynamic)"
    group_label: "Parks"
    value_format_name: percent_1
    type: number
  }

  measure: residential_dynamic {
    sql: CASE WHEN {% parameter daily_or_avg %} = 'daily'
           THEN ${avg_residential_percent_change_from_baseline}
           WHEN {% parameter daily_or_avg %} = 'mov_avg'
           THEN ${residential_7_day_moving_avg}
           ELSE 0
           END;;
    html: {% if daily_or_avg._parameter_value == "'daily'" or daily_or_avg._parameter_value == "'mov_avg'" %}
              {{ rendered_value }}
            {% else %}
              You must choose daily values or moving average.
            {% endif %};;
    group_item_label: "Dynamic"
    label: "Residential (Dynamic)"
    group_label: "Residential"
    value_format_name: percent_1
    type: number
  }

  measure: retail_and_recreation_dynamic {
    sql: CASE WHEN {% parameter daily_or_avg %} = 'daily'
           THEN ${avg_retail_and_recreation_percent_change_from_baseline}
           WHEN {% parameter daily_or_avg %} = 'mov_avg'
           THEN ${retail_and_recreation_7_day_moving_avg}
           ELSE 0
           END;;
    html: {% if daily_or_avg._parameter_value == "'daily'" or daily_or_avg._parameter_value == "'mov_avg'" %}
              {{ rendered_value }}
            {% else %}
              You must choose daily values or moving average.
            {% endif %};;
    group_item_label: "Dynamic"
    label: "Retail and Recreation (Dynamic)"
    group_label: "Retail and Recreation"
    value_format_name: percent_1
    type: number
  }

  measure: transit_stations_dynamic {
    sql: CASE WHEN {% parameter daily_or_avg %} = 'daily'
           THEN ${avg_transit_stations_percent_change_from_baseline}
           WHEN {% parameter daily_or_avg %} = 'mov_avg'
           THEN ${transit_stations_7_day_moving_avg}
           ELSE 0
           END;;
    html: {% if daily_or_avg._parameter_value == "'daily'" or daily_or_avg._parameter_value == "'mov_avg'" %}
              {{ rendered_value }}
            {% else %}
              You must choose daily values or moving average.
            {% endif %};;
    group_item_label: "Dynamic"
    label: "Transit Stations (Dynamic)"
    group_label: "Transit Stations"
    value_format_name: percent_1
    type: number
  }

  measure: workplaces_dynamic {
    sql: CASE WHEN {% parameter daily_or_avg %} = 'daily'
           THEN ${avg_workplaces_percent_change_from_baseline}
           WHEN {% parameter daily_or_avg %} = 'mov_avg'
           THEN ${workplaces_7_day_moving_avg}
           ELSE 0
           END;;
    html: {% if daily_or_avg._parameter_value == "'daily'" or daily_or_avg._parameter_value == "'mov_avg'" %}
              {{ rendered_value }}
            {% else %}
              You must choose daily values or moving average.
            {% endif %};;
    group_item_label: "Dynamic"
    label: "Workplaces (Dynamic)"
    group_label: "Workplaces"
    value_format_name: percent_1
    type: number
  }

### } Dynamic 7-day or Daily Measures


### { Misc Measures

    measure: count {
      type: count
      label: "Count of days represented"
    }

    measure: max_mobility_date {
      type: date_raw
      hidden: yes
      sql: max(${mobility_date}) ;;
    }

### } Misc Measures

    drill_fields: [region_non_dynamic*]
    set: region {
      fields: [sub_region_1, sub_region_2_fips]
    }

    set: non_dynamic {
      fields: [avg_grocery_and_pharmacy_percent_change_from_baseline
        , avg_workplaces_percent_change_from_baseline
        , avg_transit_stations_percent_change_from_baseline
        , avg_retail_and_recreation_percent_change_from_baseline
        , avg_residential_percent_change_from_baseline
        , avg_parks_percent_change_from_baseline]
    }

    set: region_non_dynamic {
      fields: [region*, non_dynamic*]
    }
  }
