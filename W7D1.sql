-- Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. 

-- verifico a livello logico se effettivamente ProductKey è una PrimaryKey considerando che ogni valore debba essere univoco e non nullo.
SELECT 
	COUNT(DISTINCT ProductKey) as ConteggioProductKey, -- conta i valori distinti
	COUNT(ProductKey) as ProductKeyNotNull, -- conta i valori non null
    SUM(ProductKey IS NULL) AS ProductKeyNull -- somma i valori null 
FROM 
	dimproduct;
    
-- Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.
SELECT
	COUNT(*) AS TotaleRighe, -- conta il totale delle righe
    COUNT(DISTINCT CONCAT(SalesOrderNUmber,'-',SalesOrderLineNumber)) as CombinazionePK, -- conta i valori distinti della combinazione delle due PK
    SUM(SalesOrderNumber IS NULL OR SalesOrderLineNumber IS NULL) as ValoriPKnull -- somma i valori nulli
FROM 
	factresellersales;
    
-- Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.
SELECT 
	OrderDate,
	COUNT(SalesOrderLineNumber) as Transazioni
FROM 
	factresellersales
WHERE OrderDate >= '2020-01-01'
GROUP BY OrderDate;

-- Calcola il fatturato totale FactResellerSales.SalesAmount, la quantità totale venduta FactResellerSales.OrderQuantity
-- e il prezzo medio di vendita FactResellerSales.UnitPrice per prodotto DimProduct a partire dal 1 Gennaio 2020. 
-- Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. 
-- I campi in output devono essere parlanti!

SELECT
    F.OrderDate as Data,
    P.ProductKey as CodiceProdotto,
    P.EnglishProductName as NomeProdotto,
    SUM(F.SalesAmount) as FatturatoTotale,
    SUM(F.OrderQuantity) as QuantitàVenduta,
    AVG(F.UnitPrice) as PrezzoMedio
FROM dimproduct P INNER JOIN factresellersales F 
ON P.ProductKey = F.ProductKey
WHERE OrderDate >= '2020-01-01'
GROUP BY P.ProductKey, P.EnglishProductName;

-- Calcola il fatturato totale FactResellerSales.SalesAmount e la quantità totale venduta FactResellerSales.OrderQuantity 
-- per Categoria prodotto DimProductCategory. Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta.
-- I campi in output devono essere parlanti! 

SELECT
	C.ProductCategoryKey as CodiceProdotto,
    C.EnglishProductCategoryName as NomeProdotto,
	SUM(F.SalesAmount) as FatturatoTotale,
    SUM(F.OrderQuantity) as QuantitàVenduta
FROM factresellersales F 
	INNER JOIN dimproduct P
ON P.ProductKey = F.ProductKey
	INNER JOIN dimproductsubcategory S 
ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
	INNER JOIN dimproductcategory C
ON C.ProductCategoryKey = S.ProductCategoryKey
GROUP BY C.EnglishProductCategoryName;

-- Calcola il fatturato totale per area città DimGeography.City realizzato a partire dal 1 Gennaio 2020. 
-- Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.

SELECT * FROM dimgeography;

SELECT
    CONCAT(G.GeographyKey,'-',G.SalesTerritoryKey) as CodiceGeografico,
    G.City as Città,
    SUM(F.SalesAmount) as FatturatoTotale
FROM factresellersales F 
	JOIN dimreseller R 
ON F.ResellerKey = R.ResellerKey
	JOIN dimgeography G
ON G.GeographyKey = R.GeographyKey
WHERE OrderDate >= '2020-01-01'
GROUP BY G.City
HAVING SUM(F.SalesAmount) > 60000;