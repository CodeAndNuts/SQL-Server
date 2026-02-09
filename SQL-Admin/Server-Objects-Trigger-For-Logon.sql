CREATE TRIGGER AllowLocalOnly
ON ALL SERVER
FOR LOGON
AS
BEGIN
	DECLARE @IP			varchar(500);
	DECLARE @HostName	varchar(MAX);
	DECLARE @USUARIO	varchar(100); 
	DECLARE @APP		varchar(100);

	SET @IP = EVENTDATA().value('(/EVENT_INSTANCE/ClientHost)[1]', 'varchar(500)');
	SET @HostName = HOST_NAME();
	SET @USUARIO = ORIGINAL_LOGIN();
	SET @APP = PROGRAM_NAME();

	IF @USUARIO = 'alberto.suarez'
	Begin
		IF @HostName NOT IN('EC-DEV-AlbertoS')
			BEGIN
				ROLLBACK TRANSACTION;
				PRINT 'Esta credencial no se puede usar desde el host ' + @HostName + ', Usuario: ' + @USUARIO + ', IP: ' + @IP + ', APP: ' + @APP;
			END
	End
END
