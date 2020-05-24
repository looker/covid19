view: nyc_subway_turnstiles {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: with zcta_match as (
          SELECT
            tp.control_area,
            tp.unit,
            tp.division,
            s.station_id,
            s.gtfs_stop_id,
            s.station_name,
            s.borough_name,
            s.station_lat,
            s.station_lon,
            zip_code,
            ST_DISTANCE(zcta.zip_code_geom, s.station_geom) as distance
          FROM new_york_subway.turnstile_banks as tp
          LEFT JOIN new_york_subway.station_unit_mapping sum on tp.control_area = sum.booth AND tp.unit = sum.remote
          LEFT JOIN `bigquery-public-data.new_york_subway.stations` as s ON sum.station_id = s.station_id AND sum.gtfs_stop_id = s.gtfs_stop_id
          CROSS JOIN `bigquery-public-data.geo_us_boundaries.zip_codes` as zcta
          WHERE s.station_id is not null)
        SELECT
          control_area,
          unit,
          division,
          station_id,
          gtfs_stop_id,
          borough_name,
          station_name,
          station_lat,
          station_lon,
          ARRAY_AGG(zip_code IGNORE NULLS ORDER BY distance LIMIT 1)  as zip_code,
        FROM
          zcta_match
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9
      ;;
    persist_for: "154 hours"
  }

  # Define your dimensions and measures here, like this:
  dimension: pk {
    primary_key: yes
    sql: CONCAT(${control_area}, ${unit}, ${division}, ${station_id}, ${gtfs_stop_id}) ;;
  }
  dimension: control_area {}
  dimension: unit {}
  dimension: division {}
  dimension: station_id {}
  dimension: gtfs_stop_id {}
  dimension: station_name {}
  dimension: station_location {
    type: location
    sql_latitude: ${TABLE}.station_lat ;;
    sql_longitude: ${TABLE}.station_lon ;;
  }
  dimension: zip_code {
    type: zipcode
    sql: ${TABLE}.zip_code[SAFE_OFFSET(0)] ;;
  }
  dimension: borough {
    type: string
    sql: ${TABLE}.borough_name ;;
  }
}
