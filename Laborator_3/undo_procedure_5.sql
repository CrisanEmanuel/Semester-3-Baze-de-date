USE [CasaDeDiscuri]
GO
/****** Object:  StoredProcedure [dbo].[undo_procedure_5]    Script Date: 26-Nov-23 22:41:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[undo_procedure_5]
AS
BEGIN
	ALTER TABLE DJs
	DROP CONSTRAINT fk_GenMuzical
	PRINT '5) Am sters constrangerea de cheie straina pe tabelul "DJs", campul "GenMuzicalID"'
END


