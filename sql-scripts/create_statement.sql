

CREATE TABLE aeroporto (
    id_aeroporto INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    codice_iata CHAR(3) UNIQUE NOT NULL,
    codice_icao CHAR(4) UNIQUE,
    nome VARCHAR(200) NOT NULL,
    citta VARCHAR(100) NOT NULL
);


CREATE TABLE passeggero (
    id_passeggero INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    data_nascita DATE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    id_skywards VARCHAR(16) UNIQUE
);


CREATE TABLE aeromobile (
    id_aeromobile INT UNSIGNED AUTO_INCREMENT,
    registration_number CHAR(10) NOT NULL,
    modello VARCHAR(50) NOT NULL,
    
    PRIMARY KEY (id_aeromobile),
    UNIQUE KEY uk_aeromobile_registration (registration_number)
);


CREATE TABLE rotta (
    id_rotta INT  AUTO_INCREMENT,
    id_aeroporto_origine INT  NOT NULL,
    id_aeroporto_destinazione INT  NOT NULL,
    
    PRIMARY KEY (id_rotta),
    CONSTRAINT fk_rotta_origine FOREIGN KEY (id_aeroporto_origine) 
    REFERENCES aeroporto (id_aeroporto) ON DELETE RESTRICT ON UPDATE NO ACTION,
    
    CONSTRAINT fk_rotta_destinazione FOREIGN KEY (id_aeroporto_destinazione)
    REFERENCES aeroporto (id_aeroporto)ON DELETE RESTRICT ON UPDATE NO ACTION,
    
    CONSTRAINT uk_rotta UNIQUE (id_aeroporto_origine, id_aeroporto_destinazione),
    CONSTRAINT chk_rotta_aeroporti_diversi CHECK (id_aeroporto_origine <> id_aeroporto_destinazione)

);

CREATE TABLE volo (
    id_volo INT  AUTO_INCREMENT,

    codice_volo CHAR(6) NOT NULL,
    id_rotta INT  NOT NULL,
    id_aeromobile INT UNSIGNED  NOT NULL,
    data_volo DATE NOT NULL,
    ora_partenza TIME NOT NULL,
    ora_arrivo TIME NOT NULL,

    PRIMARY KEY (id_volo),
    CONSTRAINT fk_volo_rotta FOREIGN KEY (id_rotta)
    REFERENCES rotta (id_rotta) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_volo_aeromobile FOREIGN KEY (id_aeromobile) 
    REFERENCES aeromobile (id_aeromobile)ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT uk_volo UNIQUE (codice_volo, data_volo),
    INDEX idx_volo_rotta (id_rotta)
);


CREATE TABLE classe (
    id_classe TINYINT  AUTO_INCREMENT,
    nome_classe VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_classe),
    UNIQUE KEY uk_classe_nome (nome_classe)
);

CREATE TABLE posto (
    id_posto INT  AUTO_INCREMENT,
    id_aeromobile INT UNSIGNED NOT NULL,
    id_classe TINYINT  NOT NULL,
    numero_posto VARCHAR(5) NOT NULL,
    disponibile TINYINT(1) NOT NULL DEFAULT 1,

    PRIMARY KEY (id_posto),
    CONSTRAINT fk_posto_aeromobile  FOREIGN KEY (id_aeromobile) 
    REFERENCES aeromobile (id_aeromobile) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_posto_classe FOREIGN KEY (id_classe) 
    REFERENCES classe (id_classe) ON UPDATE CASCADE,   
    CONSTRAINT uk_posto_aeromobile UNIQUE (id_aeromobile, numero_posto),
    INDEX idx_posto_disponibilita (id_aeromobile, disponibile)
);


CREATE TABLE prenotazione (
    id_prenotazione INT  AUTO_INCREMENT,
    codice_pnr CHAR(6) NOT NULL,
    id_passeggero INT  NOT NULL,
    data_prenotazione TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    prezzo DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_prenotazione),
    CONSTRAINT uk_prenotazione_pnr UNIQUE (codice_pnr),
    CONSTRAINT fk_prenotazione_passeggero FOREIGN KEY (id_passeggero)
    REFERENCES passeggero (id_passeggero) ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_prenotazione_data (data_prenotazione)
);


CREATE TABLE biglietto (
    id_biglietto INT  AUTO_INCREMENT,
    numero_biglietto CHAR(13) NOT NULL,  
    id_prenotazione INT  NOT NULL,
    id_passeggero INT  NOT NULL,
    id_classe TINYINT  NOT NULL,
    tipo_biglietto ENUM ('SOLO_ANDATA','ANDATA_RITORNO', 'MULTI_CITTA') NOT NULL,
    data_emissione TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id_biglietto),
    CONSTRAINT uk_biglietto_numero UNIQUE (numero_biglietto),
    CONSTRAINT fk_biglietto_prenotazione FOREIGN KEY (id_prenotazione) 
    REFERENCES prenotazione (id_prenotazione) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_biglietto_passeggero FOREIGN KEY (id_passeggero)
    REFERENCES passeggero (id_passeggero)ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_biglietto_classe FOREIGN KEY (id_classe) 
    REFERENCES classe (id_classe) ON UPDATE CASCADE,
    INDEX idx_biglietto_prenotazione (id_prenotazione),
    INDEX idx_biglietto_passeggero (id_passeggero)
);


CREATE TABLE biglietto_has_volo (
    id_biglietto INT NOT NULL,
    id_volo INT NOT NULL,
    id_posto INT NOT NULL,
    sequenza INT NOT NULL, -- 1 = primo volo, 2 = secondo volo (scalo)
    segmento_tipo ENUM('Principale', 'Connessione') NOT NULL,
    
    PRIMARY KEY (id_biglietto, id_volo),
    FOREIGN KEY (id_biglietto) REFERENCES biglietto(id_biglietto) ON DELETE CASCADE,
    FOREIGN KEY (id_volo) REFERENCES volo(id_volo),
    FOREIGN KEY (id_posto) REFERENCES posto(id_posto),
    INDEX idx_volo (id_volo)
);


CREATE TABLE pagamento (
    id_pagamento INT  AUTO_INCREMENT,
    id_prenotazione INT  NOT NULL,
    importo DECIMAL(10,2) NOT NULL,
    data_pagamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id_pagamento),
    CONSTRAINT fk_pagamento_prenotazione FOREIGN KEY (id_prenotazione) 
    REFERENCES prenotazione (id_prenotazione)ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_pagamento_prenotazione (id_prenotazione),
    CONSTRAINT chk_pagamento_importo CHECK (importo > 0)
);


