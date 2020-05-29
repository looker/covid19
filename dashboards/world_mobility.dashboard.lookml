- dashboard: country_dashboard
  title: Country Dashboard
  layout: newspaper
  elements:
  - title: Workplace Time vs. Baseline
    name: Workplace Time vs Baseline
    model: covid
    explore: mobility
    type: looker_map
    fields: [mobility.workplaces_dynamic, mobility.country_region_code]
    filters:
      mobility.geography_level: '0'
    sorts: [mobility.workplaces_dynamic desc]
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
    map_latitude: 35.82226734114512
    map_longitude: -9.538879394531252
    map_zoom: 1
    map_value_colors: ["#f1eef6", "#045a8d"]
    defaults_version: 1
    series_types: {}
    listen:
      Moving Avg or Daily: mobility.daily_or_avg
    row: 5
    col: 1
    width: 9
    height: 9
  - title: Residential Time vs. Baseline
    name: Residential Time vs Baseline
    model: covid
    explore: mobility
    type: looker_map
    fields: [mobility.residential_dynamic, mobility.country_region_code]
    filters:
      mobility.geography_level: '0'
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
    map_latitude: 47.517200697839414
    map_longitude: 27.773437500000004
    map_zoom: 1
    map_value_colors: ["#feedde", "#a63603"]
    defaults_version: 1
    series_types: {}
    listen:
      Moving Avg or Daily: mobility.daily_or_avg
    row: 5
    col: 13
    width: 9
    height: 9
  - title: Grocery and Pharmacy
    name: Grocery and Pharmacy
    model: covid
    explore: mobility
    type: looker_line
    fields: [mobility.mobility_date, mobility.grocery_and_pharmacy_dynamic, mobility.country_region_code]
    pivots: [mobility.country_region_code]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '0'
    sorts: [mobility.mobility_date desc]
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
      Country: mobility.country_region
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
    fields: [mobility.mobility_date, mobility.parks_dynamic, mobility.country_region_code]
    pivots: [mobility.country_region_code]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '0'
    sorts: [mobility.mobility_date desc, mobility.country_region_code]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: mobility.parks_dynamic,
            id: AE - United Arab Emirates - mobility.parks_dynamic, name: AE}, {axisId: mobility.parks_dynamic,
            id: AF - Afghanistan - mobility.parks_dynamic, name: AF}, {axisId: mobility.parks_dynamic,
            id: AG - Antigua and Barbuda - mobility.parks_dynamic, name: AG}, {axisId: mobility.parks_dynamic,
            id: AO - Angola - mobility.parks_dynamic, name: AO}, {axisId: mobility.parks_dynamic,
            id: AR - Argentina - mobility.parks_dynamic, name: AR}, {axisId: mobility.parks_dynamic,
            id: AT - Austria - mobility.parks_dynamic, name: AT}, {axisId: mobility.parks_dynamic,
            id: AU - Australia - mobility.parks_dynamic, name: AU}, {axisId: mobility.parks_dynamic,
            id: AW - Aruba - mobility.parks_dynamic, name: AW}, {axisId: mobility.parks_dynamic,
            id: BA - Bosnia and Herzegovina - mobility.parks_dynamic, name: BA}, {
            axisId: mobility.parks_dynamic, id: BB - Barbados - mobility.parks_dynamic,
            name: BB}, {axisId: mobility.parks_dynamic, id: BD - Bangladesh - mobility.parks_dynamic,
            name: BD}, {axisId: mobility.parks_dynamic, id: BE - Belgium - mobility.parks_dynamic,
            name: BE}, {axisId: mobility.parks_dynamic, id: BF - Burkina Faso - mobility.parks_dynamic,
            name: BF}, {axisId: mobility.parks_dynamic, id: BG - Bulgaria - mobility.parks_dynamic,
            name: BG}, {axisId: mobility.parks_dynamic, id: BH - Bahrain - mobility.parks_dynamic,
            name: BH}, {axisId: mobility.parks_dynamic, id: BJ - Benin - mobility.parks_dynamic,
            name: BJ}, {axisId: mobility.parks_dynamic, id: BO - Bolivia - mobility.parks_dynamic,
            name: BO}, {axisId: mobility.parks_dynamic, id: BR - Brazil - mobility.parks_dynamic,
            name: BR}, {axisId: mobility.parks_dynamic, id: BS - The Bahamas - mobility.parks_dynamic,
            name: BS}, {axisId: mobility.parks_dynamic, id: BW - Botswana - mobility.parks_dynamic,
            name: BW}, {axisId: mobility.parks_dynamic, id: BY - Belarus - mobility.parks_dynamic,
            name: BY}, {axisId: mobility.parks_dynamic, id: BZ - Belize - mobility.parks_dynamic,
            name: BZ}, {axisId: mobility.parks_dynamic, id: CA - Canada - mobility.parks_dynamic,
            name: CA}, {axisId: mobility.parks_dynamic, id: CH - Switzerland - mobility.parks_dynamic,
            name: CH}, {axisId: mobility.parks_dynamic, id: CI - Côte d'Ivoire - mobility.parks_dynamic,
            name: CI}, {axisId: mobility.parks_dynamic, id: CL - Chile - mobility.parks_dynamic,
            name: CL}, {axisId: mobility.parks_dynamic, id: CM - Cameroon - mobility.parks_dynamic,
            name: CM}, {axisId: mobility.parks_dynamic, id: CO - Colombia - mobility.parks_dynamic,
            name: CO}, {axisId: mobility.parks_dynamic, id: CR - Costa Rica - mobility.parks_dynamic,
            name: CR}, {axisId: mobility.parks_dynamic, id: CV - Cape Verde - mobility.parks_dynamic,
            name: CV}, {axisId: mobility.parks_dynamic, id: CZ - Czechia - mobility.parks_dynamic,
            name: CZ}, {axisId: mobility.parks_dynamic, id: DE - Germany - mobility.parks_dynamic,
            name: DE}, {axisId: mobility.parks_dynamic, id: DK - Denmark - mobility.parks_dynamic,
            name: DK}, {axisId: mobility.parks_dynamic, id: DO - Dominican Republic
              - mobility.parks_dynamic, name: DO}, {axisId: mobility.parks_dynamic,
            id: EC - Ecuador - mobility.parks_dynamic, name: EC}, {axisId: mobility.parks_dynamic,
            id: EE - Estonia - mobility.parks_dynamic, name: EE}, {axisId: mobility.parks_dynamic,
            id: EG - Egypt - mobility.parks_dynamic, name: EG}, {axisId: mobility.parks_dynamic,
            id: ES - Spain - mobility.parks_dynamic, name: ES}, {axisId: mobility.parks_dynamic,
            id: FI - Finland - mobility.parks_dynamic, name: FI}, {axisId: mobility.parks_dynamic,
            id: FJ - Fiji - mobility.parks_dynamic, name: FJ}, {axisId: mobility.parks_dynamic,
            id: FR - France - mobility.parks_dynamic, name: FR}, {axisId: mobility.parks_dynamic,
            id: GA - Gabon - mobility.parks_dynamic, name: GA}, {axisId: mobility.parks_dynamic,
            id: GB - United Kingdom - mobility.parks_dynamic, name: GB}, {axisId: mobility.parks_dynamic,
            id: GE - Georgia - mobility.parks_dynamic, name: GE}, {axisId: mobility.parks_dynamic,
            id: GH - Ghana - mobility.parks_dynamic, name: GH}, {axisId: mobility.parks_dynamic,
            id: GR - Greece - mobility.parks_dynamic, name: GR}, {axisId: mobility.parks_dynamic,
            id: GT - Guatemala - mobility.parks_dynamic, name: GT}, {axisId: mobility.parks_dynamic,
            id: GW - Guinea-Bissau - mobility.parks_dynamic, name: GW}, {axisId: mobility.parks_dynamic,
            id: HK - Hong Kong - mobility.parks_dynamic, name: HK}, {axisId: mobility.parks_dynamic,
            id: HN - Honduras - mobility.parks_dynamic, name: HN}], showLabels: false,
        showValues: true, maxValue: !!null '', minValue: !!null '', unpinAxis: false,
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
      Country: mobility.country_region
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
    fields: [mobility.mobility_date, mobility.residential_dynamic, mobility.country_region_code]
    pivots: [mobility.country_region_code]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '0'
    sorts: [mobility.mobility_date desc, mobility.country_region_code]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: mobility.residential_dynamic,
            id: AE - United Arab Emirates - mobility.residential_dynamic, name: AE},
          {axisId: mobility.residential_dynamic, id: AF - Afghanistan - mobility.residential_dynamic,
            name: AF}, {axisId: mobility.residential_dynamic, id: AG - Antigua and
              Barbuda - mobility.residential_dynamic, name: AG}, {axisId: mobility.residential_dynamic,
            id: AO - Angola - mobility.residential_dynamic, name: AO}, {axisId: mobility.residential_dynamic,
            id: AR - Argentina - mobility.residential_dynamic, name: AR}, {axisId: mobility.residential_dynamic,
            id: AT - Austria - mobility.residential_dynamic, name: AT}, {axisId: mobility.residential_dynamic,
            id: AU - Australia - mobility.residential_dynamic, name: AU}, {axisId: mobility.residential_dynamic,
            id: AW - Aruba - mobility.residential_dynamic, name: AW}, {axisId: mobility.residential_dynamic,
            id: BA - Bosnia and Herzegovina - mobility.residential_dynamic, name: BA},
          {axisId: mobility.residential_dynamic, id: BB - Barbados - mobility.residential_dynamic,
            name: BB}, {axisId: mobility.residential_dynamic, id: BD - Bangladesh
              - mobility.residential_dynamic, name: BD}, {axisId: mobility.residential_dynamic,
            id: BE - Belgium - mobility.residential_dynamic, name: BE}, {axisId: mobility.residential_dynamic,
            id: BF - Burkina Faso - mobility.residential_dynamic, name: BF}, {axisId: mobility.residential_dynamic,
            id: BG - Bulgaria - mobility.residential_dynamic, name: BG}, {axisId: mobility.residential_dynamic,
            id: BH - Bahrain - mobility.residential_dynamic, name: BH}, {axisId: mobility.residential_dynamic,
            id: BJ - Benin - mobility.residential_dynamic, name: BJ}, {axisId: mobility.residential_dynamic,
            id: BO - Bolivia - mobility.residential_dynamic, name: BO}, {axisId: mobility.residential_dynamic,
            id: BR - Brazil - mobility.residential_dynamic, name: BR}, {axisId: mobility.residential_dynamic,
            id: BS - The Bahamas - mobility.residential_dynamic, name: BS}, {axisId: mobility.residential_dynamic,
            id: BW - Botswana - mobility.residential_dynamic, name: BW}, {axisId: mobility.residential_dynamic,
            id: BY - Belarus - mobility.residential_dynamic, name: BY}, {axisId: mobility.residential_dynamic,
            id: BZ - Belize - mobility.residential_dynamic, name: BZ}, {axisId: mobility.residential_dynamic,
            id: CA - Canada - mobility.residential_dynamic, name: CA}, {axisId: mobility.residential_dynamic,
            id: CH - Switzerland - mobility.residential_dynamic, name: CH}, {axisId: mobility.residential_dynamic,
            id: CI - Côte d'Ivoire - mobility.residential_dynamic, name: CI}, {axisId: mobility.residential_dynamic,
            id: CL - Chile - mobility.residential_dynamic, name: CL}, {axisId: mobility.residential_dynamic,
            id: CM - Cameroon - mobility.residential_dynamic, name: CM}, {axisId: mobility.residential_dynamic,
            id: CO - Colombia - mobility.residential_dynamic, name: CO}, {axisId: mobility.residential_dynamic,
            id: CR - Costa Rica - mobility.residential_dynamic, name: CR}, {axisId: mobility.residential_dynamic,
            id: CV - Cape Verde - mobility.residential_dynamic, name: CV}, {axisId: mobility.residential_dynamic,
            id: CZ - Czechia - mobility.residential_dynamic, name: CZ}, {axisId: mobility.residential_dynamic,
            id: DE - Germany - mobility.residential_dynamic, name: DE}, {axisId: mobility.residential_dynamic,
            id: DK - Denmark - mobility.residential_dynamic, name: DK}, {axisId: mobility.residential_dynamic,
            id: DO - Dominican Republic - mobility.residential_dynamic, name: DO},
          {axisId: mobility.residential_dynamic, id: EC - Ecuador - mobility.residential_dynamic,
            name: EC}, {axisId: mobility.residential_dynamic, id: EE - Estonia - mobility.residential_dynamic,
            name: EE}, {axisId: mobility.residential_dynamic, id: EG - Egypt - mobility.residential_dynamic,
            name: EG}, {axisId: mobility.residential_dynamic, id: ES - Spain - mobility.residential_dynamic,
            name: ES}, {axisId: mobility.residential_dynamic, id: FI - Finland - mobility.residential_dynamic,
            name: FI}, {axisId: mobility.residential_dynamic, id: FJ - Fiji - mobility.residential_dynamic,
            name: FJ}, {axisId: mobility.residential_dynamic, id: FR - France - mobility.residential_dynamic,
            name: FR}, {axisId: mobility.residential_dynamic, id: GA - Gabon - mobility.residential_dynamic,
            name: GA}, {axisId: mobility.residential_dynamic, id: GB - United Kingdom
              - mobility.residential_dynamic, name: GB}, {axisId: mobility.residential_dynamic,
            id: GE - Georgia - mobility.residential_dynamic, name: GE}, {axisId: mobility.residential_dynamic,
            id: GH - Ghana - mobility.residential_dynamic, name: GH}, {axisId: mobility.residential_dynamic,
            id: GR - Greece - mobility.residential_dynamic, name: GR}, {axisId: mobility.residential_dynamic,
            id: GT - Guatemala - mobility.residential_dynamic, name: GT}, {axisId: mobility.residential_dynamic,
            id: GW - Guinea-Bissau - mobility.residential_dynamic, name: GW}, {axisId: mobility.residential_dynamic,
            id: HK - Hong Kong - mobility.residential_dynamic, name: HK}, {axisId: mobility.residential_dynamic,
            id: HN - Honduras - mobility.residential_dynamic, name: HN}], showLabels: false,
        showValues: true, maxValue: !!null '', minValue: !!null '', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
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
      Country: mobility.country_region
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
    fields: [mobility.retail_and_recreation_dynamic, mobility.mobility_date, mobility.country_region_code]
    pivots: [mobility.country_region_code]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '0'
    sorts: [mobility.mobility_date desc, mobility.country_region_code]
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
            id: AE - United Arab Emirates - mobility.retail_and_recreation_dynamic,
            name: AE}, {axisId: mobility.retail_and_recreation_dynamic, id: AF - Afghanistan
              - mobility.retail_and_recreation_dynamic, name: AF}, {axisId: mobility.retail_and_recreation_dynamic,
            id: AG - Antigua and Barbuda - mobility.retail_and_recreation_dynamic,
            name: AG}, {axisId: mobility.retail_and_recreation_dynamic, id: AO - Angola
              - mobility.retail_and_recreation_dynamic, name: AO}, {axisId: mobility.retail_and_recreation_dynamic,
            id: AR - Argentina - mobility.retail_and_recreation_dynamic, name: AR},
          {axisId: mobility.retail_and_recreation_dynamic, id: AT - Austria - mobility.retail_and_recreation_dynamic,
            name: AT}, {axisId: mobility.retail_and_recreation_dynamic, id: AU - Australia
              - mobility.retail_and_recreation_dynamic, name: AU}, {axisId: mobility.retail_and_recreation_dynamic,
            id: AW - Aruba - mobility.retail_and_recreation_dynamic, name: AW}, {
            axisId: mobility.retail_and_recreation_dynamic, id: BA - Bosnia and Herzegovina
              - mobility.retail_and_recreation_dynamic, name: BA}, {axisId: mobility.retail_and_recreation_dynamic,
            id: BB - Barbados - mobility.retail_and_recreation_dynamic, name: BB},
          {axisId: mobility.retail_and_recreation_dynamic, id: BD - Bangladesh - mobility.retail_and_recreation_dynamic,
            name: BD}, {axisId: mobility.retail_and_recreation_dynamic, id: BE - Belgium
              - mobility.retail_and_recreation_dynamic, name: BE}, {axisId: mobility.retail_and_recreation_dynamic,
            id: BF - Burkina Faso - mobility.retail_and_recreation_dynamic, name: BF},
          {axisId: mobility.retail_and_recreation_dynamic, id: BG - Bulgaria - mobility.retail_and_recreation_dynamic,
            name: BG}, {axisId: mobility.retail_and_recreation_dynamic, id: BH - Bahrain
              - mobility.retail_and_recreation_dynamic, name: BH}, {axisId: mobility.retail_and_recreation_dynamic,
            id: BJ - Benin - mobility.retail_and_recreation_dynamic, name: BJ}, {
            axisId: mobility.retail_and_recreation_dynamic, id: BO - Bolivia - mobility.retail_and_recreation_dynamic,
            name: BO}, {axisId: mobility.retail_and_recreation_dynamic, id: BR - Brazil
              - mobility.retail_and_recreation_dynamic, name: BR}, {axisId: mobility.retail_and_recreation_dynamic,
            id: BS - The Bahamas - mobility.retail_and_recreation_dynamic, name: BS},
          {axisId: mobility.retail_and_recreation_dynamic, id: BW - Botswana - mobility.retail_and_recreation_dynamic,
            name: BW}, {axisId: mobility.retail_and_recreation_dynamic, id: BY - Belarus
              - mobility.retail_and_recreation_dynamic, name: BY}, {axisId: mobility.retail_and_recreation_dynamic,
            id: BZ - Belize - mobility.retail_and_recreation_dynamic, name: BZ}, {
            axisId: mobility.retail_and_recreation_dynamic, id: CA - Canada - mobility.retail_and_recreation_dynamic,
            name: CA}, {axisId: mobility.retail_and_recreation_dynamic, id: CH - Switzerland
              - mobility.retail_and_recreation_dynamic, name: CH}, {axisId: mobility.retail_and_recreation_dynamic,
            id: CI - Côte d'Ivoire - mobility.retail_and_recreation_dynamic, name: CI},
          {axisId: mobility.retail_and_recreation_dynamic, id: CL - Chile - mobility.retail_and_recreation_dynamic,
            name: CL}, {axisId: mobility.retail_and_recreation_dynamic, id: CM - Cameroon
              - mobility.retail_and_recreation_dynamic, name: CM}, {axisId: mobility.retail_and_recreation_dynamic,
            id: CO - Colombia - mobility.retail_and_recreation_dynamic, name: CO},
          {axisId: mobility.retail_and_recreation_dynamic, id: CR - Costa Rica - mobility.retail_and_recreation_dynamic,
            name: CR}, {axisId: mobility.retail_and_recreation_dynamic, id: CV - Cape
              Verde - mobility.retail_and_recreation_dynamic, name: CV}, {axisId: mobility.retail_and_recreation_dynamic,
            id: CZ - Czechia - mobility.retail_and_recreation_dynamic, name: CZ},
          {axisId: mobility.retail_and_recreation_dynamic, id: DE - Germany - mobility.retail_and_recreation_dynamic,
            name: DE}, {axisId: mobility.retail_and_recreation_dynamic, id: DK - Denmark
              - mobility.retail_and_recreation_dynamic, name: DK}, {axisId: mobility.retail_and_recreation_dynamic,
            id: DO - Dominican Republic - mobility.retail_and_recreation_dynamic,
            name: DO}, {axisId: mobility.retail_and_recreation_dynamic, id: EC - Ecuador
              - mobility.retail_and_recreation_dynamic, name: EC}, {axisId: mobility.retail_and_recreation_dynamic,
            id: EE - Estonia - mobility.retail_and_recreation_dynamic, name: EE},
          {axisId: mobility.retail_and_recreation_dynamic, id: EG - Egypt - mobility.retail_and_recreation_dynamic,
            name: EG}, {axisId: mobility.retail_and_recreation_dynamic, id: ES - Spain
              - mobility.retail_and_recreation_dynamic, name: ES}, {axisId: mobility.retail_and_recreation_dynamic,
            id: FI - Finland - mobility.retail_and_recreation_dynamic, name: FI},
          {axisId: mobility.retail_and_recreation_dynamic, id: FJ - Fiji - mobility.retail_and_recreation_dynamic,
            name: FJ}, {axisId: mobility.retail_and_recreation_dynamic, id: FR - France
              - mobility.retail_and_recreation_dynamic, name: FR}, {axisId: mobility.retail_and_recreation_dynamic,
            id: GA - Gabon - mobility.retail_and_recreation_dynamic, name: GA}, {
            axisId: mobility.retail_and_recreation_dynamic, id: GB - United Kingdom
              - mobility.retail_and_recreation_dynamic, name: GB}, {axisId: mobility.retail_and_recreation_dynamic,
            id: GE - Georgia - mobility.retail_and_recreation_dynamic, name: GE},
          {axisId: mobility.retail_and_recreation_dynamic, id: GH - Ghana - mobility.retail_and_recreation_dynamic,
            name: GH}, {axisId: mobility.retail_and_recreation_dynamic, id: GR - Greece
              - mobility.retail_and_recreation_dynamic, name: GR}, {axisId: mobility.retail_and_recreation_dynamic,
            id: GT - Guatemala - mobility.retail_and_recreation_dynamic, name: GT},
          {axisId: mobility.retail_and_recreation_dynamic, id: GW - Guinea-Bissau
              - mobility.retail_and_recreation_dynamic, name: GW}, {axisId: mobility.retail_and_recreation_dynamic,
            id: HK - Hong Kong - mobility.retail_and_recreation_dynamic, name: HK},
          {axisId: mobility.retail_and_recreation_dynamic, id: HN - Honduras - mobility.retail_and_recreation_dynamic,
            name: HN}], showLabels: false, showValues: true, maxValue: !!null '',
        minValue: !!null '', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
      Country: mobility.country_region
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
    fields: [mobility.mobility_date, mobility.transit_stations_dynamic, mobility.country_region_code]
    pivots: [mobility.country_region_code]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '0'
    sorts: [mobility.mobility_date desc, mobility.country_region_code]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: mobility.transit_stations_dynamic,
            id: AE - United Arab Emirates - mobility.transit_stations_dynamic, name: AE},
          {axisId: mobility.transit_stations_dynamic, id: AF - Afghanistan - mobility.transit_stations_dynamic,
            name: AF}, {axisId: mobility.transit_stations_dynamic, id: AG - Antigua
              and Barbuda - mobility.transit_stations_dynamic, name: AG}, {axisId: mobility.transit_stations_dynamic,
            id: AO - Angola - mobility.transit_stations_dynamic, name: AO}, {axisId: mobility.transit_stations_dynamic,
            id: AR - Argentina - mobility.transit_stations_dynamic, name: AR}, {axisId: mobility.transit_stations_dynamic,
            id: AT - Austria - mobility.transit_stations_dynamic, name: AT}, {axisId: mobility.transit_stations_dynamic,
            id: AU - Australia - mobility.transit_stations_dynamic, name: AU}, {axisId: mobility.transit_stations_dynamic,
            id: AW - Aruba - mobility.transit_stations_dynamic, name: AW}, {axisId: mobility.transit_stations_dynamic,
            id: BA - Bosnia and Herzegovina - mobility.transit_stations_dynamic, name: BA},
          {axisId: mobility.transit_stations_dynamic, id: BB - Barbados - mobility.transit_stations_dynamic,
            name: BB}, {axisId: mobility.transit_stations_dynamic, id: BD - Bangladesh
              - mobility.transit_stations_dynamic, name: BD}, {axisId: mobility.transit_stations_dynamic,
            id: BE - Belgium - mobility.transit_stations_dynamic, name: BE}, {axisId: mobility.transit_stations_dynamic,
            id: BF - Burkina Faso - mobility.transit_stations_dynamic, name: BF},
          {axisId: mobility.transit_stations_dynamic, id: BG - Bulgaria - mobility.transit_stations_dynamic,
            name: BG}, {axisId: mobility.transit_stations_dynamic, id: BH - Bahrain
              - mobility.transit_stations_dynamic, name: BH}, {axisId: mobility.transit_stations_dynamic,
            id: BJ - Benin - mobility.transit_stations_dynamic, name: BJ}, {axisId: mobility.transit_stations_dynamic,
            id: BO - Bolivia - mobility.transit_stations_dynamic, name: BO}, {axisId: mobility.transit_stations_dynamic,
            id: BR - Brazil - mobility.transit_stations_dynamic, name: BR}, {axisId: mobility.transit_stations_dynamic,
            id: BS - The Bahamas - mobility.transit_stations_dynamic, name: BS}, {
            axisId: mobility.transit_stations_dynamic, id: BW - Botswana - mobility.transit_stations_dynamic,
            name: BW}, {axisId: mobility.transit_stations_dynamic, id: BY - Belarus
              - mobility.transit_stations_dynamic, name: BY}, {axisId: mobility.transit_stations_dynamic,
            id: BZ - Belize - mobility.transit_stations_dynamic, name: BZ}, {axisId: mobility.transit_stations_dynamic,
            id: CA - Canada - mobility.transit_stations_dynamic, name: CA}, {axisId: mobility.transit_stations_dynamic,
            id: CH - Switzerland - mobility.transit_stations_dynamic, name: CH}, {
            axisId: mobility.transit_stations_dynamic, id: CI - Côte d'Ivoire - mobility.transit_stations_dynamic,
            name: CI}, {axisId: mobility.transit_stations_dynamic, id: CL - Chile
              - mobility.transit_stations_dynamic, name: CL}, {axisId: mobility.transit_stations_dynamic,
            id: CM - Cameroon - mobility.transit_stations_dynamic, name: CM}, {axisId: mobility.transit_stations_dynamic,
            id: CO - Colombia - mobility.transit_stations_dynamic, name: CO}, {axisId: mobility.transit_stations_dynamic,
            id: CR - Costa Rica - mobility.transit_stations_dynamic, name: CR}, {
            axisId: mobility.transit_stations_dynamic, id: CV - Cape Verde - mobility.transit_stations_dynamic,
            name: CV}, {axisId: mobility.transit_stations_dynamic, id: CZ - Czechia
              - mobility.transit_stations_dynamic, name: CZ}, {axisId: mobility.transit_stations_dynamic,
            id: DE - Germany - mobility.transit_stations_dynamic, name: DE}, {axisId: mobility.transit_stations_dynamic,
            id: DK - Denmark - mobility.transit_stations_dynamic, name: DK}, {axisId: mobility.transit_stations_dynamic,
            id: DO - Dominican Republic - mobility.transit_stations_dynamic, name: DO},
          {axisId: mobility.transit_stations_dynamic, id: EC - Ecuador - mobility.transit_stations_dynamic,
            name: EC}, {axisId: mobility.transit_stations_dynamic, id: EE - Estonia
              - mobility.transit_stations_dynamic, name: EE}, {axisId: mobility.transit_stations_dynamic,
            id: EG - Egypt - mobility.transit_stations_dynamic, name: EG}, {axisId: mobility.transit_stations_dynamic,
            id: ES - Spain - mobility.transit_stations_dynamic, name: ES}, {axisId: mobility.transit_stations_dynamic,
            id: FI - Finland - mobility.transit_stations_dynamic, name: FI}, {axisId: mobility.transit_stations_dynamic,
            id: FJ - Fiji - mobility.transit_stations_dynamic, name: FJ}, {axisId: mobility.transit_stations_dynamic,
            id: FR - France - mobility.transit_stations_dynamic, name: FR}, {axisId: mobility.transit_stations_dynamic,
            id: GA - Gabon - mobility.transit_stations_dynamic, name: GA}, {axisId: mobility.transit_stations_dynamic,
            id: GB - United Kingdom - mobility.transit_stations_dynamic, name: GB},
          {axisId: mobility.transit_stations_dynamic, id: GE - Georgia - mobility.transit_stations_dynamic,
            name: GE}, {axisId: mobility.transit_stations_dynamic, id: GH - Ghana
              - mobility.transit_stations_dynamic, name: GH}, {axisId: mobility.transit_stations_dynamic,
            id: GR - Greece - mobility.transit_stations_dynamic, name: GR}, {axisId: mobility.transit_stations_dynamic,
            id: GT - Guatemala - mobility.transit_stations_dynamic, name: GT}, {axisId: mobility.transit_stations_dynamic,
            id: GW - Guinea-Bissau - mobility.transit_stations_dynamic, name: GW},
          {axisId: mobility.transit_stations_dynamic, id: HK - Hong Kong - mobility.transit_stations_dynamic,
            name: HK}, {axisId: mobility.transit_stations_dynamic, id: HN - Honduras
              - mobility.transit_stations_dynamic, name: HN}], showLabels: false,
        showValues: true, maxValue: !!null '', minValue: !!null '', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
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
      Country: mobility.country_region
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
    fields: [mobility.workplaces_dynamic, mobility.mobility_date, mobility.country_region_code]
    pivots: [mobility.country_region_code]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '0'
    sorts: [mobility.mobility_date desc, mobility.country_region_code]
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
      Country: mobility.country_region
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
  - name: Country
    title: Country
    type: field_filter
    default_value: France,Italy,United Kingdom
    allow_multiple_values: true
    required: true
    model: covid
    explore: mobility
    listens_to_filters: []
    field: mobility.country_region
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
