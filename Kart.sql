CREATE DATABASE KartingDB;
USE KartingDB;

-- drop database if exits KartingDB;

CREATE TABLE Utenti (
    id_utente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE DatiAnagrafici (
    id_utente INT PRIMARY KEY,
    indirizzo VARCHAR(255),
    data_nascita DATE,
    codice_fiscale VARCHAR(16) UNIQUE,
    FOREIGN KEY (id_utente) REFERENCES Utenti(id_utente) ON DELETE CASCADE
);

CREATE TABLE Pista (
    id_pista INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    localizzazione VARCHAR(255),
    capacita_massima INT
);

CREATE TABLE Eventi (
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    data DATE,
    orario TIME,
    tipo_kart VARCHAR(50),
    costo DECIMAL(10,2),
    id_pista INT,
    FOREIGN KEY (id_pista) REFERENCES Pista(id_pista) ON DELETE CASCADE
);

CREATE TABLE SessioniKart (
    id_sessione INT PRIMARY KEY AUTO_INCREMENT,
    id_evento INT,
    numero_kart INT,
    stato ENUM('disponibile', 'occupato'),
    FOREIGN KEY (id_evento) REFERENCES Eventi(id_evento) ON DELETE CASCADE
);

CREATE TABLE Prenotazioni (
    id_prenotazione INT PRIMARY KEY AUTO_INCREMENT,
    id_utente INT,
    id_evento INT,
    data_prenotazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    stato ENUM('confermato', 'annullato'),
    FOREIGN KEY (id_utente) REFERENCES Utenti(id_utente) ON DELETE CASCADE,
    FOREIGN KEY (id_evento) REFERENCES Eventi(id_evento) ON DELETE CASCADE
);

CREATE TABLE Pagamenti (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_utente INT,
    importo DECIMAL(10,2),
    data_pagamento DATE,
    metodo_pagamento VARCHAR(50),
    FOREIGN KEY (id_utente) REFERENCES Utenti(id_utente) ON DELETE CASCADE
);


INSERT INTO Utenti (nome, email, telefono) VALUES 
('Mario Rossi', 'mario.rossi@email.com', '3331234567'),
('Luca Bianchi', 'luca.bianchi@email.com', '3349876543');

INSERT INTO DatiAnagrafici (id_utente, indirizzo, data_nascita, codice_fiscale) VALUES
(1, 'Via Roma 1, Milano', '1990-05-15', 'RSSMRA90E15H501Z'),
(2, 'Corso Italia 22, Torino', '1995-08-22', 'BNCLCU95M22L219Q');

INSERT INTO Pista (nome, localizzazione, capacita_massima) VALUES
('Kartodromo Milano', 'Milano, Italia', 20),
('SpeedTrack Torino', 'Torino, Italia', 15);

INSERT INTO Eventi (data, orario, tipo_kart, costo, id_pista) VALUES
('2025-04-10', '14:00:00', '125cc', 50.00, 1),
('2025-04-15', '16:00:00', '250cc', 75.00, 2);

INSERT INTO SessioniKart (id_evento, numero_kart, stato) VALUES
(1, 5, 'disponibile'),
(2, 7, 'occupato');

INSERT INTO Prenotazioni (id_utente, id_evento, stato) VALUES
(1, 1, 'confermato'),
(2, 2, 'confermato');

INSERT INTO Pagamenti (id_utente, importo, data_pagamento, metodo_pagamento) VALUES
(1, 50.00, '2025-03-20', 'Carta di credito'),
(2, 75.00, '2025-03-22', 'PayPal');


SELECT 
    U.nome AS Nome_Utente, 
    U.email AS Email,
    P.nome AS Nome_Pista,
    E.data AS Data_Evento,
    E.orario AS Orario,
    S.numero_kart AS Numero_Kart,
    Pr.stato AS Stato_Prenotazione,
    Pg.importo AS Importo_Pagato,
    Pg.metodo_pagamento AS Metodo_Pagamento
FROM Prenotazioni Pr
INNER JOIN Utenti U ON Pr.id_utente = U.id_utente
INNER JOIN Eventi E ON Pr.id_evento = E.id_evento
INNER JOIN Pista P ON E.id_pista = P.id_pista
INNER JOIN SessioniKart S ON E.id_evento = S.id_evento
INNER JOIN Pagamenti Pg ON U.id_utente = Pg.id_utente;

