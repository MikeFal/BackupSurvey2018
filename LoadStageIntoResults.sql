update stage
set largestDB = '10TB+'
where largestDB = 'Over 10TB'

TRUNCATE TABLE RESULTS

INSERT INTO [dbo].[RESULTS]
           ([ResponseTime]
           ,[ServerCountResponse]
           ,[DatabaseCountResponse]
           ,[DataVolumeResponse]
           ,[LargestDBResponse]
           ,[DBACountResponse]
           ,[SQL2000_2005]
           ,[SQL2008_2008R2]
           ,[SQL2012]
           ,[SQL2014]
           ,[SQL2016]
           ,[SQL2017]
           ,[Features_CDC]
           ,[Features_ColumnStore]
           ,[Features_DBCompression]
           ,[Features_FileStream]
           ,[Features_InMemoryOLTP]
           ,[Features_TDE]
           ,[Tools_MaintenancePlans]
           ,[Tools_CommunityScripts]
           ,[Tools_RollYourOwn]
           ,[Tools_VendorSoftware]
           ,[Tools_EnterprisePlatform]
           ,[Testing_None]
           ,[Testing_BackupVerification]
           ,[Testing_DBCC]
           ,[HADR_FCI]
           ,[HADR_AG]
           ,[HADR_LogShipping]
           ,[HADR_Mirroring]
           ,[HADR_ThirdParty]
           ,[BackupPain])
select
	convert(datetime2(0),left(responsetime,22))
	,scr.ResponseId as ServerCountResponse
	,dcr.ResponseId as DatabaseCountResponse
	,dvr.ResponseId as DatabaseVolumeResponse
	,ldr.ResponseId as LargestDBResponse
	,dba.ResponseId as DBACountResponse
	,CASE WHEN SQLVersions LIKE '%SQL 2000%' THEN 1 ELSE 0 END as SQL2000_2005
	,CASE WHEN SQLVersions LIKE '%SQL 2008%' THEN 1 ELSE 0 END as SQL2008_2008R2
	,CASE WHEN SQLVersions LIKE '%SQL 2012%' THEN 1 ELSE 0 END as SQL2012
	,CASE WHEN SQLVersions LIKE '%SQL 2014%' THEN 1 ELSE 0 END as SQL2014
	,CASE WHEN SQLVersions LIKE '%SQL 2016%' THEN 1 ELSE 0 END as SQL2016
	,CASE WHEN SQLVersions LIKE '%SQL 2017%' THEN 1 ELSE 0 END as SQL2017
	,CASE WHEN SQLFeatures LIKE '%Change Data%' THEN 1 ELSE 0 END as Features_CDC
	,CASE WHEN SQLFeatures LIKE '%Column Store%' THEN 1 ELSE 0 END as Features_ColumnStore
	,CASE WHEN SQLFeatures LIKE '%Compression%' THEN 1 ELSE 0 END as Features_Compression
	,CASE WHEN SQLFeatures LIKE '%Filestream%' THEN 1 ELSE 0 END as Features_Filestream
	,CASE WHEN SQLFeatures LIKE '%OLTP%' THEN 1 ELSE 0 END as Features_InMemoryOLTP
	,CASE WHEN SQLFeatures LIKE '%Transparent%' THEN 1 ELSE 0 END as Features_TDE
	,CASE WHEN BackupTools LIKE '%Maintenance%' THEN 1 ELSE 0 END as Tools_MaintenancePlans
	,CASE WHEN BackupTools LIKE '%Community%' THEN 1 ELSE 0 END as Tools_CommunityScripts
	,CASE WHEN BackupTools LIKE '%Roll%' THEN 1 ELSE 0 END as Tools_RollYourOwn
	,CASE WHEN BackupTools LIKE '%Vendor%' THEN 1 ELSE 0 END as Tools_VendorSoftware
	,CASE WHEN BackupTools LIKE '%Enterprise%' THEN 1 ELSE 0 END as Tools_EnterprisePlatform
	,CASE WHEN BackupTesting LIKE '%No verification%' THEN 1 ELSE 0 END as Testing_None
	,CASE WHEN BackupTesting LIKE '%Backup job%' THEN 1 ELSE 0 END as Test_BackupVerification
	,CASE WHEN BackupTesting LIKE '%DBCC%' THEN 1 ELSE 0 END as Testing_DBCC
	,CASE WHEN HADRTools LIKE '%Failover%' THEN 1 ELSE 0 END as HADR_FCI
	,CASE WHEN HADRTools LIKE '%Availability%' THEN 1 ELSE 0 END as HADR_AG
	,CASE WHEN HADRTools LIKE '%Log Shipping%' THEN 1 ELSE 0 END as HADR_LogShipping
	,CASE WHEN HADRTools LIKE '%Mirroring%' THEN 1 ELSE 0 END as HADR_Mirroring
	,CASE WHEN HADRTools LIKE '%Third%' THEN 1 ELSE 0 END as HADR_ThirdParty
	,BackupPain
from stage s
	join [dbo].[dim_ServerCountResponse] scr on (s.ServerCount = scr.ResponseValue)
	join [dbo].[dim_DatabaseCountResponse] dcr on (s.DatabaseCount = dcr.ResponseValue)
	join [dbo].[dim_DatabaseVolumeResponse] dvr on (s.DataVolume = dvr.ResponseValue)
	join [dbo].[dim_LargestDBResponse] ldr on (s.LargestDB = ldr.ResponseValue)
	join [dbo].[dim_DBACountResponse] dba on (s.DBACount = dba.ResponseValue)
