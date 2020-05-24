include: "*.view.lkml"

explore: turnstile_partitioned {}

explore: turnstile_daily {
  join: nyc_subway_turnstiles {
    sql_on: ${turnstile_daily.control_area} = ${nyc_subway_turnstiles.control_area}
        AND ${turnstile_daily.unit} = ${nyc_subway_turnstiles.unit}
        AND ${nyc_subway_turnstiles.station_id} IS NOT NULL;;
    relationship: many_to_one
  }
  join: nyc_station_baselines {
    sql_on: ${nyc_station_baselines.control_area} = ${nyc_subway_turnstiles.control_area}
      AND ${nyc_station_baselines.unit} = ${nyc_subway_turnstiles.unit}
      AND ${turnstile_daily.scp} = ${nyc_station_baselines.scp}
      AND ${turnstile_daily.reported_dow} = ${nyc_station_baselines.day_of_week}
    ;;
    relationship: many_to_one
  }
}

view: turnstile_partitioned {
  derived_table: {
    sql:
      SELECT
        control_area,
        unit,
        scp,
        reported_timestamp as reported_at,
        description,
        entries,
        exits,
        ABS(entries - lag(entries, 1) OVER (PARTITION BY CONCAT(tp.control_area, tp.unit, scp) ORDER BY reported_timestamp)) AS calculated_net_entries,
        ABS(exits - lag(exits, 1) OVER (PARTITION BY CONCAT(tp.control_area, tp.unit, scp) ORDER BY reported_timestamp)) AS calculated_net_exits
      FROM
        new_york_subway.turnstile_partitioned_in_place tp;;
    sql_trigger_value: select count(*) FROM turnstile_partitioned_in_place  ;;
    partition_keys: ["reported_at"]
  }

  dimension: pk {
    sql: CONCAT(${control_area}, ${unit}, ${scp}, ${reported_raw}) ;;
    hidden: yes
  }

  dimension: unit_id {
    sql: CONCAT(${control_area}, ${unit}, ${scp}) ;;
  }

  dimension: control_area {
    type: string
    sql: ${TABLE}.control_area ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: division {
    type: string
    sql: ${TABLE}.division ;;
  }

  dimension: station_location {
    type: location
    sql_latitude: ${TABLE}.station_lat ;;
    sql_longitude: ${TABLE}.station_lon ;;
  }

  dimension: entries {
    type: number
    sql: ${TABLE}.entries ;;
  }

  dimension: exits {
    type: number
    sql: ${TABLE}.exits ;;
  }

  dimension: linename {
    type: string
    sql: ${TABLE}.linename ;;
  }

  dimension_group: reported {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week
    ]
    sql: ${TABLE}.reported_at ;;
  }

  measure: days_counted {
    type: count_distinct
    sql: ${reported_date} ;;
  }

  dimension: scp {
    type: string
    sql: ${TABLE}.scp ;;
  }

  dimension: station_id {
    type: string
    sql: ${TABLE}.station_id ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: calculated_net_entries {
    type: number
    sql:  CASE
            WHEN ${TABLE}.calculated_net_entries > 10000
            THEN NULL
            WHEN ${TABLE}.entries = 0 AND ${TABLE}.exits = 0
            THEN NULL
            ELSE ${TABLE}.calculated_net_entries
          END;;
  }

  measure: total_entries {
    type: sum
    value_format_name: decimal_0
    sql: ${calculated_net_entries};;
  }

#   measure: baseline_entries {
#     type: sum
#     value_format_name: decimal_0
#     sql: ${nyc_station_baselines.average_entries_per_day};;
#   }

  dimension: calculated_net_exits {
    type: number
    value_format_name: decimal_0
    sql:  CASE
            WHEN ${TABLE}.calculated_net_exits > 10000
            THEN NULL
            WHEN ${TABLE}.entries = 0 AND ${TABLE}.exits = 0
            THEN NULL
            ELSE ${TABLE}.calculated_net_exits
          END;;
  }

  measure: total_exits {
    type: sum
    value_format_name: decimal_0
    sql: ${calculated_net_exits} ;;
  }



  measure: count {
    type: count
    drill_fields: [linename]
  }
}
