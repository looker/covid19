- dashboard: us_county_dashboard
  title: US County Dashboard
  layout: newspaper
  elements:
  - title: Workplace Time vs. Baseline
    name: Workplace Time vs Baseline
    model: covid
    explore: mobility
    type: looker_map
    fields: [mobility.workplaces_dynamic, mobility.sub_region_2_fips]
    filters:
      mobility.geography_level: '2'
    limit: 500
    column_limit: 50
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.7
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
    reverse_map_value_colors: true
    map_latitude: 52.04869010664421
    map_longitude: -102.74414062500001
    map_zoom: 3
    map_value_colors: ["#f1eef6", "#045a8d"]
    defaults_version: 1
    series_types: {}
    listen:
      State: mobility.sub_region_1
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
    fields: [mobility.residential_dynamic, mobility.sub_region_2_fips]
    filters:
      mobility.geography_level: '2'
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
    map_latitude: 53.0143701518044
    map_longitude: -100.30586242675783
    map_zoom: 3
    map_value_colors: ["#feedde", "#a63603"]
    defaults_version: 1
    series_types: {}
    listen:
      State: mobility.sub_region_1
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
    fields: [mobility.mobility_date, mobility.grocery_and_pharmacy_dynamic, mobility.sub_region_2]
    pivots: [mobility.sub_region_2]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '2'
    sorts: [mobility.mobility_date desc, mobility.sub_region_2]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Abbeville County - mobility.grocery_and_pharmacy_dynamic, name: Abbeville
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Acadia
              Parish - mobility.grocery_and_pharmacy_dynamic, name: Acadia Parish},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Accomack County - mobility.grocery_and_pharmacy_dynamic,
            name: Accomack County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Ada County - mobility.grocery_and_pharmacy_dynamic, name: Ada County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Adair County - mobility.grocery_and_pharmacy_dynamic,
            name: Adair County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Adams
              County - mobility.grocery_and_pharmacy_dynamic, name: Adams County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Addison County - mobility.grocery_and_pharmacy_dynamic,
            name: Addison County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Aiken County - mobility.grocery_and_pharmacy_dynamic, name: Aiken
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Aitkin
              County - mobility.grocery_and_pharmacy_dynamic, name: Aitkin County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Alachua County - mobility.grocery_and_pharmacy_dynamic,
            name: Alachua County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Alamance County - mobility.grocery_and_pharmacy_dynamic, name: Alamance
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Alameda
              County - mobility.grocery_and_pharmacy_dynamic, name: Alameda County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Alamosa County - mobility.grocery_and_pharmacy_dynamic,
            name: Alamosa County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Albany County - mobility.grocery_and_pharmacy_dynamic, name: Albany
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Albemarle
              County - mobility.grocery_and_pharmacy_dynamic, name: Albemarle County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Alcona County - mobility.grocery_and_pharmacy_dynamic,
            name: Alcona County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Alcorn County - mobility.grocery_and_pharmacy_dynamic, name: Alcorn
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Alexander
              County - mobility.grocery_and_pharmacy_dynamic, name: Alexander County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Alexandria - mobility.grocery_and_pharmacy_dynamic,
            name: Alexandria}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Alger
              County - mobility.grocery_and_pharmacy_dynamic, name: Alger County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Allamakee County - mobility.grocery_and_pharmacy_dynamic,
            name: Allamakee County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Allegan County - mobility.grocery_and_pharmacy_dynamic, name: Allegan
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Allegany
              County - mobility.grocery_and_pharmacy_dynamic, name: Allegany County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Alleghany County - mobility.grocery_and_pharmacy_dynamic,
            name: Alleghany County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Allegheny County - mobility.grocery_and_pharmacy_dynamic, name: Allegheny
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Allen County
              - mobility.grocery_and_pharmacy_dynamic, name: Allen County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Allen Parish - mobility.grocery_and_pharmacy_dynamic, name: Allen
              Parish}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Allendale
              County - mobility.grocery_and_pharmacy_dynamic, name: Allendale County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Alpena County - mobility.grocery_and_pharmacy_dynamic,
            name: Alpena County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Amador County - mobility.grocery_and_pharmacy_dynamic, name: Amador
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Amelia
              County - mobility.grocery_and_pharmacy_dynamic, name: Amelia County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Amherst County - mobility.grocery_and_pharmacy_dynamic,
            name: Amherst County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Amite County - mobility.grocery_and_pharmacy_dynamic, name: Amite
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Anchorage
              - mobility.grocery_and_pharmacy_dynamic, name: Anchorage}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Anderson County - mobility.grocery_and_pharmacy_dynamic, name: Anderson
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Andrew
              County - mobility.grocery_and_pharmacy_dynamic, name: Andrew County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Andrews County - mobility.grocery_and_pharmacy_dynamic,
            name: Andrews County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Androscoggin County - mobility.grocery_and_pharmacy_dynamic, name: Androscoggin
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Angelina
              County - mobility.grocery_and_pharmacy_dynamic, name: Angelina County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Anne Arundel County
              - mobility.grocery_and_pharmacy_dynamic, name: Anne Arundel County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Anoka County - mobility.grocery_and_pharmacy_dynamic,
            name: Anoka County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Anson
              County - mobility.grocery_and_pharmacy_dynamic, name: Anson County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Antelope County - mobility.grocery_and_pharmacy_dynamic,
            name: Antelope County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Antrim County - mobility.grocery_and_pharmacy_dynamic, name: Antrim
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Apache
              County - mobility.grocery_and_pharmacy_dynamic, name: Apache County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Appanoose County - mobility.grocery_and_pharmacy_dynamic,
            name: Appanoose County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Appling County - mobility.grocery_and_pharmacy_dynamic, name: Appling
              County}, {axisId: mobility.grocery_and_pharmacy_dynamic, id: Appomattox
              County - mobility.grocery_and_pharmacy_dynamic, name: Appomattox County},
          {axisId: mobility.grocery_and_pharmacy_dynamic, id: Aransas County - mobility.grocery_and_pharmacy_dynamic,
            name: Aransas County}, {axisId: mobility.grocery_and_pharmacy_dynamic,
            id: Arapahoe County - mobility.grocery_and_pharmacy_dynamic, name: Arapahoe
              County}], showLabels: false, showValues: true, maxValue: !!null '',
        minValue: !!null '', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
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
      State: mobility.sub_region_1
      County: mobility.sub_region_2
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
    fields: [mobility.mobility_date, mobility.parks_dynamic, mobility.sub_region_2]
    pivots: [mobility.sub_region_2]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '2'
    sorts: [mobility.mobility_date desc, mobility.sub_region_2]
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
            id: Abbeville County - mobility.parks_dynamic, name: Abbeville County},
          {axisId: mobility.parks_dynamic, id: Acadia Parish - mobility.parks_dynamic,
            name: Acadia Parish}, {axisId: mobility.parks_dynamic, id: Accomack County
              - mobility.parks_dynamic, name: Accomack County}, {axisId: mobility.parks_dynamic,
            id: Ada County - mobility.parks_dynamic, name: Ada County}, {axisId: mobility.parks_dynamic,
            id: Adair County - mobility.parks_dynamic, name: Adair County}, {axisId: mobility.parks_dynamic,
            id: Adams County - mobility.parks_dynamic, name: Adams County}, {axisId: mobility.parks_dynamic,
            id: Addison County - mobility.parks_dynamic, name: Addison County}, {
            axisId: mobility.parks_dynamic, id: Aiken County - mobility.parks_dynamic,
            name: Aiken County}, {axisId: mobility.parks_dynamic, id: Aitkin County
              - mobility.parks_dynamic, name: Aitkin County}, {axisId: mobility.parks_dynamic,
            id: Alachua County - mobility.parks_dynamic, name: Alachua County}, {
            axisId: mobility.parks_dynamic, id: Alamance County - mobility.parks_dynamic,
            name: Alamance County}, {axisId: mobility.parks_dynamic, id: Alameda County
              - mobility.parks_dynamic, name: Alameda County}, {axisId: mobility.parks_dynamic,
            id: Alamosa County - mobility.parks_dynamic, name: Alamosa County}, {
            axisId: mobility.parks_dynamic, id: Albany County - mobility.parks_dynamic,
            name: Albany County}, {axisId: mobility.parks_dynamic, id: Albemarle County
              - mobility.parks_dynamic, name: Albemarle County}, {axisId: mobility.parks_dynamic,
            id: Alcona County - mobility.parks_dynamic, name: Alcona County}, {axisId: mobility.parks_dynamic,
            id: Alcorn County - mobility.parks_dynamic, name: Alcorn County}, {axisId: mobility.parks_dynamic,
            id: Alexander County - mobility.parks_dynamic, name: Alexander County},
          {axisId: mobility.parks_dynamic, id: Alexandria - mobility.parks_dynamic,
            name: Alexandria}, {axisId: mobility.parks_dynamic, id: Alger County -
              mobility.parks_dynamic, name: Alger County}, {axisId: mobility.parks_dynamic,
            id: Allamakee County - mobility.parks_dynamic, name: Allamakee County},
          {axisId: mobility.parks_dynamic, id: Allegan County - mobility.parks_dynamic,
            name: Allegan County}, {axisId: mobility.parks_dynamic, id: Allegany County
              - mobility.parks_dynamic, name: Allegany County}, {axisId: mobility.parks_dynamic,
            id: Alleghany County - mobility.parks_dynamic, name: Alleghany County},
          {axisId: mobility.parks_dynamic, id: Allegheny County - mobility.parks_dynamic,
            name: Allegheny County}, {axisId: mobility.parks_dynamic, id: Allen County
              - mobility.parks_dynamic, name: Allen County}, {axisId: mobility.parks_dynamic,
            id: Allen Parish - mobility.parks_dynamic, name: Allen Parish}, {axisId: mobility.parks_dynamic,
            id: Allendale County - mobility.parks_dynamic, name: Allendale County},
          {axisId: mobility.parks_dynamic, id: Alpena County - mobility.parks_dynamic,
            name: Alpena County}, {axisId: mobility.parks_dynamic, id: Amador County
              - mobility.parks_dynamic, name: Amador County}, {axisId: mobility.parks_dynamic,
            id: Amelia County - mobility.parks_dynamic, name: Amelia County}, {axisId: mobility.parks_dynamic,
            id: Amherst County - mobility.parks_dynamic, name: Amherst County}, {
            axisId: mobility.parks_dynamic, id: Amite County - mobility.parks_dynamic,
            name: Amite County}, {axisId: mobility.parks_dynamic, id: Anchorage -
              mobility.parks_dynamic, name: Anchorage}, {axisId: mobility.parks_dynamic,
            id: Anderson County - mobility.parks_dynamic, name: Anderson County},
          {axisId: mobility.parks_dynamic, id: Andrew County - mobility.parks_dynamic,
            name: Andrew County}, {axisId: mobility.parks_dynamic, id: Andrews County
              - mobility.parks_dynamic, name: Andrews County}, {axisId: mobility.parks_dynamic,
            id: Androscoggin County - mobility.parks_dynamic, name: Androscoggin County},
          {axisId: mobility.parks_dynamic, id: Angelina County - mobility.parks_dynamic,
            name: Angelina County}, {axisId: mobility.parks_dynamic, id: Anne Arundel
              County - mobility.parks_dynamic, name: Anne Arundel County}, {axisId: mobility.parks_dynamic,
            id: Anoka County - mobility.parks_dynamic, name: Anoka County}, {axisId: mobility.parks_dynamic,
            id: Anson County - mobility.parks_dynamic, name: Anson County}, {axisId: mobility.parks_dynamic,
            id: Antelope County - mobility.parks_dynamic, name: Antelope County},
          {axisId: mobility.parks_dynamic, id: Antrim County - mobility.parks_dynamic,
            name: Antrim County}, {axisId: mobility.parks_dynamic, id: Apache County
              - mobility.parks_dynamic, name: Apache County}, {axisId: mobility.parks_dynamic,
            id: Appanoose County - mobility.parks_dynamic, name: Appanoose County},
          {axisId: mobility.parks_dynamic, id: Appling County - mobility.parks_dynamic,
            name: Appling County}, {axisId: mobility.parks_dynamic, id: Appomattox
              County - mobility.parks_dynamic, name: Appomattox County}, {axisId: mobility.parks_dynamic,
            id: Aransas County - mobility.parks_dynamic, name: Aransas County}, {
            axisId: mobility.parks_dynamic, id: Arapahoe County - mobility.parks_dynamic,
            name: Arapahoe County}], showLabels: false, showValues: true, maxValue: !!null '',
        minValue: !!null '', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
      State: mobility.sub_region_1
      County: mobility.sub_region_2
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
    fields: [mobility.mobility_date, mobility.residential_dynamic, mobility.sub_region_2]
    pivots: [mobility.sub_region_2]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '2'
    sorts: [mobility.mobility_date desc, mobility.sub_region_2]
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
            id: Abbeville County - mobility.residential_dynamic, name: Abbeville County},
          {axisId: mobility.residential_dynamic, id: Acadia Parish - mobility.residential_dynamic,
            name: Acadia Parish}, {axisId: mobility.residential_dynamic, id: Accomack
              County - mobility.residential_dynamic, name: Accomack County}, {axisId: mobility.residential_dynamic,
            id: Ada County - mobility.residential_dynamic, name: Ada County}, {axisId: mobility.residential_dynamic,
            id: Adair County - mobility.residential_dynamic, name: Adair County},
          {axisId: mobility.residential_dynamic, id: Adams County - mobility.residential_dynamic,
            name: Adams County}, {axisId: mobility.residential_dynamic, id: Addison
              County - mobility.residential_dynamic, name: Addison County}, {axisId: mobility.residential_dynamic,
            id: Aiken County - mobility.residential_dynamic, name: Aiken County},
          {axisId: mobility.residential_dynamic, id: Aitkin County - mobility.residential_dynamic,
            name: Aitkin County}, {axisId: mobility.residential_dynamic, id: Alachua
              County - mobility.residential_dynamic, name: Alachua County}, {axisId: mobility.residential_dynamic,
            id: Alamance County - mobility.residential_dynamic, name: Alamance County},
          {axisId: mobility.residential_dynamic, id: Alameda County - mobility.residential_dynamic,
            name: Alameda County}, {axisId: mobility.residential_dynamic, id: Alamosa
              County - mobility.residential_dynamic, name: Alamosa County}, {axisId: mobility.residential_dynamic,
            id: Albany County - mobility.residential_dynamic, name: Albany County},
          {axisId: mobility.residential_dynamic, id: Albemarle County - mobility.residential_dynamic,
            name: Albemarle County}, {axisId: mobility.residential_dynamic, id: Alcona
              County - mobility.residential_dynamic, name: Alcona County}, {axisId: mobility.residential_dynamic,
            id: Alcorn County - mobility.residential_dynamic, name: Alcorn County},
          {axisId: mobility.residential_dynamic, id: Alexander County - mobility.residential_dynamic,
            name: Alexander County}, {axisId: mobility.residential_dynamic, id: Alexandria
              - mobility.residential_dynamic, name: Alexandria}, {axisId: mobility.residential_dynamic,
            id: Alger County - mobility.residential_dynamic, name: Alger County},
          {axisId: mobility.residential_dynamic, id: Allamakee County - mobility.residential_dynamic,
            name: Allamakee County}, {axisId: mobility.residential_dynamic, id: Allegan
              County - mobility.residential_dynamic, name: Allegan County}, {axisId: mobility.residential_dynamic,
            id: Allegany County - mobility.residential_dynamic, name: Allegany County},
          {axisId: mobility.residential_dynamic, id: Alleghany County - mobility.residential_dynamic,
            name: Alleghany County}, {axisId: mobility.residential_dynamic, id: Allegheny
              County - mobility.residential_dynamic, name: Allegheny County}, {axisId: mobility.residential_dynamic,
            id: Allen County - mobility.residential_dynamic, name: Allen County},
          {axisId: mobility.residential_dynamic, id: Allen Parish - mobility.residential_dynamic,
            name: Allen Parish}, {axisId: mobility.residential_dynamic, id: Allendale
              County - mobility.residential_dynamic, name: Allendale County}, {axisId: mobility.residential_dynamic,
            id: Alpena County - mobility.residential_dynamic, name: Alpena County},
          {axisId: mobility.residential_dynamic, id: Amador County - mobility.residential_dynamic,
            name: Amador County}, {axisId: mobility.residential_dynamic, id: Amelia
              County - mobility.residential_dynamic, name: Amelia County}, {axisId: mobility.residential_dynamic,
            id: Amherst County - mobility.residential_dynamic, name: Amherst County},
          {axisId: mobility.residential_dynamic, id: Amite County - mobility.residential_dynamic,
            name: Amite County}, {axisId: mobility.residential_dynamic, id: Anchorage
              - mobility.residential_dynamic, name: Anchorage}, {axisId: mobility.residential_dynamic,
            id: Anderson County - mobility.residential_dynamic, name: Anderson County},
          {axisId: mobility.residential_dynamic, id: Andrew County - mobility.residential_dynamic,
            name: Andrew County}, {axisId: mobility.residential_dynamic, id: Andrews
              County - mobility.residential_dynamic, name: Andrews County}, {axisId: mobility.residential_dynamic,
            id: Androscoggin County - mobility.residential_dynamic, name: Androscoggin
              County}, {axisId: mobility.residential_dynamic, id: Angelina County
              - mobility.residential_dynamic, name: Angelina County}, {axisId: mobility.residential_dynamic,
            id: Anne Arundel County - mobility.residential_dynamic, name: Anne Arundel
              County}, {axisId: mobility.residential_dynamic, id: Anoka County - mobility.residential_dynamic,
            name: Anoka County}, {axisId: mobility.residential_dynamic, id: Anson
              County - mobility.residential_dynamic, name: Anson County}, {axisId: mobility.residential_dynamic,
            id: Antelope County - mobility.residential_dynamic, name: Antelope County},
          {axisId: mobility.residential_dynamic, id: Antrim County - mobility.residential_dynamic,
            name: Antrim County}, {axisId: mobility.residential_dynamic, id: Apache
              County - mobility.residential_dynamic, name: Apache County}, {axisId: mobility.residential_dynamic,
            id: Appanoose County - mobility.residential_dynamic, name: Appanoose County},
          {axisId: mobility.residential_dynamic, id: Appling County - mobility.residential_dynamic,
            name: Appling County}, {axisId: mobility.residential_dynamic, id: Appomattox
              County - mobility.residential_dynamic, name: Appomattox County}, {axisId: mobility.residential_dynamic,
            id: Aransas County - mobility.residential_dynamic, name: Aransas County},
          {axisId: mobility.residential_dynamic, id: Arapahoe County - mobility.residential_dynamic,
            name: Arapahoe County}], showLabels: false, showValues: true, maxValue: !!null '',
        minValue: !!null '', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
      State: mobility.sub_region_1
      County: mobility.sub_region_2
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
    fields: [mobility.retail_and_recreation_dynamic, mobility.mobility_date, mobility.sub_region_2]
    pivots: [mobility.sub_region_2]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '2'
    sorts: [mobility.mobility_date desc, mobility.sub_region_2]
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
            id: Abbeville County - mobility.retail_and_recreation_dynamic, name: Abbeville
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Acadia
              Parish - mobility.retail_and_recreation_dynamic, name: Acadia Parish},
          {axisId: mobility.retail_and_recreation_dynamic, id: Accomack County - mobility.retail_and_recreation_dynamic,
            name: Accomack County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Ada County - mobility.retail_and_recreation_dynamic, name: Ada County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Adair County - mobility.retail_and_recreation_dynamic,
            name: Adair County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Adams County - mobility.retail_and_recreation_dynamic, name: Adams
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Addison
              County - mobility.retail_and_recreation_dynamic, name: Addison County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Aiken County - mobility.retail_and_recreation_dynamic,
            name: Aiken County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Aitkin County - mobility.retail_and_recreation_dynamic, name: Aitkin
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Alachua
              County - mobility.retail_and_recreation_dynamic, name: Alachua County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Alamance County - mobility.retail_and_recreation_dynamic,
            name: Alamance County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Alameda County - mobility.retail_and_recreation_dynamic, name: Alameda
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Alamosa
              County - mobility.retail_and_recreation_dynamic, name: Alamosa County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Albany County - mobility.retail_and_recreation_dynamic,
            name: Albany County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Albemarle County - mobility.retail_and_recreation_dynamic, name: Albemarle
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Alcona
              County - mobility.retail_and_recreation_dynamic, name: Alcona County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Alcorn County - mobility.retail_and_recreation_dynamic,
            name: Alcorn County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Alexander County - mobility.retail_and_recreation_dynamic, name: Alexander
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Alexandria
              - mobility.retail_and_recreation_dynamic, name: Alexandria}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Alger County - mobility.retail_and_recreation_dynamic, name: Alger
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Allamakee
              County - mobility.retail_and_recreation_dynamic, name: Allamakee County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Allegan County - mobility.retail_and_recreation_dynamic,
            name: Allegan County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Allegany County - mobility.retail_and_recreation_dynamic, name: Allegany
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Alleghany
              County - mobility.retail_and_recreation_dynamic, name: Alleghany County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Allegheny County -
              mobility.retail_and_recreation_dynamic, name: Allegheny County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Allen County - mobility.retail_and_recreation_dynamic, name: Allen
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Allen
              Parish - mobility.retail_and_recreation_dynamic, name: Allen Parish},
          {axisId: mobility.retail_and_recreation_dynamic, id: Allendale County -
              mobility.retail_and_recreation_dynamic, name: Allendale County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Alpena County - mobility.retail_and_recreation_dynamic, name: Alpena
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Amador
              County - mobility.retail_and_recreation_dynamic, name: Amador County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Amelia County - mobility.retail_and_recreation_dynamic,
            name: Amelia County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Amherst County - mobility.retail_and_recreation_dynamic, name: Amherst
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Amite
              County - mobility.retail_and_recreation_dynamic, name: Amite County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Anchorage - mobility.retail_and_recreation_dynamic,
            name: Anchorage}, {axisId: mobility.retail_and_recreation_dynamic, id: Anderson
              County - mobility.retail_and_recreation_dynamic, name: Anderson County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Andrew County - mobility.retail_and_recreation_dynamic,
            name: Andrew County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Andrews County - mobility.retail_and_recreation_dynamic, name: Andrews
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Androscoggin
              County - mobility.retail_and_recreation_dynamic, name: Androscoggin
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Angelina
              County - mobility.retail_and_recreation_dynamic, name: Angelina County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Anne Arundel County
              - mobility.retail_and_recreation_dynamic, name: Anne Arundel County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Anoka County - mobility.retail_and_recreation_dynamic,
            name: Anoka County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Anson County - mobility.retail_and_recreation_dynamic, name: Anson
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Antelope
              County - mobility.retail_and_recreation_dynamic, name: Antelope County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Antrim County - mobility.retail_and_recreation_dynamic,
            name: Antrim County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Apache County - mobility.retail_and_recreation_dynamic, name: Apache
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Appanoose
              County - mobility.retail_and_recreation_dynamic, name: Appanoose County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Appling County - mobility.retail_and_recreation_dynamic,
            name: Appling County}, {axisId: mobility.retail_and_recreation_dynamic,
            id: Appomattox County - mobility.retail_and_recreation_dynamic, name: Appomattox
              County}, {axisId: mobility.retail_and_recreation_dynamic, id: Aransas
              County - mobility.retail_and_recreation_dynamic, name: Aransas County},
          {axisId: mobility.retail_and_recreation_dynamic, id: Arapahoe County - mobility.retail_and_recreation_dynamic,
            name: Arapahoe County}], showLabels: false, showValues: true, maxValue: !!null '',
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
      State: mobility.sub_region_1
      County: mobility.sub_region_2
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
    fields: [mobility.mobility_date, mobility.transit_stations_dynamic, mobility.sub_region_2]
    pivots: [mobility.sub_region_2]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '2'
    sorts: [mobility.mobility_date desc, mobility.sub_region_2]
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
            id: Abbeville County - mobility.transit_stations_dynamic, name: Abbeville
              County}, {axisId: mobility.transit_stations_dynamic, id: Acadia Parish
              - mobility.transit_stations_dynamic, name: Acadia Parish}, {axisId: mobility.transit_stations_dynamic,
            id: Accomack County - mobility.transit_stations_dynamic, name: Accomack
              County}, {axisId: mobility.transit_stations_dynamic, id: Ada County
              - mobility.transit_stations_dynamic, name: Ada County}, {axisId: mobility.transit_stations_dynamic,
            id: Adair County - mobility.transit_stations_dynamic, name: Adair County},
          {axisId: mobility.transit_stations_dynamic, id: Adams County - mobility.transit_stations_dynamic,
            name: Adams County}, {axisId: mobility.transit_stations_dynamic, id: Addison
              County - mobility.transit_stations_dynamic, name: Addison County}, {
            axisId: mobility.transit_stations_dynamic, id: Aiken County - mobility.transit_stations_dynamic,
            name: Aiken County}, {axisId: mobility.transit_stations_dynamic, id: Aitkin
              County - mobility.transit_stations_dynamic, name: Aitkin County}, {
            axisId: mobility.transit_stations_dynamic, id: Alachua County - mobility.transit_stations_dynamic,
            name: Alachua County}, {axisId: mobility.transit_stations_dynamic, id: Alamance
              County - mobility.transit_stations_dynamic, name: Alamance County},
          {axisId: mobility.transit_stations_dynamic, id: Alameda County - mobility.transit_stations_dynamic,
            name: Alameda County}, {axisId: mobility.transit_stations_dynamic, id: Alamosa
              County - mobility.transit_stations_dynamic, name: Alamosa County}, {
            axisId: mobility.transit_stations_dynamic, id: Albany County - mobility.transit_stations_dynamic,
            name: Albany County}, {axisId: mobility.transit_stations_dynamic, id: Albemarle
              County - mobility.transit_stations_dynamic, name: Albemarle County},
          {axisId: mobility.transit_stations_dynamic, id: Alcona County - mobility.transit_stations_dynamic,
            name: Alcona County}, {axisId: mobility.transit_stations_dynamic, id: Alcorn
              County - mobility.transit_stations_dynamic, name: Alcorn County}, {
            axisId: mobility.transit_stations_dynamic, id: Alexander County - mobility.transit_stations_dynamic,
            name: Alexander County}, {axisId: mobility.transit_stations_dynamic, id: Alexandria
              - mobility.transit_stations_dynamic, name: Alexandria}, {axisId: mobility.transit_stations_dynamic,
            id: Alger County - mobility.transit_stations_dynamic, name: Alger County},
          {axisId: mobility.transit_stations_dynamic, id: Allamakee County - mobility.transit_stations_dynamic,
            name: Allamakee County}, {axisId: mobility.transit_stations_dynamic, id: Allegan
              County - mobility.transit_stations_dynamic, name: Allegan County}, {
            axisId: mobility.transit_stations_dynamic, id: Allegany County - mobility.transit_stations_dynamic,
            name: Allegany County}, {axisId: mobility.transit_stations_dynamic, id: Alleghany
              County - mobility.transit_stations_dynamic, name: Alleghany County},
          {axisId: mobility.transit_stations_dynamic, id: Allegheny County - mobility.transit_stations_dynamic,
            name: Allegheny County}, {axisId: mobility.transit_stations_dynamic, id: Allen
              County - mobility.transit_stations_dynamic, name: Allen County}, {axisId: mobility.transit_stations_dynamic,
            id: Allen Parish - mobility.transit_stations_dynamic, name: Allen Parish},
          {axisId: mobility.transit_stations_dynamic, id: Allendale County - mobility.transit_stations_dynamic,
            name: Allendale County}, {axisId: mobility.transit_stations_dynamic, id: Alpena
              County - mobility.transit_stations_dynamic, name: Alpena County}, {
            axisId: mobility.transit_stations_dynamic, id: Amador County - mobility.transit_stations_dynamic,
            name: Amador County}, {axisId: mobility.transit_stations_dynamic, id: Amelia
              County - mobility.transit_stations_dynamic, name: Amelia County}, {
            axisId: mobility.transit_stations_dynamic, id: Amherst County - mobility.transit_stations_dynamic,
            name: Amherst County}, {axisId: mobility.transit_stations_dynamic, id: Amite
              County - mobility.transit_stations_dynamic, name: Amite County}, {axisId: mobility.transit_stations_dynamic,
            id: Anchorage - mobility.transit_stations_dynamic, name: Anchorage}, {
            axisId: mobility.transit_stations_dynamic, id: Anderson County - mobility.transit_stations_dynamic,
            name: Anderson County}, {axisId: mobility.transit_stations_dynamic, id: Andrew
              County - mobility.transit_stations_dynamic, name: Andrew County}, {
            axisId: mobility.transit_stations_dynamic, id: Andrews County - mobility.transit_stations_dynamic,
            name: Andrews County}, {axisId: mobility.transit_stations_dynamic, id: Androscoggin
              County - mobility.transit_stations_dynamic, name: Androscoggin County},
          {axisId: mobility.transit_stations_dynamic, id: Angelina County - mobility.transit_stations_dynamic,
            name: Angelina County}, {axisId: mobility.transit_stations_dynamic, id: Anne
              Arundel County - mobility.transit_stations_dynamic, name: Anne Arundel
              County}, {axisId: mobility.transit_stations_dynamic, id: Anoka County
              - mobility.transit_stations_dynamic, name: Anoka County}, {axisId: mobility.transit_stations_dynamic,
            id: Anson County - mobility.transit_stations_dynamic, name: Anson County},
          {axisId: mobility.transit_stations_dynamic, id: Antelope County - mobility.transit_stations_dynamic,
            name: Antelope County}, {axisId: mobility.transit_stations_dynamic, id: Antrim
              County - mobility.transit_stations_dynamic, name: Antrim County}, {
            axisId: mobility.transit_stations_dynamic, id: Apache County - mobility.transit_stations_dynamic,
            name: Apache County}, {axisId: mobility.transit_stations_dynamic, id: Appanoose
              County - mobility.transit_stations_dynamic, name: Appanoose County},
          {axisId: mobility.transit_stations_dynamic, id: Appling County - mobility.transit_stations_dynamic,
            name: Appling County}, {axisId: mobility.transit_stations_dynamic, id: Appomattox
              County - mobility.transit_stations_dynamic, name: Appomattox County},
          {axisId: mobility.transit_stations_dynamic, id: Aransas County - mobility.transit_stations_dynamic,
            name: Aransas County}, {axisId: mobility.transit_stations_dynamic, id: Arapahoe
              County - mobility.transit_stations_dynamic, name: Arapahoe County}],
        showLabels: false, showValues: true, maxValue: !!null '', minValue: !!null '',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
      State: mobility.sub_region_1
      County: mobility.sub_region_2
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
    fields: [mobility.workplaces_dynamic, mobility.mobility_date, mobility.sub_region_2]
    pivots: [mobility.sub_region_2]
    fill_fields: [mobility.mobility_date]
    filters:
      mobility.geography_level: '2'
    sorts: [mobility.mobility_date desc, mobility.sub_region_2]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: mobility.workplaces_dynamic,
            id: Abbeville County - mobility.workplaces_dynamic, name: Abbeville County},
          {axisId: mobility.workplaces_dynamic, id: Acadia Parish - mobility.workplaces_dynamic,
            name: Acadia Parish}, {axisId: mobility.workplaces_dynamic, id: Accomack
              County - mobility.workplaces_dynamic, name: Accomack County}, {axisId: mobility.workplaces_dynamic,
            id: Ada County - mobility.workplaces_dynamic, name: Ada County}, {axisId: mobility.workplaces_dynamic,
            id: Adair County - mobility.workplaces_dynamic, name: Adair County}, {
            axisId: mobility.workplaces_dynamic, id: Adams County - mobility.workplaces_dynamic,
            name: Adams County}, {axisId: mobility.workplaces_dynamic, id: Addison
              County - mobility.workplaces_dynamic, name: Addison County}, {axisId: mobility.workplaces_dynamic,
            id: Aiken County - mobility.workplaces_dynamic, name: Aiken County}, {
            axisId: mobility.workplaces_dynamic, id: Aitkin County - mobility.workplaces_dynamic,
            name: Aitkin County}, {axisId: mobility.workplaces_dynamic, id: Alachua
              County - mobility.workplaces_dynamic, name: Alachua County}, {axisId: mobility.workplaces_dynamic,
            id: Alamance County - mobility.workplaces_dynamic, name: Alamance County},
          {axisId: mobility.workplaces_dynamic, id: Alameda County - mobility.workplaces_dynamic,
            name: Alameda County}, {axisId: mobility.workplaces_dynamic, id: Alamosa
              County - mobility.workplaces_dynamic, name: Alamosa County}, {axisId: mobility.workplaces_dynamic,
            id: Albany County - mobility.workplaces_dynamic, name: Albany County},
          {axisId: mobility.workplaces_dynamic, id: Albemarle County - mobility.workplaces_dynamic,
            name: Albemarle County}, {axisId: mobility.workplaces_dynamic, id: Alcona
              County - mobility.workplaces_dynamic, name: Alcona County}, {axisId: mobility.workplaces_dynamic,
            id: Alcorn County - mobility.workplaces_dynamic, name: Alcorn County},
          {axisId: mobility.workplaces_dynamic, id: Alexander County - mobility.workplaces_dynamic,
            name: Alexander County}, {axisId: mobility.workplaces_dynamic, id: Alexandria
              - mobility.workplaces_dynamic, name: Alexandria}, {axisId: mobility.workplaces_dynamic,
            id: Alger County - mobility.workplaces_dynamic, name: Alger County}, {
            axisId: mobility.workplaces_dynamic, id: Allamakee County - mobility.workplaces_dynamic,
            name: Allamakee County}, {axisId: mobility.workplaces_dynamic, id: Allegan
              County - mobility.workplaces_dynamic, name: Allegan County}, {axisId: mobility.workplaces_dynamic,
            id: Allegany County - mobility.workplaces_dynamic, name: Allegany County},
          {axisId: mobility.workplaces_dynamic, id: Alleghany County - mobility.workplaces_dynamic,
            name: Alleghany County}, {axisId: mobility.workplaces_dynamic, id: Allegheny
              County - mobility.workplaces_dynamic, name: Allegheny County}, {axisId: mobility.workplaces_dynamic,
            id: Allen County - mobility.workplaces_dynamic, name: Allen County}, {
            axisId: mobility.workplaces_dynamic, id: Allen Parish - mobility.workplaces_dynamic,
            name: Allen Parish}, {axisId: mobility.workplaces_dynamic, id: Allendale
              County - mobility.workplaces_dynamic, name: Allendale County}, {axisId: mobility.workplaces_dynamic,
            id: Alpena County - mobility.workplaces_dynamic, name: Alpena County},
          {axisId: mobility.workplaces_dynamic, id: Amador County - mobility.workplaces_dynamic,
            name: Amador County}, {axisId: mobility.workplaces_dynamic, id: Amelia
              County - mobility.workplaces_dynamic, name: Amelia County}, {axisId: mobility.workplaces_dynamic,
            id: Amherst County - mobility.workplaces_dynamic, name: Amherst County},
          {axisId: mobility.workplaces_dynamic, id: Amite County - mobility.workplaces_dynamic,
            name: Amite County}, {axisId: mobility.workplaces_dynamic, id: Anchorage
              - mobility.workplaces_dynamic, name: Anchorage}, {axisId: mobility.workplaces_dynamic,
            id: Anderson County - mobility.workplaces_dynamic, name: Anderson County},
          {axisId: mobility.workplaces_dynamic, id: Andrew County - mobility.workplaces_dynamic,
            name: Andrew County}, {axisId: mobility.workplaces_dynamic, id: Andrews
              County - mobility.workplaces_dynamic, name: Andrews County}, {axisId: mobility.workplaces_dynamic,
            id: Androscoggin County - mobility.workplaces_dynamic, name: Androscoggin
              County}, {axisId: mobility.workplaces_dynamic, id: Angelina County -
              mobility.workplaces_dynamic, name: Angelina County}, {axisId: mobility.workplaces_dynamic,
            id: Anne Arundel County - mobility.workplaces_dynamic, name: Anne Arundel
              County}, {axisId: mobility.workplaces_dynamic, id: Anoka County - mobility.workplaces_dynamic,
            name: Anoka County}, {axisId: mobility.workplaces_dynamic, id: Anson County
              - mobility.workplaces_dynamic, name: Anson County}, {axisId: mobility.workplaces_dynamic,
            id: Antelope County - mobility.workplaces_dynamic, name: Antelope County},
          {axisId: mobility.workplaces_dynamic, id: Antrim County - mobility.workplaces_dynamic,
            name: Antrim County}, {axisId: mobility.workplaces_dynamic, id: Apache
              County - mobility.workplaces_dynamic, name: Apache County}, {axisId: mobility.workplaces_dynamic,
            id: Appanoose County - mobility.workplaces_dynamic, name: Appanoose County},
          {axisId: mobility.workplaces_dynamic, id: Appling County - mobility.workplaces_dynamic,
            name: Appling County}, {axisId: mobility.workplaces_dynamic, id: Appomattox
              County - mobility.workplaces_dynamic, name: Appomattox County}, {axisId: mobility.workplaces_dynamic,
            id: Aransas County - mobility.workplaces_dynamic, name: Aransas County},
          {axisId: mobility.workplaces_dynamic, id: Arapahoe County - mobility.workplaces_dynamic,
            name: Arapahoe County}], showLabels: false, showValues: true, maxValue: !!null '',
        minValue: !!null '', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
      State: mobility.sub_region_1
      County: mobility.sub_region_2
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
  - name: State
    title: State
    type: field_filter
    default_value: New York,Texas,California
    allow_multiple_values: true
    required: false
    model: covid
    explore: mobility
    listens_to_filters: []
    field: mobility.sub_region_1
  - name: County
    title: County
    type: field_filter
    default_value: Kings County,New York County,Rensselaer County,Erie County
    allow_multiple_values: true
    required: false
    model: covid
    explore: mobility
    listens_to_filters: []
    field: mobility.sub_region_2
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
