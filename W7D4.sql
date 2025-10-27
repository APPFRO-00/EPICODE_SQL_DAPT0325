-- Implementa una vista denominata Product al fine di creare unʼanagrafica (dimensione) prodotto completa.
-- La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome prodotto, il nome della sottocategoria associata e il nome della categoria associata.

CREATE VIEW Product as(
	SELECT 
		P.ProductKey as IDProdotto,
        P.EnglishProductName as NomeProdotto,
        S.EnglishProductSubcategoryName as NomeSottocategoria,
        C.EnglishProductCategoryName as NomeCategoria
	FROM 
		dimproduct as P
        INNER JOIN dimproductsubcategory as S
        ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
        INNER JOIN dimproductcategory as C
        ON S.ProductCategoryKey = C.ProductCategoryKey
	);
    
-- Implementa una vista denominata Reseller al fine di creare unʼanagrafica (dimensione) reseller completa. 
-- La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome del reseller, il nome della città e il nome della regione.

CREATE VIEW Reseller as(
	SELECT 
		R.ResellerKey as IDReseller,
		R.ResellerName as NomeReseller,
		G.City as NomeCittà, 
		G.EnglishCountryRegionName as NomeRegione
	FROM dimreseller as R
		INNER JOIN dimgeography as G
		ON R.GeographyKey = G.GeographyKey
	);
    
-- Crea una vista denominata Sales che deve restituire la data dellʼordine, il codice documento, 
-- la riga di corpo del documento, la quantità venduta, lʼimporto totale e il profitto.

CREATE VIEW Sales as (
	SELECT
		OrderDate as DataOrdine,
		SalesOrderNumber as CodiceDocumento,
		SalesOrderLineNumber as RigaCorpo,
		ProductKey as IDProdotto,
        ResellerKey as IDReseller,
        OrderQuantity as QuantitàVenduta,
		SalesAmount as ImportoTotale,
		(SalesAmount-TotalProductCost) as Profitto
	FROM factresellersales 
	);
