#### Compare Geographies ####

explore: kpis_by_entity_by_date_core {
  from: kpis_by_entity_by_date
  extension: required
  description: "This is a simplified explore, based only on JHU / NYT data, that can be used to compare different geographies with each other"
  group_label: "COVID 19"
  label: "COVID Apps - Compare Geographies"
  view_label: " COVID19"
  sql_always_where:
          {% if kpis_by_entity_by_date.days_since_first_outbreaks._in_query %} ${days_since_first_outbreaks} > 0
          {% else %}  1 = 1
          {% endif %}
  ;;
}
