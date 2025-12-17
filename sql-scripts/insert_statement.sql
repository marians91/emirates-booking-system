-- ============================================================================
-- SCRIPT DI POPOLAMENTO DATABASE - EMIRATES AIRLINES
-- ============================================================================
-- Descrizione: Dati di esempio per validare i casi d'uso principali
-- Nota: Dati realistici ma semplificati per testing
-- ============================================================================

-- Pulisci dati esistenti (opzionale, per re-run dello script)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE pagamento;
TRUNCATE TABLE biglietto_has_volo;
TRUNCATE TABLE biglietto;
TRUNCATE TABLE prenotazione;
TRUNCATE TABLE posto;
TRUNCATE TABLE volo;
TRUNCATE TABLE rotta;
TRUNCATE TABLE aeromobile;
TRUNCATE TABLE aeroporto;
TRUNCATE TABLE passeggero;
TRUNCATE TABLE classe;
SET FOREIGN_KEY_CHECKS = 1;


-- ============================================================================
-- 1. AEROPORTI (Network Emirates)
-- ============================================================================

INSERT INTO aeroporto (codice_iata, codice_icao, nome, citta) VALUES
-- Hub principale
('DXB', 'OMDB', 'Dubai International Airport', 'Dubai'),

-- Europa
('MXP', 'LIMC', 'Milano Malpensa', 'Milano'),
('FCO', 'LIRF', 'Roma Fiumicino', 'Roma'),
('LHR', 'EGLL', 'London Heathrow', 'Londra'),
('CDG', 'LFPG', 'Paris Charles de Gaulle', 'Parigi'),

-- Nord America
('JFK', 'KJFK', 'John F. Kennedy International', 'New York'),
('LAX', 'KLAX', 'Los Angeles International', 'Los Angeles'),

-- Asia
('BKK', 'VTBS', 'Suvarnabhumi Airport', 'Bangkok'),
('SIN', 'WSSS', 'Singapore Changi', 'Singapore'),

-- Oceania
('SYD', 'YSSY', 'Sydney Kingsford Smith', 'Sydney');


-- ============================================================================
-- 2. CLASSI DI SERVIZIO (Emirates: First, Business, Economy)
-- ============================================================================

INSERT INTO classe (nome_classe) VALUES
('First'),
('Business'),
('Economy');


-- ============================================================================
-- 3. AEROMOBILI (Flotta Emirates)
-- ============================================================================

INSERT INTO aeromobile (registration_number, modello) VALUES
-- Airbus A380 (long-haul intercontinentale)
('A6-EUA', 'A380-800'),
('A6-EUB', 'A380-800'),
('A6-EUC', 'A380-800'),

-- Boeing 777 (long-haul)
('A6-EBA', 'B777-300ER'),
('A6-EBB', 'B777-300ER'),
('A6-EBC', 'B777-300ER');


-- ============================================================================
-- 4. POSTI (Configurazione per ogni aeromobile)
-- ============================================================================
-- Nota: Generazione semplificata, in produzione usare stored procedure

-- A380-800 (A6-EUA): Configurazione 489 posti totali
-- First Class: 14 posti (1A-1K, 2A-2K)
INSERT INTO posto (id_aeromobile, id_classe, numero_posto, disponibile) VALUES
(1, 1, '1A', 1), (1, 1, '1C', 1), (1, 1, '1E', 1), (1, 1, '1F', 1), (1, 1, '1K', 1),
(1, 1, '2A', 1), (1, 1, '2C', 1), (1, 1, '2E', 1), (1, 1, '2F', 1), (1, 1, '2K', 1),
(1, 1, '3A', 1), (1, 1, '3C', 1), (1, 1, '3E', 1), (1, 1, '3F', 1);

-- Business Class: 20 posti campione (6A-10K)
INSERT INTO posto (id_aeromobile, id_classe, numero_posto, disponibile) VALUES
(1, 2, '6A', 1), (1, 2, '6C', 1), (1, 2, '6E', 1), (1, 2, '6K', 1),
(1, 2, '7A', 1), (1, 2, '7C', 1), (1, 2, '7E', 1), (1, 2, '7K', 1),
(1, 2, '8A', 1), (1, 2, '8C', 1), (1, 2, '8E', 1), (1, 2, '8K', 1),
(1, 2, '9A', 1), (1, 2, '9C', 1), (1, 2, '9E', 1), (1, 2, '9K', 1),
(1, 2, '10A', 1), (1, 2, '10C', 1), (1, 2, '10E', 1), (1, 2, '10K', 1);

-- Economy Class: 30 posti campione (43A-48K)
INSERT INTO posto (id_aeromobile, id_classe, numero_posto, disponibile) VALUES
(1, 3, '43A', 1), (1, 3, '43B', 1), (1, 3, '43C', 1), (1, 3, '43D', 1), (1, 3, '43E', 1),
(1, 3, '43F', 1), (1, 3, '43G', 1), (1, 3, '43H', 1), (1, 3, '43J', 1), (1, 3, '43K', 1),
(1, 3, '44A', 1), (1, 3, '44B', 1), (1, 3, '44C', 1), (1, 3, '44D', 1), (1, 3, '44E', 1),
(1, 3, '44F', 1), (1, 3, '44G', 1), (1, 3, '44H', 1), (1, 3, '44J', 1), (1, 3, '44K', 1),
(1, 3, '45A', 1), (1, 3, '45B', 1), (1, 3, '45C', 1), (1, 3, '45D', 1), (1, 3, '45E', 1),
(1, 3, '45F', 1), (1, 3, '45G', 1), (1, 3, '45H', 1), (1, 3, '45J', 1), (1, 3, '45K', 1);

-- Boeing 777 (A6-EBA): Configurazione semplificata 30 posti
INSERT IGNORE INTO posto (id_aeromobile, id_classe, numero_posto, disponibile) VALUES
-- Business: 10 posti
(4, 2, '1A', 1), (4, 2, '1C', 1), (4, 2, '1E', 1), (4, 2, '1K', 1),
(4, 2, '2A', 1), (4, 2, '2C', 1), (4, 2, '2E', 1), (4, 2, '2K', 1),
(4, 2, '3A', 1), (4, 2, '3C', 1),

-- Economy: 20 posti
(4, 3, '20A', 1), (4, 3, '20B', 1), (4, 3, '20C', 1), (4, 3, '20D', 1), (4, 3, '20E', 1),
(4, 3, '20F', 1), (4, 3, '20G', 1), (4, 3, '20H', 1), (4, 3, '20J', 1), (4, 3, '20K', 1),
(4, 3, '21A', 1), (4, 3, '21B', 1), (4, 3, '21C', 1), (4, 3, '21D', 1), (4, 3, '21E', 1),
(4, 3, '21F', 1), (4, 3, '21G', 1), (4, 3, '21H', 1), (4, 3, '21J', 1), (4, 3, '21K', 1);


-- ============================================================================
-- 5. ROTTE (Network Emirates con hub Dubai)
-- ============================================================================

INSERT INTO rotta (id_aeroporto_origine, id_aeroporto_destinazione) VALUES
-- Rotte da/per Milano
(2, 1),  -- MXP → DXB
(1, 2),  -- DXB → MXP

-- Rotte da/per Dubai (hub)
(1, 6),  -- DXB → JFK (New York)
(6, 1),  -- JFK → DXB
(1, 7),  -- DXB → LAX (Los Angeles)
(7, 1),  -- LAX → DXB
(1, 8),  -- DXB → BKK (Bangkok)
(8, 1),  -- BKK → DXB
(1, 10), -- DXB → SYD (Sydney)
(10, 1), -- SYD → DXB

-- Rotte europee verso Dubai
(3, 1),  -- FCO (Roma) → DXB
(1, 3),  -- DXB → FCO
(4, 1),  -- LHR (Londra) → DXB
(1, 4);  -- DXB → LHR


-- ============================================================================
-- 6. VOLI (Programmazione settimanale)
-- ============================================================================

INSERT INTO volo (codice_volo, id_rotta, id_aeromobile, data_volo, ora_partenza, ora_arrivo) VALUES
-- Voli Milano → Dubai → New York (con scalo)
('EK091', 1, 1, '2026-01-15', '14:20:00', '22:45:00'),  -- MXP → DXB (A380)
('EK201', 4, 1, '2026-01-16', '03:10:00', '08:35:00'),  -- DXB → JFK (stesso A380)

-- Voli ritorno New York → Dubai → Milano
('EK202', 5, 1, '2026-01-22', '10:30:00', '18:45:00'),  -- JFK → DXB
('EK092', 2, 1, '2026-01-23', '02:50:00', '07:10:00'),  -- DXB → MXP

-- Voli diretti Milano → Dubai
('EK095', 1, 4, '2026-01-15', '22:30:00', '06:50:00'),  -- MXP → DXB (B777, volo notturno)
('EK096', 2, 4, '2026-01-16', '09:00:00', '13:20:00'),  -- DXB → MXP

-- Altri voli operativi
('EK001', 4, 1, '2026-01-15', '08:30:00', '13:55:00'),  -- DXB → JFK (daily)
('EK011', 6, 1, '2026-01-15', '14:45:00', '22:30:00'),  -- DXB → LAX
('EK384', 8, 4, '2026-01-15', '02:25:00', '08:50:00'),  -- DXB → BKK
('EK413', 10, 1, '2026-01-15', '22:30:00', '16:40:00'); -- DXB → SYD (+1 giorno)


-- ============================================================================
-- 7. PASSEGGERI (Profili diversificati)
-- ============================================================================

INSERT INTO passeggero (nome, cognome, data_nascita, email, id_skywards) VALUES
-- Famiglia Rossi (viaggiatori frequenti, membri Skywards Gold)
('Mario', 'Rossi', '1975-03-15', 'mario.rossi@example.com', 'EK1234567890'),
('Laura', 'Rossi', '1978-07-22', 'laura.rossi@example.com', 'EK1234567891'),
('Giulia', 'Rossi', '2005-11-10', 'giulia.rossi@example.com', 'EK1234567892'),
('Marco', 'Rossi', '2008-04-18', 'marco.rossi@example.com', 'EK1234567893'),

-- Business traveler
('Alessandro', 'Bianchi', '1982-09-05', 'a.bianchi@company.it', 'EK9876543210'),

-- Viaggiatori occasionali (no Skywards)
('Sofia', 'Verdi', '1990-12-25', 'sofia.verdi@email.com', NULL),
('Luca', 'Neri', '1988-06-30', 'luca.neri@email.com', NULL),

-- Coppia in viaggio di nozze
('Francesca', 'Ferrari', '1995-02-14', 'francesca.ferrari@example.com', NULL),
('Andrea', 'Ferrari', '1993-08-20', 'andrea.ferrari@example.com', NULL);


-- ============================================================================
-- 8. PRENOTAZIONI E BIGLIETTI
-- ============================================================================

-- ----------------------------------------------------------------------------
-- CASO D'USO 1: Famiglia Rossi - Viaggio con scalo (Milano → Dubai → New York)
-- Prenotazione gruppo (4 persone), classe Economy, andata e ritorno
-- ----------------------------------------------------------------------------

-- Prenotazione famiglia
INSERT INTO prenotazione (codice_pnr, id_passeggero, data_prenotazione, prezzo) VALUES
('ABC123', 1, '2025-12-10 14:30:00', 4800.00);  -- Mario Rossi intestatario

-- Biglietti per ogni membro della famiglia
INSERT INTO biglietto (numero_biglietto, id_prenotazione, id_passeggero, id_classe, tipo_biglietto, data_emissione) VALUES
('1761234567890', 1, 1, 3, 'ANDATA_RITORNO', '2025-12-10 14:35:00'),  -- Mario
('1761234567891', 1, 2, 3, 'ANDATA_RITORNO', '2025-12-10 14:35:00'),  -- Laura
('1761234567892', 1, 3, 3, 'ANDATA_RITORNO', '2025-12-10 14:35:00'),  -- Giulia
('1761234567893', 1, 4, 3, 'ANDATA_RITORNO', '2025-12-10 14:35:00');  -- Marco

-- Itinerario ANDATA: Milano → Dubai → New York (2 voli con scalo)
INSERT INTO biglietto_has_volo (id_biglietto, id_volo, id_posto, sequenza, segmento_tipo) VALUES
-- Mario: MXP → DXB → JFK
(1, 1, 21, 1, 'Principale'),    -- EK091 MXP→DXB, posto 43A
(1, 2, 22, 2, 'Connessione'),   -- EK201 DXB→JFK, posto 43B
-- Laura: MXP → DXB → JFK
(2, 1, 23, 1, 'Principale'),    -- EK091 MXP→DXB, posto 43C
(2, 2, 24, 2, 'Connessione'),   -- EK201 DXB→JFK, posto 43D
-- Giulia: MXP → DXB → JFK
(3, 1, 25, 1, 'Principale'),    -- EK091 MXP→DXB, posto 43E
(3, 2, 26, 2, 'Connessione'),   -- EK201 DXB→JFK, posto 43F
-- Marco: MXP → DXB → JFK
(4, 1, 27, 1, 'Principale'),    -- EK091 MXP→DXB, posto 43G
(4, 2, 28, 2, 'Connessione');   -- EK201 DXB→JFK, posto 43H

-- Itinerario RITORNO: New York → Dubai → Milano (2 voli)
INSERT INTO biglietto_has_volo (id_biglietto, id_volo, id_posto, sequenza, segmento_tipo) VALUES
-- Mario: JFK → DXB → MXP
(1, 3, 29, 3, 'Principale'),    -- EK202 JFK→DXB, posto 43J
(1, 4, 30, 4, 'Connessione'),   -- EK092 DXB→MXP, posto 43K
-- Laura: JFK → DXB → MXP
(2, 3, 31, 3, 'Principale'),    -- EK202 JFK→DXB, posto 44A
(2, 4, 32, 4, 'Connessione'),   -- EK092 DXB→MXP, posto 44B
-- Giulia: JFK → DXB → MXP
(3, 3, 33, 3, 'Principale'),    -- EK202 JFK→DXB, posto 44C
(3, 4, 34, 4, 'Connessione'),   -- EK092 DXB→MXP, posto 44D
-- Marco: JFK → DXB → MXP
(4, 3, 35, 3, 'Principale'),    -- EK202 JFK→DXB, posto 44E
(4, 4, 36, 4, 'Connessione');   -- EK092 DXB→MXP, posto 44F

-- Aggiorna disponibilità posti occupati (importante!)
UPDATE posto SET disponibile = 0 WHERE id_posto IN (21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36);

-- Pagamento famiglia Rossi (pagamento in 2 tranche)
INSERT INTO pagamento (id_prenotazione, importo, data_pagamento) VALUES
(1, 2400.00, '2025-12-10 14:40:00'),  -- Acconto 50%
(1, 2400.00, '2025-12-20 10:15:00');  -- Saldo


-- ----------------------------------------------------------------------------
-- CASO D'USO 2: Business traveler - Volo diretto Milano → Dubai (solo andata)
-- Classe Business, nessuno scalo
-- ----------------------------------------------------------------------------

INSERT INTO prenotazione (codice_pnr, id_passeggero, data_prenotazione, prezzo) VALUES
('DEF456', 5, '2025-12-15 09:20:00', 2500.00);  -- Alessandro Bianchi

INSERT INTO biglietto (numero_biglietto, id_prenotazione, id_passeggero, id_classe, tipo_biglietto, data_emissione) VALUES
('1769876543210', 2, 5, 2, 'SOLO_ANDATA', '2025-12-15 09:25:00');

-- Volo diretto MXP → DXB (nessuno scalo)
INSERT INTO biglietto_has_volo (id_biglietto, id_volo, id_posto, sequenza, segmento_tipo) VALUES
(5, 5, 15, 1, 'Principale');  -- EK095 MXP→DXB, posto Business 6A

UPDATE posto SET disponibile = 0 WHERE id_posto = 15;

-- Pagamento immediato
INSERT INTO pagamento (id_prenotazione, importo, data_pagamento) VALUES
(2, 2500.00, '2025-12-15 09:30:00');


-- ----------------------------------------------------------------------------
-- CASO D'USO 3: Coppia in viaggio di nozze - First Class (andata e ritorno)
-- Milano → Dubai → New York, ritorno dopo 7 giorni
-- ----------------------------------------------------------------------------

INSERT INTO prenotazione (codice_pnr, id_passeggero, data_prenotazione, prezzo) VALUES
('GHI789', 8, '2025-12-18 16:45:00', 16000.00);  -- Francesca Ferrari intestataria

INSERT INTO biglietto (numero_biglietto, id_prenotazione, id_passeggero, id_classe, tipo_biglietto, data_emissione) VALUES
('1761111111111', 3, 8, 1, 'ANDATA_RITORNO', '2025-12-18 16:50:00'),  -- Francesca
('1762222222222', 3, 9, 1, 'ANDATA_RITORNO', '2025-12-18 16:50:00');  -- Andrea

-- Itinerario ANDATA: First Class
INSERT INTO biglietto_has_volo (id_biglietto, id_volo, id_posto, sequenza, segmento_tipo) VALUES
-- Francesca: MXP → DXB → JFK (First)
(6, 1, 1, 1, 'Principale'),     -- EK091 MXP→DXB, posto 1A (First)
(6, 2, 2, 2, 'Connessione'),    -- EK201 DXB→JFK, posto 1C (First)
-- Andrea: MXP → DXB → JFK (First)
(7, 1, 3, 1, 'Principale'),     -- EK091 MXP→DXB, posto 1E (First)
(7, 2, 4, 2, 'Connessione');    -- EK201 DXB→JFK, posto 1F (First)

-- Itinerario RITORNO
INSERT INTO biglietto_has_volo (id_biglietto, id_volo, id_posto, sequenza, segmento_tipo) VALUES
-- Francesca: JFK → DXB → MXP (First)
(6, 3, 5, 3, 'Principale'),     -- EK202 JFK→DXB, posto 1K (First)
(6, 4, 6, 4, 'Connessione'),    -- EK092 DXB→MXP, posto 2A (First)
-- Andrea: JFK → DXB → MXP (First)
(7, 3, 7, 3, 'Principale'),     -- EK202 JFK→DXB, posto 2C (First)
(7, 4, 8, 4, 'Connessione');    -- EK092 DXB→MXP, posto 2E (First)

UPDATE posto SET disponibile = 0 WHERE id_posto IN (1,2,3,4,5,6,7,8);

-- Pagamento First Class (in unica soluzione)
INSERT INTO pagamento (id_prenotazione, importo, data_pagamento) VALUES
(3, 16000.00, '2025-12-18 17:00:00');


-- ----------------------------------------------------------------------------
-- CASO D'USO 4: Viaggiatori occasionali - Voli diversi (corner cases)
-- ----------------------------------------------------------------------------

-- Sofia Verdi: Solo andata Dubai → New York
INSERT INTO prenotazione (codice_pnr, id_passeggero, data_prenotazione, prezzo) VALUES
('JKL012', 6, '2025-12-12 11:00:00', 950.00);

INSERT INTO biglietto (numero_biglietto, id_prenotazione, id_passeggero, id_classe, tipo_biglietto, data_emissione) VALUES
('1763333333333', 4, 6, 3, 'SOLO_ANDATA', '2025-12-12 11:05:00');

INSERT INTO biglietto_has_volo (id_biglietto, id_volo, id_posto, sequenza, segmento_tipo) VALUES
(8, 7, 37, 1, 'Principale');  -- EK001 DXB→JFK, posto Economy

UPDATE posto SET disponibile = 0 WHERE id_posto = 37;

INSERT INTO pagamento (id_prenotazione, importo, data_pagamento) VALUES
(4, 950.00, '2025-12-12 11:10:00');


-- Luca Neri: Business Class Dubai → Bangkok
INSERT INTO prenotazione (codice_pnr, id_passeggero, data_prenotazione, prezzo) VALUES
('MNO345', 7, '2025-12-14 18:30:00', 1800.00);

INSERT INTO biglietto (numero_biglietto, id_prenotazione, id_passeggero, id_classe, tipo_biglietto, data_emissione) VALUES
('1764444444444', 5, 7, 2, 'SOLO_ANDATA', '2025-12-14 18:35:00');

INSERT INTO biglietto_has_volo (id_biglietto, id_volo, id_posto, sequenza, segmento_tipo) VALUES
(9, 9, 55, 1, 'Principale');  -- EK384 DXB→BKK, posto Business B777

UPDATE posto SET disponibile = 0 WHERE id_posto = 55;

-- Pagamento parziale (caso: acconto, saldo mancante)
INSERT INTO pagamento (id_prenotazione, importo, data_pagamento) VALUES
(5, 900.00, '2025-12-14 18:40:00');  -- Solo acconto 50%, saldo non ancora pagato!