--CREATION DE LA BASE DE DONNEES CHECKPOINTDQL

	CREATE DATABASE CHECKPOINTDQL;

--Utilisation de la base de données checkpointDQL

	USE CHECKPOINTDQL;

-- CREATION DE LA TABLE PRODUITS

	CREATE TABLE PRODUCTS (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    ProductType VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- INSERTION DES ENREGISTREMENTS

	INSERT INTO PRODUCTS (ProductID, ProductName, ProductType, Price) VALUES
(1, 'Widget A', 'Widget', 10.00),
(2, 'Widget B', 'Widget', 15.00),
(3, 'Gadget X', 'Gadget', 20.00),
(4, 'Gadget Y', 'Gadget', 25.00),
(5, 'Machin Z', 'Machin Z', 30.00);

-- CREATION DE LA TABLE CLIENTS

	CREATE TABLE CUSTOMERS (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Email VARCHAR(100),
    Telephone VARCHAR(15)
);

-- INSERTION DES ENREGISTREMENTS

	INSERT INTO CUSTOMERS (CustomerID, CustomerName, Email, Telephone) VALUES
(1, 'John Smith', 'john@example.com', '123-456-7890'),
(2, 'Jane Doe', 'jane.doe@example.com', '987-654-3210'),
(3, 'Alice Brown', 'alice.brown@example.com', '456-789-0123');

-- CREATION DE LA TABLE commandes 

	CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID)
);

-- INSERTION DES ENREGISTREMENTS 

	INSERT INTO ORDERS (OrderID, CustomerID, OrderDate) VALUES
(101, 1, '2024-05-01'),
(102, 2, '2024-05-02'),
(103, 3, '2024-05-01');

-- CREATION DE LA TABLE DETAILS_COMMANDES 

	CREATE TABLE ORDER_DETAILS (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductID)
);

-- INSERTION DES ENREGISTREMENTS

	INSERT INTO ORDER_DETAILS (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1, 101, 1, 2),
(2, 101, 3, 1),
(3, 102, 2, 3),
(4, 102, 4, 2),
(5, 103, 5, 1);

--CREATION DE LA TABLE TYPES DE PRODUITS 

	 CREATE TABLE PRODUCT_TYPES (
    ProductTypeID INT PRIMARY KEY,
    ProductTypeName VARCHAR(50)
);

--INSERTION DES ENREGISTREMENTS 
 
	INSERT INTO PRODUCT_TYPES (ProductTypeID, ProductTypeName) VALUES
(1, 'Widget'),
(2, 'Gadget'),
(3, 'Doohickey');

-- 1 Récupérer tous les produits.

	SELECT * FROM PRODUCTS;

-- 2 Récupérer tous les clients.

	SELECT * FROM CUSTOMERS;

-- 3 Récupérer toutes les commandes.

	SELECT * FROM ORDERS;

-- 4 Récupérer tous les détails de la commande.

	SELECT * FROM ORDER_DETAILS;

-- 5 Récupérer tous les types de produits.

	SELECT * FROM PRODUCT_TYPES;

-- 6 Récupérez les noms des produits qui ont été commandés par au moins un client, ainsi que la quantité totale de chaque produit commandé.

	SELECT 
    P.PRODUCTNAME,
    SUM(OD.QUANTITY) AS TOTAL_QUANTITY_ORDERED
FROM 
    PRODUCTS P
JOIN 
    ORDER_DETAILS OD ON P.ProductType = OD.ProductID
GROUP BY 
    P.PRODUCTNAME
HAVING 
    SUM(OD.QUANTITY) > 0;

-- 7 Récupérez les noms des clients qui ont passé une commande chaque jour de la semaine, ainsi que le nombre total de commandes passées par chaque client.

	SELECT 
    C.CUSTOMERNAME,
    COUNT(O.ORDERID) AS TOTAL_ORDERS
FROM 
    CUSTOMERS C
JOIN 
    ORDERS O ON C.CUSTOMERID = O.CUSTOMERID
WHERE 
    DATEPART(WEEKDAY, O.OrderDate) IN (1, 2, 3, 4, 5, 6, 7)
GROUP BY 
    C.CUSTOMERNAME
HAVING 
    COUNT(DISTINCT DATEPART(WEEKDAY, O.OrderDate)) = 7;

-- 8 Récupérez les noms des clients ayant passé le plus de commandes, ainsi que le nombre total de commandes passées par chaque client.

	 SELECT 
    C.CUSTOMERNAME,
    COUNT(O.ORDERID) AS TOTAL_ORDERS
FROM 
    CUSTOMERS C
JOIN 
    ORDERS O ON C.CUSTOMERID = O.CUSTOMERID
GROUP BY 
    C.CUSTOMERNAME
ORDER BY 
    TOTAL_ORDERS DESC;

-- 9 Récupérez les noms des produits qui ont été le plus commandés, ainsi que la quantité totale de chaque produit commandé.

	SELECT 
    P.ProductName,
    SUM(OD.Quantity) AS TotalQuantityOrdered
FROM 
    PRODUCTS P
JOIN 
    ORDER_DETAILS OD ON P.ProductID = OD.ProductID
GROUP BY 
    P.ProductName
ORDER BY 
    TotalQuantityOrdered DESC;

-- 10 Récupérer les noms des clients ayant passé commande pour au moins un widget.

	SELECT 
    DISTINCT C.CUSTOMERNAME
FROM 
    CUSTOMERS C
JOIN 
    ORDERS O ON C.CUSTOMERID = O.CUSTOMERID
JOIN 
    ORDER_DETAILS OD ON O.ORDERID = OD.ORDERID
JOIN 
    PRODUCTS P ON OD.ProductID = P.ProductID
WHERE 
    P.ProductName = 'widget';


