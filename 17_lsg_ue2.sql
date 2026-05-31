USE AdventureWorks2012;
GO

IF OBJECT_ID('getOrders') IS NOT NULL
BEGIN
	PRINT 'Prozedur wird gelöscht'
	DROP PROCEDURE getOrders;
END
GO

CREATE PROCEDURE getOrders
  @Date DATE
AS
	SELECT * FROM Sales.SalesOrderHeader
		WHERE
		  OrderDate BETWEEN @Date AND DATEADD(WEEK, 1, @Date)
		  --Alternative: 
		  --OrderDate >= @Date
		  --AND
		  --OrderDate <= DATEADD(WEEK, 1, @Date)
GO

EXECUTE getOrders '20070730';

 
	--StartDate <= '20060101'
	--AND 
	--EndDate >=  '20060101'
	;
GO