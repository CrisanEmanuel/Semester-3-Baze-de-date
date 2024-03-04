exec inserare_testgen 1;
exec stergere_testgen 3;

exec run_test 3;
exec view_testgen 3;

select * from Tables;
select * from Views;
select * from TestViews;
select * from Tests;
select * from TestTables;
select * from TestRuns;

select * from TestRunTables;
select * from TestRunViews;

select * from SesiuneDeInregistrare
select * from Artisti
select * from ArtistiSesiune

update Tests set Name = 'DIV_SesiuneDeInregistrare_1000' where Name = 'DIV_SesiuneDeInregistrare_10' 
update Tests set Name = 'DIV_Artisti_1000' where Name = 'DIV_Artisti_10' 
update Tests set Name = 'DIV_ArtistiSesiune_1000' where Name = 'DIV_ArtistiSesiune_10'
select * from Tests

update Tests set Name = 'DIV_SesiuneDeInregistrare_10000' where Name = 'DIV_SesiuneDeInregistrare_1000' 
update Tests set Name = 'DIV_Artisti_10000' where Name = 'DIV_Artisti_1000' 
update Tests set Name = 'DIV_ArtistiSesiune_10000' where Name = 'DIV_ArtistiSesiune_1000'
select * from Tests

update TestTables set NoOfRows = 1000 where NoOfRows = 10
select * from TestTables

update TestTables set NoOfRows = 10000 where NoOfRows = 1000
select * from TestTables
