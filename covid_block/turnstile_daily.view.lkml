view: turnstile_daily {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    explore_source: turnstile_partitioned {
      column: control_area {}
      column: unit {}
      column: scp {}
      column: reported_date {field:turnstile_partitioned.reported_date}
      column: reported_dow {field:turnstile_partitioned.reported_day_of_week}
      column: total_entries  {field:turnstile_partitioned.total_entries}
      column: total_exits  {field:turnstile_partitioned.total_exits}
    }
  }

  dimension: pk {
    primary_key: yes
    sql: CONCAT(${control_area}, ${unit}, ${scp}, ${reported_date}) ;;
  }
  dimension: turnstile_id {
    sql: CONCAT(${control_area}, ${unit}, ${scp});;
  }
  dimension: control_area {}
  dimension: unit {}
  dimension: scp {}
  dimension: reported_date {
    type: date
    sql: ${TABLE}.reported_date ;;
  }
  dimension: reported_dow {
    type: string
    sql: ${TABLE}.reported_dow ;;
  }


  measure: total_entries {
    type: sum
  }
  measure: total_exits {
    type: sum
  }

}


# ${nyc_station_baselines.day_of_week} = ${turnstile_daily.reported_day_of_week}
