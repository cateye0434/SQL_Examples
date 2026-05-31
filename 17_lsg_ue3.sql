USE Messenger;
GO

IF OBJECT_ID('insertMessage') IS NOT NULL
BEGIN
	PRINT 'Prozedur wird gelöscht'
	DROP PROCEDURE insertMessage;
END
GO

CREATE PROCEDURE insertMessage
	@ID_Sender INT,
	@NachrichtenText NVARCHAR(500),
	@ID_Empfaenger INT
AS
  INSERT INTO Nachrichten(Sender, Text, Zeitstempel)
		VALUES (@ID_Sender, @NachrichtenText, GETDATE());
  DECLARE @ID_Nachricht INT;
  SET @ID_Nachricht =  IDENT_CURRENT('Nachrichten')
  PRINT @ID_Nachricht;
  INSERT INTO Empfaenger(ID_Nachricht, ID_Nutzer)
	VALUES(@ID_Nachricht, @ID_Empfaenger); 

GO

EXECUTE insertMessage 1, 'Hallo Bob! Stored Procedure Version 2', 2;