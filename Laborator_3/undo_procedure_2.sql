USE [CasaDeDiscuri]
GO
/****** Object:  StoredProcedure [dbo].[undo_procedure_2]    Script Date: 26-Nov-23 22:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[undo_procedure_2]
AS
BEGIN
	ALTER TABLE Instrumente
	DROP CONSTRAINT df_pret;
	PRINT '2) Am eliminat constrangerea default pentru campul "Pret"'
END


