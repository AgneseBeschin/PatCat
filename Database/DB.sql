use progettotec;

DROP TABLE IF EXISTS LikePost;
DROP TABLE IF EXISTS Commento;
DROP TABLE IF EXISTS Post;
DROP TABLE IF EXISTS Foto;
DROP TABLE IF EXISTS Ban;
DROP TABLE IF EXISTS UAdmin;
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
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Percorso VARCHAR(255) NOT NULL,

    -- Dati geografici:
    Latitudine DECIMAL(10, 8),
    Longitudine DECIMAL(11, 8),

    ColoreGatto ENUM('Nero', 'Bianco', 'Rosso/Arancio', 'Grigio', 'Tigrato', 'Tartaruga', 'Multicolore'),
    EtaGatto ENUM ('Cucciolo', 'Adulto', 'Anziano'),
    DescrizioneBreve VARCHAR(255)
);

-- Se banniamo un utente i suoi post restano nel db, ma EmailAutore diventa NULL
CREATE TABLE Post (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    EmailAutore VARCHAR(100),
    FotoID INT NOT NULL,
    Testo TEXT,
    DataOra DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (EmailAutore) REFERENCES Utente(Email)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (FotoID) REFERENCES Foto(ID)
        ON DELETE RESTRICT -- Una foto può essere riusata, ma non cancellata se in uso
        ON UPDATE CASCADE
);

CREATE TABLE Commento (
    Email VARCHAR(100),
    PostID INT,
    DataOra DATETIME DEFAULT CURRENT_TIMESTAMP,
    Testo TEXT NOT NULL,
    PRIMARY KEY (Email, PostID, DataOra),
    FOREIGN KEY (Email) REFERENCES Utente(Email)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PostID) REFERENCES Post(ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- RELAZIONE BAN (Admin -<>- Utente)
CREATE TABLE Ban (
    EmailAdmin VARCHAR(100),
    EmailUtente VARCHAR(100),
    Motivo TEXT NOT NULL,
    DataOra DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (EmailAdmin, EmailUtente),
    FOREIGN KEY (EmailAdmin) REFERENCES UAdmin(Email)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (EmailUtente) REFERENCES Utente(Email)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- RELAZIONE LIKE (Utente -<>- Post)
CREATE TABLE LikePost (
    Email VARCHAR(100),
    PostID INT,
    PRIMARY KEY (Email, PostID),
    FOREIGN KEY (Email) REFERENCES Utente(Email)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PostID) REFERENCES Post(ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- RELAZIONE FOLLOW (Utente -<>- Utente)
CREATE TABLE Follow (
    Follower VARCHAR(100),
    Followed VARCHAR(100),
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

