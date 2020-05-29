- dashboard: us_state_dashboard
  title: US State Dashboard
  layout: newspaper
  elements:
  - title: Workplace Time vs. Baseline
    name: Workplace Time vs Baseline
    model: covid
    explore: mobility
    type: looker_map
    fields: [mobility.workplaces_dynamic, mobility.sub_region_1]
    filters:
      mobility.geography_level: '1'
      mobility.country_region: United States
    sorts: [mobility.sub_region_1]
    limit: 500
    column_limit: 50
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
    reverse_map_value_colors: true
    map_latitude: 52.04869010664421
    map_longitude: -102.74414062500001
    map_zoom: 3
    map_value_colors: ["#f1eef6", "#045a8d"]
    defaults_version: 1
    series_types: {}
    listen:
      Moving Avg or Daily: mobility.daily_or_avg
    row: 5
    col: 0
    width: 11
    height: 9
  - title: Residential Time vs. Baseline
    name: Residential Time vs Baseline
    model: covid
    explore: mobility
    type: looker_map
    fields: [mobility.sub_region_1, mobility.residential_dynamic]
    filters:
      mobility.country_region_code: US
      mobility.geography_level: '1'
    sorts: [mobility.residential_dynamic desc]
    limit: 500
    column_limit: 50
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
    map_latitude: 53.0143701518044
    map_longitude: -100.30586242675783
    map_zoom: 3
    map_value_colors: ["#feedde", "#a63603"]
    defaults_version: 1
    series_types: {}
    listen:
      Moving Avg or Daily: mobility.daily_or_avg
    row: 5
    col: 11
    width: 13
    height: 9
  - title: Grocery and Pharmacy
    name: Grocery and Pharmacy
    model: covid
    explore: mobility
    type: looker_line
    fields: [mobility.sub_region_1, mobility.mobility_date, mobility.grocery_and_pharmacy_dynamic]
    pivots: [mobility.sub_region_1]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '1'
      mobility.country_region: United States
    sorts: [mobility.mobility_date desc, mobility.sub_region_1]
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
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: mobility_dev.grocery_and_pharmacy_7_day_moving_avg,
            id: mobility_dev.grocery_and_pharmacy_7_day_moving_avg, name: Grocery
              and Pharmacy (7-Day Moving Avg)}], showLabels: false, showValues: true,
        maxValue: 0.5, minValue: -0.75, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_types: {}
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#000000",
        label: Baseline, line_value: '0'}]
    trend_lines: []
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.7
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_latitude: 42.18350433370498
    map_longitude: -76.17293357849123
    map_zoom: 6
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
    map_value_colors: ["#feedde", "#a63603"]
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    listen:
      2 - State, Province, or Similar: mobility.sub_region_1
      Moving Avg or Daily: mobility.daily_or_avg
    row: 14
    col: 0
    width: 8
    height: 7
  - title: Parks
    name: Parks
    model: covid
    explore: mobility
    type: looker_line
    fields: [mobility.sub_region_1, mobility.mobility_date, mobility.parks_dynamic]
    pivots: [mobility.sub_region_1]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.country_region_code: US
      mobility.geography_level: '1'
    sorts: [mobility.mobility_date desc, mobility.sub_region_1]
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
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: mobility_dev.parks_7_day_moving_avg,
            id: mobility_dev.parks_7_day_moving_avg, name: Parks (7-Day Moving Avg)}],
        showLabels: false, showValues: true, maxValue: 0.5, minValue: -0.75, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      mobility_dev.parks_7_day_moving_avg: "#10C871"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#000000",
        line_value: '0', label: Baseline}]
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.7
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_latitude: 42.18350433370498
    map_longitude: -76.17293357849123
    map_zoom: 6
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
    map_value_colors: ["#feedde", "#a63603"]
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    listen:
      2 - State, Province, or Similar: mobility.sub_region_1
      Moving Avg or Daily: mobility.daily_or_avg
    row: 14
    col: 8
    width: 8
    height: 7
  - title: Residential
    name: Residential
    model: covid
    explore: mobility
    type: looker_line
    fields: [mobility.sub_region_1, mobility.mobility_date, mobility.residential_dynamic]
    pivots: [mobility.sub_region_1]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '1'
      mobility.country_region_code: US
    sorts: [mobility.mobility_date desc, mobility.sub_region_1]
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
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: mobility_dev.residential_7_cay_moving_avg,
            id: mobility_dev.residential_7_cay_moving_avg, name: Residential (7-Day
              Moving Avg)}], showLabels: false, showValues: true, maxValue: 0.5, minValue: -0.75,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      mobility_dev.parks_7_day_moving_avg: "#7CC8FA"
      mobility_dev.residential_7_cay_moving_avg: "#FD9577"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#000000",
        line_value: '0', label: Baseline}]
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.7
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_latitude: 42.18350433370498
    map_longitude: -76.17293357849123
    map_zoom: 6
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
    map_value_colors: ["#feedde", "#a63603"]
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    listen:
      2 - State, Province, or Similar: mobility.sub_region_1
      Moving Avg or Daily: mobility.daily_or_avg
    row: 21
    col: 16
    width: 8
    height: 7
  - title: Retail and Recreation
    name: Retail and Recreation
    model: covid
    explore: mobility
    type: looker_line
    fields: [mobility.retail_and_recreation_dynamic, mobility.sub_region_1, mobility.mobility_date]
    pivots: [mobility.sub_region_1]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '1'
    sorts: [mobility.mobility_date desc, mobility.sub_region_1]
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
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: mobility.retail_and_recreation_dynamic,
            id: Aargau - mobility.retail_and_recreation_dynamic, name: Aargau}, {
            axisId: mobility.retail_and_recreation_dynamic, id: Aberdeen City - mobility.retail_and_recreation_dynamic,
            name: Aberdeen City}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Aberdeenshire - mobility.retail_and_recreation_dynamic, name: Aberdeenshire},
          {axisId: mobility.retail_and_recreation_dynamic, id: Abia - mobility.retail_and_recreation_dynamic,
            name: Abia}, {axisId: mobility.retail_and_recreation_dynamic, id: Abidjan
              Autonomous District - mobility.retail_and_recreation_dynamic, name: Abidjan
              Autonomous District}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Abruzzo - mobility.retail_and_recreation_dynamic, name: Abruzzo},
          {axisId: mobility.retail_and_recreation_dynamic, id: Abu Dhabi - mobility.retail_and_recreation_dynamic,
            name: Abu Dhabi}, {axisId: mobility.retail_and_recreation_dynamic, id: Aceh
              - mobility.retail_and_recreation_dynamic, name: Aceh}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Ad Dakhiliyah ‍Governorate - mobility.retail_and_recreation_dynamic,
            name: Ad Dakhiliyah ‍Governorate}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Ad Dhahirah Governorate - mobility.retail_and_recreation_dynamic,
            name: Ad Dhahirah Governorate}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Adamawa - mobility.retail_and_recreation_dynamic, name: Adamawa},
          {axisId: mobility.retail_and_recreation_dynamic, id: Adana - mobility.retail_and_recreation_dynamic,
            name: Adana}, {axisId: mobility.retail_and_recreation_dynamic, id: Adıyaman
              - mobility.retail_and_recreation_dynamic, name: Adıyaman}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Adjuntas - mobility.retail_and_recreation_dynamic, name: Adjuntas},
          {axisId: mobility.retail_and_recreation_dynamic, id: Administrative unit
              Maribor - mobility.retail_and_recreation_dynamic, name: Administrative
              unit Maribor}, {axisId: mobility.retail_and_recreation_dynamic, id: Afyonkarahisar
              - mobility.retail_and_recreation_dynamic, name: Afyonkarahisar}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Agadez Region - mobility.retail_and_recreation_dynamic, name: Agadez
              Region}, {axisId: mobility.retail_and_recreation_dynamic, id: Agder
              - mobility.retail_and_recreation_dynamic, name: Agder}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Aguada - mobility.retail_and_recreation_dynamic, name: Aguada}, {
            axisId: mobility.retail_and_recreation_dynamic, id: Aguadilla - mobility.retail_and_recreation_dynamic,
            name: Aguadilla}, {axisId: mobility.retail_and_recreation_dynamic, id: Aguas
              Buenas - mobility.retail_and_recreation_dynamic, name: Aguas Buenas},
          {axisId: mobility.retail_and_recreation_dynamic, id: Aguascalientes - mobility.retail_and_recreation_dynamic,
            name: Aguascalientes}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Ahuachapán Department - mobility.retail_and_recreation_dynamic, name: Ahuachapán
              Department}, {axisId: mobility.retail_and_recreation_dynamic, id: Aibonito
              - mobility.retail_and_recreation_dynamic, name: Aibonito}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Aichi - mobility.retail_and_recreation_dynamic, name: Aichi}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Aizkraukle Municipality - mobility.retail_and_recreation_dynamic,
            name: Aizkraukle Municipality}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Ajdovščina - mobility.retail_and_recreation_dynamic, name: Ajdovščina},
          {axisId: mobility.retail_and_recreation_dynamic, id: Ajloun Governorate
              - mobility.retail_and_recreation_dynamic, name: Ajloun Governorate},
          {axisId: mobility.retail_and_recreation_dynamic, id: Ajman - mobility.retail_and_recreation_dynamic,
            name: Ajman}, {axisId: mobility.retail_and_recreation_dynamic, id: Akita
              - mobility.retail_and_recreation_dynamic, name: Akita}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Akkar Governorate - mobility.retail_and_recreation_dynamic, name: Akkar
              Governorate}, {axisId: mobility.retail_and_recreation_dynamic, id: Aksaray
              - mobility.retail_and_recreation_dynamic, name: Aksaray}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Akwa Ibom - mobility.retail_and_recreation_dynamic, name: Akwa Ibom},
          {axisId: mobility.retail_and_recreation_dynamic, id: Al Ahmadi Governorate
              - mobility.retail_and_recreation_dynamic, name: Al Ahmadi Governorate},
          {axisId: mobility.retail_and_recreation_dynamic, id: Al Asimah Governate
              - mobility.retail_and_recreation_dynamic, name: Al Asimah Governate},
          {axisId: mobility.retail_and_recreation_dynamic, id: Al Bahah Province -
              mobility.retail_and_recreation_dynamic, name: Al Bahah Province}, {
            axisId: mobility.retail_and_recreation_dynamic, id: Al Batinah North Governorate
              - mobility.retail_and_recreation_dynamic, name: Al Batinah North Governorate},
          {axisId: mobility.retail_and_recreation_dynamic, id: Al Batinah South Governorate
              - mobility.retail_and_recreation_dynamic, name: Al Batinah South Governorate},
          {axisId: mobility.retail_and_recreation_dynamic, id: Al Buraymi Governorate
              - mobility.retail_and_recreation_dynamic, name: Al Buraymi Governorate},
          {axisId: mobility.retail_and_recreation_dynamic, id: Al Farwaniyah Governorate
              - mobility.retail_and_recreation_dynamic, name: Al Farwaniyah Governorate},
          {axisId: mobility.retail_and_recreation_dynamic, id: Al Jahra Governorate
              - mobility.retail_and_recreation_dynamic, name: Al Jahra Governorate},
          {axisId: mobility.retail_and_recreation_dynamic, id: Al Jowf - mobility.retail_and_recreation_dynamic,
            name: Al Jowf}, {axisId: mobility.retail_and_recreation_dynamic, id: Al
              Madinah Province - mobility.retail_and_recreation_dynamic, name: Al
              Madinah Province}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Al Qalyubia Governorate - mobility.retail_and_recreation_dynamic,
            name: Al Qalyubia Governorate}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Al Qassim - mobility.retail_and_recreation_dynamic, name: Al Qassim},
          {axisId: mobility.retail_and_recreation_dynamic, id: Al Wahat District -
              mobility.retail_and_recreation_dynamic, name: Al Wahat District}, {
            axisId: mobility.retail_and_recreation_dynamic, id: Al Wusta Governorate
              - mobility.retail_and_recreation_dynamic, name: Al Wusta Governorate},
          {axisId: mobility.retail_and_recreation_dynamic, id: Alabama - mobility.retail_and_recreation_dynamic,
            name: Alabama}, {axisId: mobility.retail_and_recreation_dynamic, id: Alaska
              - mobility.retail_and_recreation_dynamic, name: Alaska}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Alba County - mobility.retail_and_recreation_dynamic, name: Alba County}],
        showLabels: false, showValues: true, maxValue: 0.5, minValue: -0.75, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      mobility_dev.parks_7_day_moving_avg: "#7CC8FA"
      mobility_dev.residential_7_cay_moving_avg: "#f56776"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#000000",
        line_value: '0', label: Baseline}]
    discontinuous_nulls: true
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.7
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_latitude: 42.18350433370498
    map_longitude: -76.17293357849123
    map_zoom: 6
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
    map_value_colors: ["#feedde", "#a63603"]
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    listen:
      2 - State, Province, or Similar: mobility.sub_region_1
      Moving Avg or Daily: mobility.daily_or_avg
    row: 14
    col: 16
    width: 8
    height: 7
  - title: Transit Stations
    name: Transit Stations
    model: covid
    explore: mobility
    type: looker_line
    fields: [mobility.sub_region_1, mobility.mobility_date, mobility.transit_stations_dynamic]
    pivots: [mobility.sub_region_1]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '1'
    sorts: [mobility.mobility_date desc, mobility.sub_region_1]
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
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: mobility_dev.transit_stations_7_day_moving_avg,
            id: mobility_dev.transit_stations_7_day_moving_avg, name: Transit Stations
              (7-Day Moving Avg)}], showLabels: false, showValues: true, maxValue: 0.5,
        minValue: -0.75, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_types: {}
    series_colors:
      mobility_dev.parks_7_day_moving_avg: "#7CC8FA"
      mobility_dev.residential_7_cay_moving_avg: "#f56776"
      mobility_dev.transit_stations_7_day_moving_avg: "#9E7FD0"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#000000",
        line_value: '0', label: Baseline}]
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.7
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_latitude: 42.18350433370498
    map_longitude: -76.17293357849123
    map_zoom: 6
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
    map_value_colors: ["#feedde", "#a63603"]
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    listen:
      2 - State, Province, or Similar: mobility.sub_region_1
      Moving Avg or Daily: mobility.daily_or_avg
    row: 21
    col: 8
    width: 8
    height: 7
  - title: Workplaces
    name: Workplaces
    model: covid
    explore: mobility
    type: looker_line
    fields: [mobility.workplaces_dynamic, mobility.mobility_date, mobility.sub_region_1]
    pivots: [mobility.sub_region_1]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '1'
      mobility.country_region_code: US
    sorts: [mobility.mobility_date desc, mobility.sub_region_1]
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
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: mobility_dev.workplaces_7_day_moving_avg,
            id: mobility_dev.workplaces_7_day_moving_avg, name: Workplaces (7-Day
              Moving Avg)}], showLabels: false, showValues: true, maxValue: 0.5, minValue: -0.75,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      mobility_dev.parks_7_day_moving_avg: "#7CC8FA"
      mobility_dev.residential_7_cay_moving_avg: "#f56776"
      mobility_dev.transit_stations_7_day_moving_avg: "#9E7FD0"
      mobility_dev.workplaces_7_day_moving_avg: "#7CC8FA"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#000000",
        line_value: '0', label: Baseline}]
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.7
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_latitude: 42.18350433370498
    map_longitude: -76.17293357849123
    map_zoom: 6
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
    map_value_colors: ["#feedde", "#a63603"]
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    listen:
      2 - State, Province, or Similar: mobility.sub_region_1
      Moving Avg or Daily: mobility.daily_or_avg
    row: 21
    col: 0
    width: 8
    height: 7
  - name: COVID-19 Community Mobility Reports
    type: text
    title_text: COVID-19 Community Mobility Reports
    subtitle_text: by Google
    body_text: |-
      These reports compare communities' mobility (as measured via anonymized cell phone location data) visiting different types of locations. Data is compared to baseline values computed as the median in the 5‑week period Jan 3 – Feb 6, 2020 by day of the week.

      Data is updated regularly, but not daily. For more information, we strongly encourage you to read [the full documentation](https://www.google.com/covid19/mobility/).
    row: 0
    col: 0
    width: 24
    height: 5
  filters:
  - name: 2 - State, Province, or Similar
    title: 2 - State, Province, or Similar
    type: field_filter
    default_value: New York,Texas,California
    allow_multiple_values: true
    required: false
    model: covid
    explore: mobility
    listens_to_filters: []
    field: mobility.sub_region_1
  - name: Moving Avg or Daily
    title: Moving Avg or Daily
    type: field_filter
    default_value: mov^_avg
    allow_multiple_values: true
    required: false
    model: covid
    explore: mobility
    listens_to_filters: []
    field: mobility.daily_or_avg
