insert into Tables(Name)
values  ('SesiuneDeInregistrare'),
		('Artisti'),
		('ArtistiSesiune');
select * from Tables;

create view view_SesiuneDeInregistrare as
select * from SesiuneDeInregistrare;

create view view_Artisti as
select a.NumeDeScena, tr.Denumire from Artisti a
inner join Trupe tr on tr.TrupaID = a.TrupaID;


create view view_ArtistiSesiune as
select a.NumeDeScena, s.Denumire from ArtistiSesiune ses
inner join Artisti a on a.ArtistID = ses.ArtistID
inner join SesiuneDeInregistrare s on s.SesiuneID = ses.SesiuneID
group by a.NumeDeScena, s.Denumire

insert into Views 
values ('view_SesiuneDeInregistrare'),
	   ('view_Artisti'),
	   ('view_ArtistiSesiune');
select * from Views 


insert into Tests
values ('DIV_SesiuneDeInregistrare_10'),
	   ('DIV_Artisti_7'),
	   ('DIV_ArtistiSesiune_10');
select * from Tests


insert into TestTables
values	(1, 1, 10, 1),
		(2, 2, 7, 2),
		(3, 1, 10, 3),
		(3, 3, 10, 4);
select * from TestTables

insert into TestViews
values (1, 1),
	   (2, 2),
	   (3, 3);
select * from TestViews


-- pentru SesiuneDeInregsitrare
drop procedure ins_test_SesiuneDeInregistrare
create procedure ins_test_SesiuneDeInregistrare @NoOfRows int
as
begin
	set nocount on;

	declare @denumire nvarchar(100);
	declare @durata_sesiune int;
	declare @last_id int = isnull((select max(SesiuneID) from SesiuneDeInregistrare), 0) + 1;
	declare @n int = 0;

	while @n < @NoOfRows
	begin
		set @denumire = 'SesiuneDeInregistrare TEST ' + convert(varchar(10), @last_id);
		set @durata_sesiune = 100 + @last_id;

		insert into SesiuneDeInregistrare(SesiuneID, Denumire, DurataSesiune)
		values (@last_id, @denumire, @durata_sesiune);

		set @last_id = @last_id + 1;
		set @n = @n + 1;
	end
	print 'S-au inserat ' + convert(varchar(10), @NoOfRows) + ' valori in SesiuneDeInregistrare.';
end



-- pentru Artisti
drop procedure ins_test_Artisti
create procedure ins_test_Artisti @NoOfRows int
as
begin
	set nocount on;

	declare @fk int = (select top 1 TrupaID from Trupe);
	declare @nume nvarchar(255);
	declare @nume_de_scena nvarchar(255);
	declare @numar_albume int;
	declare @last_id int = isnull((select max(ArtistID) from Artisti), 0) + 1;
	declare @n int = 0;

	while @n < @NoOfRows
	begin
		set @nume = 'Nume TEST ' + convert(varchar(10), @last_id);
		set @nume_de_scena = 'Nume de scena TEST' + convert(varchar(10), @last_id);
		set @numar_albume = 100 + @last_id;

		insert into Artisti(ArtistID, Nume, NumeDeScena, NumarAlbume, TrupaID)
		values (@last_id, @nume, @nume_de_scena, @numar_albume, @fk);

		set @last_id = @last_id + 1;
		set @n = @n + 1;
	end

	print 'S-au inserat ' + convert(varchar(10), @NoOfRows) + ' valori in Artisti.';
end


-- pentru ArtistMelodie
drop procedure ins_test_ArtistiSesiune
go
create procedure ins_test_ArtistiSesiune @NoOfRows int
as
begin
	set nocount on;

	declare @n int = 0;
	declare @id_artist int = (select top 1 Artisti.ArtistID from Artisti)
	declare @id_sesiune int;

	declare cursorSesiune cursor fast_forward for
		select top(@NoOfRows) SesiuneID from SesiuneDeInregistrare;

	open cursorSesiune;

	fetch next from cursorSesiune into @id_sesiune;

	while (@n < @NoOfRows) and (@@FETCH_STATUS = 0)
	begin
		insert into ArtistiSesiune(ArtistID, SesiuneID)
		values (@id_artist, @id_sesiune);
		set @n = @n + 1;
		fetch next from cursorSesiune into @id_sesiune;
	end
	
	close cursorSesiune;
	deallocate cursorSesiune;

	print 'S-au inserat ' + convert(varchar(10), @n) + ' valori in ArtistiSesiune.';
end


-- pentru SesiuneDeInregistrare
drop procedure del_test_SesiuneDeInregistrare
create procedure del_test_SesiuneDeInregistrare
as
begin
	set nocount on;
	 delete from SesiuneDeInregistrare
	where SesiuneDeInregistrare.Denumire like 'SesiuneDeInregistrare TEST %'
	print 'S-au sters ' + convert(varchar(10), @@rowcount) + ' valori din SesiuneDeInregistrare.';
end


-- pentru Artisti
create procedure del_test_Artisti
as
begin
	set nocount on;
	delete from Artisti
	where Artisti.Nume like 'Nume TEST %'
	print 'S-au sters ' + convert(varchar(10), @@rowcount) + ' valori din Artisti.';
end

-- pentru ArtistMelodie
go
drop procedure del_test_ArtistiSesiune
create procedure del_test_ArtistiSesiune
as
begin
	set nocount on;
	delete from ArtistiSesiune;
	print 'S-au sters ' + convert(varchar(10), @@rowcount) + ' valori din ArtistiSesiune.';
end


----- Creez procedura generala de inserare -----
GO
drop procedure inserare_testgen
CREATE PROCEDURE inserare_testgen @idTest INT
AS
BEGIN
	DECLARE @numeTest NVARCHAR(50) = (SELECT T.Name FROM Tests T WHERE T.TestID = @idTest);
	DECLARE @numeTabela NVARCHAR(50);
	DECLARE @NoOfRows INT;
	DECLARE @procedura NVARCHAR(50);

	DECLARE cursorTab CURSOR FORWARD_ONLY FOR
		SELECT Tab.Name, Test.NoOfRows FROM TestTables Test
		INNER JOIN Tables Tab ON Test.TableID = Tab.TableID
		WHERE Test.TestID = @idTest
		ORDER BY Test.Position;
	OPEN cursorTab;

	FETCH NEXT FROM cursorTab INTO @numeTabela, @NoOfRows;
	WHILE (@numeTest NOT LIKE N'DIV_' + @numeTabela + N'_' + CONVERT(NVARCHAR(10), @NoOfRows)) AND (@@FETCH_STATUS = 0)
	BEGIN
		SET @procedura = N'ins_test_' + @numeTabela;
		EXECUTE @procedura @NoOfRows;
		FETCH NEXT FROM cursorTab INTO @numeTabela, @NoOfRows;
	END

	SET @procedura = N'ins_test_' + @numeTabela;
	EXECUTE @procedura @NoOfRows;

	CLOSE cursorTab;
	DEALLOCATE cursorTab;
END


----- Creez procedura generala de stergere -----
GO
drop procedure stergere_testgen
CREATE PROCEDURE stergere_testgen @idTest INT
AS
BEGIN
	DECLARE @numeTest NVARCHAR(50) = (SELECT T.Name FROM Tests T WHERE T.TestID = @idTest);
	DECLARE @numeTabela NVARCHAR(50);
	DECLARE @NoOfRows INT;
	DECLARE @procedura NVARCHAR(50);

	DECLARE cursorTab CURSOR FORWARD_ONLY FOR
		SELECT Tab.Name, Test.NoOfRows FROM TestTables Test
		INNER JOIN Tables Tab ON Test.TableID = Tab.TableID
		WHERE Test.TestID = @idTest
		ORDER BY Test.Position DESC;
	OPEN cursorTab;

	FETCH NEXT FROM cursorTab INTO @numeTabela, @NoOfRows;
	WHILE (@numeTest NOT LIKE N'DIV_' + @numeTabela + N'_' + CONVERT(NVARCHAR(10), @NoOfRows)) AND (@@FETCH_STATUS = 0)
	BEGIN
		SET @procedura = N'del_test_' + @numeTabela;
		EXECUTE @procedura;
		FETCH NEXT FROM cursorTab INTO @numeTabela, @NoOfRows;
	END

	SET @procedura = N'del_test_' + @numeTabela;
	EXECUTE @procedura;

	CLOSE cursorTab;
	DEALLOCATE cursorTab;
END


----- Creez procedura generala pentru view-uri -----

GO
CREATE PROCEDURE view_testgen @idTest INT
AS
BEGIN
	DECLARE @viewName NVARCHAR(50) = 
		(SELECT V.Name FROM Views V
		INNER JOIN TestViews TV ON TV.ViewID = V.ViewID
		WHERE TV.TestID = @idTest);

	DECLARE @comanda NVARCHAR(55) = 
		N'SELECT * FROM ' + @viewName;
	
	EXECUTE (@comanda);
END


----- Creez procedura de rulare a unui test -----
GO
drop procedure run_test
CREATE PROCEDURE run_test @idTest INT
AS
BEGIN
	DECLARE @startTime DATETIME;
	DECLARE @interTime DATETIME;
	DECLARE @endTime DATETIME;

	SET @startTime = GETDATE();
	
	EXECUTE stergere_testgen @idTest;
	EXECUTE inserare_testgen @idTest;
	
	SET @interTime = GETDATE();
	
	EXECUTE view_testgen @idTest;

	SET @endTime = GETDATE();

	-- var pt insert
	DECLARE @testName NVARCHAR(50) =
		(SELECT T.Name FROM Tests T WHERE T.TestID = @idTest);
	INSERT INTO TestRuns VALUES (@testName, @startTime, @endTime);

	DECLARE @viewID INT =
		(SELECT V.ViewID FROM Views V
		INNER JOIN TestViews TV ON TV.ViewID = V.ViewID
		WHERE TV.TestID = @idTest);
	DECLARE @tableID INT =
		(SELECT TB.TableID FROM Tests T
		INNER JOIN TestTables TT ON T.TestID = TT.TestID
		INNER JOIN Tables TB ON TB.TableID = TT.TableID
		WHERE T.TestID = @idTest AND 
		T.Name LIKE N'DIV_' + TB.Name + N'_' + CONVERT(NVARCHAR(10), TT.NoOfRows));
	DECLARE @testRunID INT = 
		(SELECT TOP 1 T.TestRunID FROM TestRuns T
		WHERE T.Description = @testName
		ORDER BY T.TestRunID DESC);
	
	INSERT INTO TestRunTables VALUES (@testRunID, @tableID, @startTime, @interTime);
	INSERT INTO TestRunViews VALUES (@testRunID, @viewID, @interTime, @endTime);

	PRINT CHAR(10) + '---> TEST COMPLETAT CU SUCCES IN ' + 
		 CONVERT(VARCHAR(10), DATEDIFF(millisecond, @startTime, @endTime)) +
		 ' milisecunde. <---'
END





