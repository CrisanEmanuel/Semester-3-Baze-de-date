USE CasaDeDiscuri
GO

-- 1) Numarul de artisti experimentati care canta la chitara (cu minim 5 albume)
SELECT COUNT(*) AS ArtistiChitaraExperimentati
FROM Artisti INNER JOIN Instrumente
ON Artisti.ArtistID = Instrumente.ArtistID	
WHERE Artisti.NumarAlbume >= 5 AND Instrumente.Denumire ='Chitara'

-- 2) Melodiile 'hip-hop' care nu dureaza foarte mult, pentru a nu plictisi (mai putin de 3 minute)
SELECT Melodii.Denumire, Melodii.Durata, GenMuzical.Denumire
FROM Melodii 
INNER JOIN GenMuzical ON Melodii.GenMuzicalID = GenMuzical.GenMuzicalID
WHERE  Melodii.Durata <=3 AND GenMuzical.Denumire LIKE 'HIP%'

-- 3) Numarul de melodii populare
SELECT COUNT(*) AS MelodiiPopulare
FROM Melodii
INNER JOIN GenMuzical ON Melodii.GenMuzicalID = GenMuzical.GenMuzicalID
WHERE GenMuzical.Denumire = 'POPULARA';

-- 4) Artistii care detin instrumente rezistente la conditii de vreme rea (cele cu valoare peste 50)
SELECT Artisti.NumeDeScena
FROM Artisti
INNER JOIN Instrumente ON Artisti.ArtistID = Instrumente.ArtistID
WHERE Instrumente.Pret >= 50

-- 5) Numarul de melodii leakuite
SELECT COUNT(Melodii.MelodieID) AS MelodiiLeakuite
FROM Melodii
INNER JOIN BeatMelodie ON BeatMelodie.BeatID = Melodii.MelodieID
WHERE BeatMelodie.Leakuit = 1

-- 6) In medie cam cat dureaza o melodie de pe fiecare album
SELECT Albume.Denumire AS AlbumTitle, AVG(Melodii.Durata) AS AvgSongDuration
FROM Albume
INNER JOIN Melodii ON Albume.AlbumID = Melodii.AlbumID
GROUP BY Albume.Denumire
ORDER BY AlbumTitle;

-- 7) Artistii care abia sunt la inceput (au scos macar un album)
SELECT Artisti.ArtistID, Nume AS ArtistName, COUNT(AlbumID) AS TotalAlbums
FROM Artisti
INNER JOIN Albume ON Artisti.ArtistID = Albume.ArtistID
GROUP BY Artisti.ArtistID, Nume
HAVING COUNT(DISTINCT AlbumID) = 1;

-- 8) Cate melodii de fiecare gen exista la studio
SELECT GenMuzical.Denumire AS Genre, COUNT(Melodii.MelodieID) AS TotalSongs
FROM GenMuzical
INNER JOIN Melodii ON GenMuzical.GenMuzicalID = Melodii.GenMuzicalID
GROUP BY GenMuzical.Denumire
ORDER BY TotalSongs DESC;

-- 9) Artistii care au inregistrat la 'microfon' mai mult de 2 melodii (m-n)
SELECT Artisti.NumeDeScena
FROM Artisti
INNER JOIN ArtistMelodie ON Artisti.ArtistID = ArtistMelodie.ArtistID
INNER JOIN Melodii ON ArtistMelodie.MelodieID = Melodii.MelodieID
INNER JOIN Instrumente ON Artisti.ArtistID = Instrumente.ArtistID
GROUP BY Artisti.NumeDeScena
HAVING COUNT(Melodii.MelodieID) >= 2 AND MAX(Instrumente.Denumire) = 'Microfon';

-- 10) Numarul de sesiuni pentru fiecare artist (m-n)
SELECT Artisti.Nume AS ArtistName, COUNT(SesiuneDeInregistrare.SesiuneID) AS TotalSessions
FROM Artisti
INNER JOIN ArtistiSesiune ON Artisti.ArtistID = ArtistiSesiune.ArtistID
INNER JOIN SesiuneDeInregistrare ON ArtistiSesiune.SesiuneID = SesiuneDeInregistrare.SesiuneID
GROUP BY Artisti.Nume
ORDER BY TotalSessions DESC;

-- 11) Localitatiile unde se afla artistii 
SELECT DISTINCT Oras
FROM Artisti



