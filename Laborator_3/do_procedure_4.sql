USE [CasaDeDiscuri]
GO
/****** Object:  StoredProcedure [dbo].[do_procedure_4]    Script Date: 26-Nov-23 22:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[do_procedure_4]
AS
BEGIN
	ALTER TABLE Trupe
	ADD gen_muzical VARCHAR(50)
	PRINT '4) Am adaugat coloana "gen_muzical" in tabela "Trupe"'
END


