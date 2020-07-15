view: open_data {
  derived_table: {
    sql: SELECT
        province_state
        , country_region
        , date
        , latitude
        , longitude
        -- , location_geometry AS location_geom
        , confirmed
        , deaths
        , recovered
        , active
        , fips
        , admin_2
        , combined_key
      FROM `bigquery-public-data.covid19_open_data.compatibility_view`
       ;;
  }

  dimension: od_pk {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${combined_key}, ${TABLE}.date) ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: province_state {
    type: string
    sql: ${TABLE}.province_state ;;
  }

  dimension: country_region {
    type: string
    sql: ${TABLE}.country_region ;;
  }

  dimension_group: date {
    type: time
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: confirmed {
    type: number
    sql: ${TABLE}.confirmed ;;
  }

  dimension: deaths {
    type: number
    sql: ${TABLE}.deaths ;;
  }

  dimension: recovered {
    type: number
    sql: ${TABLE}.recovered ;;
  }

  dimension: active {
    type: number
    sql: ${TABLE}.active ;;
  }

  dimension: fips {
    type: string
    sql: ${TABLE}.fips ;;
  }

  dimension: admin_2 {
    type: string
    sql: ${TABLE}.admin_2 ;;
  }

  dimension: combined_key {
    type: string
    sql: ${TABLE}.combined_key ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  set: detail {
    fields: [
      province_state,
      country_region,
      date_date,
      latitude,
      longitude,
      confirmed,
      deaths,
      recovered,
      active,
      fips,
      admin_2,
      combined_key,
      location
    ]
  }
}
