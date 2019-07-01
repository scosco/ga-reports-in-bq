# ga-reports-in-bq
Translate reports from Google Analytics to queries in BigQuery running on raw data exports.

Google Analytics offers a [demo account](https://analytics.google.com/analytics/web/#/report-home/a54516992w87479473p92320289).
BigQuery offers an export of this data in their public project under [bigquery-public-data:google_analytics_sample.ga_sessions_yyyymmdd](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=google_analytics_sample&t=ga_sessions_20170801&page=table) from dates 2016-08-01 to 2017-08-01.

The idea is to develop queries that replicate numbers showing up in reports:
 * Audience
 * Aquisition
 * Behavior
 * Conversion

as well as calculation of metrics - see [Dimensions and Metrics Explorer](https://developers.google.com/analytics/devguides/reporting/core/dimsmets).
