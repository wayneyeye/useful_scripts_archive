SELECT databasename,
TABLENAME,
SUM(currentperm)  /1024/1024 AS tablesize,
MAX(currentperm)/1024/1024 AS maxperm,
MIN(currentperm)/1024/1024 AS minperm ,
AVG(currentperm) /1024/1024 AS avgperm,
(MAX(currentperm)-AVG(currentperm))/MAX(currentperm) * 100 skewfactor
FROM dbc.tablesize
WHERE databasename='clsfd_tables'
AND TABLENAME='clsfd_p2p_account_status'
GROUP BY 1,2
ORDER BY tablesize DESC;

-- check query performance statistics
SELECT 
starttime, ERRORCODE, 
 (firstresptime-starttime) HOUR(2) TO SECOND AS log_time,
(firstresptime-firststeptime) HOUR(2) TO SECOND AS actual_run_time,
CAST(HotAmp1CPU AS DECIMAL(18,2)) HotAmp,
CAST((HotAmp1CPU*c-TotalCPUTime)AS DECIMAL(18,2)) Avg_Skew,
CAST(((TotalCPUTime)/((HotAmp1CPU)*c+1))*100 AS DECIMAL(18,2)) ParallelEfficiency,
CAST(TotalCPUTime AS DECIMAL(18,2)) TotalCPU,
CAST(totalIOcount AS DECIMAL(18,2)) IO,
spoolusage,
QueryText
FROM dw_monitor_views.QryLogHIST_dba_live       v , 
(SELECT COUNT(*) c FROM dbc.diskspace WHERE databasename = 'yunqiu' ) c 
WHERE QueryText LIKE '%dqrc.CLSFD_CAS_ODS_AD%'
AND USERNAME = 'yunqiu'
AND CAST(StartTime AS DATE)  >= '2018-08-13'
;
