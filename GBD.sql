/*
	wine(NumW, Category, Year, Degree)

	producer(NumP, FirstName, LastName, Region)

1) Convertissez le diagramme entité-relation donné en un modèle relationnel.
	harvest(NumW, NumP, Quantity)
*/
-- CREATION DE LA BASE DE DONNEES GBD

	CREATE DATABASE GBD;

--Utilisation de la GBD

	USE GBD;



-- créons d'abord les tables wine et producer

-- creatio de la table wine

	CREATE TABLE wine(
	NumW int primary key,
	Category varchar(25) not null,
	Year int, 
	Degree decimal(4,2)
);

-- creation de la table producer

	CREATE TABLE producer(
	Nump int primary key, 
	FirstName varchar(20),
	LastName varchar(20),
	Region varchar(20)
);

-- 2) IMPLEMENTATION DU MODEL A L'AIDE DE SQL

	CREATE TABLE HARVEST(

	NumW int,

	NumP int,

	Quantity decimal(10,2),


	FOREIGN KEY (NumW) REFERENCES wine (NumW),

	FOREIGN KEY (NumP) REFERENCES producer (NumP),

	PRIMARY KEY (NumW, NumP)
);

-- 3) Insérer des données dans les tables de la base de données.


-- Insertion des données dans la table wine
	INSERT INTO wine (NumW, Category, Year, Degree)
	VALUES
	(1, 'Rouge', 2019, 13.5),
	(2, 'Blanc', 2020, 12.0),
	(3, 'Rose', 2018, 11.5),
	(4, 'Red', 2021, 14.0),
	(5, 'Sparkling', 2017, 10.5),
	(6, 'Blanc', 2019, 12.5),
	(7, 'Rouge', 2022, 13.0),
	(8, 'Rose', 2020, 11.0),
	(9, 'Rouge', 2018, 12.0),
	(10, 'Sparkling', 2019, 10.0),
	(11, 'Blanc', 2021, 11.5),
	(12, 'Rouge', 2022, 15.0);


-- Insertion des données dans la table producer

	INSERT INTO producer (NumP, FirstName, LastName, Region)
	VALUES
	(1, 'John', 'Smith', 'Sousse'),
	(2, 'Emma', 'Johnson', 'Tunis'),
	(3, 'Michael', 'Williams', 'Sfax'),
	(4, 'Emily', 'Brown', 'Sousse'),
	(5, 'James', 'Jones', 'Sousse'),
	(6, 'Sarah', 'Davis', 'Tunis'),
	(7, 'David', 'Miller', 'Sfax'),
	(8, 'Olivia', 'Wilson', 'Monastir'),
	(9, 'Daniel', 'Moore', 'Sousse'),
	(10, 'Sophia', 'Taylor', 'Tunis'),
	(11, 'Matthieu', 'Anderson', 'Sfax'),
	(12, 'Amélia', 'Thomas', 'Sousse');

-- 4) Récupérer une liste de tous les producteurs.

	SELECT * FROM producer;

-- 5) Récupérer une liste triée de producteurs par nom.

	SELECT * 

	FROM producer

	order by LastName;

-- 6) Récupérer une liste de producteurs de Sousse.

	SELECT * 

	FROM producer 

	WHERE Region ='Sousse';

-- 7) Calculez la quantité totale de vin produite avec le numéro de vin 12.

	SELECT SUM(Quantity) AS TotalQuantity
	FROM harvest
	WHERE NumW = '12';

-- 8) Calculez la quantité de vin produite pour chaque catégorie.

	SELECT w.Category, SUM(h.Quantity) AS TotalQuantity
	FROM harvest h
	JOIN wine w ON h.NumW = w.NumW
	GROUP BY w.Category;

/*
9) Retrouvez les producteurs de la région de Sousse ayant récolté au moins un vin en quantité supérieure à 300 litres. 
Affichez leurs noms et prénoms, classés par ordre alphabétique.
*/

-- 11) Trouvez le producteur qui a produit la plus grande quantité de vin.

	SELECT TOP(1) p.NumP, p.FirstName, p.LastName, SUM(h.Quantity) AS TotalQuantity
FROM producer p
JOIN harvest h ON p.NumP = h.NumP
GROUP BY p.NumP, p.FirstName, p.LastName
ORDER BY TotalQuantity DESC;

-- 12) Trouvez le degré moyen de vin produit.

	SELECT AVG(Degree) AS AverageDegree
FROM wine;

-- 13) Trouvez le vin le plus ancien de la base de données.

	SELECT TOP(1) NumW, Category, Year, Degree
FROM wine
ORDER BY Year ASC;

-- 14) Récupérez une liste de producteurs ainsi que la quantité totale de vin qu'ils ont produite.

	SELECT p.NumP, p.FirstName, p.LastName, SUM(h.Quantity) AS TotalQuantity
FROM producer p
JOIN harvest h ON p.NumP = h.NumP
GROUP BY p.NumP, p.FirstName, p.LastName
ORDER BY TotalQuantity DESC;

-- 15) Récupérez une liste de vins ainsi que les coordonnées de leurs producteurs.

	


