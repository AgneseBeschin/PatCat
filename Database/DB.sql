use progettotec;

DROP TABLE IF EXISTS Utente;
DROP TABLE IF EXISTS UAdmin;

CREATE TABLE Utente
(
	Email varchar(100) PRIMARY KEY,
    Username varchar(20),
    Pass char(64),
    Stato enum("Blocked","Non Blocked"),
    Livello enum("Cat Apprentice","Cat Whisperer","Pat Wizard","Pat Master"),
    Punti smallint UNSIGNED,
    constraint Stato CHECK(Stato in ("Blocked","Non Blocked")),
    constraint Email CHECK(LENGTH(Email) > 7 AND LENGTH(Email) <= 20),
    constraint Username CHECK(LENGTH(Username) > 0 AND LENGTH(Username) <= 20),
	constraint Pass CHECK(LENGTH(Pass) = 64)
);

CREATE TABLE UAdmin
(
	EmailA varchar(100) PRIMARY KEY,
    UsernameA varchar(20),
    PassA char(64),
	constraint EmailA CHECK(LENGTH(EmailA) > 7 AND LENGTH(EmailA) <= 20),
    constraint UsernameA CHECK(LENGTH(UsernameA) > 5 AND LENGTH(UsernameA) <= 20),
	constraint PassA CHECK(LENGTH(PassA) = 64)
);

/*dati provvisori, non rispettano i controlli (che sono ancora da fare lato JS e PHP) : test123*/
INSERT INTO Utente(Email,Username,Pass,Stato,Livello,Punti) VALUES ("asd@gmail.com","tester","ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae","Non Blocked","Cat Apprentice",199);

