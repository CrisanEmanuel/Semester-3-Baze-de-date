USE [CasaDeDiscuri]
GO
/****** Object:  StoredProcedure [dbo].[undo_procedure_3]    Script Date: 26-Nov-23 22:41:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[undo_procedure_3]
AS
BEGIN
	DROP TABLE DJs;
	PRINT '3) Am sters tabela DJs'
END


