USE CasaDeDiscuri
GO

CREATE TABLE PlayList (
	PlayListID		INT PRIMARY KEY IDENTITY,
	Denumire		VARCHAR(255),
	NumarDescarcari INT
);

CREATE TABLE Trupe (
	TrupaID			INT PRIMARY KEY,
	Denumire		VARCHAR(255),
	AnInfiintare	INT
);

CREATE TABLE ColectiiDeAlbume (
	ColectieID		INT PRIMARY KEY,
	Denumire		VARCHAR(255)
);

drop table Artisti
CREATE TABLE Artisti (
	ArtistID		INT PRIMARY KEY,
	Nume			VARCHAR(255),
	NumeDeScena		VARCHAR(255),
	NumarAlbume		INT,
	TrupaID			INT FOREIGN KEY REFERENCES Trupe(TrupaID) ON DELETE CASCADE
);

DROP TABLE Albume
CREATE TABLE Albume (
	AlbumID			INT PRIMARY KEY,
	Denumire		VARCHAR(255),
	NumarMelodii	INT,
	ArtistID		INT FOREIGN KEY REFERENCES Artisti(ArtistID) ON DELETE CASCADE,
	ColectieID		INT FOREIGN KEY REFERENCES ColectiiDeAlbume(ColectieID) ON DELETE CASCADE
);

CREATE TABLE GenMuzical (
	GenMuzicalID	INT PRIMARY KEY,
	Denumire		VARCHAR(100) NOT NULL
);

CREATE TABLE SesiuneDeInregistrare (
	SesiuneID		INT PRIMARY KEY,
	Denumire		VARCHAR(255) NOT NULL,
	DurataSesiune   INT 
);

DROP TABLE Instrumente
CREATE TABLE Instrumente (
	InstrumentID	INT PRIMARY KEY,
	Denumire		VARCHAR(255),
	Pret			FLOAT,
	ArtistID		INT FOREIGN KEY REFERENCES Artisti(ArtistID) UNIQUE,
);

CREATE TABLE Melodii (
	MelodieID		INT PRIMARY KEY,
	Denumire		VARCHAR(255),
	Durata			INT,
	AlbumID			INT FOREIGN KEY REFERENCES Albume(AlbumID),
	GenMuzicalID	INT FOREIGN KEY REFERENCES GenMuzical(GenMuzicalID),
	PlayListID		INT FOREIGN KEY REFERENCES PlayList(PlayListID)
);
DROP TABLE ArtistMelodie
CREATE TABLE ArtistMelodie (
	ArtistID		INT FOREIGN KEY REFERENCES Artisti(ArtistID),
	MelodieID		INT FOREIGN KEY REFERENCES Melodii(MelodieID),
	PRIMARY KEY(ArtistID, MelodieID)
);
DROP TABLE ArtistiSesiune
CREATE TABLE ArtistiSesiune (
	ArtistID INT FOREIGN KEY REFERENCES Artisti(ArtistID),
	SesiuneID INT FOREIGN KEY REFERENCES SesiuneDeInregistrare(SesiuneID)
	PRIMARY KEY(ArtistID, SesiuneID)
);

DROP TABLE InstrumenteSesiuni
CREATE TABLE InstrumenteSesiuni(
	InstrumentID	INT FOREIGN KEY REFERENCES Instrumente(InstrumentID),
	SesiuneID		INT FOREIGN KEY REFERENCES SesiuneDeInregistrare(SesiuneID),
	PRIMARY KEY(InstrumentID, SesiuneID) 
);

drop table BeatMelodie
CREATE TABLE BeatMelodie (
	BeatID			INT PRIMARY KEY IDENTITY,
	NumeBeat		VARCHAR(255),
	Leakuit			BIT
);

drop table Producator
CREATE TABLE Producator (
	ProducatorID INT PRIMARY KEY IDENTITY,
	Nume	     VARCHAR(255),
	Telefon		 INT,
	Email		 VARCHAR(255)
); 

drop table ProducatorBeat
CREATE TABLE ProducatorBeat (
	BeatID		INT FOREIGN KEY REFERENCES BeatMelodie(BeatID),
	ProducatorID  INT FOREIGN KEY REFERENCES Producator(ProducatorID),
	PRIMARY KEY(BeatID, ProducatorID)
);

