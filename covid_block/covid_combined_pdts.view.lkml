include: "//@{CONFIG_PROJECT_NAME}/covid_block/covid_combined_pdts.view.lkml"

### This view file has several different PDTs that calculate metrics like ranks and comparisons of geographies


####################
### Max Dates
####################
view: max_date_covid {
  extends: [max_date_covid_config]
}

view: max_date_tracking_project {
  extends: [max_date_tracking_project_config]
}


####################
### Ranks
####################
view: country_rank {
  extends: [country_rank_config]
}

view: state_rank {
  extends: [state_rank_config]
}

view: fips_rank {
  extends: [fips_rank_config]
}


####################
### Growth Rate / Days to Double
####################
view: prior_days_cases_covid {
  extends: [prior_days_cases_covid_config]
}

####################
### Compare Geographies
####################
view: kpis_by_county_by_date {
  extends: [kpis_by_county_by_date_config]
}

view: kpis_by_state_by_date {
  extends: [kpis_by_state_by_date_config]
}

view: kpis_by_country_by_date {
  extends: [kpis_by_country_by_date_config]
}

view: kpis_by_entity_by_date {
  extends: [kpis_by_entity_by_date_config]
}

##########################################


####################
### Max Dates
####################

view: max_date_covid_core {
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: covid_combined {
      column: max_date {}
    }
  }
  dimension_group: max_date {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date
    ]
    sql: cast(${TABLE}.max_date as date) ;;
  }
}

view: max_date_tracking_project_core {
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: covid_combined {
      column: max_date { field: covid_tracking_project.max_date }
    }
  }
  dimension_group: max_date {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date
    ]
    sql: cast(${TABLE}.max_date as date) ;;
  }
}

####################
### Ranks
####################

view: country_rank_core {
  derived_table: {
    explore_source: covid_combined {
      bind_all_filters: yes
      column: country_raw {}
      column: confirmed_running_total {}
      derived_column: rank {
        sql: row_number() OVER (PARTITION BY 'X' ORDER BY confirmed_running_total desc) ;;
      }
    }
  }
  dimension: country_raw { primary_key: yes hidden: yes }
  dimension: rank { hidden: yes type: number }
}

view: state_rank_core {
  derived_table: {
    explore_source: covid_combined {
      bind_all_filters: yes
      column: province_state {}
      column: confirmed_running_total {}
      derived_column: rank {
        sql: row_number() OVER (PARTITION BY 'X' ORDER BY confirmed_running_total desc) ;;
      }
      filters: {
        field: covid_combined.country_raw
        value: "US"
      }
    }
  }
  dimension: province_state { primary_key: yes hidden: yes }
  dimension: rank { hidden: yes type: number }
}

view: fips_rank_core {
  derived_table: {
    explore_source: covid_combined {
      bind_all_filters: yes
      column: fips {}
      column: confirmed_running_total {}
      derived_column: rank {
        sql: row_number() OVER (PARTITION BY 'X' ORDER BY confirmed_running_total desc) ;;
      }
      filters: {
        field: covid_combined.country_raw
        value: "US"
      }
    }
  }
  dimension: fips { primary_key: yes hidden: yes }
  dimension: rank { hidden: yes type: number }
}

####################
### Growth Rate / Days to Double
####################

view: prior_days_cases_covid_core {
  view_label: "Trends"
  derived_table: {
    sql_trigger_value: SELECT max(cast(measurement_date as date)) as max_date FROM ${covid_combined.SQL_TABLE_NAME} ;;
    explore_source: covid_combined {
      column: measurement_date {}
      column: pre_pk {}
      column: confirmed_running_total {}
      column: deaths_running_total {}
      column: confirmed_new {}
      column: deaths_new {}
      column: confirmed_running_total_per_million {}
      column: deaths_running_total_per_million {}
      column: confirmed_new_per_million {}
      column: deaths_new_per_million {}

      derived_column: prior_1_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

    }
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${pre_pk},${measurement_date}) ;;
  }

  dimension_group: measurement {
    type: time
    timeframes: [date,raw]
    hidden:yes
    datatype: date
    sql: cast(${TABLE}.measurement_date as date) ;;
  }


  dimension: pre_pk { hidden:yes}

  dimension: prior_1_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_2_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_3_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_4_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_5_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_6_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_7_days_confirmed_running_total {type:number hidden:yes}

  dimension: prior_1_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_2_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_3_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_4_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_5_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_6_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_7_days_deaths_running_total {type:number hidden:yes}

  dimension: prior_1_days_confirmed_new {type:number hidden:yes}
  dimension: prior_2_days_confirmed_new {type:number hidden:yes}
  dimension: prior_3_days_confirmed_new {type:number hidden:yes}
  dimension: prior_4_days_confirmed_new {type:number hidden:yes}
  dimension: prior_5_days_confirmed_new {type:number hidden:yes}
  dimension: prior_6_days_confirmed_new {type:number hidden:yes}
  dimension: prior_7_days_confirmed_new {type:number hidden:yes}

  dimension: prior_1_days_deaths_new {type:number hidden:yes}
  dimension: prior_2_days_deaths_new {type:number hidden:yes}
  dimension: prior_3_days_deaths_new {type:number hidden:yes}
  dimension: prior_4_days_deaths_new {type:number hidden:yes}
  dimension: prior_5_days_deaths_new {type:number hidden:yes}
  dimension: prior_6_days_deaths_new {type:number hidden:yes}
  dimension: prior_7_days_deaths_new {type:number hidden:yes}

  dimension: prior_1_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_2_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_3_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_4_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_5_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_6_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_7_days_confirmed_running_total_per_million {type:number hidden:yes}

  dimension: prior_1_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_2_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_3_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_4_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_5_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_6_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_7_days_deaths_running_total_per_million {type:number hidden:yes}

  dimension: prior_1_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_2_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_3_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_4_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_5_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_6_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_7_days_confirmed_new_per_million {type:number hidden:yes}

  dimension: prior_1_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_2_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_3_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_4_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_5_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_6_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_7_days_deaths_new_per_million {type:number hidden:yes}


  #All of these metrics require having date selected, or filtered to a single date.
  measure: sum_prior_1_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_1_days_confirmed_running_total};;}
  measure: sum_prior_2_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_2_days_confirmed_running_total};;}
  measure: sum_prior_3_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_3_days_confirmed_running_total};;}
  measure: sum_prior_4_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_4_days_confirmed_running_total};;}
  measure: sum_prior_5_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_5_days_confirmed_running_total};;}
  measure: sum_prior_6_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_6_days_confirmed_running_total};;}
  measure: sum_prior_7_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_7_days_confirmed_running_total};;}

  measure: sum_prior_1_days_deaths_running_total { type:sum hidden:yes sql: ${prior_1_days_deaths_running_total};;}
  measure: sum_prior_2_days_deaths_running_total { type:sum hidden:yes sql: ${prior_2_days_deaths_running_total};;}
  measure: sum_prior_3_days_deaths_running_total { type:sum hidden:yes sql: ${prior_3_days_deaths_running_total};;}
  measure: sum_prior_4_days_deaths_running_total { type:sum hidden:yes sql: ${prior_4_days_deaths_running_total};;}
  measure: sum_prior_5_days_deaths_running_total { type:sum hidden:yes sql: ${prior_5_days_deaths_running_total};;}
  measure: sum_prior_6_days_deaths_running_total { type:sum hidden:yes sql: ${prior_6_days_deaths_running_total};;}
  measure: sum_prior_7_days_deaths_running_total { type:sum hidden:yes sql: ${prior_7_days_deaths_running_total};;}

  measure: sum_prior_1_days_confirmed_new { type:sum hidden:yes sql: ${prior_1_days_confirmed_new};;}
  measure: sum_prior_2_days_confirmed_new { type:sum hidden:yes sql: ${prior_2_days_confirmed_new};;}
  measure: sum_prior_3_days_confirmed_new { type:sum hidden:yes sql: ${prior_3_days_confirmed_new};;}
  measure: sum_prior_4_days_confirmed_new { type:sum hidden:yes sql: ${prior_4_days_confirmed_new};;}
  measure: sum_prior_5_days_confirmed_new { type:sum hidden:yes sql: ${prior_5_days_confirmed_new};;}
  measure: sum_prior_6_days_confirmed_new { type:sum hidden:yes sql: ${prior_6_days_confirmed_new};;}
  measure: sum_prior_7_days_confirmed_new { type:sum hidden:yes sql: ${prior_7_days_confirmed_new};;}

  measure: sum_prior_1_days_deaths_new { type:sum hidden:yes sql: ${prior_1_days_deaths_new};;}
  measure: sum_prior_2_days_deaths_new { type:sum hidden:yes sql: ${prior_2_days_deaths_new};;}
  measure: sum_prior_3_days_deaths_new { type:sum hidden:yes sql: ${prior_3_days_deaths_new};;}
  measure: sum_prior_4_days_deaths_new { type:sum hidden:yes sql: ${prior_4_days_deaths_new};;}
  measure: sum_prior_5_days_deaths_new { type:sum hidden:yes sql: ${prior_5_days_deaths_new};;}
  measure: sum_prior_6_days_deaths_new { type:sum hidden:yes sql: ${prior_6_days_deaths_new};;}
  measure: sum_prior_7_days_deaths_new { type:sum hidden:yes sql: ${prior_7_days_deaths_new};;}

  measure: sum_prior_1_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_1_days_confirmed_running_total_per_million};;}
  measure: sum_prior_2_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_2_days_confirmed_running_total_per_million};;}
  measure: sum_prior_3_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_3_days_confirmed_running_total_per_million};;}
  measure: sum_prior_4_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_4_days_confirmed_running_total_per_million};;}
  measure: sum_prior_5_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_5_days_confirmed_running_total_per_million};;}
  measure: sum_prior_6_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_6_days_confirmed_running_total_per_million};;}
  measure: sum_prior_7_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_7_days_confirmed_running_total_per_million};;}

  measure: sum_prior_1_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_1_days_deaths_running_total_per_million};;}
  measure: sum_prior_2_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_2_days_deaths_running_total_per_million};;}
  measure: sum_prior_3_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_3_days_deaths_running_total_per_million};;}
  measure: sum_prior_4_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_4_days_deaths_running_total_per_million};;}
  measure: sum_prior_5_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_5_days_deaths_running_total_per_million};;}
  measure: sum_prior_6_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_6_days_deaths_running_total_per_million};;}
  measure: sum_prior_7_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_7_days_deaths_running_total_per_million};;}

  measure: sum_prior_1_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_1_days_confirmed_new_per_million};;}
  measure: sum_prior_2_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_2_days_confirmed_new_per_million};;}
  measure: sum_prior_3_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_3_days_confirmed_new_per_million};;}
  measure: sum_prior_4_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_4_days_confirmed_new_per_million};;}
  measure: sum_prior_5_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_5_days_confirmed_new_per_million};;}
  measure: sum_prior_6_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_6_days_confirmed_new_per_million};;}
  measure: sum_prior_7_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_7_days_confirmed_new_per_million};;}

  measure: sum_prior_1_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_1_days_deaths_new_per_million};;}
  measure: sum_prior_2_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_2_days_deaths_new_per_million};;}
  measure: sum_prior_3_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_3_days_deaths_new_per_million};;}
  measure: sum_prior_4_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_4_days_deaths_new_per_million};;}
  measure: sum_prior_5_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_5_days_deaths_new_per_million};;}
  measure: sum_prior_6_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_6_days_deaths_new_per_million};;}
  measure: sum_prior_7_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_7_days_deaths_new_per_million};;}

  measure: seven_day_average_change_rate_confirmed_cases_running_total {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases Running Total (7 Day Average Change)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${covid_combined.confirmed_running_total}    - ${sum_prior_1_days_confirmed_running_total}) / NULLIF(${sum_prior_1_days_confirmed_running_total},0))*7.0
          + ((${sum_prior_1_days_confirmed_running_total}                 - ${sum_prior_2_days_confirmed_running_total}) / NULLIF(${sum_prior_2_days_confirmed_running_total},0))*6.0
          + ((${sum_prior_2_days_confirmed_running_total}                 - ${sum_prior_3_days_confirmed_running_total}) / NULLIF(${sum_prior_3_days_confirmed_running_total},0))*5.0
          + ((${sum_prior_3_days_confirmed_running_total}                 - ${sum_prior_4_days_confirmed_running_total}) / NULLIF(${sum_prior_4_days_confirmed_running_total},0))*4.0
          + ((${sum_prior_4_days_confirmed_running_total}                 - ${sum_prior_5_days_confirmed_running_total}) / NULLIF(${sum_prior_5_days_confirmed_running_total},0))*3.0
          + ((${sum_prior_5_days_confirmed_running_total}                 - ${sum_prior_6_days_confirmed_running_total}) / NULLIF(${sum_prior_6_days_confirmed_running_total},0))*2.0
          + ((${sum_prior_6_days_confirmed_running_total}                 - ${sum_prior_7_days_confirmed_running_total}) / NULLIF(${sum_prior_7_days_confirmed_running_total},0))
        )/28.0;;
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

  measure: seven_day_average_change_rate_deaths_running_total {
    group_label: "Advanced Analytics"
    label: "Deaths Running Total (7 Day Average Change)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${covid_combined.deaths_running_total}   - ${sum_prior_1_days_deaths_running_total}) / NULLIF(${sum_prior_1_days_deaths_running_total},0))*7.0
          + ((${sum_prior_1_days_deaths_running_total}                - ${sum_prior_2_days_deaths_running_total}) / NULLIF(${sum_prior_2_days_deaths_running_total},0))*6.0
          + ((${sum_prior_2_days_deaths_running_total}                - ${sum_prior_3_days_deaths_running_total}) / NULLIF(${sum_prior_3_days_deaths_running_total},0))*5.0
          + ((${sum_prior_3_days_deaths_running_total}                - ${sum_prior_4_days_deaths_running_total}) / NULLIF(${sum_prior_4_days_deaths_running_total},0))*4.0
          + ((${sum_prior_4_days_deaths_running_total}                - ${sum_prior_5_days_deaths_running_total}) / NULLIF(${sum_prior_5_days_deaths_running_total},0))*3.0
          + ((${sum_prior_5_days_deaths_running_total}                - ${sum_prior_6_days_deaths_running_total}) / NULLIF(${sum_prior_6_days_deaths_running_total},0))*2.0
          + ((${sum_prior_6_days_deaths_running_total}                - ${sum_prior_7_days_deaths_running_total}) / NULLIF(${sum_prior_7_days_deaths_running_total},0))
        )/28.0;;
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

  measure: seven_day_average_change_rate_confirmed_cases_new {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases New (7 Day Average Change)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${covid_combined.confirmed_new}    - ${sum_prior_1_days_confirmed_new}) / NULLIF(${sum_prior_1_days_confirmed_new},0))*7.0
          + ((${sum_prior_1_days_confirmed_new}                 - ${sum_prior_2_days_confirmed_new}) / NULLIF(${sum_prior_2_days_confirmed_new},0))*6.0
          + ((${sum_prior_2_days_confirmed_new}                 - ${sum_prior_3_days_confirmed_new}) / NULLIF(${sum_prior_3_days_confirmed_new},0))*5.0
          + ((${sum_prior_3_days_confirmed_new}                 - ${sum_prior_4_days_confirmed_new}) / NULLIF(${sum_prior_4_days_confirmed_new},0))*4.0
          + ((${sum_prior_4_days_confirmed_new}                 - ${sum_prior_5_days_confirmed_new}) / NULLIF(${sum_prior_5_days_confirmed_new},0))*3.0
          + ((${sum_prior_5_days_confirmed_new}                 - ${sum_prior_6_days_confirmed_new}) / NULLIF(${sum_prior_6_days_confirmed_new},0))*2.0
          + ((${sum_prior_6_days_confirmed_new}                 - ${sum_prior_7_days_confirmed_new}) / NULLIF(${sum_prior_7_days_confirmed_new},0))
        )/28.0;;
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

  measure: seven_day_average_change_rate_deaths_new {
    group_label: "Advanced Analytics"
    label: "Deaths New (7 Day Average Change)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${covid_combined.deaths_new}   - ${sum_prior_1_days_deaths_new}) / NULLIF(${sum_prior_1_days_deaths_new},0))*7.0
          + ((${sum_prior_1_days_deaths_new}                - ${sum_prior_2_days_deaths_new}) / NULLIF(${sum_prior_2_days_deaths_new},0))*6.0
          + ((${sum_prior_2_days_deaths_new}                - ${sum_prior_3_days_deaths_new}) / NULLIF(${sum_prior_3_days_deaths_new},0))*5.0
          + ((${sum_prior_3_days_deaths_new}                - ${sum_prior_4_days_deaths_new}) / NULLIF(${sum_prior_4_days_deaths_new},0))*4.0
          + ((${sum_prior_4_days_deaths_new}                - ${sum_prior_5_days_deaths_new}) / NULLIF(${sum_prior_5_days_deaths_new},0))*3.0
          + ((${sum_prior_5_days_deaths_new}                - ${sum_prior_6_days_deaths_new}) / NULLIF(${sum_prior_6_days_deaths_new},0))*2.0
          + ((${sum_prior_6_days_deaths_new}                - ${sum_prior_7_days_deaths_new}) / NULLIF(${sum_prior_7_days_deaths_new},0))
        )/28.0;;
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

  measure: seven_day_average_change_rate_confirmed_cases_running_total_per_million {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases Running Total per Million (7 Day Average Change)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${covid_combined.confirmed_running_total_per_million}    - ${sum_prior_1_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_1_days_confirmed_running_total_per_million},0))*7.0
          + ((${sum_prior_1_days_confirmed_running_total_per_million}                 - ${sum_prior_2_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_2_days_confirmed_running_total_per_million},0))*6.0
          + ((${sum_prior_2_days_confirmed_running_total_per_million}                 - ${sum_prior_3_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_3_days_confirmed_running_total_per_million},0))*5.0
          + ((${sum_prior_3_days_confirmed_running_total_per_million}                 - ${sum_prior_4_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_4_days_confirmed_running_total_per_million},0))*4.0
          + ((${sum_prior_4_days_confirmed_running_total_per_million}                 - ${sum_prior_5_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_5_days_confirmed_running_total_per_million},0))*3.0
          + ((${sum_prior_5_days_confirmed_running_total_per_million}                 - ${sum_prior_6_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_6_days_confirmed_running_total_per_million},0))*2.0
          + ((${sum_prior_6_days_confirmed_running_total_per_million}                 - ${sum_prior_7_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_7_days_confirmed_running_total_per_million},0))
        )/28.0;;
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

  measure: seven_day_average_change_rate_deaths_running_total_per_million {
    group_label: "Advanced Analytics"
    label: "Deaths Running Total per Million (7 Day Average Change)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${covid_combined.deaths_running_total_per_million}   - ${sum_prior_1_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_1_days_deaths_running_total_per_million},0))*7.0
          + ((${sum_prior_1_days_deaths_running_total_per_million}                - ${sum_prior_2_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_2_days_deaths_running_total_per_million},0))*6.0
          + ((${sum_prior_2_days_deaths_running_total_per_million}                - ${sum_prior_3_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_3_days_deaths_running_total_per_million},0))*5.0
          + ((${sum_prior_3_days_deaths_running_total_per_million}                - ${sum_prior_4_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_4_days_deaths_running_total_per_million},0))*4.0
          + ((${sum_prior_4_days_deaths_running_total_per_million}                - ${sum_prior_5_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_5_days_deaths_running_total_per_million},0))*3.0
          + ((${sum_prior_5_days_deaths_running_total_per_million}                - ${sum_prior_6_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_6_days_deaths_running_total_per_million},0))*2.0
          + ((${sum_prior_6_days_deaths_running_total_per_million}                - ${sum_prior_7_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_7_days_deaths_running_total_per_million},0))
        )/28.0;;
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

  measure: seven_day_average_change_rate_confirmed_cases_new_per_million {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases New per Million (7 Day Average Change)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${covid_combined.confirmed_new_per_million}    - ${sum_prior_1_days_confirmed_new_per_million}) / NULLIF(${sum_prior_1_days_confirmed_new_per_million},0))*7.0
          + ((${sum_prior_1_days_confirmed_new_per_million}                 - ${sum_prior_2_days_confirmed_new_per_million}) / NULLIF(${sum_prior_2_days_confirmed_new_per_million},0))*6.0
          + ((${sum_prior_2_days_confirmed_new_per_million}                 - ${sum_prior_3_days_confirmed_new_per_million}) / NULLIF(${sum_prior_3_days_confirmed_new_per_million},0))*5.0
          + ((${sum_prior_3_days_confirmed_new_per_million}                 - ${sum_prior_4_days_confirmed_new_per_million}) / NULLIF(${sum_prior_4_days_confirmed_new_per_million},0))*4.0
          + ((${sum_prior_4_days_confirmed_new_per_million}                 - ${sum_prior_5_days_confirmed_new_per_million}) / NULLIF(${sum_prior_5_days_confirmed_new_per_million},0))*3.0
          + ((${sum_prior_5_days_confirmed_new_per_million}                 - ${sum_prior_6_days_confirmed_new_per_million}) / NULLIF(${sum_prior_6_days_confirmed_new_per_million},0))*2.0
          + ((${sum_prior_6_days_confirmed_new_per_million}                 - ${sum_prior_7_days_confirmed_new_per_million}) / NULLIF(${sum_prior_7_days_confirmed_new_per_million},0))
        )/28.0;;
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

  measure: seven_day_average_change_rate_deaths_new_per_million {
    group_label: "Advanced Analytics"
    label: "Deaths New per Million (7 Day Average Change)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${covid_combined.deaths_new_per_million}   - ${sum_prior_1_days_deaths_new_per_million}) / NULLIF(${sum_prior_1_days_deaths_new_per_million},0))*7.0
          + ((${sum_prior_1_days_deaths_new_per_million}                - ${sum_prior_2_days_deaths_new_per_million}) / NULLIF(${sum_prior_2_days_deaths_new_per_million},0))*6.0
          + ((${sum_prior_2_days_deaths_new_per_million}                - ${sum_prior_3_days_deaths_new_per_million}) / NULLIF(${sum_prior_3_days_deaths_new_per_million},0))*5.0
          + ((${sum_prior_3_days_deaths_new_per_million}                - ${sum_prior_4_days_deaths_new_per_million}) / NULLIF(${sum_prior_4_days_deaths_new_per_million},0))*4.0
          + ((${sum_prior_4_days_deaths_new_per_million}                - ${sum_prior_5_days_deaths_new_per_million}) / NULLIF(${sum_prior_5_days_deaths_new_per_million},0))*3.0
          + ((${sum_prior_5_days_deaths_new_per_million}                - ${sum_prior_6_days_deaths_new_per_million}) / NULLIF(${sum_prior_6_days_deaths_new_per_million},0))*2.0
          + ((${sum_prior_6_days_deaths_new_per_million}                - ${sum_prior_7_days_deaths_new_per_million}) / NULLIF(${sum_prior_7_days_deaths_new_per_million},0))
        )/28.0;;
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

## Using the rule of 70 to calculate doubling time
  measure: doubling_time_confirmed_cases_rolling_total {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases Running Total (Days to Double)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_confirmed_cases_running_total},0);;
    html: {{rendered_value}} Day(s) ;;
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

  measure: doubling_time_deaths_rolling_total {
    group_label: "Advanced Analytics"
    label: "Deaths Running Total (Days to Double)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_deaths_running_total},0);;
    html: {{rendered_value}} Day(s) ;;
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

  measure: doubling_time_confirmed_cases_new {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases New (Days to Double)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_confirmed_cases_new},0);;
    html: {{rendered_value}} Day(s) ;;
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

  measure: doubling_time_deaths_new {
    group_label: "Advanced Analytics"
    label: "Deaths New (Days to Double)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_deaths_new},0);;
    html: {{rendered_value}} Day(s) ;;
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

  measure: doubling_time_confirmed_cases_rolling_total_per_million {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases Running Total per Million (Days to Double)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_confirmed_cases_running_total_per_million},0);;
    html: {{rendered_value}} Day(s) ;;
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

  measure: doubling_time_deaths_rolling_total_per_million {
    group_label: "Advanced Analytics"
    label: "Deaths Running Total per Million (Days to Double)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_deaths_running_total_per_million},0);;
    html: {{rendered_value}} Day(s) ;;
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

  measure: doubling_time_confirmed_cases_new_per_million {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases New per Million (Days to Double)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_confirmed_cases_new_per_million},0);;
    html: {{rendered_value}} Day(s) ;;
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

  measure: doubling_time_deaths_new_per_million {
    group_label: "Advanced Analytics"
    label: "Deaths New per Million (Days to Double)"
    description: "These metrics require having date selected or filtered to a single date."
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_deaths_new_per_million},0);;
    html: {{rendered_value}} Day(s) ;;
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

}

####################
### Compare Geographies
####################

view: kpis_by_county_by_date_core {
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: covid_combined {
      column: county_full {}
      column: measurement_date {}
      column: days_since_first_outbreak {}
      column: confirmed_new {}
      column: confirmed_new_per_million {}
      column: deaths_new {}
      column: deaths_new_per_million {}
      column: confirmed_running_total {}
      column: confirmed_running_total_per_million {}
      column: deaths_running_total {}
      column: deaths_running_total_per_million {}
      column: doubling_time_confirmed_cases_new_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_new_per_million }
      column: doubling_time_confirmed_cases_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_rolling_total_per_million }
      column: doubling_time_deaths_new_per_million { field: prior_days_cases_covid.doubling_time_deaths_new_per_million }
      column: doubling_time_deaths_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_deaths_rolling_total_per_million }
      filters: {
        field: covid_combined.fips
        value: "NOT NULL"
      }
    }
  }
}

view: kpis_by_state_by_date_core {
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: covid_combined {
      column: state_full {}
      column: measurement_date {}
      column: days_since_first_outbreak {}
      column: confirmed_new {}
      column: confirmed_new_per_million {}
      column: deaths_new {}
      column: deaths_new_per_million {}
      column: confirmed_running_total {}
      column: confirmed_running_total_per_million {}
      column: deaths_running_total {}
      column: deaths_running_total_per_million {}
      column: doubling_time_confirmed_cases_new_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_new_per_million }
      column: doubling_time_confirmed_cases_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_rolling_total_per_million }
      column: doubling_time_deaths_new_per_million { field: prior_days_cases_covid.doubling_time_deaths_new_per_million }
      column: doubling_time_deaths_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_deaths_rolling_total_per_million }
      filters: {
        field: covid_combined.province_state
        value: "-NULL"
      }
    }
  }
}

view: kpis_by_country_by_date_core {
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: covid_combined {
      column: country_region {}
      column: measurement_date {}
      column: days_since_first_outbreak {}
      column: confirmed_new {}
      column: confirmed_new_per_million {}
      column: deaths_new {}
      column: deaths_new_per_million {}
      column: confirmed_running_total {}
      column: confirmed_running_total_per_million {}
      column: deaths_running_total {}
      column: deaths_running_total_per_million {}
      column: doubling_time_confirmed_cases_new_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_new_per_million }
      column: doubling_time_confirmed_cases_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_rolling_total_per_million }
      column: doubling_time_deaths_new_per_million { field: prior_days_cases_covid.doubling_time_deaths_new_per_million }
      column: doubling_time_deaths_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_deaths_rolling_total_per_million }
      filters: {
        field: covid_combined.country_region
        value: "-NULL"
      }
    }
  }
}

view: kpis_by_entity_by_date_core {
  derived_table: {
    datagroup_trigger: covid_data
    sql:

  SELECT
    'County' as entity_level
  , county_full as entity
  , measurement_date
  , days_since_first_outbreak
  , confirmed_new
  , confirmed_new_per_million
  , deaths_new
  , deaths_new_per_million
  , confirmed_running_total
  , confirmed_running_total_per_million
  , deaths_running_total
  , deaths_running_total_per_million
  , doubling_time_confirmed_cases_new_per_million
  , doubling_time_confirmed_cases_rolling_total_per_million
  , doubling_time_deaths_new_per_million
  , doubling_time_deaths_rolling_total_per_million
  FROM ${kpis_by_county_by_date.SQL_TABLE_NAME}

  UNION ALL

  SELECT 'State' as entity_level, *
  FROM ${kpis_by_state_by_date.SQL_TABLE_NAME}

  UNION ALL

  SELECT 'Country' as entity_level,
   country_region as entity
  , measurement_date
  , days_since_first_outbreak
  , confirmed_new
  , confirmed_new_per_million
  , deaths_new
  , deaths_new_per_million
  , confirmed_running_total
  , confirmed_running_total_per_million
  , deaths_running_total
  , deaths_running_total_per_million
  , doubling_time_confirmed_cases_new_per_million
  , doubling_time_confirmed_cases_rolling_total_per_million
  , doubling_time_deaths_new_per_million
  , doubling_time_deaths_rolling_total_per_million
  FROM ${kpis_by_country_by_date.SQL_TABLE_NAME}

    ;;
  }

  dimension: entity {
    type: string
#     sql:
#       CASE
#         WHEN entity = 'Country' then concat('  ',${TABLE}.entity)
#         WHEN entity = 'State' then concat(' ',${TABLE}.entity)
#         WHEN entity = 'County' then ${TABLE}.entity
#       END
#     ;;
  }
  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: concat(${entity},cast(${measurement_date} as string)) ;;
  }

  dimension_group: measurement {
    type: time
    timeframes: [
      raw,date
    ]
    sql: ${TABLE}.measurement_date ;;
  }

  dimension: days_since_first_outbreak {
    hidden: yes
    type: number
  }

  dimension: entity_level { type: number hidden:yes }
  dimension: confirmed_new { type: number hidden:yes }
  dimension: confirmed_new_per_million { type: number hidden:yes }
  dimension: deaths_new { type: number hidden:yes }
  dimension: deaths_new_per_million { type: number hidden:yes }
  dimension: confirmed_running_total { type: number hidden:yes }
  dimension: confirmed_running_total_per_million { type: number hidden:yes }
  dimension: deaths_running_total { type: number hidden:yes }
  dimension: deaths_running_total_per_million { type: number hidden:yes }
  dimension: doubling_time_confirmed_cases_new_per_million { type: number hidden:yes }
  dimension: doubling_time_confirmed_cases_rolling_total_per_million { type: number hidden:yes }
  dimension: doubling_time_deaths_new_per_million { type: number hidden:yes }
  dimension: doubling_time_deaths_rolling_total_per_million { type: number hidden:yes }

  parameter: minimum_number_cases {
    label: "Minimum Number of Cases (X)"
    description: "Modify your analysis to start counting days since outbreak to start with a minumum of X cases."
    type: number
    default_value: "1"
  }

  dimension_group: outbreak_start {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql:
      (
        SELECT CAST(MIN(foobar.measurement_date) AS TIMESTAMP)
        FROM ${kpis_by_entity_by_date.SQL_TABLE_NAME} as foobar
        WHERE foobar.confirmed_running_total >=  {% parameter minimum_number_cases %}
        AND ${TABLE}.entity = foobar.entity
      )
      ;;
  }

  dimension: days_since_first_outbreaks {
    label: "Days Since (X) Cases"
    description: "Use with the minimum number of cases filter, otherwise the default is 1 case"
    type:  number
    sql: date_diff(${measurement_date},${outbreak_start_date},  day) + 1 ;;
  }

  parameter: metric_type {
    type: string
    default_value: "new"
    allowed_value: {
      label: "New"
      value: "new"
    }
    allowed_value: {
      label: "Running Total"
      value: "running_total"
    }
  }

  parameter: metric_value {
    description: "Select the value of the metric you want to compare, use with the metric fiter. For example, selecting 'actual value' with confirmed cases, means you want to compare the raw number of confirmed cases or deaths."
    type: string
    default_value: "per_million_people"
    allowed_value: {
      label: "Actual Value"
      value: "actual_value"
    }
    allowed_value: {
      label: "Per Million People"
      value: "per_million_people"
    }
    allowed_value: {
      label: "Days to Double"
      value: "days_to_double"
    }
  }

  parameter: metric {
    description: "Select the metric you would like to compare, either confirmed cases or deahts"
    type: string
    default_value: "confirmed_cases"
    allowed_value: {
      label: "Confirmed_Cases"
      value: "confirmed_cases"
    }
    allowed_value: {
      label: "Deaths"
      value: "deaths"
    }
  }

  dimension: concat_parameters {
    type: string
    # hidden: yes
    sql: concat({% parameter metric_type %},'|',{% parameter metric_value %},'|',{% parameter metric %}) ;;
  }

  measure: kpi_to_select {
    label: " Dynamic KPI"
    type: number
    sql:
    CASE
      WHEN ${concat_parameters} = 'new|actual_value|confirmed_cases'                  THEN ${sum_confirmed_new}
      WHEN ${concat_parameters} = 'new|actual_value|deaths'                           THEN ${sum_deaths_new}
      WHEN ${concat_parameters} = 'new|per_million_people|confirmed_cases'            THEN ${sum_confirmed_new_per_million}
      WHEN ${concat_parameters} = 'new|per_million_people|deaths'                     THEN ${sum_deaths_new_per_million}
      WHEN ${concat_parameters} = 'new|days_to_double|confirmed_cases'                THEN ${sum_doubling_time_confirmed_cases_new_per_million}
      WHEN ${concat_parameters} = 'new|days_to_double|deaths'                         THEN ${sum_doubling_time_deaths_new_per_million}
      WHEN ${concat_parameters} = 'running_total|actual_value|confirmed_cases'        THEN ${sum_confirmed_running_total}
      WHEN ${concat_parameters} = 'running_total|actual_value|deaths'                 THEN ${sum_deaths_running_total}
      WHEN ${concat_parameters} = 'running_total|per_million_people|confirmed_cases'  THEN ${sum_confirmed_running_total_per_million}
      WHEN ${concat_parameters} = 'running_total|per_million_people|deaths'           THEN ${sum_deaths_running_total_per_million}
      WHEN ${concat_parameters} = 'running_total|days_to_double|confirmed_cases'      THEN ${sum_doubling_time_confirmed_cases_rolling_total_per_million}
      WHEN ${concat_parameters} = 'running_total|days_to_double|deaths'               THEN ${sum_doubling_time_deaths_rolling_total_per_million}
    END
    ;;
    value_format_name: decimal_1
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

  measure: sum_confirmed_new {
    group_label: "New"
    label: "Confirmed (New)"
    type: sum
    sql: ${confirmed_new} ;;
    value_format_name: decimal_0
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
  measure: sum_confirmed_new_per_million {
    group_label: "New"
    label: "Confirmed (New) (Per Million)"
    type: sum
    sql: ${confirmed_new_per_million} ;;
    value_format_name: decimal_0
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
  measure: sum_deaths_new {
    group_label: "New"
    label: "Deaths (New)"
    type: sum
    sql: ${deaths_new} ;;
    value_format_name: decimal_0
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
  measure: sum_deaths_new_per_million {
    group_label: "New"
    label: "Deaths (New) (Per Million)"
    type: sum
    sql: ${deaths_new_per_million} ;;
    value_format_name: decimal_0
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
  measure: sum_confirmed_running_total {
    group_label: "Running Total"
    label: "Confirmed (Running Total)"
    type: sum
    sql: ${confirmed_running_total} ;;
    value_format_name: decimal_0
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
  measure: sum_confirmed_running_total_per_million {
    group_label: "Running Total"
    label: "Confirmed (Running Total) (Per Million)"
    type: sum
    sql: ${confirmed_running_total_per_million} ;;
    value_format_name: decimal_0
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

  measure: sum_deaths_running_total {
    group_label: "Running Total"
    label: "Deaths (Running Total)"
    type: sum
    sql: ${deaths_running_total} ;;
    value_format_name: decimal_0
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

  measure: sum_deaths_running_total_per_million {
    group_label: "Running Total"
    label: "Deaths (Running Total) (Per Million)"
    type: sum
    sql: ${deaths_running_total_per_million} ;;
    value_format_name: decimal_0
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

  measure: sum_doubling_time_confirmed_cases_new_per_million {
    group_label: "New"
    label: "Days to double Confirmed Cases (New)"
    type: average
    sql: ${doubling_time_confirmed_cases_new_per_million} ;;
    value_format_name: decimal_1
    html: {{rendered_value}} Day(s) ;;
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

  measure: sum_doubling_time_confirmed_cases_rolling_total_per_million {
    group_label: "Running Total"
    label: "Days to double Confirmed Cases (Rolling Total)"
    type: average
    sql: ${doubling_time_confirmed_cases_rolling_total_per_million} ;;
    value_format_name: decimal_1
    html: {{rendered_value}} Day(s) ;;
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

  measure: sum_doubling_time_deaths_new_per_million {
    group_label: "New"
    label: "Days to double Deaths (New)"
    type: average
    sql: ${doubling_time_deaths_new_per_million} ;;
    value_format_name: decimal_1
    html: {{rendered_value}} Day(s) ;;
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

  measure: sum_doubling_time_deaths_rolling_total_per_million {
    group_label: "Running Total"
    label: "Days to double Deaths (Rolling Total)"
    type: average
    sql: ${doubling_time_deaths_rolling_total_per_million} ;;
    value_format_name: decimal_1
    html: {{rendered_value}} Day(s) ;;
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
}
