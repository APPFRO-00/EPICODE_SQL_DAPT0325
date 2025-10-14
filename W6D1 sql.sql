#utilizzo DB adventureworks
USE AdventureWorksDW;

SELECT *
FROM dimproduct;

SELECT 
    ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    Color,
    StandardCost,
    FinishedGoodsFlag
FROM
    dimproduct
WHERE
    FinishedGoodsFlag = 1;

SELECT 
    ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    StandardCost,
    ListPrice,
    ListPrice - StandardCost AS Markup
FROM
    dimproduct
WHERE
    ProductAlternateKey LIKE 'FR%'
OR 
	ProductAlternateKey LIKE 'BK%';

SELECT 
    ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    StandardCost,
    ListPrice,
    FinishedGoodsFlag
FROM
    dimproduct
WHERE
    FinishedGoodsFlag = 1
        AND ListPrice BETWEEN 1000 AND 2000;

#Esploro la tabella degli impiegati aziendali DimEmployee
SELECT * FROM dimemployee;

#Espongo, interrogando la tabella degli impiegati aziendali, lʼelenco dei soli agenti. 
#Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.
SELECT 
    EmployeeKey,
    FirstName,
    LastName,
    Title,
    DepartmentName,
    Position,
    SalesPersonFlag
FROM
    dimemployee
WHERE
    SalesPersonFlag = 1;

#Esploro la tabella delle vendite FactResellerSales
SELECT * FROM factresellersales;

#Espongo in output lʼelenco delle transazioni registrate a partire dal 1 gennaio 2020 
SELECT 
    SalesOrderNumber,
    SalesOrderLineNumber,
    OrderDate,
    DueDate,
    ShipDate,
    ProductKey,
    TotalProductCost,
    SalesAmount,
    SalesAmount - TotalProductCost AS Profit
FROM
    factresellersales
WHERE
    OrderDate >= '2020-01-01'
AND 
	ProductKey IN (597 , 598, 477, 214);