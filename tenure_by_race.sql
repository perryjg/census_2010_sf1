SELECT a.county,
       a.total AS total_00, b.total AS total_10,
       a.white AS white_00, b.white AS white_10,
       a.black AS black_00, b.white AS black_10,
       a.amind AS amind_00, b.amind AS amind_10,
       a.asian AS asian_00, b.asian AS asian_10,
       a.pacisl AS pacisl_00, b.pacisl AS pacisl_10,
       a.other AS other_00, b.other AS other_10,
       a.multi AS multi_00, b.multi AS multi_10,
       a.hisp AS hisp_00, b.hisp AS hisp_10
FROM (
  SELECT g.sumlev, g.county,
         d37.H014001 AS hh,
         ROUND( d37.H014002 / d37.H014001 * 100, 2 ) AS total,
         ROUND( d37.H014003 / ( d37.H014003 + d37.H014011 ) * 100, 2 ) AS white,
         ROUND( d37.H014004 / ( d37.H014004 + d37.H014012 ) * 100, 2 ) AS black,
         ROUND( d37.H014005 / ( d37.H014005 + d37.H014013 ) * 100, 2 ) AS amind,
         ROUND( d37.H014006 / ( d37.H014006 + d37.H014014 ) * 100, 2 ) AS asian,
         ROUND( d37.H014007 / ( d37.H014007 + d37.H014015 ) * 100, 2 ) AS pacisl,
         ROUND( d37.H014008 / ( d37.H014008 + d37.H014016 ) * 100, 2 ) AS other,
         ROUND( d37.H014009 / ( d37.H014009 + d37.H014017 ) * 100, 2 ) AS multi,
         ROUND( d38.H015H002 / d38.H015H001 * 100, 2 ) AS hisp
  FROM census_sf1_2000.sf1_geo g
  JOIN census_sf1_2000.sf1_seg37 d37 USING( LOGRECNO )
  JOIN census_sf1_2000.sf1_seg38 d38 USING( LOGRECNO )
  WHERE g.sumlev = '050'
) a JOIN (
  SELECT g.sumlev, g.county,
         d44.H0140001 AS hh,
         ROUND( d44.H0140002 / d44.H0140001 * 100, 2 ) AS total,
         ROUND( d44.H0140003 / ( d44.H0140003 + d44.H0140011 ) * 100, 2 ) AS white,
         ROUND( d44.H0140004 / ( d44.H0140004 + d44.H0140012 ) * 100, 2 ) AS black,
         ROUND( d44.H0140005 / ( d44.H0140005 + d44.H0140013 ) * 100, 2 ) AS amind,
         ROUND( d44.H0140006 / ( d44.H0140006 + d44.H0140014 ) * 100, 2 ) AS asian,
         ROUND( d44.H0140007 / ( d44.H0140007 + d44.H0140015 ) * 100, 2 ) AS pacisl,
         ROUND( d44.H0140008 / ( d44.H0140008 + d44.H0140016 ) * 100, 2 ) AS other,
         ROUND( d44.H0140009 / ( d44.H0140009 + d44.H0140017 ) * 100, 2 ) AS multi,
         ROUND( d45.H016H0002 / d45.H016H0001 * 100, 2 ) AS hisp
  FROM census_sf1_2010.sf1_geo g
  JOIN census_sf1_2010.sf1_p44 d44 USING( LOGRECNO )
  JOIN census_sf1_2010.sf1_p45 d45 USING( LOGRECNO )
  WHERE g.sumlev = '050'
) b USING( county )

