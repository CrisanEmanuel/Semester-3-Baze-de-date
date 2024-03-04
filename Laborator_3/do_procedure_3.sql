USE [CasaDeDiscuri]
GO
/****** Object:  StoredProcedure [dbo].[do_procedure_3]    Script Date: 26-Nov-23 22:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[do_procedure_3]
AS
BEGIN
	CREATE TABLE DJs (
	DJ_id INT PRIMARY KEY IDENTITY,
	GenMuzicalID INT,
	nume VARCHAR(30),
	pseudonim VARCHAR(30),
	experient INT,
	tarif_pe_ora FLOAT
	);
	PRINT '3) Am creat tabela DJs'
END


