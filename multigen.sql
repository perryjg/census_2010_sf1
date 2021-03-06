/* compare multi-generational households by county 2000-2010 for Cobb, Clayton, DeKalb, Fulton and Gwinnett counties*/
SELECT a.county, b.hh_00, a.hh_10, b.multigen_00, a.multigen_10
FROM (
  SELECT geo.county,
         data.PCT0140001 AS hh_10,
         data.PCT0140002 AS multigen_10
  FROM census_sf1_2010.sf1_geo geo
  JOIN census_sf1_2010.sf1_p18 DATA USING( LOGRECNO )
  WHERE geo.SUMLEV = '050'
) a
JOIN (
  SELECT b.COUNTYFP AS county,
         SUM(a.hweight) AS hh_00,
         SUM(CASE a.MGF WHEN 1 THEN hweight ELSE 0 END) AS multigen_00
  FROM census_pums_2000.multigen a
  JOIN census_pums_2000.puma5_to_county b ON a.PUMA5 = b.PUMA5CE00
  GROUP BY b.COUNTYFP
) b USING(county)


/* Presence of multi-generational family households by tract */
SELECT geo.county, geo.tract,
       data.PCT0140001 AS hh,
       data.PCT0140002 AS multigen,
       ROUND( data.PCT0140002 / data.PCT0140001 * 100, 2 ) AS pct_multigen,
       CONCAT(geo.state, geo.county, geo.tract) AS geoid
FROM census_sf1_2010.sf1_geo geo
  JOIN census_sf1_2010.sf1_p18 DATA USING( LOGRECNO )
WHERE geo.SUMLEV = '140'

