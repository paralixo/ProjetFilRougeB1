#------------------------------------------------------------
#        Script MySQL de © Biblio-Tech : Jonathan DINH - Florian LAFUENTE - Théo HERNANDEZ - Clément MEHAYE
#------------------------------------------------------------
#------------------------------------------------------------
# Table: OUVRAGE
#------------------------------------------------------------
CREATE TABLE OUVRAGE(
    ouvrage_id INT(11) AUTO_INCREMENT NOT NULL,
    ouvrage_titre VARCHAR(40),
    ouvrage_nb_pages INT,
    ouvrage_resume VARCHAR(1000),
    ouvrage_parution DATE,
    ouvrage_isbn INT,
    auteur_id INT,
    serie_id INT,
    collection_id INT,
    tome_id INT,
    PRIMARY KEY(ouvrage_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: AUTEUR
#------------------------------------------------------------
CREATE TABLE AUTEUR(
    auteur_id INT(11) AUTO_INCREMENT NOT NULL,
    auteur_prenom VARCHAR(40),
    auteur_nom VARCHAR(40),
    auteur_date_naissance DATE,
    auteur_date_mort DATE,
    auteur_pseudo VARCHAR(40),
    civilite_id INT,
    PRIMARY KEY(auteur_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: NATIONALITE
#------------------------------------------------------------
CREATE TABLE NATIONALITE(
    nationalite_id INT(11) AUTO_INCREMENT NOT NULL,
    nationalite_libelle VARCHAR(40),
    PRIMARY KEY(nationalite_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: TYPE
#------------------------------------------------------------
CREATE TABLE TYPE(
    type_id INT(11) AUTO_INCREMENT NOT NULL,
    type_nom VARCHAR(40),
    PRIMARY KEY(type_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: GENRE
#------------------------------------------------------------
CREATE TABLE GENRE(
    genre_id INT(11) AUTO_INCREMENT NOT NULL,
    genre_nom VARCHAR(40),
    PRIMARY KEY(genre_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: MOT-CLE
#------------------------------------------------------------
CREATE TABLE MOT_CLE(
    mot_cle_id INT(11) AUTO_INCREMENT NOT NULL,
    mot_cle_tag VARCHAR(40),
    PRIMARY KEY(mot_cle_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: UTILISATEUR
#------------------------------------------------------------
CREATE TABLE UTILISATEUR(
    utilisateur_id INT(11) AUTO_INCREMENT NOT NULL,
    utilisateur_nom VARCHAR(40),
    utilisateur_prenom VARCHAR(40),
    utilisateur_date_naissance DATE,
    utilisateur_n_rue INT,
    utilisateur_rue VARCHAR(100),
    utilisateur_email VARCHAR(40),
    utilisateur_tel_portable INT,
    ville_id INT,
    civilite_id INT,
    grade_id INT,
    PRIMARY KEY(utilisateur_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: VILLE
#------------------------------------------------------------
CREATE TABLE VILLE(
    ville_id INT(11) AUTO_INCREMENT NOT NULL,
    ville_cp INT,
    ville_nom VARCHAR(40),
    PRIMARY KEY(ville_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: CIVILITE
#------------------------------------------------------------
CREATE TABLE CIVILITE(
    civilite_id INT(11) AUTO_INCREMENT NOT NULL,
    civilite_libelle VARCHAR(5),
    PRIMARY KEY(civilite_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: COLLECTION
#------------------------------------------------------------
CREATE TABLE COLLECTION(
    collection_id INT(11) AUTO_INCREMENT NOT NULL,
    collection_nom VARCHAR(40),
    PRIMARY KEY(collection_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: SERIE
#------------------------------------------------------------
CREATE TABLE SERIE(
    serie_id INT(11) AUTO_INCREMENT NOT NULL,
    serie_nom VARCHAR(40),
    PRIMARY KEY(serie_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: TOME
#------------------------------------------------------------
CREATE TABLE TOME(
    tome_id INT(11) AUTO_INCREMENT NOT NULL,
    tome_num INT,
    PRIMARY KEY(tome_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: EDITEUR
#------------------------------------------------------------
CREATE TABLE EDITEUR(
    editeur_id INT(11) AUTO_INCREMENT NOT NULL,
    editeur_nom VARCHAR(40),
    PRIMARY KEY(editeur_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: GRADE
#------------------------------------------------------------
CREATE TABLE GRADE(
    grade_id INT(11) AUTO_INCREMENT NOT NULL,
    grade_libelle VARCHAR(10),
    PRIMARY KEY(grade_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: POSSEDER
#------------------------------------------------------------
CREATE TABLE POSSEDER(
    nationalite_id INT NOT NULL,
    auteur_id INT NOT NULL,
    PRIMARY KEY(nationalite_id, auteur_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: EMPRUNTER
#------------------------------------------------------------
CREATE TABLE EMPRUNTER(
    date_emprunt DATE,
    date_retour DATE,
    utilisateur_id INT NOT NULL,
    ouvrage_id INT NOT NULL,
    PRIMARY KEY(utilisateur_id, ouvrage_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: CLASSIFIER
#------------------------------------------------------------
CREATE TABLE CLASSIFIER(
    type_id INT NOT NULL,
    ouvrage_id INT NOT NULL,
    PRIMARY KEY(type_id, ouvrage_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: THEMATISER
#------------------------------------------------------------
CREATE TABLE THEMATISER(
    genre_id INT NOT NULL,
    ouvrage_id INT NOT NULL,
    PRIMARY KEY(genre_id, ouvrage_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: ETIQUETER
#------------------------------------------------------------
CREATE TABLE ETIQUETER(
    mot_cle_id INT NOT NULL,
    ouvrage_id INT NOT NULL,
    PRIMARY KEY(mot_cle_id, ouvrage_id)
) ENGINE = InnoDB;

#------------------------------------------------------------
# Table: EDITER
#------------------------------------------------------------
CREATE TABLE EDITER(
    ouvrage_id INT NOT NULL,
    editeur_id INT NOT NULL,
    PRIMARY KEY(ouvrage_id, editeur_id)
) ENGINE = InnoDB; 

ALTER TABLE
    OUVRAGE ADD CONSTRAINT FK_OUVRAGE_auteur_id FOREIGN KEY(auteur_id) REFERENCES AUTEUR(auteur_id);
ALTER TABLE
    OUVRAGE ADD CONSTRAINT FK_OUVRAGE_serie_id FOREIGN KEY(serie_id) REFERENCES SERIE(serie_id);
ALTER TABLE
    OUVRAGE ADD CONSTRAINT FK_OUVRAGE_collection_id FOREIGN KEY(collection_id) REFERENCES COLLECTION(collection_id);
ALTER TABLE
    OUVRAGE ADD CONSTRAINT FK_OUVRAGE_tome_id FOREIGN KEY(tome_id) REFERENCES TOME(tome_id);
ALTER TABLE
    AUTEUR ADD CONSTRAINT FK_AUTEUR_civilite_id FOREIGN KEY(civilite_id) REFERENCES CIVILITE(civilite_id);
ALTER TABLE
    UTILISATEUR ADD CONSTRAINT FK_UTILISATEUR_ville_id FOREIGN KEY(ville_id) REFERENCES VILLE(ville_id);
ALTER TABLE
    UTILISATEUR ADD CONSTRAINT FK_UTILISATEUR_civilite_id FOREIGN KEY(civilite_id) REFERENCES CIVILITE(civilite_id);
ALTER TABLE
    UTILISATEUR ADD CONSTRAINT FK_UTILISATEUR_grade_id FOREIGN KEY(grade_id) REFERENCES GRADE(grade_id);
ALTER TABLE
    POSSEDER ADD CONSTRAINT FK_POSSEDER_nationalite_id FOREIGN KEY(nationalite_id) REFERENCES NATIONALITE(nationalite_id);
ALTER TABLE
    POSSEDER ADD CONSTRAINT FK_POSSEDER_auteur_id FOREIGN KEY(auteur_id) REFERENCES AUTEUR(auteur_id);
ALTER TABLE
    EMPRUNTER ADD CONSTRAINT FK_EMPRUNTER_utilisateur_id FOREIGN KEY(utilisateur_id) REFERENCES UTILISATEUR(utilisateur_id);
ALTER TABLE
    EMPRUNTER ADD CONSTRAINT FK_EMPRUNTER_ouvrage_id FOREIGN KEY(ouvrage_id) REFERENCES OUVRAGE(ouvrage_id);
ALTER TABLE
    CLASSIFIER ADD CONSTRAINT FK_CLASSIFIER_type_id FOREIGN KEY(type_id) REFERENCES TYPE(type_id);
ALTER TABLE
    CLASSIFIER ADD CONSTRAINT FK_CLASSIFIER_ouvrage_id FOREIGN KEY(ouvrage_id) REFERENCES OUVRAGE(ouvrage_id);
ALTER TABLE
    THEMATISER ADD CONSTRAINT FK_THEMATISER_genre_id FOREIGN KEY(genre_id) REFERENCES GENRE(genre_id);
ALTER TABLE
    THEMATISER ADD CONSTRAINT FK_THEMATISER_ouvrage_id FOREIGN KEY(ouvrage_id) REFERENCES OUVRAGE(ouvrage_id);
ALTER TABLE
    ETIQUETER ADD CONSTRAINT FK_ETIQUETER_mot_cle_id FOREIGN KEY(mot_cle_id) REFERENCES MOT_CLE(mot_cle_id);
ALTER TABLE
    ETIQUETER ADD CONSTRAINT FK_ETIQUETER_ouvrage_id FOREIGN KEY(ouvrage_id) REFERENCES OUVRAGE(ouvrage_id);
ALTER TABLE
    EDITER ADD CONSTRAINT FK_EDITER_ouvrage_id FOREIGN KEY(ouvrage_id) REFERENCES OUVRAGE(ouvrage_id);
ALTER TABLE
    EDITER ADD CONSTRAINT FK_EDITER_editeur_id FOREIGN KEY(editeur_id) REFERENCES EDITEUR(editeur_id);