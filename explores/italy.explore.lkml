#### Italy ####

explore: italy_core {
  from: italy_regions
  extension: required
  description: "This explore is based off of data released from the Italian government which shows province and region level data for Italy"
  group_label: "COVID 19"


  join: italy_province {
    relationship: one_to_many
    view_label: "Italy"
    sql_on: ${italy.pk} = ${italy_province.region_fk};;
  }

  join: max_italy_date {
    relationship: one_to_one
    sql_on:  1 = 1 ;;
  }

  join: italy_region_stats {
    relationship: many_to_one
    sql_on: (${italy.region_code} = ${italy_region_stats.codice_regione} OR ${italy_region_stats.codice_regione} = 4)
      AND ${italy.region_name} = ${italy_region_stats.denominazione_regione} ;;
  }

  join: italy_province_stats {
    relationship: many_to_one
    sql_on: ${italy_province.province_abbreviation} = ${italy_province_stats.sigla_provincia} ;;
  }
}
