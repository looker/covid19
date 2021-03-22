- dashboard: state_cases__policy_response
  preferred_viewer: dashboards-next
  title: State Cases & Policy Response
  layout: newspaper
  elements:
  - title: Confirmed Cases
    name: Confirmed Cases
    model: covid
    explore: covid_combined
    type: single_value
    fields: [covid_combined.confirmed_running_total, covid_combined.measurement_date]
    fill_fields: [covid_combined.measurement_date]
    filters:
      covid_combined.country_region: United States of America
    sorts: [covid_combined.measurement_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${covid_combined.confirmed_running_total},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: vs_prior_day, label: vs. Prior Day,
        expression: "${covid_combined.confirmed_running_total}-${yesterday}", value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [last_week, yesterday]
    series_types: {}
    y_axes: []
    listen:
      State: covid_combined.province_state
      County: covid_combined.county
    row: 5
    col: 6
    width: 6
    height: 5
  - title: Deaths
    name: Deaths
    model: covid
    explore: covid_combined
    type: single_value
    fields: [covid_combined.measurement_date, covid_combined.deaths_running_total]
    fill_fields: [covid_combined.measurement_date]
    filters:
      covid_combined.country_region: United States of America
    sorts: [covid_combined.measurement_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${covid_combined.deaths_running_total},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: vs_prior_day, label: vs. Prior Day,
        expression: "${covid_combined.deaths_running_total}-${yesterday}", value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [last_week, yesterday]
    series_types: {}
    y_axes: []
    listen:
      State: covid_combined.province_state
      County: covid_combined.county
    row: 10
    col: 4
    width: 4
    height: 4
  - title: Daily Growth Rate
    name: Daily Growth Rate
    model: covid
    explore: covid_combined
    type: single_value
    fields: [covid_combined.measurement_date, prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total]
    fill_fields: [covid_combined.measurement_date]
    filters:
      covid_combined.country_region: United States of America
    sorts: [covid_combined.measurement_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: vs_prior_day, label: vs. Prior Day,
        expression: "${prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total}-${yesterday}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [last_week, yesterday]
    series_types: {}
    y_axes: []
    listen:
      State: covid_combined.province_state
      County: covid_combined.county
    row: 10
    col: 0
    width: 4
    height: 4
  - title: Cases / ICU Beds
    name: Cases / ICU Beds
    model: covid
    explore: covid_combined
    type: single_value
    fields: [covid_combined.measurement_date, covid_combined.confirmed_cases_per_icu_beds]
    fill_fields: [covid_combined.measurement_date]
    filters:
      covid_combined.country_region: United States of America
    sorts: [covid_combined.measurement_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${covid_combined.confirmed_cases_per_icu_beds},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: vs_prior_day, label: vs. Prior Day,
        expression: "${covid_combined.confirmed_cases_per_icu_beds}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [last_week, yesterday]
    series_types: {}
    y_axes: []
    listen:
      State: covid_combined.province_state
      County: covid_combined.county
    row: 10
    col: 8
    width: 4
    height: 4
  - title: Confirmed Cases
    name: Confirmed Cases (2)
    model: covid
    explore: covid_combined
    type: looker_map
    fields: [covid_combined.fips, covid_combined.confirmed_running_total]
    filters:
      covid_combined.country_region: United States of America
    sorts: [covid_combined.confirmed_running_total desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${covid_combined.confirmed_running_total},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: vs_yesterday,
        label: vs. Yesterday, expression: "${covid_combined.confirmed_running_total}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map: topojson
    map_projection: ''
    colors: ["#5a30c2"]
    quantize_colors: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [last_week]
    series_types: {}
    y_axes: []
    listen:
      State: covid_combined.province_state
      County: covid_combined.county
    row: 5
    col: 12
    width: 6
    height: 9
  - title: Daily Growth Rate
    name: Daily Growth Rate (2)
    model: covid
    explore: covid_combined
    type: looker_map
    fields: [prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total,
      covid_combined.fips]
    filters:
      covid_combined.country_region: United States of America
      covid_combined.is_max_date: 'Yes'
    sorts: [prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total
        desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${covid_combined.confirmed_running_total},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: vs_yesterday,
        label: vs. Yesterday, expression: "${covid_combined.confirmed_running_total}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map: usa
    map_projection: ''
    quantize_colors: false
    colors: ["#5a30c2"]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [last_week]
    series_types: {}
    y_axes: []
    listen:
      State: covid_combined.province_state
      County: covid_combined.county
    row: 5
    col: 18
    width: 6
    height: 9
  - title: Current Summary
    name: Current Summary
    model: covid
    explore: covid_combined
    type: looker_grid
    fields: [covid_combined.county, covid_combined.confirmed_cases_per_icu_beds, covid_combined.confirmed_cases_per_licensed_beds,
      covid_combined.confirmed_running_total, covid_combined.deaths_running_total,
      covid_combined.confirmed_running_total_per_million]
    filters:
      covid_combined.country_region: United States of America
    sorts: [covid_combined.confirmed_cases_per_icu_beds desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: covid
      palette_id: covid-categorical-0
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total: Confirmed
        Growth
      prior_days_cases_covid.seven_day_average_change_rate_deaths_running_total: Death
        Growth
      covid_combined.confirmed_new: New Cases
      covid_combined.confirmed_cases_per_icu_beds: Cases / ICU Bed
      covid_combined.confirmed_cases_per_licensed_beds: Cases / Licensed Bed
      covid_combined.confirmed_running_total: Confirmed
      covid_combined.deaths_running_total: Deaths
      covid_combined.confirmed_running_total_per_million: Cases / Mil
    series_cell_visualizations:
      covid_combined.confirmed_running_total:
        is_active: false
      prior_days_cases_covid.seven_day_average_change_rate_deaths_running_total:
        is_active: false
      covid_combined.deaths_running_total:
        is_active: false
      covid_combined.confirmed_cases_per_icu_beds:
        is_active: true
      covid_combined.confirmed_cases_per_licensed_beds:
        is_active: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    legend_position: center
    colors: ["#5a30c2"]
    series_types: {}
    point_style: none
    series_colors: {}
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    map: world
    map_projection: ''
    quantize_colors: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [last_week]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    y_axes: []
    listen:
      State: covid_combined.province_state
      County: covid_combined.county
    row: 14
    col: 12
    width: 12
    height: 9
  - title: State Mandates
    name: State Mandates
    model: covid
    explore: covid_combined
    type: looker_single_record
    fields: [covid_combined.province_state, policies_by_state.non_essential_business_closures,
      policies_by_state.large_gatherings_ban, policies_by_state.bar_restaurant_limits,
      policies_by_state.paid_sick_leave, policies_by_state.section_1135_waiver]
    filters:
      covid_combined.country_region: United States of America
    sorts: [covid_combined.province_state]
    limit: 500
    column_limit: 50
    show_view_names: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [last_week, policies_by_state.section_1135_waiver]
    series_types: {}
    y_axes: []
    listen:
      State: covid_combined.province_state
      County: covid_combined.county
    row: 5
    col: 0
    width: 6
    height: 5
  - title: Confirmed Cases by County
    name: Confirmed Cases by County
    model: covid
    explore: covid_combined
    type: looker_column
    fields: [covid_combined.measurement_date, covid_combined.county_top_x, covid_combined.confirmed_running_total_no_drill]
    pivots: [covid_combined.county_top_x]
    fill_fields: [covid_combined.measurement_date]
    filters:
      covid_combined.country_region: United States of America
      covid_combined.days_since_max_date: "[-20, 0]"
      covid_combined.show_top_x_values: '5'
    sorts: [covid_combined.measurement_date, covid_combined.county_top_x]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: covid
      palette_id: covid-categorical-0
      options:
        steps: 5
    y_axes: [{label: Confirmed Cases, orientation: left, series: [{axisId: " Other\
              \ -  Other - covid_combined.confirmed_running_total_no_drill",
            id: " Other -  Other - covid_combined.confirmed_running_total_no_drill",
            name: " Other"}, {axisId: " Other - California - covid_combined.confirmed_running_total_no_drill",
            id: " Other - California - covid_combined.confirmed_running_total_no_drill",
            name: " Other"}, {axisId: " Other - Michigan - covid_combined.confirmed_running_total_no_drill",
            id: " Other - Michigan - covid_combined.confirmed_running_total_no_drill",
            name: " Other"}, {axisId: " Other - New Jersey - covid_combined.confirmed_running_total_no_drill",
            id: " Other - New Jersey - covid_combined.confirmed_running_total_no_drill",
            name: " Other"}, {axisId: " Other - New York - covid_combined.confirmed_running_total_no_drill",
            id: " Other - New York - covid_combined.confirmed_running_total_no_drill",
            name: " Other"}, {axisId: " Other - Washington - covid_combined.confirmed_running_total_no_drill",
            id: " Other - Washington - covid_combined.confirmed_running_total_no_drill",
            name: " Other"}, {axisId: Cook -  Other - covid_combined.confirmed_running_total_no_drill,
            id: Cook -  Other - covid_combined.confirmed_running_total_no_drill,
            name: Cook}, {axisId: Nassau - New York - covid_combined.confirmed_running_total_no_drill,
            id: Nassau - New York - covid_combined.confirmed_running_total_no_drill,
            name: Nassau}, {axisId: New York City - New York - covid_combined.confirmed_running_total_no_drill,
            id: New York City - New York - covid_combined.confirmed_running_total_no_drill,
            name: New York City}, {axisId: Suffolk - New York - covid_combined.confirmed_running_total_no_drill,
            id: Suffolk - New York - covid_combined.confirmed_running_total_no_drill,
            name: Suffolk}, {axisId: Westchester - New York - covid_combined.confirmed_running_total_no_drill,
            id: Westchester - New York - covid_combined.confirmed_running_total_no_drill,
            name: Westchester}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    hidden_series: []
    colors: ["#5a30c2"]
    series_types: {}
    series_colors: {}
    show_null_points: true
    interpolation: linear
    map: usa
    map_projection: ''
    quantize_colors: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: [last_week]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    listen:
      State: covid_combined.province_state
      County: covid_combined.county
    row: 14
    col: 0
    width: 12
    height: 9
  - name: ''
    type: text
    title_text: ''
    subtitle_text: <div style="color:black">COVID-19 State Level</div>
    body_text: |-
      <div style="color:black"><br />
      <small><center><strong>This information is provided for informational purposes only.</strong></center> <center>We make our best effort to keep data accurate and up to date. If you have questions about the data, please contact the data source identified in the menu of each tile. If you have questions or feedback on the underlying Looker model, please email looker-covid-data-block@google.com </center></small></div>
    row: 0
    col: 0
    width: 24
    height: 5
  filters:
  - name: State
    title: State
    type: field_filter
    default_value: New York
    allow_multiple_values: true
    required: false
    model: covid
    explore: covid_combined
    listens_to_filters: [Region]
    field: covid_combined.province_state
  - name: County
    title: County
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: covid
    explore: covid_combined
    listens_to_filters: [State]
    field: covid_combined.county
