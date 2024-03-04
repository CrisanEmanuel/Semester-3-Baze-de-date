USE [CasaDeDiscuri]
GO
/****** Object:  StoredProcedure [dbo].[undo_procedure_1]    Script Date: 26-Nov-23 22:40:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[undo_procedure_1]
AS
BEGIN
    ALTER TABLE SesiuneDeInregistrare
    ALTER COLUMN DurataSesiune INT;

    UPDATE Versiune SET nr_versiune = 0;

    PRINT '1) Am readus in tabela "SesiuneDeInregistrari" tipul campului "DurataSesiune", din float, in int';
END


