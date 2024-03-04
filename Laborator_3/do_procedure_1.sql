USE [CasaDeDiscuri]
GO
/****** Object:  StoredProcedure [dbo].[do_procedure_1]    Script Date: 26-Nov-23 22:39:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[do_procedure_1]
AS
BEGIN
    ALTER TABLE SesiuneDeInregistrare
    ALTER COLUMN DurataSesiune FLOAT;

	UPDATE Versiune SET nr_versiune = 1

    PRINT '1) Am modificat cu succes din tabela "SesiuneDeInregistrari" tipul campului "DurataSesiune" din int in float';
END


