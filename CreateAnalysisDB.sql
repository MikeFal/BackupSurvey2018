IF not exists (SELECT 1 FROM sys.databases WHERE name = 'BackupSurvey2018')
	CREATE DATABASE BackupSurvey2018;

use BackupSurvey2018

IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'STAGE')
	DROP TABLE STAGE;

CREATE TABLE STAGE(
	ResponseID int IDENTITY(1,1)
	,ResponseTime varchar(100)
	,ServerCount varchar(100)
	,DatabaseCount varchar(100)
	,DataVolume varchar(100)
	,LargestDB varchar(100)
	,DBACount varchar(100)
	,SQLVersions varchar(4000)
	,SQLFeatures varchar(4000)
	,BackupTools varchar(4000)
	,BackupTesting varchar(4000)
	,HADRTools varchar(4000)
	,BackupPain varchar(4000)
)

IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'RESULTS')
	DROP TABLE RESULTS;

CREATE TABLE RESULTS(
ResponseTime datetime2(0) not null
,ServerCountResponse smallint not null
,DatabaseCountResponse smallint not null
,DataVolumeResponse smallint not null
,LargestDBResponse smallint not null
,DBACountResponse smallint not null
,SQL2000_2005 bit default 0 not null
,SQL2008_2008R2 bit default 0 not null
,SQL2012 bit default 0 not null
,SQL2014 bit default 0 not null
,SQL2016 bit default 0 not null
,SQL2017 bit default 0 not null
,Features_CDC bit default 0 not null
,Features_ColumnStore bit default 0 not null
,Features_DBCompression bit default 0 not null
,Features_FileStream bit default 0 not null
,Features_InMemoryOLTP bit default 0 not null
,Features_TDE bit default 0 not null
,Tools_MaintenancePlans bit default 0 not null
,Tools_CommunityScripts bit default 0 not null
,Tools_RollYourOwn bit default 0 not null
,Tools_VendorSoftware bit default 0 not null
,Tools_EnterprisePlatform bit default 0 not null
,Testing_None bit default 0 not null
,Testing_BackupVerification bit default 0 not null
,Testing_DBCC bit default 0 not null
,HADR_FCI bit default 0 not null
,HADR_AG bit default 0 not null
,HADR_LogShipping bit default 0 not null
,HADR_Mirroring bit default 0 not null
,HADR_ThirdParty bit default 0 not null
,BackupPain varchar(4000)) 

IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'dim_ServerCountResponse')
	DROP TABLE dim_ServerCountResponse;

CREATE TABLE dim_ServerCountResponse(
ResponseID smallint identity(1,1)
,ResponseValue varchar(20)
,CONSTRAINT PK_dim_ServerCountResponse PRIMARY KEY CLUSTERED (ResponseID))

INSERT INTO dim_ServerCountResponse
VALUES ('1-10'),('10-25'),('25-50'),('50-100'),('100+')

IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'dim_DatabaseCountResponse')
	DROP TABLE dim_DatabaseCountResponse;

CREATE TABLE dim_DatabaseCountResponse(
ResponseID smallint identity(1,1)
,ResponseValue varchar(20)
,CONSTRAINT PK_dim_DatabaseCountResponse PRIMARY KEY CLUSTERED (ResponseID))

INSERT INTO dim_DatabaseCountResponse
VALUES ('1-25'),('26-100'),('101-500'),('501-2000'),('2001+')

IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'dim_DatabaseVolumeResponse')
	DROP TABLE dim_DatabaseVolumeResponse;

CREATE TABLE dim_DatabaseVolumeResponse(
ResponseID smallint identity(1,1)
,ResponseValue varchar(20)
,CONSTRAINT PK_dim_DatabaseVolumeResponse PRIMARY KEY CLUSTERED (ResponseID))

INSERT INTO dim_DatabaseVolumeResponse
VALUES ('0-10TB'),('10TB-25TB'),('25TB-50TB'),('50TB+')

IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'dim_LargestDBResponse')
	DROP TABLE dim_LargestDBResponse;

CREATE TABLE dim_LargestDBResponse(
ResponseID smallint identity(1,1)
,ResponseValue varchar(20)
,CONSTRAINT PK_dim_LargestDBResponse PRIMARY KEY CLUSTERED (ResponseID))

INSERT INTO dim_LargestDBResponse
VALUES ('0-1TB'),('1TB-5TB'),('5TB-10TB'),('10TB+')

IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'dim_DBACountResponse')
	DROP TABLE dim_DBACountResponse;

CREATE TABLE dim_DBACountResponse(
ResponseID smallint identity(1,1)
,ResponseValue varchar(20)
,CONSTRAINT PK_dim_DBACountResponse PRIMARY KEY CLUSTERED (ResponseID))

INSERT INTO dim_DBACountResponse
VALUES ('1'),('2-5'),('6-10'),('11+')
