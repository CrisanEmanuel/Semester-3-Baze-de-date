USE [CasaDeDiscuri]
GO
/****** Object:  StoredProcedure [dbo].[do_procedure_5]    Script Date: 26-Nov-23 22:40:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[do_procedure_5]
AS
BEGIN
	ALTER TABLE DJs
	ADD CONSTRAINT fk_GenMuzical FOREIGN KEY (GenMuzicalID) REFERENCES GenMuzical(GenMuzicalID)
	PRINT '5) Am adaugat o constrangere de cheie straina pe tabelul "DJs", campul "GenMuzicalID"'
END


