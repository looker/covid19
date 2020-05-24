view: nyc_station_baselines {
  derived_table: {
    explore_source: turnstile_partitioned {
        column: day_of_week {field: turnstile_partitioned.reported_day_of_week}
        column: control_area {field: turnstile_partitioned.control_area}
        column: unit {field: turnstile_partitioned.unit}
        column: scp {field: turnstile_partitioned.scp}
        column: total_entries {field: turnstile_partitioned.total_entries}
        column: total_exits {field: turnstile_partitioned.total_exits}
        column: days_counted {field: turnstile_partitioned.days_counted}
        derived_column: average_entries_per_day {
          sql:  total_entries/days_counted ;;
        }
        derived_column: average_exits_per_day {
          sql:  total_exits/days_counted ;;
        }
        filters: [turnstile_partitioned.reported_date: "2020/01/05 to 2020/03/01"]
    }
  }

  dimension: pk {
    primary_key: yes
    sql: CONCAT(${day_of_week}, ${unit}, ${control_area}, ${scp}) ;;
  }
  dimension: unit {}
  dimension: control_area {}
  dimension: scp {}
  dimension: day_of_week {}
  dimension: turnstile_id {
    sql: CONCAT(${control_area}, ${unit}, ${scp});;
  }
  dimension: total_entries {}
  dimension: total_exits {}
  dimension: average_entries_per_day {
    type: number
    value_format_name: decimal_0
  }
  dimension: average_exits_per_day {
    type: number
    value_format_name: decimal_0
  }
  measure: baseline_entries {
    type: sum
    sql: ${average_entries_per_day} ;;
    value_format_name: decimal_0
  }

}
