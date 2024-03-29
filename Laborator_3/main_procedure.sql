USE [CasaDeDiscuri]
GO
/****** Object:  StoredProcedure [dbo].[main]    Script Date: 26-Nov-23 22:41:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[main] @vers_noua INT
AS
BEGIN

	IF (@vers_noua < 0 OR @vers_noua > 5)
		BEGIN
			RAISERROR('Versiune inexistenta', 16, 1);
			RETURN
		END

	DECLARE @vers_veche AS INT
	SELECT @vers_veche = nr_versiune FROM Versiune

	IF (@vers_veche = @vers_noua)
		BEGIN
			RAISERROR('Sunteti deja in aceasta versiune', 16, 1);
			RETURN
		END

	DECLARE @nume_functie VARCHAR(30);

	WHILE (@vers_noua <> @vers_veche)
		BEGIN
		IF (@vers_veche < @vers_noua)
			BEGIN
				SET @vers_veche = @vers_veche + 1
				SET @nume_functie = 'do_procedure_' + cast(@vers_veche AS VARCHAR(1))
				EXEC (@nume_functie)
			END
		IF (@vers_veche > @vers_noua)
			BEGIN
				SET @nume_functie = 'undo_procedure_' + cast(@vers_veche AS varchar(1))
				EXEC (@nume_functie)
				SET @vers_veche = @vers_veche - 1
			END
		END
	UPDATE Versiune SET nr_versiune = @vers_noua
	print 'Am modificat versiunea!'
END 
