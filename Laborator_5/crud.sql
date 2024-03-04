-- Constrangeri pentru BeatMelodie
alter table BeatMelodie
alter column NumeBeat varchar(255) not null;
go

-- Functii de validare a datelor din tabela BeatMelodie
create or alter function ValidareNumeBeat (@numeBeat varchar(255))
returns bit
as
begin
	declare @valid bit = 1;
	if @numeBeat is null or @numeBeat like ''
		set @valid = 0;
	return @valid;
end;
go

create or alter function ValidareLeakuit(@bitValue varchar(5))
returns bit
as
begin
    declare @isValid bit = 0;

    if @bitValue is not null and @bitValue in ('0', '1', 'true', 'false')
        set @isValid = 1;
    return @isValid;
end;
go

-- Procedura pentru inserare in tabelul BeatMelodie (CREATE)
create or alter procedure InsertBeat
							@numeBeat varchar(255),
							@leakuit varchar(5),
							@beatId int output,
							@succes bit output
as
begin
	if dbo.ValidareNumeBeat(@numeBeat) = 1 and dbo.ValidareLeakuit(@leakuit) = 1
		begin
			insert into BeatMelodie(NumeBeat, Leakuit)
			values (@numeBeat, @leakuit);
			set @beatId = SCOPE_IDENTITY();
			set @succes = 1;
		end
	else 
		set @succes = 0;
end;
go

-- Procedura pentru obtinerea unui beat (READ)
create or alter procedure ReadBeat
						@beatId int,
						@succes bit output
as
begin
	if (not exists(select * from BeatMelodie where BeatID = @beatId))
		begin
			set @succes = 0;
			return;
		end
	else
		begin
			set @succes = 1;
			select * from BeatMelodie where BeatID = @beatId;
		end
end;
go

-- Procedura pentru update la leak-ul unui beat (UPDATE)
create or alter procedure UpdateBeat
						@beatId int,
						@leak_nou varchar(5),
						@succes bit output
as
begin
	if (not exists(select * from BeatMelodie where BeatID = @beatId) or dbo.ValidareLeakuit(@leak_nou) = 0)
		begin
			set @succes = 0;
			return;
		end
	else
		begin
			update BeatMelodie set Leakuit = @leak_nou where BeatID = @beatId;
			set @succes = 1;
		end
end;
go


-- Procedura pentru delete la un beat (DELETE)
create or alter procedure DeleteBeat
						@beatId int,
						@succes bit output
as
begin
	if (not exists(select * from BeatMelodie where BeatID = @beatId) or exists(select * from ProducatorBeat where BeatID = @beatId))
		begin
			set @succes = 0;
			return;
		end
	else
		begin
			delete from BeatMelodie where BeatID = @beatId;
			set @succes = 1;
		end
end;
go

-----------------------------------------------------------------------

-- Constrangeri pentr tabela Producator
alter table Producator
alter column Nume varchar(255) not null;

alter table Producator
alter column Telefon int not null;

alter table Producator
add constraint ck_TelefonValid
check (Telefon between 100000 and 100000000);

alter table Producator
alter column Email varchar(255) not null;
go

-- Functii de validare a datelor din tabela Producator
create or alter function ValidareNumeProducator (@nume varchar(255))
returns bit
as
begin
	declare @valid bit = 1;
	if @nume is null or @nume like ''
		set @valid = 0;
	return @valid;
end;
go

create or alter function ValidareEmail (@email varchar(255))
returns bit
as
begin
	declare @valid bit = 1;
	if @email is null or @email like ''
		set @valid = 0;
	return @valid;
end;
go

create or alter function ValidareTelefon (@telefon int)
returns bit
as
begin
	declare @valid bit = 1;
	if @telefon is null or (@telefon < 100000 or @telefon > 100000000)
		set @valid = 0;
	return @valid;
end;
go


-- Procedura pentru inserare in Producator (CREATE)
create or alter procedure InsertProducator
						@nume varchar(255),
						@telefon int,
						@email varchar(255),
						@succes bit output,
						@poducatorId int output
as
begin
	if dbo.ValidareNumeProducator(@nume) = 1 and dbo.ValidareTelefon(@telefon) = 1 and dbo.ValidareEmail(@email) = 1
		begin
			insert into Producator(Nume, Telefon, Email)
			values (@nume, @telefon, @email);
			set @poducatorId = SCOPE_IDENTITY();
			set @succes = 1;
		end
	else 
		set @succes = 0;
end;
go

-- Procedura pentru obtinerea unui producator (READ)
create or alter procedure ReadProducator
						@producatorId int,
						@succes bit output
as
begin
	if (not exists(select * from Producator where ProducatorID = @producatorId))
		begin
			set @succes = 0;
			return;
		end
	else
		begin
			set @succes = 1;
			select * from Producator where ProducatorID = @producatorId;
		end
end;
go

-- Procedura pentru update la emailul unui producator (UPDATE)
create or alter procedure UpdateProducator
						@producatorId int,
						@email_nou varchar(5),
						@succes bit output
as
begin
	if (not exists(select * from Producator where ProducatorID = @producatorId) or dbo.ValidareEmail(@email_nou) = 0)
		begin
			set @succes = 0;
			return;
		end
	else
		begin
			update Producator set Email = @email_nou where ProducatorID = @producatorId;
			set @succes = 1;
		end
end;
go


-- Procedura pentru delete la un praducator (DELETE)
create or alter procedure DeleteProducator
						@producatorId int,
						@succes bit output
as
begin
	if (not exists(select * from Producator where ProducatorID = @producatorId) or exists(select * from ProducatorBeat where ProducatorID = @producatorId))
		begin
			set @succes = 0;
			return;
		end
	else
		begin
			delete from Producator where ProducatorID = @producatorId;
			set @succes = 1;
		end
end;
go

-----------------------------------------------------------------------

--Functii pentru validarea capurilor BeatID si PromotieID din tabela ProducatorBeat
create or alter function ValidareBeatID (@beatId int)
returns bit
as
begin
	declare @valid bit = 1;
	if @beatId is null
		set @valid = 0;
	if (not exists(select * from BeatMelodie where BeatID = @beatId))
		set @valid = 0;
	return @valid;
end;
go

create or alter function ValidareProducatorID (@producatorId int)
returns bit
as
begin
	declare @valid bit = 1;
	if @producatorId is null
		set @valid = 0;
	if (not exists(select * from Producator where ProducatorID = @producatorId))
		set @valid = 0;
	return @valid;
end;
go

-- Procedura pentru inserare in tabela ProducatorBeat (CREATE)
create or alter procedure InsertProducatorBeat
						@beatId int,
						@producatorId int,
						@producatorBeatId int output,
						@succes bit output
as
begin
	if dbo.ValidareBeatID(@beatId) = 1 and dbo.ValidareProducatorID(@producatorId) = 1 and
	not exists(select * from ProducatorBeat where BeatID = @beatId and ProducatorID = @producatorId)
		begin
			insert into ProducatorBeat(BeatID, ProducatorID)
			values (@beatId, @producatorId);
			set @producatorBeatId = SCOPE_IDENTITY();
			set @succes = 1;
		end
	else
		set @succes = 0;
end;
go

-- Procedura pentru citirea din ProducatorBeat (READ)
create or alter procedure ReadProducatorBeat
						@beatId int,
						@producatorId int,
						@succes bit output
as
begin
	if not exists(select * from ProducatorBeat where BeatID = @beatId and ProducatorID = @producatorId)
		begin
			set @succes = 0;
			return;
		end
	else
		begin
			select * from ProducatorBeat where BeatID = @beatId and ProducatorID = @producatorId
			set @succes = 1;
		end
end;
go

-- Procedura pentru stergerea din ProducatorBeat (DELETE)
create or alter procedure DeleteProducatorBeat
						@beatId int,
						@producatorId int,
						@succes bit output
as
begin
	if not exists(select * from ProducatorBeat where BeatID = @beatId and ProducatorID = @producatorId)
		begin
			set @succes = 0;
			return;
		end
	else
		begin
			delete from ProducatorBeat where BeatID = @beatId and ProducatorID = @producatorId
			set @succes = 1;
		end
end;
go

-----------------------------------------------------------------------
-- View-uri
-- View care imi arata fiecare beat si ce producatori au participat la acel beat
create or alter view vw_BeatWithProducers as
select
    BM.BeatID,
    BM.NumeBeat,
    BM.Leakuit,
    PB.ProducatorID,
    P.Nume as NumeProducator,
    P.Telefon,
    P.Email
from BeatMelodie BM
JOIN ProducatorBeat PB  on BM.BeatID = PB.BeatID
JOIN Producator P on PB.ProducatorID = P.ProducatorID;
go

-- View care imi arata cati producatori au participat la creearea unui beat
create or alter view vw_NumProducersPerBeat as
select BM.BeatID, NumeBeat, COUNT(PB.ProducatorID) as NumProducers
from BeatMelodie BM
LEFT JOIN ProducatorBeat PB on BM.BeatID = PB.BeatID
group by BM.BeatID, BM.NumeBeat;
go

-- Indexi
--create nonclustered index IX_Producator_ProducatorID ON Producator (ProducatorID);
--create nonclustered index IX_ProducatorBeat_BeatID ON ProducatorBeat (BeatID);
--create nonclustered index IX_ProducatorBeat_ProducatorID ON ProducatorBeat (ProducatorID);

select * from vw_BeatWithProducers
select * from vw_NumProducersPerBeat

select * from BeatMelodie;
select * from Producator;
select * from ProducatorBeat;
