USE [CasaDeDiscuri]
GO
/****** Object:  StoredProcedure [dbo].[do_procedure_2]    Script Date: 26-Nov-23 22:39:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[do_procedure_2]
AS
BEGIN
	ALTER TABLE Instrumente
	ADD CONSTRAINT df_pret DEFAULT 50.0 FOR  Pret;
	PRINT '2) Am adaugat o constrangere pentru campul "Pret" si i-am dat valoarea 50.0'
END

