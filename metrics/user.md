UI Name | API Name | Big Query  | Type  | Data Type  | Description   | Allowed in Segments?
----- | ----| ---- | ---- | ---- | ---- | ----
New Users | ga:newUsers | `SUM(totals.newVisits)` | METRIC | INTEGER | The number of sessions marked as a user's first sessions. | TRUE 
Users  | ga:users | For Views without User Id feature: Use `COUNT(DISTINCT fullVisitorId)`. Google Analytics shows an approximation for users, Big Query is exact. You can test this with unsampled reports in Google Analytics - numbers will match. Also: GA uses all available data to count users, even where `totals.visits is NULL`! In contrast GA counts sessions only where `totals.visits = 1`!  | METRIC  | 	INTEGER | 	The total number of users for the requested time period. | 	undefined
