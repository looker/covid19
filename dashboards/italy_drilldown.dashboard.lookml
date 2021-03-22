- dashboard: italy_drilldown
  preferred_viewer: dashboards-next
  title: Italy Drilldown
  layout: newspaper
  elements:
  - title: Status of Current Confirmed Patients
    name: Status of Current Confirmed Patients
    model: covid
    explore: italy
    type: looker_column
    fields: [italy.icu, italy.home_quarantine, italy.currently_hospitalized, italy.region]
    sorts: [italy.icu desc]
    limit: 500
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: left
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: asc
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
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
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 14
    col: 0
    width: 24
    height: 9
  - title: Total Cases by Province (per thousand inhabitants)
    name: Total Cases by Province (per thousand inhabitants)
    model: covid
    explore: italy
    type: looker_map
    fields: [italy_province.total_cases_pp, italy_province.province]
    sorts: [italy_province.total_cases_pp desc]
    limit: 500
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.7
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
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
    map_latitude: 42.147114459221015
    map_longitude: 11.546630859375
    map_zoom: 5
    map_value_colors: ["#ffffff", "#5a30c2"]
    map_value_scale_clamp_min: 0
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 4
    col: 0
    width: 12
    height: 10
  - title: Deaths by Region (per thousand inhabitants)
    name: Deaths by Region (per thousand inhabitants)
    model: covid
    explore: italy
    type: looker_map
    fields: [italy.total_deceased_pp, italy.deceased, italy.region]
    sorts: [italy.total_deceased_pp desc]
    limit: 500
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.7
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
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
    map_latitude: 42.147114459221015
    map_longitude: 11.546630859375
    map_zoom: 5
    map_value_colors: ["#ffffff", "#5a30c2"]
    map_value_scale_clamp_min: 0
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 4
    col: 12
    width: 12
    height: 10
  - title: Daily Growth Rate by Province
    name: Daily Growth Rate by Province
    model: covid
    explore: italy
    type: looker_grid
    fields: [italy.reporting_date, italy_province.total_cases, italy.new_cases, italy_province.province]
    pivots: [italy_province.province]
    fill_fields: [italy.reporting_date]
    filters:
      italy.reporting_date: after 21 days ago
    sorts: [italy.reporting_date desc, italy_province.province]
    limit: 30
    column_limit: 500
    dynamic_fields: [{table_calculation: growth_from_previous_day, label: Growth from
          Previous Day, expression: "${italy_province.total_cases}/\n(${italy_province.total_cases}-${italy.new_cases})-1",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: calculation, label: "'", expression: "(7\
          \ * ${growth_from_previous_day} +\n  6 * offset(${growth_from_previous_day},\
          \ 1) +\n  5 * offset(${growth_from_previous_day}, 2) +\n  4 * offset(${growth_from_previous_day},\
          \ 3) +\n  3 * offset(${growth_from_previous_day}, 4) +\n  2 * offset(${growth_from_previous_day},\
          \ 5) +\n  offset(${growth_from_previous_day}, 6))/28\n  \n  ", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: true
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: true
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_column_widths:
      italy_province.nome_pro: 106
      measure_italy_province.nome_pro: 154
      measure: 50
      '2020-04-11': 115
      '2020-04-10': 115
      '2020-04-09': 115
      '2020-04-08': 115
      '2020-04-07': 115
      '2020-04-06': 115
      '2020-04-05': 115
      '2020-04-04': 115
      '2020-04-03': 115
      '2020-04-02': 115
      '2020-04-01': 115
      '2020-03-31': 115
      '2020-03-30': 115
      '2020-03-29': 115
      measure_italy_province.province: 150
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#5a30c2",
        font_color: !!null '', color_application: {collection_id: covid, custom: {
            id: 3fcb68c2-45a6-4b2c-2ec7-16a900a784d7, label: Custom, type: continuous,
            stops: [{color: "#f83f65", offset: 0}, {color: "#FFFFFF", offset: 100}]},
          options: {steps: 5, constraints: {min: {type: number, value: 0}, mid: {
                type: number, value: 0.1}, max: {type: maximum}}, mirror: false, reverse: true,
            stepped: false}}, bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
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
    map_latitude: 45.28068450114256
    map_longitude: 7.632751464843751
    map_zoom: 8
    map_value_scale_clamp_max: 1
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
    series_types: {}
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [italy_province.total_cases, italy.new_cases, growth_from_previous_day]
    y_axes: []
    column_order: {}
    listen: {}
    row: 32
    col: 0
    width: 24
    height: 46
  - title: Daily Tests per 1,000 Inhabitants
    name: Daily Tests per 1,000 Inhabitants
    model: covid
    explore: italy
    type: looker_column
    fields: [italy.reporting_date, italy.new_tests, italy.population, italy.region]
    pivots: [italy.region]
    fill_fields: [italy.reporting_date]
    filters:
      italy.reporting_date: after 30 days ago
    sorts: [italy.reporting_date desc, italy.region]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: tests_run_per_1000_inhabitants, label: 'Tests
          run per 1,000 inhabitants', expression: '1000*${italy.new_tests}/${italy.population}',
        value_format: !!null '', value_format_name: decimal_1, _kind_hint: measure,
        _type_hint: number}, {measure: count_of_reporting_date, based_on: italy.reporting_date,
        type: count_distinct, label: Count of Reporting Date, expression: !!null '',
        _kind_hint: measure, _type_hint: number}]
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
    hidden_series: []
    series_types: {}
    show_null_points: true
    interpolation: linear
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
    defaults_version: 1
    hidden_fields: [italy.population, italy.new_tests]
    y_axes: []
    listen: {}
    row: 23
    col: 0
    width: 24
    height: 9
  - name: ''
    type: text
    title_text: ''
    subtitle_text: <div style="color:black">COVID-19 Italy</div>
    body_text: |-
      <div style="color:black"><br />
      <small><center><strong>This information is provided for informational purposes only.</strong></center> <center>We make our best effort to keep data accurate and up to date. If you have questions about the data, please contact the data source identified in the menu of each tile. If you have questions or feedback on the underlying Looker model, please email looker-covid-data-block@google.com </center></small></div>
    row: 0
    col: 0
    width: 24
    height: 4
