-- function returns an array with two entries: offset 0: start date, offset 1: end date
CREATE TEMP FUNCTION  start_end() AS ( [DATE(2017,9,24), DATE(2017,10,5)] );
 
-- create a calendar table 1 column "day" and one row for each day in the desired timeframe
WITH
  calendar AS (
  SELECT
    day
  FROM
    UNNEST(GENERATE_DATE_ARRAY( start_end()[OFFSET(0)], start_end()[OFFSET(1)], INTERVAL 1 DAY) ) AS day )
 
-- count distinct fullvisitorids starting with (day - timeframe) and ending with (day) 
SELECT
  day,
  -- isNew,
  COUNT(DISTINCT IF(date = FORMAT_DATE('%Y%m%d',day),
      fullvisitorid,
      NULL)) DAU,
  COUNT(DISTINCT IF(date BETWEEN FORMAT_DATE('%Y%m%d',DATE_SUB(day,INTERVAL 6 DAY))
      AND FORMAT_DATE('%Y%m%d',day),
      fullvisitorid,
      NULL)) last7Days,
  COUNT(DISTINCT IF(date BETWEEN FORMAT_DATE('%Y%m%d',DATE_SUB(day,INTERVAL 13 DAY))
      AND FORMAT_DATE('%Y%m%d',day),
      fullvisitorid,
      NULL)) last14Days,
  COUNT(DISTINCT IF(date BETWEEN FORMAT_DATE('%Y%m%d',DATE_SUB(day,INTERVAL 29 DAY))
      AND FORMAT_DATE('%Y%m%d',day),
      fullvisitorid,
      NULL)) last30Days
FROM
  -- cross join the calendar with all fullvisitorids in the desired time frame - 30 days to the past
  calendar,
  (SELECT date, fullvisitorid,
    -- add user segments here using window functions
    -- MAX(totals.newVisits IS NOT NULL OR totals.newVisits = 1) OVER (PARTITION BY fullvisitorid) AS isNew
    FROM `oval-unity-88908.97553715.ga_sessions_*`
    WHERE _table_suffix BETWEEN FORMAT_DATE('%Y%m%d',DATE_SUB(start_end()[OFFSET(0)],INTERVAL 30 DAY))
    AND FORMAT_DATE('%Y%m%d',start_end()[OFFSET(1)]))
GROUP BY
  1 --, 2
ORDER BY
  1
