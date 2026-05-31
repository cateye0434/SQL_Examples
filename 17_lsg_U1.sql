USE AdventureWorks2012;
GO

IF OBJECT_ID('getPriceForDate') IS NOT NULL
BEGIN
	DROP PROCEDURE getPriceForDate;
END 
GO


CREATE PROCEDURE getPriceForDate
	@Name NVARCHAR(50),
	@Zeitpunkt DATE
AS

	SELECT P.Name, PLPH.ListPrice FROM Production.Product P
		JOIN Production.ProductListPriceHistory PLPH
			ON P.ProductID=PLPH.ProductID
		WHERE P.Name LIKE '%' + @Name + '%'
		AND 
		(
		  @Zeitpunkt BETWEEN PLPH.StartDate AND PLPH.EndDate
		  OR
		 ( @Zeitpunkt >= PLPH.StartDate AND PLPH.EndDate IS NULL)
		 )
		
;
GO

--  

--EXECUTE getPriceForDate 'HL Road Frame - Red, 62', '20060601';


--EXECUTE getPriceForDate 'HL Road Frame - Red, 44', '20060701';

--EXECUTE getPriceForDate 'HL Road Frame - Red, 44', '20060101';


EXECUTE getPriceForDate 'HL Road Frame - Red, 44', '20200210';


EXECUTE getPriceForDate 'Road Frame', '20060701';