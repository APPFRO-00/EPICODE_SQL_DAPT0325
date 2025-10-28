CREATE DATABASE azienda; -- creo un nuovo db
USE azienda; -- uso il db azienda

#creazione tabella region: id_region PK, città, regione, area_geografica, nazione

CREATE TABLE region (
	id_region INT AUTO_INCREMENT PRIMARY KEY ,
    città VARCHAR(50) NOT NULL,
    regione VARCHAR(50) NOT NULL,
    area_geografica VARCHAR(50) NOT NULL,
    nazione VARCHAR(50) NOT NULL
    );

#creazione tabella store con i campi: id_store, nome_store, data_apertura, indirizzo, cap, telefono, email
#id_region(chiave esterna verso Region), responsabile, fatturato_annuo

CREATE TABLE store (
	id_store INT,
    nome_store VARCHAR (50) NOT NULL,
    data_apertura DATE NOT NULL,
    indirizzo VARCHAR(50) NOT NULL,
    cap VARCHAR(50) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    id_region INT,
    responsabile VARCHAR(50) NOT NULL,
	FOREIGN KEY(id_region) REFERENCES region(id_region)
    );
    
DESCRIBE region; -- controllo i campi della tabella region e li prendo per l'inserimento dati

INSERT INTO region(città, regione, area_geografica, nazione) -- inserisco i campi per popolare la tabella region
VALUES
	('Milano', 'Lombardia', 'Nord', 'Italia'),
	('Torino', 'Piemonte', 'Nord', 'Italia'),
    ('Firenze', 'Toscana', 'Centro', 'Italia'),
    ('Roma', 'Lazio', 'Centro', 'Italia'),
    ('Napoli', 'Campania', 'Sud', 'Italia');
    
SELECT * FROM region; -- controllo se i campi sono stati inseriti correttamente

DESCRIBE store; -- controllo i campi della tabella store e li prendo per l'inserimento dati

INSERT INTO store (nome_store, data_apertura, indirizzo, cap, telefono, email, id_region, responsabile) -- inserisco i campi per popolare la tabella store
VALUES 
	('Store Milano Duomo', '2017-04-10', 'Via Torino, 15', '20123', '028765432', 'milano@azienda.it', 1, 'Marco Rossi'),
    ('Store Milano Nord', '2021-02-05', 'Corso Sempione, 45', '20145','023456789', 'milanonord@azienda.it', 1, 'Chiara Fontana'),
    ('Store Torino Centro', '2018-07-22', 'Via Roma, 98', '10121', '011334455', 'torino@azienda.it', 2, 'Luca Bianchi'),
    ('Store Firenze Ponte Vecchio', '2019-09-12', 'Piazza della Signoria, 3', '50122', '055667788', 'firenze@azienda.it', 3, 'Elisa Conti'),
    ('Store Roma Centro', '2020-01-15', 'Via del Corso, 120', '00186', '066778899', 'roma@azienda.it', 4, 'Davide Neri'),
    ('Store Roma Nord', '2022-05-01', 'Viale Parioli, 87', '00197', '061234567', 'romanord@azienda.it', 4, 'Giulia Ferri'),
    ('Store Napoli Centro', '2019-06-09', 'Via Toledo, 55', '80134', '081556677', 'napoli@azienda.it', 5, 'Francesco Russo'),
    ('Store Napoli Vomero', '2023-03-30', 'Via Scarlatti, 22', '80129', '081998877', 'napolivomero@azienda.it', 5, 'Alessia Esposito'),
    ('Store Torino Sud', '2021-08-25', 'Corso Unione Sovietica, 200', '10135', '011998822', 'torinosud@azienda.it', 2, 'Matteo Greco'),
    ('Store Firenze Sud', '2020-11-11', 'Via Senese,90', '50124', '055778899', 'firenzesud@azienda.it', 3, 'Serena Martini');
    
SELECT * FROM store; -- controllo se i campi sono stati inseriti correttamente

-- ho dimenticato di inserire PK, aggiorno l'entità id_store con l'aggiunta della PK
ALTER TABLE store
MODIFY id_store INT AUTO_INCREMENT PRIMARY KEY;

-- modifico 1 record nella tabella region
UPDATE region
SET area_geografica = 'Centro-Sud'
WHERE id_region = 4;

-- elimino 1 record nella tabella store
DELETE FROM store
WHERE id_store = 8;

-- modifico e rendo permanente la transazione
START TRANSACTION;
	UPDATE region 
    SET città = 'Bergamo'
    WHERE id_region = 1;
    SELECT * FROM region
COMMIT;

-- modifico e rendo permanente la transazione
START TRANSACTION;
	UPDATE store
    SET nome_store = 'Store Bergamo Centro'
    WHERE id_store = 1;
	SELECT * FROM store
COMMIT;
    
-- Visualizzare tutti gli store con la loro area geografica
SELECT 
    s.id_store,
    s.nome_store,
    s.data_apertura,
    r.città,
    r.regione,
    r.area_geografica,
    s.responsabile
FROM Store AS s
JOIN Region AS r
ON s.id_region = r.id_region
ORDER BY id_store ASC;