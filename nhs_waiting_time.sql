USE NHS_UK_db;
GO

SELECT TOP 10 *
FROM dbo.NHS_waiting_times_cleaned;


IF OBJECT_ID('vw_Fact_PatientWaits', 'V') IS NOT NULL
    DROP VIEW vw_Fact_PatientWaits;
GO

CREATE VIEW vw_Fact_PatientWaits AS
SELECT
    CAST(Period AS DATE) AS PeriodDate,
    Provider_Org_Name AS ProviderName,
    WaitCategory,
    SUM(Patients) AS TotalPatients
FROM dbo.NHS_waiting_times_cleaned
GROUP BY CAST(Period AS DATE), Provider_Org_Name, WaitCategory;
GO

IF OBJECT_ID('vw_Dim_Date', 'V') IS NOT NULL
    DROP VIEW vw_Dim_Date;
GO

CREATE VIEW vw_Dim_Date AS
SELECT DISTINCT
    CAST(Period AS DATE) AS Date,
    YEAR(CAST(Period AS DATE)) AS Year,
    DATENAME(MONTH, CAST(Period AS DATE)) AS MonthName,
    MONTH(CAST(Period AS DATE)) AS MonthNumber,
    FORMAT(CAST(Period AS DATE), 'yyyy-MM') AS YearMonth
FROM dbo.NHS_waiting_times_cleaned;
GO

IF OBJECT_ID('vw_Dim_Provider', 'V') IS NOT NULL
    DROP VIEW vw_Dim_Provider;
GO

CREATE VIEW vw_Dim_Provider AS
SELECT DISTINCT
    Provider_Org_Name AS ProviderName
FROM dbo.NHS_waiting_times_cleaned;
GO


IF OBJECT_ID('vw_Dim_WaitCategory', 'V') IS NOT NULL
    DROP VIEW vw_Dim_WaitCategory;
GO

CREATE VIEW vw_Dim_WaitCategory AS
SELECT DISTINCT
    WaitCategory
FROM dbo.NHS_waiting_times_cleaned;
GO



SELECT TOP 10 * FROM vw_Fact_PatientWaits;
SELECT TOP 10 * FROM vw_Dim_Date;
SELECT TOP 10 * FROM vw_Dim_Provider;
SELECT TOP 10 * FROM vw_Dim_WaitCategory;



