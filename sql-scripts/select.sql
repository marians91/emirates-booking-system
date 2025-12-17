-- ============================================================================
-- VERIFICA DATI INSERITI
-- ============================================================================

-- Riepilogo dati inseriti
SELECT 
    'Aeroporti' AS Tabella, COUNT(*) AS Totale FROM aeroporto
UNION ALL
SELECT 'Classi', COUNT(*) FROM classe
UNION ALL
SELECT 'Aeromobili', COUNT(*) FROM aeromobile
UNION ALL
SELECT 'Posti', COUNT(*) FROM posto
UNION ALL
SELECT 'Rotte', COUNT(*) FROM rotta
UNION ALL
SELECT 'Voli', COUNT(*) FROM volo
UNION ALL
SELECT 'Passeggeri', COUNT(*) FROM passeggero
UNION ALL
SELECT 'Prenotazioni', COUNT(*) FROM prenotazione
UNION ALL
SELECT 'Biglietti', COUNT(*) FROM biglietto
UNION ALL
SELECT 'Biglietto-Volo', COUNT(*) FROM biglietto_has_volo
UNION ALL
SELECT 'Pagamenti', COUNT(*) FROM pagamento;


-- ============================================================================
-- QUERY DI VERIFICA CASI D'USO
-- ============================================================================

-- TEST 1: Verifica itinerario famiglia Rossi (4 voli con scali)
SELECT 
    b.numero_biglietto,
    p.nome,
    p.cognome,
    bv.sequenza,
    v.codice_volo,
    v.data_volo,
    ao.codice_iata AS 'Da',
    ad.codice_iata AS 'A'
FROM biglietto b
JOIN passeggero p ON b.id_passeggero = p.id_passeggero
JOIN biglietto_has_volo bv ON b.id_biglietto = bv.id_biglietto
JOIN volo v ON bv.id_volo = v.id_volo
JOIN rotta r ON v.id_rotta = r.id_rotta
JOIN aeroporto ao ON r.id_aeroporto_origine = ao.id_aeroporto
JOIN aeroporto ad ON r.id_aeroporto_destinazione = ad.id_aeroporto
WHERE b.id_prenotazione = 1
ORDER BY b.id_biglietto, bv.sequenza;


-- TEST 2: Verifica posti occupati/disponibili volo EK091
SELECT 
    c.nome_classe,
    COUNT(*) AS posti_totali,
    SUM(CASE WHEN p.disponibile = 0 THEN 1 ELSE 0 END) AS occupati,
    SUM(CASE WHEN p.disponibile = 1 THEN 1 ELSE 0 END) AS disponibili
FROM volo v
JOIN aeromobile am ON v.id_aeromobile = am.id_aeromobile
JOIN posto p ON am.id_aeromobile = p.id_aeromobile
JOIN classe c ON p.id_classe = c.id_classe
WHERE v.codice_volo = 'EK091' AND v.data_volo = '2026-01-15'
GROUP BY c.id_classe, c.nome_classe
ORDER BY FIELD(c.nome_classe, 'First', 'Business', 'Economy');


-- TEST 3: Verifica storico prenotazioni Mario Rossi
SELECT 
    pr.codice_pnr,
    pr.data_prenotazione,
    pr.prezzo AS 'Importo Prenotazione',
    COUNT(b.id_biglietto) AS 'Num Biglietti',
    COALESCE(SUM(pg.importo), 0) AS 'Totale Pagato',
    CASE 
        WHEN COALESCE(SUM(pg.importo), 0) >= pr.prezzo THEN 'Saldato'
        ELSE 'Parziale'
    END AS 'Stato'
FROM prenotazione pr
LEFT JOIN biglietto b ON pr.id_prenotazione = b.id_prenotazione
LEFT JOIN pagamento pg ON pr.id_prenotazione = pg.id_prenotazione
WHERE pr.id_passeggero = 1
GROUP BY pr.id_prenotazione;


-- TEST 4: Incasso totale 2025
SELECT 
    YEAR(pg.data_pagamento) AS anno,
    COUNT(pg.id_pagamento) AS transazioni,
    SUM(pg.importo) AS incasso_totale
FROM pagamento pg
WHERE YEAR(pg.data_pagamento) = 2025
GROUP BY YEAR(pg.data_pagamento);

