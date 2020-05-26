include: "//@{CONFIG_PROJECT_NAME}/covid_block/mobility_pdts.view.lkml"

view: max_date_mobility {
  extends: [max_date_mobility_config]
}

###################################################

view: max_date_mobility_core {
  derived_table: {
    sql: SELECT
            country_region_code
            , IFNULL(sub_region_1, '') as sub_region_1
            , IFNULL(sub_region_2, '') as sub_region_2
            , MAX(date) as max_mobility_date
            FROM
              `bigquery-public-data.covid19_google_mobility.mobility_report` m -- base mobility data
            WHERE
              {% condition mobility.mobility_date %} date {% endcondition %}
            GROUP BY 1, 2, 3
            ;;
  }

  dimension: pk {
    primary_key:yes
    hidden: yes
    type: string
    sql: concat(coalesce(${county},''), coalesce(${province_state},''), coalesce(${country_region_code},'')) ;;
  }

  dimension: county {
    sql: ${TABLE}.sub_region_2 ;;
    hidden:yes
  }

  dimension: province_state {
    sql: ${TABLE}.sub_region_1 ;;
    hidden:yes
  }

  dimension: country_region_code {hidden:yes}

  dimension_group: max_mobility {
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.max_mobility_date ;;
  }
}

explore: countries {
  hidden: yes
}

view: countries {
  derived_table: {
    sql: SELECT country_region as country_name FROM `bigquery-public-data.covid19_google_mobility.mobility_report` ;;
  }

  dimension: country_name {}
}

explore: counties {
  hidden: yes
}

view: counties {
  derived_table: {
    sql: SELECT sub_region_2 as county_name FROM `bigquery-public-data.covid19_google_mobility.mobility_report` ;;
  }

  dimension: county_name {}
}

explore: states {
  hidden: yes
}


view: states {
  derived_table: {
    sql: SELECT sub_region_1 as state_name FROM `bigquery-public-data.covid19_google_mobility.mobility_report` ;;
  }

  dimension: state_name {}

}
