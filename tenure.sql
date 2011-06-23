/* tenure comparison 2000 to 2010 by county */
SELECT a.COUNTY,
       a.total_00, b.total_10,
       
       own_00, own_10,
       own_1524_00, own_1524_10,
       own_2534_00, own_2534_10,
       own_3544_00, own_3544_10,
       own_4554_00, own_4554_10,
       own_5564_00, own_5564_10,
       own_6574_00, own_6574_10,
       own_7584_00, own_7584_10,
       own_85_00, own_85_10,
       
       rent_00, rent_10,
       rent_1524_00, rent_1524_10,
       rent_2534_00, rent_2534_10,
       rent_3544_00, rent_3544_10,
       rent_4554_00, rent_4554_10,
       rent_5564_00, rent_5564_10,
       rent_6574_00, rent_6574_10,
       rent_7584_00, rent_7584_10,
       rent_85_00, rent_85_10
FROM (
  SELECT ag.SUMLEV, ag.COUNTY,
         ad.H016001 AS total_00,
         ad.H016002 AS own_00,
         ad.H016003 AS own_1524_00,
         ad.H016004 AS own_2534_00,
         ad.H016005 AS own_3544_00,
         ad.H016006 AS own_4554_00,
         ad.H016007 AS own_5564_00,
         ad.H016008 AS own_6574_00,
         ad.H016009 AS own_7584_00,
         ad.H016010 AS own_85_00,
         ad.H016011 AS rent_00,
         ad.H016012 AS rent_1524_00,
         ad.H016013 AS rent_2534_00,
         ad.H016014 AS rent_3544_00,
         ad.H016015 AS rent_4554_00,
         ad.H016016 AS rent_5564_00,
         ad.H016017 AS rent_6574_00,
         ad.H016018 AS rent_7584_00,
         ad.H016019 AS rent_85_00
  FROM census_sf1_2000.sf1_seg37 ad
  JOIN census_sf1_2000.sf1_geo ag USING(LOGRECNO)
  WHERE ag.SUMLEV = '050'
) a
JOIN (
  SELECT ag.SUMLEV, ag.COUNTY,
         ad.H0170001 AS total_10,
         ad.H0170002 AS own_10,
         ad.H0170003 AS own_1524_10,
         ad.H0170004 AS own_2534_10,
         ad.H0170005 AS own_3544_10,
         ad.H0170006 AS own_4554_10,
         ad.H0170007 + ad.H0170008 AS own_5564_10,
         ad.H0170009 AS own_6574_10,
         ad.H0170010 AS own_7584_10,
         ad.H0170011 AS own_85_10,
         ad.H0170012 AS rent_10,
         ad.H0170013 AS rent_1524_10,
         ad.H0170014 AS rent_2534_10,
         ad.H0170015 AS rent_3544_10,
         ad.H0170016 AS rent_4554_10,
         ad.H0170017 + ad.H0170018 AS rent_5564_10,
         ad.H0170019 AS rent_6574_10,
         ad.H0170020 AS rent_7584_10,
         ad.H0170021 AS rent_85_10
  FROM census_sf1_2010.sf1_p44 ad
  JOIN census_sf1_2010.sf1_geo ag USING(LOGRECNO)
  WHERE ag.SUMLEV = '050'
) b ON a.COUNTY = b.COUNTY 


/* tenure by tract */
SELECT ag.SUMLEV, ag.COUNTY,
       ad.H0170001 AS total_10,
       ad.H0170002 AS own_10,
       ad.H0170003 AS own_1524_10,
       ad.H0170004 AS own_2534_10,
       ad.H0170005 AS own_3544_10,
       ad.H0170006 AS own_4554_10,
       ad.H0170007 + ad.H0170008 AS own_5564_10,
       ad.H0170009 AS own_6574_10,
       ad.H0170010 AS own_7584_10,
       ad.H0170011 AS own_85_10,
       ad.H0170012 AS rent_10,
       ad.H0170013 AS rent_1524_10,
       ad.H0170014 AS rent_2534_10,
       ad.H0170015 AS rent_3544_10,
       ad.H0170016 AS rent_4554_10,
       ad.H0170017 + ad.H0170018 AS rent_5564_10,
       ad.H0170019 AS rent_6574_10,
       ad.H0170020 AS rent_7584_10,
       ad.H0170021 AS rent_85_10
FROM census_sf1_2010.sf1_p44 ad
JOIN census_sf1_2010.sf1_geo ag USING(LOGRECNO)
WHERE ag.SUMLEV = '140'

