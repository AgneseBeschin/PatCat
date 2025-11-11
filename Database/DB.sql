use progettotec;

DROP TABLE IF EXISTS Follow;
DROP TABLE IF EXISTS LikePost;
DROP TABLE IF EXISTS Commento;
DROP TABLE IF EXISTS Post;
DROP TABLE IF EXISTS Foto;
DROP TABLE IF EXISTS Ban;
DROP TABLE IF EXISTS UAdmin;
DROP TABLE IF EXISTS UtenteStorico;
DROP TABLE IF EXISTS Utente;

CREATE TABLE Utente (
    Email VARCHAR(100) PRIMARY KEY,
    Username VARCHAR(20) UNIQUE NOT NULL,
    Pass CHAR(64) NOT NULL,
    Stato ENUM('Blocked', 'Non Blocked') DEFAULT 'Non Blocked',
    Livello ENUM('Cat Apprentice', 'Cat Whisperer', 'Pat Wizard', 'Pat Master') DEFAULT 'Cat Apprentice',
    Punti SMALLINT UNSIGNED DEFAULT 0,
    CONSTRAINT ck_email CHECK (LENGTH(Email) > 7 AND LENGTH(Email) <= 100),
    CONSTRAINT ck_username CHECK (LENGTH(Username) > 0 AND LENGTH(Username) <= 20),
    CONSTRAINT ck_pass CHECK (LENGTH(Pass) = 64)
);

CREATE TABLE UAdmin (
    Email VARCHAR(100) PRIMARY KEY,
    FOREIGN KEY (Email) REFERENCES Utente(Email)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Foto (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Percorso VARCHAR(255) NOT NULL,

    -- Dati geografici:
    Latitudine DECIMAL(10, 8),
    Longitudine DECIMAL(11, 8),

    ColoreGatto ENUM('Nero', 'Bianco', 'Rosso/Arancio', 'Grigio', 'Tigrato', 'Tartaruga', 'Multicolore'),
    EtaGatto ENUM ('Cucciolo', 'Adulto', 'Anziano'),
    DescrizioneBreve VARCHAR(255) NOT NULL
);

-- Questa tabella viene popolata da un trigger prima di DELETE FROM Utente.
CREATE TABLE UtenteStorico (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(100) NOT NULL,
    Username VARCHAR(20) NOT NULL,
    Pass CHAR(64) NOT NULL,
    Livello ENUM('Cat Apprentice', 'Cat Whisperer', 'Pat Wizard', 'Pat Master'),
    Punti SMALLINT UNSIGNED,
    DataCancellazione DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Post (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    EmailAutore VARCHAR(100) NOT NULL,
    FotoID INT UNSIGNED NOT NULL,
    Testo VARCHAR(300),
    DataOra DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    IsCancellato BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (EmailAutore) REFERENCES Utente(Email)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (FotoID) REFERENCES Foto(ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Commento (
    Email VARCHAR(100) NOT NULL,
    PostID INT UNSIGNED NOT NULL,
    DataOra DATETIME DEFAULT CURRENT_TIMESTAMP,
    Testo VARCHAR(300) NOT NULL,
    PRIMARY KEY (Email, PostID, DataOra),
    FOREIGN KEY (Email) REFERENCES Utente(Email)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PostID) REFERENCES Post(ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- RELAZIONE CANCELLAZIONE POST (Utente (0,N)-<>-(0,N) Post)
-- un utente può cancellare molti post, un post può avere molti eventi di cancellazione
-- (es: se viene riattivato e poi cancellato di nuovo)
CREATE TABLE LogCancellazionePost (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PostID INT UNSIGNED NOT NULL,
    EmailCancella VARCHAR(100) NOT NULL,
    RuoloCancella ENUM('Utente', 'Admin') NOT NULL,
    DataOra DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (PostID) REFERENCES Post(ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (EmailCancella) REFERENCES Utente(Email)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RELAZIONE BAN (Admin -<>- Utente)
CREATE TABLE Ban (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    EmailAdmin VARCHAR(100) NOT NULL,
    EmailUtente VARCHAR(100) NOT NULL,
    Motivo VARCHAR(200) NOT NULL,
    DataOra DATETIME DEFAULT CURRENT_TIMESTAMP,
    DurataGiorni SMALLINT UNSIGNED,
    FOREIGN KEY (EmailAdmin) REFERENCES UAdmin(Email)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (EmailUtente) REFERENCES Utente(Email)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RELAZIONE LIKE (Utente -<>- Post)
CREATE TABLE LikePost (
    Email VARCHAR(100) NOT NULL,
    PostID INT UNSIGNED NOT NULL,
    PRIMARY KEY (Email, PostID),
    FOREIGN KEY (Email) REFERENCES Utente(Email)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PostID) REFERENCES Post(ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- RELAZIONE FOLLOW (Utente -<>- Utente)
CREATE TABLE Follow (
    Follower VARCHAR(100) NOT NULL,
    Followed VARCHAR(100) NOT NULL,
    PRIMARY KEY (Follower, Followed),
    FOREIGN KEY (Follower) REFERENCES Utente(Email)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Followed) REFERENCES Utente(Email)
        ON DELETE CASCADE ON UPDATE CASCADE,
    -- un utente non può seguire se stesso:
    CONSTRAINT ck_no_self_follow CHECK (Follower <> Followed)
);

/*dati provvisori, non rispettano i controlli (che sono ancora da fare lato JS e PHP) : test123*/
INSERT INTO Utente(Email,Username,Pass,Stato,Livello,Punti) VALUES ("asd@gmail.com","tester","ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae","Non Blocked","Cat Apprentice",199);

