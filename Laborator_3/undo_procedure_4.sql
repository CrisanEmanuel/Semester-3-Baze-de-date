USE [CasaDeDiscuri]
GO
/****** Object:  StoredProcedure [dbo].[undo_procedure_4]    Script Date: 26-Nov-23 22:41:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[undo_procedure_4]
AS
BEGIN
	ALTER TABLE Trupe
	DROP COLUMN gen_muzical
	PRINT '4) Am eliminat coloana "gen_muzical" in tabela "Trupe"'
END


