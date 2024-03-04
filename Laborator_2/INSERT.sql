USE CasaDeDiscuri
GO


INSERT INTO Artisti(ArtistID, Nume, NumeDeScena, NumarAlbume)
VALUES  (1, 'Razvan', 'Deliric', 1),
		(2, 'Marius', 'Cedry2k', 1),
		(3, 'Alexandru', 'Rapha Saec', 2),
		(4, 'George', 'C.O.D', 2)

SELECT * 
FROM Artisti
 
INSERT INTO Albume(AlbumID, Denumire, NumarMelodii, ArtistID)
VALUES  (1, 'Cuvintecevindeca', 14, 2),
		(2, 'ITP', 22, 1),
		(3, 'Un album handicapat', 15, 3),
		(4, 'Proiect Esuat', 9, 3 ),
		(5, 'In spatele oglinzilor', 17, 4),
		(6, 'Apusul care mi-a vestit sfarsitul..', 14, 4)

SELECT *
FROM Albume

INSERT INTO GenMuzical(GenMuzicalID, Denumire)
VALUES  (1, 'Hip-Hop'),
		(2, 'Rap')

SELECT * 
FROM GenMuzical

INSERT INTO BeatMelodie(BeatID, NumeBeat, Leakuit)
VALUES  (1, 'MVRCU', 1),
		(2, 'The One', 0),
		(3, 'Executed', 1)

SELECT *
FROM BeatMelodie

INSERT INTO SesiuneDeInregistrare(SesiuneID, Denumire, DurataSesiune)
VALUES	(1, 'SesiuneAprilie', 13),
		(2, 'SesiuneMai', 30),
		(3, 'SesiuneDecembrie', 16),
		(4, 'SesiuneOctombrie', 23),
		(5, 'SesiuneNoiembrie', 19)

SELECT *
FROM SesiuneDeInregistrare

INSERT INTO Instrumente(InstrumentID, Denumire, Pret, ArtistID)
VALUES  (1, 'Microfon', 24.14, 1),
		(2, 'Microfon', 100.99, 2),
		(3, 'Microfon', 50.21, 3),
		(4, 'Chitara', 400.99, 4)

SELECT *
FROM Instrumente


INSERT INTO Melodii(MelodieID, Denumire, Durata, AlbumID, GenMuzicalID, BeatID)
VALUES  (1, 'Freestyle pe prietena ta', 3, 3, 1, 1),
		(2, 'Linie de credit', 2, 3, 2, 2),
		(3, 'Fraiere', 4, 2, 1, 3),
		(4, 'Cuvintecevindeca', 2, 1, 2, 3),
		(5, 'Neprevazutul', 4, 1, 2, 2)

SELECT *
FROM Melodii

INSERT INTO ArtistMelodie(ArtistID, MelodieID)
VALUES  (1, 3),
		(2, 4),
		(2, 5),
		(3, 1),
		(4, 2),
		(3, 2)

SELECT *
FROM ArtistMelodie

INSERT INTO ArtistiSesiune(ArtistID, SesiuneID)
VALUES  (1, 1),
		(2, 4),
		(3, 5),
		(4, 5),
		(2, 3)

SELECT *
FROM ArtistiSesiune

INSERT INTO InstrumenteSesiuni(InstrumentID, SesiuneID)
VALUES  (1, 1),
		(2, 1)

SELECT *
FROM InstrumenteSesiuni

