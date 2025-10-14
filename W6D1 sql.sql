#utilizzo DB adventureworks
USE AdventureWorksDW;

#Esploro la tabella prodotti DIMPRODUCT.
SELECT * FROM dimproduct;

#Interrogo la tabella dei prodotti DimProduct ed espongo in output alcuni campi.
SELECT  ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag 
FROM dimproduct
WHERE FinishedGoodsFlag = 1;

#Scrivo una nuova query al fine di esporre in output i prodotti il cui codice modello ProductAlternateKey) 
#comincia con FR oppure BK. Arricchisco la query con altre richieste dell'esercizio.
SELECT ProductKey, ProductAlternateKey, EnglishProductName, StandardCost, ListPrice,
ListPrice-StandardCost as Markup
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR 'BK%';

#Scrivo unʼaltra query al fine di esporre lʼelenco dei prodotti finiti il cui prezzo di listino 
#è compreso tra 1000 e 2000.
SELECT ProductKey, ProductAlternateKey, EnglishProductName, StandardCost, ListPrice
FROM dimproduct
WHERE ListPrice BETWEEN 1000 AND 2000;

#Esploro la tabella degli impiegati aziendali DimEmployee
SELECT * FROM dimemployee;

#Espongo, interrogando la tabella degli impiegati aziendali, lʼelenco dei soli agenti. 
#Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.
SELECT EmployeeKey, FirstName, LastName, MiddleName, SalesPersonFlag
FROM dimemployee
WHERE SalesPersonFlag = 1;

#Esploro la tabella delle vendite FactResellerSales
SELECT * FROM factresellersales;

#Espongo in output lʼelenco delle transazioni registrate a partire dal 1 gennaio 2020 
#dei soli codici prodotto: 597, 598, 477, 214. 
#Calcolo per ciascuna transazione il profitto (SalesAmount - TotalProductCost).
SELECT SalesOrderNumber, SalesOrderLineNumber, OrderDate, DueDate, ShipDate, ProductKey, TotalProductCost, SalesAmount,
SalesAmount-TotalProductCost as Profit
FROM factresellersales
WHERE OrderDate >= 2020-01-01 AND ProductKey IN (597, 598, 477, 214);