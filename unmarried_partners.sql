SELECT * FROM (
  SELECT geo.county,
         d.PCT014001 AS total_00,
         d.PCT014002 AS unmarried_partners_00,
         d.PCT014003 AS mm_00,
         d.PCT014004 AS mf_00,
         d.PCT014005 AS ff_00,
         d.PCT014006 AS fm_00,
         d.PCT014003 + d.PCT014006 AS ss_unmarried_partners_00
  FROM census_sf1_2000.sf1_geo geo
  JOIN census_sf1_2000.sf1_seg15 d USING(LOGRECNO)
  WHERE geo.SUMLEV = '050'
) a
JOIN (
  SELECT geo.county,
         d.PCT0150001 AS total_10,
         d.PCT0150013 AS unmarried_partners_10,
         d.PCT0150014 AS mm_10,
         d.PCT0150019 AS mf_10,
         d.PCT0150024 AS ff_10,
         d.PCT0150029 AS fm_10,
         d.PCT0150014 + d.PCT0150024 AS ss_unmarried_partners_10
  FROM census_sf1_2010.sf1_geo geo
  JOIN census_sf1_2010.sf1_p18 d USING(LOGRECNO)
  WHERE geo.SUMLEV = '050'
) b USING( county )

