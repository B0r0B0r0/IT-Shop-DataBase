
USE master
DROP DATABASE IF EXISTS MagazinIT

CREATE DATABASE MagazinIT
ON PRIMARY
(
Name = MagazinIT,
FileName = 'C:\Users\Ayeleen\Desktop\Facultate\BazeDeDate\MagazinIT\MagazinIT0.mdf',
size = 10MB,
maxsize = unlimited,
filegrowth = 1GB
),
(
Name = MagazinITData1,
FileName = 'C:\Users\Ayeleen\Desktop\Facultate\BazeDeDate\MagazinIT\MagazinIT1.ndf',
size = 10MB,
maxsize = unlimited,
filegrowth = 1GB
),
(
Name = MagazinITData2,
FileName = 'C:\Users\Ayeleen\Desktop\Facultate\BazeDeDate\MagazinIT\MagazinIT2.ndf',
size = 10MB,
maxsize = unlimited,
filegrowth = 1GB
)
LOG ON
(
Name = MagazinITLog1,
FileName = 'C:\Users\Ayeleen\Desktop\Facultate\BazeDeDate\MagazinIT\log1.ldf',
size = 10MB,
maxsize = unlimited,
filegrowth = 1024MB
),
(
Name = MagazinITLog2,
FileName = 'C:\Users\Ayeleen\Desktop\Facultate\BazeDeDate\MagazinIT\log2.ldf',
size = 10MB,
maxsize = unlimited,
filegrowth = 1024MB
)
go
use MagazinIT





IF OBJECT_ID('Impozite','u') is not null
	DROP TABLE Impozite
GO
CREATE TABLE Impozite (
  id INT PRIMARY KEY IDENTITY(1,1),
  nume VARCHAR(50),
  valoare DECIMAL(10,2)
);




IF OBJECT_ID('Categorii','u') is not null
	DROP TABLE Categorii
GO
CREATE TABLE Categorii (
  id INT PRIMARY KEY IDENTITY(1,1),
  nume VARCHAR(50),
  descriere VARCHAR(255)
);
 

 IF OBJECT_ID('Furnizori','u') is not null
	DROP TABLE Furnizori
GO
CREATE TABLE Furnizori (
  id INT PRIMARY KEY IDENTITY(1,1),
  nume VARCHAR(50),
  adresa VARCHAR(255),
  telefon VARCHAR(20)
);

IF OBJECT_ID('Produse','u') is not null
	DROP TABLE Produse
GO
CREATE TABLE Produse (
  id INT PRIMARY KEY IDENTITY(1,1),
  nume VARCHAR(50),
  descriere VARCHAR(255),
  pret DECIMAL(10,2),
  categorie_id INT REFERENCES Categorii(id) ON DELETE CASCADE,
  furnizor_id INT REFERENCES Furnizori(id) ON DELETE CASCADE
);


IF OBJECT_ID('Angajati','u') is not null
	DROP TABLE Angajati
GO
CREATE TABLE Angajati (
  id INT PRIMARY KEY IDENTITY(1,1),
  nume VARCHAR(50),
  CNP VARCHAR(13),
  adresa VARCHAR(255),
  data_angajarii DATE,
  salariu_net DECIMAL(10,2),
  CONSTRAINT CHK_CNP CHECK (isnumeric(CNP)=1 AND len(CNP)=13)
);

IF OBJECT_ID('ImpoziteAngajati','u') is not null
	DROP TABLE ImpoziteAngajati
GO
CREATE TABLE ImpoziteAngajati(
	id INT PRIMARY KEY IDENTITY(1,1),
	idImpozit INT REFERENCES Impozite(id) ON DELETE CASCADE,
	idAngajat INT REFERENCES Angajati(id) ON DELETE CASCADE
)

IF OBJECT_ID('Clienti','u') is not null
	DROP TABLE Clienti
GO
CREATE TABLE Clienti (
  id INT PRIMARY KEY IDENTITY(1,1),
  nume VARCHAR(50),
  adresa VARCHAR(255),
  telefon VARCHAR(20)
);




IF OBJECT_ID('Plati','u') is not null
	DROP TABLE Plati
GO
CREATE TABLE Plati (
  id INT PRIMARY KEY IDENTITY(1,1),
  data_plata DATE,
  suma DECIMAL(10,2)
);

IF OBJECT_ID('Livrari','u') is not null
	DROP TABLE Livrari
GO
CREATE TABLE Livrari (
  id INT PRIMARY KEY IDENTITY(1,1),
  data_livrare DATE,
  status_livrare VARCHAR(50)
);

IF OBJECT_ID('Comenzi','u') is not null
	DROP TABLE Comenzi
GO
CREATE TABLE Comenzi (
  id INT PRIMARY KEY IDENTITY(1,1),
  data_comanda DATE,
  tip_comanda VARCHAR(50),
  client_id INT REFERENCES Clienti(id) ON DELETE CASCADE,
  livrare_id INT REFERENCES Livrari(id) ON DELETE CASCADE,
  angajat_id INT REFERENCES Angajati(id) ON DELETE CASCADE
);

IF OBJECT_ID('Facturi','u') is not null
	DROP TABLE Facturi
GO
CREATE TABLE Facturi (
  id INT PRIMARY KEY IDENTITY(1,1),
  data_factura DATE,
  comanda_id INT REFERENCES Comenzi(id) ON DELETE CASCADE,
  plata_id INT REFERENCES Plati(id) ON DELETE CASCADE
);


IF OBJECT_ID('Stoc','u') is not null
	DROP TABLE Stoc
GO
CREATE TABLE Stoc (
  id INT PRIMARY KEY IDENTITY(1,1),
  produs_id INT REFERENCES Produse(id) ON DELETE CASCADE,
  cantitate INT,
  locatie VARCHAR(50)
);

IF OBJECT_ID('Functii','u') is not null
	DROP TABLE Functii
GO
CREATE TABLE Functii (
  id INT PRIMARY KEY IDENTITY(1,1),
  nume VARCHAR(50),
  salariu_brut DECIMAL(10,2)
);

IF OBJECT_ID('IstoricFunctii','u') is not null
	DROP TABLE IstoricFunctii
GO
CREATE TABLE IstoricFunctii (
  id INT PRIMARY KEY IDENTITY(1,1),
  angajat_id INT REFERENCES Angajati(id) ON DELETE CASCADE,
  functie_id INT REFERENCES Functii(id) ON DELETE CASCADE,
  data_inceput DATE,
  data_sfarsit DATE
);

IF OBJECT_ID('ComenziProduse','u') is not null
	DROP TABLE ComenziProduse
GO
CREATE TABLE ComenziProduse (
  id INT PRIMARY KEY IDENTITY(1,1),
  cantitate INT,
  produs_id INT REFERENCES Produse(id) ON DELETE CASCADE,
  comanda_id INT REFERENCES Comenzi(id) ON DELETE CASCADE
);


INSERT INTO Impozite (nume, valoare)
VALUES 
('Asigurari sociale',0.1),
('Asigurari de sanatate',0.25),
('Fondul de somaj',0.05),
('Impozit pe casa',0.05),
('Impozit pe masina',0.03)



INSERT INTO Angajati (nume, CNP, adresa, data_angajarii, salariu_net) VALUES
('Popescu Ion', '5050304403057', 'Str. Primaverii nr. 10', '2021-01-01', 3500.00),
('Ionescu Maria', '2980816123168', 'Str. Aviatiei nr. 25', '2021-02-01', 3000.00),
('Radu Andrei', '1910503285596', 'Str. Libertatii nr. 5', '2021-03-01', 4000.00),
('Popa Mihaela', '6000419356293', 'Str. Stefan cel Mare nr. 15', '2021-04-01', 2500.00),
('Georgescu Alin', '5020109409455', 'Str. Unirii nr. 7', '2021-05-01', 3200.00),
('Dumitru Ana', '6051015011116', 'Str. Aurel Vlaicu nr. 12', '2021-06-01', 2800.00),
('Dragomir Mihai', '5021212441469', 'Str. Mihai Eminescu nr. 17', '2021-07-01', 3800.00),
('Stoica Laura', '2920118246825', 'Str. Grigore Vieru nr. 4', '2021-08-01', 4200.00),
('Popescu Dan', '1960605348458', 'Str. Tudor Vladimirescu nr. 9', '2021-09-01', 2700.00),
('Ionascu Andreea', '2940121273760', 'Str. Traian nr. 21', '2021-10-01', 3100.00),
('Marin Razvan', '1940210158836', 'Str. Decebal nr. 13', '2021-11-01', 3600.00),
('Munteanu Maria', '2990925519156', 'Str. Garii nr. 8', '2021-12-01', 2900.00),
('Popescu Ioana', '6000415387675', 'Str. Vasile Alecsandri nr. 3', '2022-01-01', 3300.00),
('Constantinescu Stefan', '1911011240726', 'Str. Stefan cel Mare nr. 10', '2022-02-01', 3900.00),
('Avram Cristina', '6030920151071', 'Str. Bucuresti nr. 19', '2022-03-01', 2600.00);

INSERT INTO Functii (nume, salariu_brut) VALUES 
('Manager', 6000.00),
('Programator', 5000.00),
('Contabil', 4000.00),
('Secretar', 3000.00),
('Vanzator', 3500.00);

INSERT INTO Clienti (nume, adresa, telefon)
VALUES
('Alexandru Popescu', 'Bucuresti, Str. Calea Dorobanti nr. 15', '0765256347'),
('Andreea Ionescu', 'Brasov, Str. Republicii nr. 5', '0754258964'),
('Mihai Marinescu', 'Cluj-Napoca, Str. Memorandumului nr. 10', '0754120142'),
('Diana Avramescu', 'Iasi, Str. Stefan cel Mare nr. 20', '0745695125'),
('Radu Popa', 'Timisoara, Str. Ion Creanga nr. 7', '0758965478'),
('Laura Georgescu', 'Bucuresti, Str. Piata Amzei nr. 3', '0789852147'),
('Adrian Vasilescu', 'Suceava, Str. Stefan cel Mare nr. 17', '0789652321'),
('Gabriela Dumitrescu', 'Braila, Str. Independentei nr. 10', '0764356194'),
('Cristina Stefanescu', 'Craiova, Str. Calea Bucuresti nr. 25', '0754316425'),
('Dan Popescu', 'Pitesti, Str. Armand Calinescu nr. 7', '0728643197'),
('Simona Tudor', 'Bucuresti, Str. Soseaua Oltenitei nr. 12', '0752321456'),
('George Iacob', 'Targu Mures, Str. Mihai Viteazu nr. 20', '0785369841'),
('Andrei Stanescu', 'Bacau, Str. Vasile Alecsandri nr. 7', '0758960457'),
('Ioana Popovici', 'Constanta, Str. Dezrobirii nr. 10', '0712753951'),
('Victor Radulescu', 'Brasov, Str. Lunga nr. 13', '0755322988');

INSERT INTO Categorii (nume, descriere) VALUES
('Monitoare','Componente pentru calculatoare ce furnizeaza outputul video'),
('Procesoare', 'Componente pentru calculatoare ce efectuează operații matematice și logice.'),
('Plăci de bază', 'Componente pentru calculatoare care conectează toate celelalte componente.'),
('Plăci video', 'Componente pentru calculatoare ce generează și afișează imagini.'),
('Memorii RAM', 'Componente pentru calculatoare ce stochează temporar date în timpul funcționării.'),
('Hard disk-uri', 'Componente pentru calculatoare ce stochează date în mod permanent.'),
('Solid-state drive-uri', 'Componente pentru calculatoare ce stochează date în mod permanent folosind tehnologie flash.'),
('Surse de alimentare', 'Componente pentru calculatoare ce furnizează energie electrică către celelalte componente.'),
('Coolere', 'Componente pentru calculatoare ce ajută la răcirea celorlalte componente.'),
('Carcase', 'Componente pentru calculatoare care conțin și protejează celelalte componente.'),
('Tastaturi', 'Componente pentru calculatoare ce furnizeaza inputul utilizatorului'),
('Mouse-uri','Componente pentru calculatoare ce furnizeaza inputul in doua dimensiuni a utilizatorului'),
('Boxe','Componente pentru calculatoare ce furnizeaza outputul audio'),
('Microfoane','Componente pentru calculatoare ce furnizeaza inputul audio'),
('Webcam-uri','Componente pentru calculatoare ce furnizeaza inputul video');

INSERT INTO Furnizori (nume, adresa, telefon)
VALUES
('ABC Computers', 'Str. Libertatii nr. 1, Bucuresti', '0744 123 456'),
('PC Parts', 'Str. Stefan cel Mare nr. 2, Cluj-Napoca', '0722 987 654'),
('Tech Solutions', 'Str. Victoriei nr. 3, Timisoara', '0755 456 789'),
('GigaByte Store', 'Str. Unirii nr. 4, Brasov', '0766 234 567'),
('Cooler Master', 'Str. Aviatorilor nr. 5, Iasi', '0745 345 678'),
('ASUS Romania', 'Str. Bucuresti-Ploiesti nr. 6, Otopeni', '0721 567 890'),
('MSI Computers', 'Str. Garii nr. 7, Oradea', '0744 678 901'),
('Corsair Romania', 'Str. Mihai Viteazu nr. 8, Sibiu', '0722 345 678'),
('Intel Corporation', 'Str. Aurel Vlaicu nr. 9, Cluj-Napoca', '0755 789 012'),
('AMD Romania', 'Str. Libertatii nr. 10, Bucuresti', '0766 567 890'),
('Nvidia', 'Str. Timisoarei nr. 11, Timisoara', '0745 890 123'),
('Western Digital', 'Str. Bucuresti nr. 12, Suceava', '0721 234 567');


INSERT INTO Stoc (produs_id, cantitate, locatie) VALUES
(1, 50, 'Bucuresti'),
(2, 25, 'Cluj-Napoca'),
(3, 30, 'Timisoara'),
(4, 20, 'Iasi'),
(5, 15, 'Brasov'),
(6, 35, 'Constanta'),
(7, 10, 'Oradea'),
(8, 5, 'Sibiu'),
(9, 8, 'Craiova'),
(10, 40, 'Ploiesti'),
(11, 20, 'Bacau'),
(12, 15, 'Arad'),
(13, 25, 'Suceava'),
(14, 30, 'Galati');



INSERT INTO Produse (nume, descriere, pret, categorie_id, furnizor_id)
VALUES ('Procesor Intel Core i7-11700K', 'Procesor pentru desktop cu 8 nuclee și 16 fire de execuție', 2399.99, 2, 9),
('Placă video NVIDIA GeForce RTX 3080', 'Placă video cu 10 GB de memorie video GDDR6X', 5999.99, 4, 11),
('Memorie RAM Corsair Pro DDR4 3200 MHz 32GB', 'Kit dual-channel cu două module de 16 GB fiecare', 899.99, 5, 2),
('SSD Samsung 970 EVO Plus 1TB', 'Unitate SSD NVMe cu viteză de citire/ scriere de până la 3500/3300 MB/s', 1399.99, 7, 3),
('Placă de bază ASUS ROG Maximus XIII Hero', 'Placă de bază pentru procesoare Intel cu suport pentru PCI Express 4.0', 2999.99, 3, 4),
('Sursă Corsair RM1000x 1000W', 'Sursă de alimentare modulară cu certificare 80 Plus Gold', 1399.99, 8, 3),
('Carcasă NZXT H510 Elite', 'Carcasă pentru PC cu iluminare RGB și geam din sticlă securizată', 999.99, 10, 2),
('Cooler CPU NZXT Kraken X63', 'Sistem de răcire cu lichid pentru procesoare Intel și AMD', 799.99, 9, 5),
('Tastatură mecanică Corsair K95 RGB Platinum XT', 'Tastatură mecanică cu iluminare RGB și switch-uri Cherry MX Brown', 999.99, 11, 7),
('Mouse gaming Logitech G Pro X Superlight', 'Mouse wireless cu senzor HERO 25K și greutate de doar 63 de grame', 799.99, 12, 1),
('Monitor gaming ASUS ROG Swift PG279QZ', 'Monitor IPS cu diagonală de 27 de inch și rezoluție 2560 x 1440', 2999.99, 1, 10),
('Boxe Logitech G560', 'Sistem de boxe pentru PC cu iluminare RGB și tehnologie DTS:X Ultra 2.0', 1499.99, 13, 1),
('Microfon Blue Yeti X', 'Microfon cu diafragmă de 19 mm și 4 capsule condenser', 999.99, 14, 3),
('Webcam Logitech StreamCam', 'Webcam Full HD cu autofocus și iluminare automată', 799.99, 15, 12);



INSERT INTO Comenzi (data_comanda, tip_comanda, client_id, livrare_id, angajat_id)
VALUES 
('2023-05-01', 'Ramburs', 1, 1, 1),
('2023-05-02', 'Plata cu card', 2, 2, 2),
('2023-05-03', 'Ramburs', 3, 3, 3),
('2023-05-04', 'Plata cu card', 4, 4, 4),
('2023-05-05', 'Ramburs', 5, 5, 5),
('2023-05-06', 'Plata cu card', 6, 6, 6),
('2023-05-07', 'Ramburs', 7, 7, 7),
('2023-05-08', 'Plata cu card', 8, 8, 8),
('2023-05-09', 'Ramburs', 9, 9, 9),
('2023-05-10', 'Plata cu card', 10, 10, 10),
('2023-05-11', 'Ramburs', 11, 11, 11),
('2023-05-12', 'Plata cu card', 12, 12, 12),
('2023-05-13', 'Ramburs', 13, 13, 13),
('2023-05-14', 'Plata cu card', 14, 14, 14),
('2023-05-15', 'Ramburs', 15, 15, 15);


INSERT INTO Livrari (data_livrare, status_livrare) VALUES
(NULL, 'In curs de livrare'),
('2023-05-02', 'Livrat'),
('2023-05-03', 'Livrat'),
('2023-05-04', 'Livrat'),
(NULL, 'In curs de livrare'),
(NULL, 'In curs de livrare'),
('2023-05-07', 'Livrat'),
(NULL, 'In curs de livrare'),
(NULL, 'In curs de livrare'),
('2023-05-10', 'Livrat'),
(NULL, 'In curs de livrare'),
('2023-05-12', 'Livrat'),
('2023-05-13', 'Livrat'),
(NULL, 'In curs de livrare'),
(NULL, 'In curs de livrare');


INSERT INTO IstoricFunctii(angajat_id,functie_id,data_inceput,data_sfarsit) VALUES
(1,4,'2021-01-01',NULL),
(2,2,'2021-02-01',NULL),
(3,4,'2021-03-01',NULL),
(4,3,'2021-04-01',NULL),
(5,5,'2021-05-01',NULL),
(6,2,'2021-06-01',NULL),
(7,4,'2021-07-01',NULL),
(8,1,'2021-08-01',NULL),
(9,3,'2021-09-01',NULL),
(10,5,'2021-10-01',NULL),
(11,4,'2021-11-01',NULL),
(12,5,'2021-12-01',NULL),
(13,2,'2022-01-01',NULL),
(14,3,'2022-02-01',NULL),
(15,5,'2022-03-01',NULL);


INSERT INTO Plati (data_plata, suma)
VALUES 
('2023-05-01', 500.00),
('2023-05-02', 750.00),
('2023-05-03', 1000.00),
('2023-05-04', 300.00),
('2023-05-05', 900.00),
('2023-05-06', 600.00),
('2023-05-07', 850.00),
('2023-05-08', 700.00),
('2023-05-09', 950.00),
('2023-05-10', 400.00),
('2023-05-11', 550.00),
('2023-05-12', 800.00),
('2023-05-13', 1200.00),
('2023-05-14', 1500.00),
('2023-05-15', 2000.00);


INSERT INTO Facturi (data_factura, comanda_id, plata_id) VALUES
('2023-05-01', 2, 1),
('2023-04-29', 3, 2),
('2023-04-27', 4, 3),
('2023-04-25', 5, 4),
('2023-04-22', 6, 5),
('2023-04-20', 7, 6),
('2023-04-18', 8, 7),
('2023-04-15', 9, 8),
('2023-04-13', 10, 9),
('2023-04-11', 11, 10),
('2023-04-08', 12, 11),
('2023-04-06', 13, 12),
('2023-04-04', 14, 13),
('2023-04-01', 15, 14),
('2023-04-02', 16, 15);



INSERT INTO ComenziProduse (cantitate, produs_id, comanda_id)
VALUES 
  (3, 1, 2),
  (1, 2, 3),
  (2, 3, 4),
  (1, 4, 5),
  (4, 5, 6),
  (2, 6, 7),
  (3, 7, 8),
  (2, 8, 9),
  (1, 9, 10),
  (5, 10, 11),
  (2, 11, 12),
  (1, 12, 13),
  (3, 13, 14),
  (2, 14, 15),
  (1, 4, 16);



  INSERT INTO ImpoziteAngajati(idAngajat,idImpozit)
  VALUES
  (1,1),
  (2,2),
  (3,3),
  (4,4),
  (5,5),
  (6,1),
  (7,2),
  (8,3),
  (9,4),
  (10,5),
  (11,1),
  (12,2),
  (13,3),
  (14,4),
  (15,5);

  
--------------------------------- Selecturi ---------------------------------------
--1
select * from Angajati;
--2
select * from Categorii;
--3
select * from Clienti;
--4
select * from Comenzi;
--5
select * from ComenziProduse;
--6
select * from Facturi;
--7
select * from Functii;
--8
select * from Furnizori;
--9
select * from Impozite;
--10
select * from ImpoziteAngajati;
--11
select * from IstoricFunctii;
--12
select * from Livrari;
--13
select * from Plati;
--14
select * from Produse;
--15
select * from Stoc;

--16.Afiseaza numele produsului, categoria din care face parte si furnizorul
SELECT p.nume, c.nume
AS categorie, f.nume
AS furnizor 
FROM Produse p 
JOIN Categorii c 
ON p.categorie_id = c.id 
JOIN Furnizori f 
ON p.furnizor_id = f.id

--17.Afiseaza ce produse au fost date in comenzi
SELECT p.nume, 
SUM(cp.cantitate) 
AS total_cantitate 
FROM Produse p 
JOIN ComenziProduse cp 
ON p.id = cp.produs_id 
GROUP BY p.nume

--18.Afiseaza suma totala de plata a clientilor
SELECT c.nume, 
SUM(p.suma) 
AS total_plata
FROM Clienti c 
JOIN Comenzi cc
on cc.client_id = c.id
JOIN Facturi f 
ON cc.id = f.comanda_id
JOIN Plati p 
ON f.plata_id = p.id  
GROUP BY c.nume


--19.Afiseaza totalul de comenzi a unui 
SELECT c.nume, 
COUNT(client_id) AS total_comenzi 
FROM Clienti c 
JOIN Comenzi co 
ON c.id = co.client_id 
GROUP BY c.nume 


--20.Afiseaza fiecare produs in cate comenzi este
SELECT p.nume, 
COUNT(produs_id) AS total_comenzi 
FROM Produse p 
JOIN ComenziProduse cp 
ON p.id = cp.produs_id 
JOIN Comenzi co 
ON cp.comanda_id = co.id 
GROUP BY p.nume 


--21.Afiseaza angajatii si ce functii au
SELECT a.nume, f.nume 
AS functie 
FROM Angajati a 
JOIN IstoricFunctii fi 
ON a.id = fi.angajat_id 
JOIN Functii f 
ON fi.functie_id = f.id 
ORDER BY a.nume ASC


--22.Afiseaza numarul de functii pe care le-a avut sau le are un angajat
SELECT a.nume, 
COUNT(functie_id) AS total_functii 
FROM Angajati a 
JOIN IstoricFunctii fi 
ON a.id = fi.angajat_id 
GROUP BY a.nume 


--23.Afiseaza salariul mediu
SELECT a.nume, 
AVG(functii.salariu_brut) 
AS salariu_mediu 
FROM Angajati a 
JOIN IstoricFunctii ifunctii 
ON a.id = ifunctii.angajat_id 
JOIN Functii functii 
ON ifunctii.functie_id = functii.id 
GROUP BY a.nume


--24.Afiseaza totalul de angajati pe o functie
SELECT f.nume, 
COUNT(angajat_id) 
AS total_angajati 
FROM Functii f 
JOIN IstoricFunctii ifunctii 
ON f.id = ifunctii.functie_id 
GROUP BY f.nume 


--25.Afiseaza totalul de cheltuieli
SELECT c.nume, 
SUM(cp.cantitate * p.pret) 
AS total_cheltuieli 
FROM Clienti c 
JOIN Comenzi co 
ON c.id = co.client_id 
JOIN ComenziProduse cp 
ON co.id = cp.comanda_id 
JOIN Produse p 
ON cp.produs_id = p.id 
GROUP BY c.nume 


--26.Afiseaza salariul maxim/brut a fiecarui angajat
SELECT a.nume, 
MAX(functii.salariu_brut) 
AS maxim_salariu 
FROM Angajati a 
JOIN IstoricFunctii ifunctii 
ON a.id = ifunctii.angajat_id 
JOIN Functii functii 
ON ifunctii.functie_id = functii.id
GROUP BY a.nume


--27.Afiseaza cantitatea totala a produselor in comenzi
SELECT p.nume 
AS produs, 
SUM(cp.cantitate) 
AS cantitate_totala 
FROM Produse p 
JOIN ComenziProduse cp 
ON p.id = cp.produs_id 
GROUP BY p.nume;


--28.Afiseaza numarul de comenzi a clientilor 
SELECT c.nume 
AS client, 
COUNT(*) 
AS numar_comenzi 
FROM Clienti c 
JOIN Comenzi comenzi 
ON c.id = comenzi.client_id 
GROUP BY c.nume 



--29.Afiseaza numarul de tipuri de produse furnizate de furnizori
SELECT f.nume 
AS furnizor, 
COUNT(p.id) 
AS [Numar tipuri produs] 
FROM Furnizori f 
JOIN Produse p 
ON f.id = p.furnizor_id 
GROUP BY f.nume;



--30.Afiseaza pretul mediu a produselor dintr-o categorie
SELECT c.nume 
AS categorie, 
AVG(p.pret) 
AS pret_mediu 
FROM Categorii c 
JOIN Produse p 
ON c.id = p.categorie_id 
GROUP BY c.nume;



--31.Afiseaza numarul de comenzi preluate de fiecare angajat
SELECT a.nume 
AS angajat, 
COUNT(*) 
AS numar_comenzi 
FROM Angajati a 
JOIN Comenzi comenzi 
ON a.id = comenzi.angajat_id 
GROUP BY a.nume 
ORDER BY numar_comenzi;



--32.Afiseaza venitul lunar pe un anumit tip de comanda
SELECT YEAR(comenzi.data_comanda) 
AS an, MONTH(comenzi.data_comanda) 
AS luna, SUM(p.pret * cp.cantitate) 
AS venit_lunar 
FROM Produse p 
JOIN ComenziProduse cp 
ON p.id = cp.produs_id 
JOIN Comenzi comenzi 
ON cp.comanda_id = comenzi.id 
WHERE comenzi.tip_comanda = 'Ramburs' 
GROUP BY YEAR(comenzi.data_comanda), MONTH(comenzi.data_comanda);




--33.Afiseaza cantitatea, categoria si produsul
SELECT c.nume 
AS categorie, p.nume 
AS produs, 
SUM(cp.cantitate) 
AS cantitate_totala 
FROM Categorii c 
JOIN Produse p 
ON c.id = p.categorie_id 
JOIN ComenziProduse cp 
ON p.id = cp.produs_id 
GROUP BY c.nume, p.nume 
ORDER BY cantitate_totala 




--34.Afiseaza numarul de comenzi preluate de fiecare angajat, cat si anul angajarii
SELECT a.nume 
AS angajat, 
YEAR(a.data_angajarii) 
AS an_angajare, 
COUNT(*) 
AS numar_comenzi 
FROM Angajati a 
JOIN Comenzi comenzi 
ON a.id = comenzi.angajat_id 
GROUP BY a.nume, YEAR(a.data_angajarii);





--35.Afiseaza numarul de produse cat si stocul
SELECT c.nume 
AS categorie, COUNT(p.id) 
AS numar_produse, SUM(stoc.cantitate) 
AS cantitate_totala 
FROM Categorii c 
JOIN Produse p 
ON c.id = p.categorie_id 
JOIN Stoc stoc 
ON p.id = stoc.produs_id 
GROUP BY c.nume;



--36.Afiseaza pretul mediu a fiecarei categorii cat si numarul de furnizori
SELECT c.nume 
AS categorie, AVG(p.pret) 
AS pret_mediu, COUNT(DISTINCT f.id) 
AS numar_furnizori 
FROM Categorii c 
JOIN Produse p 
ON c.id = p.categorie_id 
JOIN Furnizori f 
ON p.furnizor_id = f.id 
GROUP BY c.nume;




--37.Afiseaza numarul de produse vandute de la un furnizor in anul 2023
SELECT f.nume 
AS furnizor, COUNT(*) 
AS numar_produse 
FROM Furnizori f 
JOIN Produse p 
ON f.id = p.furnizor_id 
JOIN ComenziProduse cp 
ON p.id = cp.produs_id 
JOIN Comenzi comenzi 
ON cp.comanda_id = comenzi.id 
WHERE YEAR(comenzi.data_comanda) = 2023
GROUP BY f.nume;



--38.Afiseaza toate comenziile care nu au fost platite
SELECT C.data_comanda,F.data_factura FROM Comenzi C
INNER JOIN Facturi F ON C.id=F.comanda_id
INNER JOIN Plati P ON P.id = F.plata_id
WHERE P.data_plata IS NULL



-- 39.Afiseaza toate produsele din categoria "placi video" care sunt in stoc si au pretul mai mare de 1000 de lei
SELECT * FROM Produse p 
JOIN Categorii c 
ON p.categorie_id = c.id 
JOIN Stoc s 
ON p.id = s.produs_id 
WHERE c.nume = 'placi video' 
AND s.cantitate > 0 
AND p.pret > 1000;


-- 40.Afiseaza numele furnizorilor care furnizeaza produsele din categoria "tastaturi"
SELECT DISTINCT Furnizori.nume FROM Furnizori 
JOIN Produse 
ON Furnizori.id = Produse.furnizor_id 
JOIN Categorii 
ON Produse.categorie_id = Categorii.id 
WHERE Categorii.nume = 'tastaturi';



-- 41.Afiseaza numele angajatilor care au avut un salariu net mai mare de 2500 de lei
SELECT nume FROM Angajati 
WHERE salariu_net > 2500;




-- 42.Afiseaza numele angajatilor care au lucrat la comenzi plasate de clientul cu numele "Adrian Vasilescu"
SELECT DISTINCT Angajati.nume FROM Angajati 
JOIN Comenzi 
ON Angajati.id = Comenzi.angajat_id 
JOIN Clienti 
ON Comenzi.client_id = Clienti.id 
WHERE Clienti.nume = 'Adrian Vasilescu';

select * from clienti

--43.Afiseaza numele angajatilor si media salariilor brute pe care le-au avut in toate functiile in care au lucrat
SELECT Angajati.nume, AVG(Functii.salariu_brut) FROM Angajati 
JOIN IstoricFunctii 
ON Angajati.id = IstoricFunctii.angajat_id 
JOIN Functii 
ON IstoricFunctii.functie_id = Functii.id 
GROUP BY Angajati.nume;



--44.Afiseaza numele angajatilor care au lucrat ca programatori
SELECT DISTINCT Angajati.nume FROM Angajati 
JOIN IstoricFunctii 
ON Angajati.id = IstoricFunctii.angajat_id 
JOIN Functii 
ON IstoricFunctii.functie_id = Functii.id 
WHERE Functii.nume = 'Programator';


--45.Afiseaza numele angajatilor si numarul de functii diferite pe care le-au avut
SELECT Angajati.nume, COUNT(DISTINCT IstoricFunctii.functie_id) AS [Numar Functii] FROM Angajati 
JOIN IstoricFunctii 
ON Angajati.id = IstoricFunctii.angajat_id 
GROUP BY Angajati.nume;


--46.Afiseaza numele categoriilor si numarul de produse din fiecare categorie
SELECT Categorii.nume, COUNT(Produse.id) AS [Numar Produse] FROM Categorii 
JOIN Produse  
ON Categorii.id = Produse.categorie_id
GROUP BY Categorii.nume;


--47.Afiseaza numarul de comenzi a fiecarui client
SELECT c.nume AS client, COUNT(*) AS numar_comenzi FROM Clienti c 
JOIN Comenzi comenzi 
ON c.id = comenzi.client_id 
GROUP BY c.nume;


--48.Afiseaza numarul de produse vandute
SELECT p.nume AS produs, SUM(cp.cantitate) AS total_vandute FROM Produse p 
JOIN ComenziProduse cp 
ON p.id = cp.produs_id 
GROUP BY p.nume;


--49.Afiseaza numarul de tipuri de vandute furnizate de furnizori
SELECT f.nume AS furnizor, COUNT(*) AS numar_produse FROM Furnizori f 
JOIN Produse p 
ON f.id = p.furnizor_id 
GROUP BY f.nume;



--50.Afiseaza valoarea totala a tuturor comenzilor unui client
SELECT c.nume AS client, COUNT(*) AS numar_comenzi, SUM(fp.pret) AS valoare_totala FROM Clienti c 
JOIN Comenzi comenzi 
ON c.id = comenzi.client_id 
JOIN ComenziProduse cp 
ON comenzi.id = cp.comanda_id 
JOIN Produse fp 
ON cp.produs_id = fp.id 
GROUP BY c.nume;

--51.Afiseaza toți clienții care au făcut cel puțin 2 comenzi

SELECT c.nume, COUNT(*) as nr_comenzi
FROM Clienti c
JOIN Comenzi co ON c.id = co.client_id
GROUP BY c.nume
HAVING COUNT(*) >= 1


--52.Afiseaza toate categoriile de produse care au cel puțin 2 produse cu prețul mai mare de 100

SELECT cat.nume, COUNT(*) as nr_produse
FROM Categorii cat
JOIN Produse p ON cat.id = p.categorie_id
WHERE p.pret > 100
GROUP BY cat.nume
HAVING COUNT(*) >= 1


--53.Afiseaza toti angajatii care au avut cel puțin o funcție cu un salariu brut mai mare de 3000
SELECT a.nume, MAX(f.salariu_brut) as maxim_salariu
FROM Angajati a
JOIN IstoricFunctii ifunc ON a.id = ifunc.angajat_id
JOIN Functii f ON ifunc.functie_id = f.id
GROUP BY a.nume
HAVING MAX(f.salariu_brut) > 3000



--54.Afiseaza toți furnizorii care au cel puțin 1 produs în stoc la o anumită locație
SELECT f.nume, COUNT(*) as nr_produse
FROM Furnizori f
JOIN Produse p ON f.id = p.furnizor_id
JOIN Stoc s ON p.id = s.produs_id
WHERE s.locatie = 'Bucuresti'
GROUP BY f.nume
HAVING COUNT(*) >= 1


--55.Afiseaza categoriile care au mai mult de un produs
SELECT categorie_id, COUNT(*) AS numar_produse 
FROM Produse
GROUP BY categorie_id
HAVING COUNT(*) >= 1;



--56.Afiseaza toti angajații și clienții în ordine alfabetică dupa nume
SELECT nume FROM Angajati
UNION
SELECT nume FROM Clienti
ORDER BY nume ASC;


--57.Afiseaza toate produsele din categoria "Boxe" și a celor din categoria "microfoane" in ordine descrescătoare după preț
SELECT nume, pret FROM Produse WHERE categorie_id = 13
UNION
SELECT nume, pret FROM Produse WHERE categorie_id = 14
ORDER BY pret DESC;


--58.Afisaza toti furnizorii și clienții din București în ordine alfabetică:
SELECT nume FROM Furnizori WHERE adresa LIKE '%Bucuresti%'
UNION
SELECT nume FROM Clienti WHERE adresa LIKE '%Bucuresti%'
ORDER BY nume ASC;



--59.Afiseaza toate plățile care au fost efectuate înainte de data de 15 mai 2023 și a 
--cele care au fost efectuate după această dată și afișarea sumei lor totale separate pe două coloane
SELECT 'Plati inainte de 15/05/2023', SUM(suma) AS suma_totala
FROM Plati
WHERE data_plata < '2023-05-15'
UNION
SELECT 'Plati dupa 01/01/2023', SUM(suma) AS suma_totala
FROM Plati
WHERE data_plata >= '2023-05-15';	



----------------update--------------------

--1.Modifica tipul comenzii in ramburs, a comenzii cu id-ul 3
select * from Comenzi
update Comenzi 
set tip_comanda = 'Ramburs'
where id =3;
select * from Comenzi

--2.Mareste pretul la toate produsele dintr-o categoria "Microfoane"

select * from Produse
UPDATE Produse
SET pret = pret * 1.1
WHERE categorie_id = (SELECT id FROM Categorii WHERE nume = 'Microfoane')
select * from Produse

--3.Mareste impozitul la "Asigurari de sanatate"

select* from Impozite
UPDATE Impozite
SET valoare = valoare * 1.05
WHERE nume= 'Asigurari de sanatate'
select* from Impozite


--4.Modifica numarul de telefon a furnizorului "Nvidia"

select* from Furnizori
UPDATE Furnizori
SET telefon  = '0756852456'
WHERE nume = 'Nvidia'
select* from Furnizori


--5.Mareste salariul angajatului cu numele "Popa Mihaela" 

select* from Angajati
UPDATE Angajati
SET salariu_net = salariu_net * 1.1
WHERE nume = 'Popa Mihaela'
select* from Angajati



--6.Modifica stocul din Bucuresti in functie de produsele de pe comanda
select * from Stoc
UPDATE Stoc
SET cantitate = cantitate - (SELECT cantitate FROM ComenziProduse WHERE produs_id = 1 AND comanda_id = 2)
WHERE produs_id = 1 AND locatie = 'Bucuresti'
select * from Stoc


--7.Mareste produsele de pe o comanda
select * from ComenziProduse
UPDATE ComenziProduse
SET cantitate = 5
WHERE produs_id = 1 AND comanda_id = 2
select * from ComenziProduse

--8.Mareste salariul tuturor programatorilor
select * from Angajati
UPDATE Angajati
SET salariu_net = salariu_net * 1.05
WHERE id IN (SELECT angajat_id FROM IstoricFunctii WHERE functie_id = 2); 
select * from Angajati


--9.Modifica categoria boxelor "Boxe Logitech G560"
select * from Produse
UPDATE Produse
SET categorie_id = 13
WHERE nume = 'Boxe Logitech G560'
select * from Produse 




--10.Introduce modificarile aferente dupa livrarea unui produs
select * from Livrari
UPDATE Livrari
SET status_livrare = 'Livrat', data_livrare = GETDATE()
WHERE id = 14
select * from Livrari


--11.Se modifica locatia tuturor produselor furnizate de PC Parts
select F.nume, S.locatie from Produse P
Inner join Stoc S on S.produs_id=P.id
Inner join Furnizori F on F.id = P.furnizor_id
Where F.nume = 'PC Parts'

UPDATE Stoc
set Stoc.locatie = 'Barlad'
from stoc
inner join Produse p on p.id = stoc.produs_id
inner join Furnizori f on p.furnizor_id = f.id
where f.nume = 'PC Parts'

select F.nume, S.locatie from Stoc S
Inner join Produse P on S.produs_id=P.id
Inner join Furnizori F on F.id = P.furnizor_id
Where F.nume = 'PC Parts'



--12.Livreaza comanda Simonei Tudor
select cc.nume,l.data_livrare, l.status_livrare from Livrari l
inner join Comenzi c on c.livrare_id=l.id
inner join Clienti cc on cc.id=c.client_id
where cc.nume = 'Simona Tudor'

UPDATE Livrari
SET data_livrare = GETDATE(), status_livrare = 'Livrat'
from Livrari
inner join Comenzi c on c.livrare_id=Livrari.id
inner join Clienti cc on cc.id=c.client_id
where cc.nume = 'Simona Tudor'

select cc.nume,l.data_livrare, l.status_livrare from Livrari l
inner join Comenzi c on c.livrare_id=l.id
inner join Clienti cc on cc.id=c.client_id
where cc.nume = 'Simona Tudor'


--13.Modifica salariul brut a lui Radu Andrei
select A.nume,F.salariu_brut from Functii F
inner join IstoricFunctii FI on FI.functie_id = F.id
inner join Angajati A on A.id = FI.angajat_id
where A.nume = 'Radu Andrei'

UPDATE Functii
set salariu_brut = 3500
from Functii
inner join IstoricFunctii FI on FI.functie_id = Functii.id
inner join Angajati A on A.id = FI.angajat_id
where A.nume = 'Radu Andrei'

select A.nume,F.salariu_brut from Functii F
inner join IstoricFunctii FI on FI.functie_id = F.id
inner join Angajati A on A.id = FI.angajat_id
where A.nume = 'Radu Andrei'

--14.Reduc toate platile din data 2023-05-12

select C.data_comanda,P.suma from Plati P
inner join Facturi F on F.plata_id=P.id
inner join Comenzi C on C.id = F.comanda_id
where C.data_comanda = '2023-05-12'

UPDATE Plati
set suma = 1000
from Plati
inner join Facturi F on F.plata_id=Plati.id
inner join Comenzi C on C.id = F.comanda_id
where C.data_comanda = '2023-05-12'

select C.data_comanda,P.suma from Plati P
inner join Facturi F on F.plata_id=P.id
inner join Comenzi C on C.id = F.comanda_id
where C.data_comanda = '2023-05-12'



--15. Scad cantitatea de produse de pe comanda a clientului Adrian Vasilescu

select CC.nume,CP.cantitate from ComenziProduse CP
inner join Comenzi C on C.id=CP.comanda_id
inner join Clienti CC on CC.id = C.client_id
where CC.nume='Adrian Vasilescu'

Update ComenziProduse
set cantitate = 2
from ComenziProduse
inner join Comenzi C on C.id=ComenziProduse.comanda_id
inner join Clienti CC on CC.id = C.client_id
where CC.nume='Adrian Vasilescu'


select CC.nume,CP.cantitate from ComenziProduse CP
inner join Comenzi C on C.id=CP.comanda_id
inner join Clienti CC on CC.id = C.client_id
where CC.nume='Adrian Vasilescu'



--16. Modific data de livrare in NULL tuturor livrarilor cu statusul "In curs de livrare"

select * from Livrari
where status_livrare = 'In curs de livrare'

update Livrari
set data_livrare = NULL
where status_livrare = 'In curs de livrare'

select * from Livrari
where status_livrare = 'In curs de livrare'


-------------------------------Proceduri------------------------------------------


--1.Sa se adauge o comanda si sa se emita o factura
IF OBJECT_ID('Pr_Adaugare_Comanda') IS NOT NULL
DROP PROC Pr_Adaugare_Comanda;
GO
CREATE PROC Pr_Adaugare_Comanda
@Nume_Client varchar(30),
@Nume_Produs nvarchar(30),
@Numar_Produse INT

AS
BEGIN

INSERT INTO Livrari(data_livrare,status_livrare) 
Values (NULL,'In curs de livrare')

INSERT INTO Comenzi(data_comanda,tip_comanda,client_id,angajat_id,livrare_id) VALUES
(GETDATE(),
'Ramburs',
(Select top 1 Clienti.id from Clienti where Clienti.nume = @Nume_Client),
(select top 1 angajat_id from Functii
inner join IstoricFunctii FI on FI.functie_id = Functii.id
inner join Angajati A on A.id = FI.angajat_id
where Functii.nume='Vanzator'),
(select max(id) from Livrari)
)

INSERT INTO ComenziProduse(cantitate,produs_id,comanda_id) VALUES
(@Numar_Produse,
(Select top 1 id from Produse where Produse.nume=@Nume_Produs),
(Select max(id) from Comenzi)
)

UPDATE Stoc 
SET stoc.cantitate = Stoc.cantitate-@Numar_Produse
select *
FROM Stoc
inner join Produse P on P.id = Stoc.produs_id
where P.nume=@Nume_Produs


INSERT INTO Plati(data_plata,suma)
VALUES (NULL,NULL);

INSERT INTO Facturi (data_factura,comanda_id,plata_id) VALUES
(
GETDATE(),
(Select max(id) from Comenzi),
(Select max(id) from Plati)
)

END
GO


select * from Comenzi
select * from ComenziProduse
select * from Plati
select * from Facturi
select * from Livrari
select * from Stoc

Exec Pr_Adaugare_Comanda 'Radu Popa', 'Microfon Blue Yeti X', 1

select * from Comenzi
select * from ComenziProduse
select * from Plati
select * from Facturi
select * from Livrari
select * from Stoc



--2.Adaugare furnizor, categorie, stoc si produse noi

IF OBJECT_ID('Pr_Adaugare_Produs') IS NOT NULL
DROP PROC Pr_Adaugare_Produs;
GO
CREATE PROC Pr_Adaugare_Produs
@numeProdus nvarchar(255),
@numeCategorie nvarchar(255),
@numeFurnizor nvarchar(255),
@DescriereProdus nvarchar(255),
@PretProdus DECIMAL(10,2),
@DescriereCategorie nvarchar(255),
@AdresaFurnizor nvarchar(255),
@TelefonFurnizor nvarchar(255),
@CantitateStoc INT,
@LocatieStoc nvarchar(255)

AS
BEGIN

INSERT INTO Categorii(nume, descriere) VALUES
(@numeCategorie,@DescriereCategorie)

INSERT INTO Furnizori(nume,adresa,telefon) VALUES
(@numeFurnizor,@AdresaFurnizor,@TelefonFurnizor)

INSERT INTO Produse(nume,descriere,pret,categorie_id,furnizor_id) VALUES
(
	@numeProdus,
	@DescriereProdus,
	@PretProdus,
	(Select max(id) from Categorii ),
	(Select max(id) from Furnizori)	
)


INSERT INTO Stoc(produs_id,cantitate,locatie) VALUES
(
	(Select max(id) from Produse),
	@CantitateStoc,
	@LocatieStoc
)

END
GO


select * from categorii
select * from Stoc
select * from Produse
select * from Furnizori


EXEC Pr_Adaugare_Produs 'Controller Wireless PlayStation 5 (PS5) DualSense','GamePad-uri','PlayStation','Microfon incorporat si mufa jack pentru casti',
349.9,'Dispozitiv de intrare utilizat pentru a controla jocurile video','Str. Mircea Eliade nr86, Barlad','0756 321 456',444,'Vaslui'


select * from categorii
select * from Stoc
select * from Produse
select * from Furnizori

--3.Aplicarea unei reduceri variabile tuturor produselor unui furnizor


IF OBJECT_ID('Pr_Aplicare_Reducere') IS NOT NULL
DROP PROC Pr_Aplicare_Reducere;
GO
CREATE PROC Pr_Aplicare_Reducere
@numeFurnizor nvarchar(255),
@Reducere INT
AS
BEGIN
UPDATE Produse
SET pret = pret-(pret*@Reducere)/100
FROM Produse
INNER JOIN Furnizori F ON F.id=Produse.furnizor_id
WHERE F.nume=@numeFurnizor
END
GO

select * from produse
INNER JOIN Furnizori F ON F.id=Produse.furnizor_id
where F.nume = 'Nvidia'

EXEC Pr_Aplicare_Reducere 'Nvidia', 10


select * from produse
INNER JOIN Furnizori F ON F.id=Produse.furnizor_id
where F.nume = 'Nvidia'



--4.Modifica locatia stocului unui furnizor

IF OBJECT_ID('Pr_Modifica_Locatia') IS NOT NULL
DROP PROC Pr_Modifica_Locatia;
GO
CREATE PROC Pr_Modifica_Locatia
@numeFurnizor nvarchar(255),
@numeLocatie nvarchar(255)
AS
BEGIN
	UPDATE Stoc
	SET locatie = @numeLocatie
	FROM Stoc
	INNER JOIN Produse P ON P.id=Stoc.produs_id
	INNER JOIN Furnizori F ON F.id = P.furnizor_id
	WHERE F.nume=@numeFurnizor
END 
GO



select * FROM Stoc
	INNER JOIN Produse P ON P.id=Stoc.produs_id
	INNER JOIN Furnizori F ON F.id = P.furnizor_id
	WHERE F.nume='GigaByte Store'

EXEC Pr_Modifica_Locatia 'GigaByte Store', 'Slatina'



select * FROM Stoc
	INNER JOIN Produse P ON P.id=Stoc.produs_id
	INNER JOIN Furnizori F ON F.id = P.furnizor_id
	WHERE F.nume='GigaByte Store'

--5.Schimbare Functie Angajat



IF OBJECT_ID('Pr_Modifica_Functia') IS NOT NULL
DROP PROC Pr_Modifica_Functia;
GO
CREATE PROC Pr_Modifica_Functia
@numeAngajat nvarchar(255),
@numeFunctie nvarchar(255)
AS
BEGIN

UPDATE IstoricFunctii
SET data_sfarsit = GETDATE()
FROM IstoricFunctii FI
INNER JOIN Angajati A on FI.angajat_id = A.id
WHERE A.nume=@numeAngajat

INSERT INTO IstoricFunctii (angajat_id,functie_id,data_inceput,data_sfarsit) VALUES
(
	(SELECT id FROM Angajati WHERE Angajati.nume=@numeAngajat),
	(SELECT id FROM Functii WHERE Functii.nume=@numeFunctie),
	GETDATE(),
	NULL
)

END
GO

select * from Angajati A
inner join IstoricFunctii FI on FI.angajat_id = A.id
inner join Functii F on F.id = FI.functie_id
where A.nume= 'Georgescu Alin'

EXEC Pr_Modifica_Functia 'Georgescu Alin', 'Contabil'


select * from Angajati A
inner join IstoricFunctii FI on FI.angajat_id = A.id
inner join Functii F on F.id = FI.functie_id
where A.nume= 'Georgescu Alin'




--6.Sterge cea mai veche plata 

IF OBJECT_ID('Pr_Sterge_Plata_Veche') IS NOT NULL
DROP PROC Pr_Sterge_Plata_Veche;
GO
CREATE PROC Pr_Sterge_Plata_Veche

AS
BEGIN

DELETE FROM Plati
WHERE id = (SELECT TOP 1 id FROM Plati  where data_plata IS NOT NULL ORDER BY (data_plata))

END
GO 

select * from Plati
EXEC Pr_Sterge_Plata_Veche
select * from Plati

--7. Afisarea tuturor produselor care nu au fost inca livrate

IF OBJECT_ID('Pr_Afiseaza_Produse_Nelivrate') IS NOT NULL
DROP PROC Pr_Afiseaza_Produse_Nelivrate;
GO
CREATE PROC Pr_Afiseaza_Produse_Nelivrate

AS
BEGIN
SELECT * FROM Produse
INNER JOIN ComenziProduse CP ON CP.produs_id = Produse.id
INNER JOIN Comenzi C ON C.id = CP.comanda_id
INNER JOIN Livrari L ON L.id = C.livrare_id
WHERE L.data_livrare IS NULL

END
GO

EXEC Pr_Afiseaza_Produse_Nelivrate


--8. Afisarea castigului total

IF OBJECT_ID('Pr_Afiseaza_Profit') IS NOT NULL
DROP PROC Pr_Afiseaza_Profit;
GO
CREATE PROC Pr_Afiseaza_Profit

AS
BEGIN

Select
(SELECT SUM(CP.cantitate*P.pret) 
FROM ComenziProduse CP
INNER JOIN Produse P ON P.id=CP.produs_id) AS [Profit relativ],
(SELECT SUM(P.suma) FROM Plati P) AS [Profit real];

END
GO

EXEC Pr_Afiseaza_Profit





--9. Afisarea celei mai mari plati a fiecarui client


IF OBJECT_ID('Pr_Afiseaza_Plata_Maxima') IS NOT NULL
DROP PROC Pr_Afiseaza_Plata_Maxima;
GO
CREATE PROC Pr_Afiseaza_Plata_Maxima

AS
BEGIN

SELECT C.nume , MAX(P.suma) AS [Max Plata]
FROM Clienti C
INNER JOIN Comenzi CC ON C.id = CC.client_id
INNER JOIN Facturi F ON F.comanda_id = CC.id
INNER JOIN Plati P ON P.id = F.plata_id
GROUP BY C.nume

END
GO

EXEC Pr_Afiseaza_Plata_Maxima

--10. Afisarea profitului fiecarui tip de categorie

IF OBJECT_ID('Pr_Afiseaza_Profit_Categorie') IS NOT NULL
DROP PROC Pr_Afiseaza_Profit_Categorie;
GO
CREATE PROC Pr_Afiseaza_Profit_Categorie

AS
BEGIN

SELECT C.nume,SUM(PP.suma) as [Profit Categorie]
FROM Categorii C
INNER JOIN Produse P ON P.categorie_id=C.id
INNER JOIN ComenziProduse CP ON CP.produs_id=P.id
INNER JOIN Comenzi CC ON CC.id = CP.comanda_id
INNER JOIN Facturi F ON F.comanda_id = CC.id
INNER JOIN Plati PP ON PP.id = F.plata_id
GROUP BY C.nume

END
GO

EXEC Pr_Afiseaza_Profit_Categorie



----------------------------View-uri--------------------------------

--1. Se afiseaza comenzile, facturile, platile si produsele tuturor clientilor

GO
IF OBJECT_ID('V_Clienti_Comenzi_Produse', 'V') is not null 
	DROP VIEW V_Clienti_Comenzi_Produse
GO
CREATE VIEW V_Clienti_Comenzi_Produse AS
SELECT C.nume AS [Client],CC.tip_comanda,P.nume AS [Produs],P.descriere,CP.cantitate,F.data_factura,PP.suma
FROM Clienti C
INNER JOIN Comenzi CC ON CC.client_id=C.id
INNER JOIN ComenziProduse CP ON CP.comanda_id = CC.id
INNER JOIN Produse P ON P.id=CP.produs_id
INNER JOIN Facturi F ON F.comanda_id = CC.id
INNER JOIN Plati PP ON PP.id = F.plata_id
GROUP BY C.nume,CC.tip_comanda,P.nume,P.descriere,CP.cantitate,F.data_factura,PP.suma


Select * 
from V_Clienti_Comenzi_Produse



--2. Se afiseaza produsele, categoria, furnizorii si stocul ramas
	
GO
IF OBJECT_ID('V_Produse_Cat_Furn_Stoc', 'V') is not null 
	DROP VIEW V_Produse_Cat_Furn_Stoc
GO
CREATE VIEW V_Produse_Cat_Furn_Stoc AS
SELECT P.nume AS [Produs],P.descriere,P.pret,C.nume AS [Categorie],F.nume AS [Furnizor],S.cantitate
FROM Produse P
INNER JOIN Furnizori F ON F.id = P.furnizor_id
INNER JOIN Categorii C ON C.id = P.categorie_id
INNER JOIN Stoc S ON S.produs_id = P.id
GROUP BY P.nume,P.descriere,P.pret,C.nume,F.nume,S.cantitate

Select * from V_Produse_Cat_Furn_Stoc


--3. Se afiseaza functiile curente ale angajatilor

GO
IF OBJECT_ID('V_Functii_Angajati', 'V') is not null 
	DROP VIEW V_Functii_Angajati
GO
CREATE VIEW V_Functii_Angajati AS
SELECT A.nume AS [Angajat],A.CNP,FI.data_inceput AS [Data intrarii in functie],F.nume AS [Functie]
FROM Angajati A
INNER JOIN IstoricFunctii FI ON FI.angajat_id= A.id
INNER JOIN Functii F ON F.id= FI.functie_id
WHERE FI.data_sfarsit IS NULL
GROUP BY A.nume,A.CNP,FI.data_inceput,F.nume

Select * from V_Functii_Angajati

--4. Se afiseaza Livrarile, Comenzile si Produsele

GO
IF OBJECT_ID('V_Livrari_Comenzi_Produse', 'V') is not null 
	DROP VIEW V_Livrari_Comenzi_Produse
GO
CREATE VIEW V_Livrari_Comenzi_Produse AS
SELECT P.nume,CP.cantitate,C.data_comanda,L.status_livrare
FROM Livrari L
INNER JOIN Comenzi C ON C.livrare_id=L.id
INNER JOIN ComenziProduse CP ON CP.comanda_id = C.id
INNER JOIN Produse P ON P.id = CP.produs_id
GROUP BY P.nume,CP.cantitate,C.data_comanda,L.status_livrare


Select * from V_Livrari_Comenzi_Produse


--5. Se afiseaza suma cheltuita de fiecare client in magazin

GO
IF OBJECT_ID('V_Suma_Client', 'V') is not null 
	DROP VIEW V_Suma_Client
GO
CREATE VIEW V_Suma_Client AS
SELECT C.nume AS [Client],SUM(P.suma) AS [Suma]
FROM Clienti C
INNER JOIN Comenzi CC ON CC.client_id = C.id
INNER JOIN Facturi F ON F.comanda_id = CC.id
INNER JOIN Plati P ON P.id = F.plata_id
GROUP BY C.nume

Select * from V_Suma_Client


---------------------------Triggere-----------------------------------------


--1. Trigger care afiseaza un mesaj la insertia unui client

IF OBJECT_ID('Tr_Adauga_Client', 'TR') IS NOT NULL
DROP TRIGGER Tr_Adauga_Client
GO	
CREATE TRIGGER Tr_Adauga_Client
ON Clienti
AFTER INSERT
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN
SET NOCOUNT ON;
DECLARE @msg NVARCHAR(100)
SELECT @msg = 'Clientul ' + nume + ' a fost adaugat cu succes.' FROM
inserted
PRINT @msg
END
INSERT INTO Clienti(nume,adresa,telefon)
VALUES ('Cosmin Temciuc','Calea Victoriei nr 3','0755602964')

--2. Verifica daca angajatul este deja introdus, in caz contrar, il introduce

IF OBJECT_ID('Tr_Adauga_Angajat', 'TR') IS NOT NULL
DROP TRIGGER Tr_Adauga_Angajat;
GO
CREATE TRIGGER Tr_Adauga_Angajat
ON Angajati
INSTEAD OF INSERT
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN
SET NOCOUNT ON;
IF EXISTS (SELECT COUNT(*) FROM inserted
INNER JOIN Angajati
on inserted.CNP = Angajati.CNP
group by Angajati.id
HAVING COUNT(*) > = 1)
BEGIN
PRINT 'Exista deja acest angajat inregistrat';
END
ELSE
BEGIN
DECLARE @nume nvarchar(20)
SELECT @nume=Nume FROM INSERTED
DECLARE @CNP  varchar(13)
SELECT @CNP = cnp FROM INSERTED
DECLARE @adresa nvarchar(255)
SELECT @adresa=Adresa FROM INSERTED
DECLARE @dataAngajare DATE
SELECT @dataAngajare = data_angajarii FROM inserted
DECLARE @salariunet FLOAT
SELECT @salariunet = salariu_net	FROM inserted
INSERT INTO Angajati(Nume,CNP, Adresa,data_angajarii,salariu_net)
VALUES (@nume,@CNP,@adresa,@dataAngajare,@salariunet)
END
END
INSERT INTO Angajati(Nume,CNP, Adresa,data_angajarii,salariu_net) values
('Mihai Eminescu','5020429171695','Bulevardul republicii nr 75','2002-11-09','2453.7')




--3. Verificarea introducerii unei noi categorii

IF OBJECT_ID('Tr_Verificare_Categorie', 'TR') IS NOT NULL
DROP TRIGGER Tr_Verificare_Categorie;
GO
CREATE TRIGGER Tr_Verificare_Categorie
on Categorii
AFTER INSERT, UPDATE
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
IF EXISTS (SELECT COUNT(*) FROM inserted
JOIN Categorii ON inserted.nume = Categorii.nume
GROUP BY inserted.nume
HAVING COUNT(*) > 1 )
BEGIN
RAISERROR('Aceasta categorie este deja introdusa!',16,1)
ROLLBACK
END
END
INSERT INTO Categorii(nume, descriere)
values
('Coolere','Componente pentru calculatoare ce ajuta la racirea celorlalte componente.')



--4. Verificarea introducerii unui nou furnizor

IF OBJECT_ID('Tr_Verificare_Furnizor', 'TR') IS NOT NULL
DROP TRIGGER TrAdFur;
GO
CREATE TRIGGER TrAdFur
ON Furnizori
AFTER INSERT, UPDATE
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
IF EXISTS (SELECT COUNT(*)
FROM Inserted AS I
INNER JOIN Furnizori AS F ON I.Nume = F.Nume
GROUP BY I.Nume
HAVING COUNT(*) > 1 )
BEGIN
PRINT 'Nu se poate introduce, nume furnizori duplicat';
ROLLBACK
END
END
INSERT INTO Furnizori(Nume,Adresa,Telefon)
VALUES ('ABC Computers','Str. Libertatii nr. 1, Bucuresti','0744 123 456')


--5. Afisarea unui mesaj ce anunta daca operatia a fost realizata cu succes


IF OBJECT_ID('Tr_Verificare_Stoc', 'TR') IS NOT NULL
DROP TRIGGER Tr_Verificare_Stoc;
GO
CREATE TRIGGER Tr_Verificare_Stoc
ON Stoc
AFTER DELETE,INSERT,UPDATE
AS
BEGIN
PRINT('Stoc modificat cu succes!')
END
GO
INSERT INTO Stoc(produs_id,cantitate,locatie)
VALUES(5,46,'Caracal')
SELECT * FROM Stoc


--6. Verifica daca eliminarea unei facturi a fost realizata cu succes

IF OBJECT_ID('Tr_Verificare_Eliminare_Factura', 'TR') IS NOT NULL
DROP TRIGGER Tr_Verificare_Eliminare_Factura;
GO
CREATE TRIGGER Tr_Verificare_Eliminare_Factura
ON Facturi
FOR DELETE
AS
BEGIN
PRINT('Factura a fost eliminata cu succes')
END
GO
DELETE FROM Facturi WHERE id = 18




--7. Refuza inserarea unui produs cu pretul mai mic de 50 de lei



IF OBJECT_ID('Tr_Regula_Pret','tr') IS NOT NULL
DROP TRIGGER Tr_Regula_Pret
GO
CREATE TRIGGER Tr_Regula_Pret
ON Produse
FOR INSERT,DELETE
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
DECLARE @pret INT
SELECT @pret=I.Pret from inserted as I
IF(@pret < 150)
BEGIN
RAISERROR('Pretul de %d de lei este mai mic decat valoarea minima(50
RON)',16,1,@pret)
ROLLBACK
END
END
INSERT INTO Produse(nume,descriere,Pret,categorie_id,furnizor_id)
VALUES('GeForce RTX 3080','8gb VRAM, 5.0Gh',40,2,2)



--8. Opreste stergerea unei functii daca inca sunt angajati pe acea functie

IF OBJECT_ID('Tr_Regula_Eliminare_Functie','tr') IS NOT NULL
DROP TRIGGER Tr_Regula_Eliminare_Functie
GO
CREATE TRIGGER Tr_Regula_Eliminare_Functie
ON Functii
INSTEAD OF DELETE
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
DECLARE @IDFunctie INT
SELECT @IDFunctie=D.id
FROM deleted AS D
IF EXISTS( SELECT F.id, F.nume, FI.functie_id
FROM Functii AS F
INNER JOIN IstoricFunctii as FI on
FI.functie_id=F.id
WHERE FI.functie_id IS NOT NULL AND F.id=@IDFunctie)
BEGIN
RAISERROR('Functia nu poate fi stearsa, intrucat inca sunt angajati!',16,1)
ROLLBACK
END
END
DELETE F 
FROM Functii AS F
WHERE F.nume='Manager'


--9. Verifica data introdusa a comenzii
IF OBJECT_ID('Tr_Verificare_Comenzi', 'TR') IS NOT NULL
DROP TRIGGER Tr_Verificare_Comenzi;
GO
CREATE TRIGGER Tr_Verificare_Comenzi
ON Comenzi
INSTEAD OF INSERT
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN
SET NOCOUNT ON;
IF EXISTS (SELECT inserted.data_comanda FROM inserted WHERE data_comanda>GETDATE())
	BEGIN
		PRINT 'Data introdusa este incorecta';
	END
ELSE 
	BEGIN
		DECLARE @datacomanda date
		SELECT @datacomanda=data_comanda FROM INSERTED
		DECLARE @tipcomanda nvarchar(255)
		SELECT @tipcomanda=tip_comanda FROM INSERTED
		DECLARE @clientid INT
		SELECT @clientid = client_id FROM inserted
		DECLARE @livrareid INT
		SELECT @livrareid = livrare_id	FROM inserted
		DECLARE @angajatid INT
		SELECT @angajatid = angajat_id FROM inserted
		INSERT INTO Comenzi(data_comanda,tip_comanda,client_id,livrare_id,angajat_id)
		VALUES (@datacomanda,@tipcomanda,@clientid,@livrareid,@angajatid)
	END

END
GO

INSERT INTO Comenzi(data_comanda,tip_comanda,client_id,livrare_id,angajat_id)
VALUES('2023-11-11','Ramburs',1,1,1)


--10. Refuza inserarea in stoc a insertiilor cu cantitate negativa

IF OBJECT_ID('Tr_Verificare_Stoc_Negativ', 'TR') IS NOT NULL
DROP TRIGGER Tr_Verificare_Stoc_Negativ;
GO
CREATE TRIGGER Tr_Verificare_Stoc_Negativ
ON Stoc
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE cantitate < 0)
		BEGIN
			RAISERROR ('Cantitatea a fost introdusa eronat', 16, 1)
		END
    ELSE 
		BEGIN
			INSERT INTO Stoc (produs_id, cantitate, locatie)
			SELECT produs_id, cantitate, locatie
			FROM inserted
		END
END

INSERT INTO Stoc (produs_id, cantitate, locatie) values (2,-155,'Oras')
select * from Stoc


-------------------------Tranzactii---------------------------

--1.Tranzactie care verifica daca exista o persoana in BD.

BEGIN TRAN
	SELECT Nume FROM Angajati
	WHERE Nume LIKE 'Popescu Ion'
	UNION ALL
	SELECT Nume FROM Clienti
	WHERE Nume LIKE 'Popescu Ion'
	IF @@ROWCOUNT = 0
	BEGIN
		PRINT 'Persoana nu exista in BD'
		ROLLBACK TRAN;
	END
	ELSE
	BEGIN
		PRINT 'Persoana exista in BD'
		COMMIT TRAN;
END




--2.Tranzactie care verifica daca exista un produs in BD.


BEGIN TRAN
	SELECT * FROM Produse
	WHERE nume = 'Boxe Logitech G560'
	IF @@ROWCOUNT = 0
	BEGIN
		PRINT 'Nu exista produsul in BD'
		ROLLBACK TRAN;
	END
	ELSE
	BEGIN
		PRINT 'Exista produsul in BD'
		COMMIT TRAN;
	END




	
--3.Tranzactie care verifica inserarea unui produs.

BEGIN TRY
BEGIN TRAN
	SET IDENTITY_INSERT Produse ON;
	INSERT INTO Produse(id,nume,descriere,pret,categorie_id,furnizor_id)
	VALUES(3,'Nvidia GeForce Ti','2Gb, RTX', 5000.0,1,1);
	SET IDENTITY_INSERT Produse OFF;
	COMMIT TRAN;
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrorNumber
	IF ERROR_NUMBER() = 2627 
	BEGIN
		PRINT 'Primary Key violation';
	END
	ELSE IF ERROR_NUMBER() = 547 
	BEGIN
		PRINT 'Constraint violation';
	END
	ELSE
	BEGIN
		PRINT 'Unhandled error';
	END;
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
END CATCH;



--4.Tranzactie in care se verifica inserarea in tabela stoc.


BEGIN TRY
BEGIN TRAN;
	INSERT INTO stoc(produs_id, cantitate,locatie)
	VALUES(5,300,'Ramnicul Sarat');
	COMMIT TRAN;
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrorNumber
	IF ERROR_NUMBER() = 547 
	BEGIN
		PRINT 'Constraint violation';
	END
	ELSE
	BEGIN
		PRINT 'Unhandled error';
	END;
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
END CATCH;

select * from stoc

 
--5.Tranzactie in care se adauga bonus salar 200 RON celor care au fost angajati inainte de 2022.

Select Angajati.nume, Functii.salariu_brut FROM Functii
inner join IstoricFunctii on Functii.id=IstoricFunctii.functie_id
inner join Angajati on Angajati.id=IstoricFunctii.angajat_id
WHERE DATEPART(YEAR,Angajati.data_angajarii)<2022

DECLARE @errnumm AS INT;
BEGIN TRAN
	UPDATE Functii
	SET salariu_brut = salariu_brut + 200 
	FROM Functii
	inner join IstoricFunctii on Functii.id=IstoricFunctii.functie_id
	inner join Angajati on Angajati.id=IstoricFunctii.angajat_id
	WHERE DATEPART(YEAR,Angajati.data_angajarii)<2022
	SET @errnumm = @@ERROR
	IF @errnumm <> 0
	BEGIN
		PRINT 'Cresterea salariilor a esuat cu eroare: ' + CAST(@errnumm as varchar);
		ROLLBACK TRAN;
	END
	ELSE
	BEGIN
		COMMIT TRAN;
	END;

Select Angajati.nume, Functii.salariu_brut FROM Functii
inner join IstoricFunctii on Functii.id=IstoricFunctii.functie_id
inner join Angajati on Angajati.id=IstoricFunctii.angajat_id
WHERE DATEPART(YEAR,Angajati.data_angajarii)<2022

	

--6.Tranzactie care la stergerea unui produs, in cazul in care apare o eroare, sa-l redenumeasca in produs.



DECLARE @errnnum AS INT;
BEGIN TRAN 
	DELETE FROM Produse
	WHERE Produse.nume LIKE 'Microfon Blue Yeti X'
		SET @errnnum=@@ERROR
	IF @errnnum<>0
	BEGIN
		PRINT 'Nu se poate sterge produsul Microfon Blue Yeti X'
		ROLLBACK TRAN;
	BEGIN TRAN
		UPDATE Produse
		SET Produse.nume = 'produs'
		WHERE Produse.nume LIKE 'Microfon Blue Yeti X'
	ROLLBACK TRAN;
	END;
	ELSE
	BEGIN
		PRINT 'S-a sters produsul Microfon Blue Yeti X'
	ROLLBACK TRAN;
END;
 
 
--7.Tranzactie care la stergerea unui Client(dupa ID) sa afiseze factura acestuia.


GO
DECLARE @errnum AS INT;
BEGIN TRAN

	

	SELECT suma
	FROM Plati
	INNER JOIN Facturi ON Plati.id=Facturi.plata_id
	INNER JOIN Comenzi ON Facturi.comanda_id=Comenzi.id
	INNER JOIN Clienti ON Clienti.id = Comenzi.client_id
	WHERE Clienti.id=5

	DELETE Clienti FROM Clienti
	WHERE Clienti.id=5

	SET @errnum=@@ERROR
	IF @errnum<>0
	BEGIN
		PRINT 'Nu se poate sterge clientul cu id-ul 5'
		ROLLBACK TRAN;
	END;
	ELSE
	BEGIN
		PRINT 'S-a sters clientul cu id-ul 5'
		ROLLBACK TRAN;
	END





--8.Tranzactie in care se modifica descrierea unei categorii.


BEGIN TRY
	SELECT @@TRANCOUNT
	SELECT @@ERROR
BEGIN TRAN
	SELECT * FROM Categorii

	DECLARE @descriere_noua varchar(255)= 'Componente pentru calculatoare ce ajuta la scaderea temperaturii celorlalte componente.' 

	UPDATE Categorii
	SET descriere=@descriere_noua
	WHERE nume='Coolere'

	SELECT * FROM Categorii
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF ERROR_NUMBER() = 2627 
	BEGIN
		PRINT 'Primary key violation';
	END
	ELSE IF ERROR_NUMBER() = 547
	BEGIN
		PRINT 'Constraint violation';
	END
	ELSE
	BEGIN
		PRINT 'Unhandled error';
	END
	IF @@TRANCOUNT > 0
		ROLLBACK TRAN;
	END CATCH;



--9.Tranzactie in care se adauga o livrare noua si i se modifica numele.

BEGIN TRY
	SELECT @@TRANCOUNT
	SELECT @@ERROR
BEGIN TRAN
	SELECT * FROM Livrari

	INSERT INTO Livrari(status_livrare)
	VALUES('In curs de livrare')

	UPDATE Livrari
	SET status_livrare='Livrat', data_livrare = GETDATE()
	WHERE status_livrare='In curs de livrare'

	SELECT * FROM Livrari
	ROLLBACK TRAN
END TRY
BEGIN CATCH
	IF ERROR_NUMBER() = 2627 
	BEGIN
		PRINT 'Primary key violation';
	END
	ELSE IF ERROR_NUMBER() = 547
	BEGIN
		PRINT 'Constraint violation';
	END
	ELSE
	BEGIN
		PRINT 'Unhandled error';
	END
	IF @@TRANCOUNT > 0
		ROLLBACK TRAN;
	END CATCH;
 

--10.Actualizarea adresei unui client.

BEGIN TRY
	SELECT @@TRANCOUNT
	SELECT @@ERROR
BEGIN TRAN
SELECT * FROM Clienti WHERE id = 3
UPDATE Clienti
SET adresa = 'Strada Schimbata, Nr. 20'
WHERE id = 3
SELECT * FROM Clienti WHERE id = 3
COMMIT TRAN
END TRY
BEGIN CATCH
	IF ERROR_NUMBER() = 2627 
	BEGIN
		PRINT 'Primary key violation';
	END
	ELSE IF ERROR_NUMBER() = 547
	BEGIN
		PRINT 'Constraint violation';
	END
	ELSE
	BEGIN
		PRINT 'Unhandled error';
	END
	IF @@TRANCOUNT > 0
		ROLLBACK TRAN;
	END CATCH;



-------------------------CTE-uri-------------------------------
--1.CTE pentru produsele care au o cantitate disponibilă mai mare decât 0
WITH ProduseDisponibile AS (
  SELECT p.id, p.nume, p.descriere, p.pret, s.cantitate
  FROM Produse p
  INNER JOIN Stoc s ON p.id = s.produs_id
  WHERE s.cantitate > 0
)
SELECT *
FROM ProduseDisponibile;


--2.CTE pentru angajații cu salariul net mai mare decât media salariilor nete ale tuturor angajaților
WITH SalariiAngajati AS (
  SELECT salariu_net
  FROM Angajati
)
SELECT *
FROM Angajati
WHERE salariu_net > (SELECT AVG(salariu_net) FROM SalariiAngajati);



--3.CTE pentru facturile neplătite
WITH FacturiNeplatite AS (
  SELECT CC.nume,f.data_factura 
  FROM Facturi f
  INNER JOIN Plati p ON f.plata_id = p.id
  INNER JOIN Comenzi C ON C.id = F.comanda_id
  INNER JOIN Clienti CC ON CC.id = C.client_id
  WHERE p.suma IS NULL
)
SELECT *
FROM FacturiNeplatite;


--4.CTE pentru produsele vândute în ultimele 30 de zile
WITH ProduseVandute AS (
  SELECT cp.produs_id, SUM(cp.cantitate) AS cantitate_vanduta
  FROM ComenziProduse cp
  INNER JOIN Comenzi c ON cp.comanda_id = c.id
  WHERE DATEDIFF(day, c.data_comanda, GETDATE()) <= 30
  GROUP BY cp.produs_id
)
SELECT p.nume, p.pret, pv.cantitate_vanduta
FROM Produse p
INNER JOIN ProduseVandute pv ON p.id = pv.produs_id;



--5.CTE pentru numărul total de angajați pe fiecare funcție

WITH AngajatiPerFunctie AS (
  SELECT i.functie_id, COUNT(i.angajat_id) AS numar_angajati
  FROM IstoricFunctii i
  GROUP BY i.functie_id
)
SELECT f.nume, apf.numar_angajati
FROM Functii f
INNER JOIN AngajatiPerFunctie apf ON f.id = apf.functie_id;




--6. CTE pentru numărul de produse vândute de fiecare furnizor
WITH ProduseVandutePerFurnizor AS (
  SELECT p.furnizor_id, SUM(cp.cantitate) AS cantitate_vanduta
  FROM ComenziProduse cp
  INNER JOIN Produse p ON cp.produs_id = p.id
  GROUP BY p.furnizor_id
)
SELECT f.nume, pvf.cantitate_vanduta
FROM Furnizori f
INNER JOIN ProduseVandutePerFurnizor pvf ON f.id = pvf.furnizor_id;




----------------------------Delete-uri----------------------------------------
--1.Sterge intrarile de functii care nu sunt curente
BEGIN TRAN
SELECT * FROM IstoricFunctii
delete from IstoricFunctii
where data_sfarsit is not null
SELECT * FROM IstoricFunctii
Rollback tran


--2.Sterge platile incheiate
BEGIN TRAN
SELECT * FROM Plati
delete from Plati
where data_plata is not null
SELECT * FROM Plati
Rollback tran


--3. Sterge livrarile livrate
BEGIN TRAN
SELECT * FROM Livrari
delete from Livrari
where data_livrare is not null
SELECT * FROM Livrari
Rollback tran


--4. Sterge toate placile video
BEGIN TRAN
select * from Produse
DELETE P
FROM Produse P
INNER JOIN Categorii C ON P.categorie_id = C.id
WHERE C.nume = 'Placi Video';
select * from Produse
Rollback tran



--5. Sterge toti angajatii cu salariul brut mai mare de 4000 de lei
BEGIN TRAN
select A.nume,F.salariu_brut FROM Angajati A
INNER JOIN Functii F ON A.id = F.id
DELETE A
FROM Angajati A
INNER JOIN Functii F ON A.id = F.id
WHERE F.salariu_brut > 4000;
select A.nume,F.salariu_brut FROM Angajati A
INNER JOIN Functii F ON A.id = F.id
Rollback tran



--6. Sterge toate comenzile clientilor a caror numar de telefon se termina cu cifra 8
BEGIN TRAN
select * from Comenzi
INNER JOIN Clienti CL ON Comenzi.client_id = CL.id
DELETE O
FROM Comenzi O
INNER JOIN Clienti CL ON O.client_id = CL.id
WHERE CL.telefon LIKE '%8';
select * from Comenzi
INNER JOIN Clienti CL ON Comenzi.client_id = CL.id
Rollback tran



--7. Sterge tot stocul produselor ce costa mai mult de 5000
BEGIN TRAN 
select * from Stoc S
INNER JOIN Produse P ON S.produs_id = P.id
DELETE S
FROM Stoc S
INNER JOIN Produse P ON S.produs_id = P.id
WHERE P.pret > 5000;
select * from Stoc S
INNER JOIN Produse P ON S.produs_id = P.id
Rollback tran

--8. Sterge toate facturile livrate
BEGIN TRAN 
select * 
FROM Facturi F
INNER JOIN Comenzi O ON F.comanda_id = O.id
INNER JOIN Livrari L ON O.livrare_id = L.id
DELETE F
FROM Facturi F
INNER JOIN Comenzi O ON F.comanda_id = O.id
INNER JOIN Livrari L ON O.livrare_id = L.id
WHERE L.status_livrare = 'Livrat';
select * 
FROM Facturi F
INNER JOIN Comenzi O ON F.comanda_id = O.id
INNER JOIN Livrari L ON O.livrare_id = L.id
Rollback tran

--9. Sterge impozitele angajatilor, a caror valoare este mai mare sau egala cu 25%
BEGIN TRAN 
select * FROM ImpoziteAngajati IA
INNER JOIN Impozite I ON IA.idImpozit = I.id
DELETE IA
FROM ImpoziteAngajati IA
INNER JOIN Impozite I ON IA.idImpozit = I.id
WHERE I.valoare >= 0.25;
select * FROM ImpoziteAngajati IA
INNER JOIN Impozite I ON IA.idImpozit = I.id
Rollback tran

--10. Sterge toate comenzile angajatilor a caror cnp incepe cu cifra 1
BEGIN TRAN 
select * FROM Comenzi O
INNER JOIN Angajati A ON O.angajat_id = A.id
DELETE O
FROM Comenzi O
INNER JOIN Angajati A ON O.angajat_id = A.id
WHERE A.CNP LIKE '1%';
select * FROM Comenzi O
INNER JOIN Angajati A ON O.angajat_id = A.id
Rollback tran




--11. Sterge toate livrarile catre clientii care stau pe orice strada cu numarul 10
BEGIN TRAN 
select * FROM Livrari L
INNER JOIN Comenzi O ON L.id = O.livrare_id
INNER JOIN Clienti CL ON O.client_id = CL.id
DELETE L
FROM Livrari L
INNER JOIN Comenzi O ON L.id = O.livrare_id
INNER JOIN Clienti CL ON O.client_id = CL.id
WHERE CL.adresa LIKE '%nr. 10';
select * FROM Livrari L
INNER JOIN Comenzi O ON L.id = O.livrare_id
INNER JOIN Clienti CL ON O.client_id = CL.id
Rollback tran





--12. Sterge toate comenzile care au fost asistate de programatori
BEGIN TRAN 
select * FROM Comenzi O
INNER JOIN Angajati A ON O.angajat_id = A.id
INNER JOIN Functii F ON A.id = F.id
DELETE O
FROM Comenzi O
INNER JOIN Angajati A ON O.angajat_id = A.id
INNER JOIN Functii F ON A.id = F.id
WHERE F.nume = 'Programator';
select * FROM Comenzi O
INNER JOIN Angajati A ON O.angajat_id = A.id
INNER JOIN Functii F ON A.id = F.id
Rollback tran






--13. Sterge toate facturile care au o plata mai mica de 800 de lei
BEGIN TRAN 
select * FROM Facturi F
INNER JOIN Plati P ON F.plata_id = P.id
DELETE F
FROM Facturi F
INNER JOIN Plati P ON F.plata_id = P.id
WHERE P.suma < 800;
select * FROM Facturi F
INNER JOIN Plati P ON F.plata_id = P.id
Rollback tran







--14. Sterge tot stocul produselor a caror categorie nu respecta modelul descriptiv
BEGIN TRAN 
select * FROM Stoc S
INNER JOIN Produse P ON S.produs_id = P.id
INNER JOIN Categorii C ON P.categorie_id = C.id
DELETE S
FROM Stoc S
INNER JOIN Produse P ON S.produs_id = P.id
INNER JOIN Categorii C ON P.categorie_id = C.id
WHERE C.descriere NOT LIKE 'Componente%';
select * from Stoc S
INNER JOIN Produse P ON S.produs_id = P.id
Rollback tran




--15. Sterge produsele furnizorilor din Bucuresti
BEGIN TRAN 
select * FROM Produse P
INNER JOIN Furnizori F ON P.furnizor_id = F.id
DELETE P
FROM Produse P
INNER JOIN Furnizori F ON P.furnizor_id = F.id
WHERE F.adresa LIKE '%Bucuresti';
select * FROM Produse P
INNER JOIN Furnizori F ON P.furnizor_id = F.id
Rollback tran
----------------------------------------------------------------------------------
