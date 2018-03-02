---------------------------------------------------------------
--        Script Oracle de © Biblio-Tech : Jonathan DINH - Florian LAFUENTE - Théo HERNANDEZ - Clément MEHAYE 
---------------------------------------------------------------


------------------------------------------------------------
-- Table: OUVRAGE
------------------------------------------------------------
CREATE TABLE OUVRAGE(
	ouvrage_id NUMBER NOT NULL,
	ouvrage_titre VARCHAR2(40),
	ouvrage_nb_pages NUMBER(10,0),
	ouvrage_resume VARCHAR2(1000),
	ouvrage_parution DATE,
	auteur_id NUMBER(10,0),
	serie_id NUMBER(10,0),
	collection_id NUMBER(10,0),
	tome_id NUMBER(10,0),
	CONSTRAINT OUVRAGE_Pk PRIMARY KEY (ouvrage_id)
);

------------------------------------------------------------
-- Table: AUTEUR
------------------------------------------------------------
CREATE TABLE AUTEUR(
	auteur_id NUMBER NOT NULL,
	auteur_prenom VARCHAR2(40),
	auteur_nom VARCHAR2(40),
	auteur_date_naissance DATE,
	auteur_date_mort DATE,
	auteur_pseudo VARCHAR2(40),
	civilite_id NUMBER(10,0),
	CONSTRAINT AUTEUR_Pk PRIMARY KEY (auteur_id)
);

------------------------------------------------------------
-- Table: NATIONALITE
------------------------------------------------------------
CREATE TABLE NATIONALITE(
	nationalite_id NUMBER NOT NULL,
	nationalite_libelle VARCHAR2(40),
	CONSTRAINT NATIONALITE_Pk PRIMARY KEY (nationalite_id)
);

------------------------------------------------------------
-- Table: TYPE
------------------------------------------------------------
CREATE TABLE TYPE(
	type_id NUMBER NOT NULL,
	type_nom VARCHAR2(40),
	CONSTRAINT TYPE_Pk PRIMARY KEY (type_id)
);

------------------------------------------------------------
-- Table: GENRE
------------------------------------------------------------
CREATE TABLE GENRE(
	genre_id NUMBER NOT NULL,
	genre_nom VARCHAR2(40),
	CONSTRAINT GENRE_Pk PRIMARY KEY (genre_id)
);

------------------------------------------------------------
-- Table: MOT-CLE
------------------------------------------------------------
CREATE TABLE MOT_CLE(
	mot_cle_id NUMBER NOT NULL,
	mot_cle_tag VARCHAR2(40),
	CONSTRAINT MOT_CLE_Pk PRIMARY KEY (mot_cle_id)
);

------------------------------------------------------------
-- Table: UTILISATEUR
------------------------------------------------------------
CREATE TABLE UTILISATEUR(
	utilisateur_id NUMBER NOT NULL,
	utilisateur_nom VARCHAR2(40),
	utilisateur_prenom VARCHAR2(40),
	utilisateur_date_naissance DATE,
	utilisateur_n_rue NUMBER(10,0),
	utilisateur_rue VARCHAR2(100),
	utilisateur_email VARCHAR2(40),
	utilisateur_tel_portable NUMBER(10,0),
	ville_id NUMBER(10,0),
	civilite_id NUMBER(10,0),
	grade_id NUMBER(10,0),
	CONSTRAINT UTILISATEUR_Pk PRIMARY KEY (utilisateur_id)
);

------------------------------------------------------------
-- Table: VILLE
------------------------------------------------------------
CREATE TABLE VILLE(
	ville_id NUMBER NOT NULL,
	ville_cp NUMBER(10,0),
	ville_nom VARCHAR2(40),
	CONSTRAINT VILLE_Pk PRIMARY KEY (ville_id)
);

------------------------------------------------------------
-- Table: CIVILITE
------------------------------------------------------------
CREATE TABLE CIVILITE(
	civilite_id NUMBER NOT NULL,
	civilite_libelle VARCHAR2(5),
	CONSTRAINT CIVILITE_Pk PRIMARY KEY (civilite_id)
);

------------------------------------------------------------
-- Table: COLLECTION
------------------------------------------------------------
CREATE TABLE COLLECTION(
	collection_id NUMBER NOT NULL,
	collection_nom VARCHAR2(40),
	CONSTRAINT COLLECTION_Pk PRIMARY KEY (collection_id)
);

------------------------------------------------------------
-- Table: SERIE
------------------------------------------------------------
CREATE TABLE SERIE(
	serie_id NUMBER NOT NULL,
	serie_nom VARCHAR2(40),
	CONSTRAINT SERIE_Pk PRIMARY KEY (serie_id)
);

------------------------------------------------------------
-- Table: TOME
------------------------------------------------------------
CREATE TABLE TOME(
	tome_id NUMBER NOT NULL,
	tome_num NUMBER(10,0),
	CONSTRAINT TOME_Pk PRIMARY KEY (tome_id)
);

------------------------------------------------------------
-- Table: EDITEUR
------------------------------------------------------------
CREATE TABLE EDITEUR(
	editeur_id NUMBER NOT NULL,
	editeur_nom VARCHAR2(40),
	CONSTRAINT EDITEUR_Pk PRIMARY KEY (editeur_id)
);

------------------------------------------------------------
-- Table: GRADE
------------------------------------------------------------
CREATE TABLE GRADE(
	grade_id NUMBER NOT NULL,
	grade_libelle VARCHAR2(10),
	CONSTRAINT GRADE_Pk PRIMARY KEY (grade_id)
);

------------------------------------------------------------
-- Table: POSSEDER
------------------------------------------------------------
CREATE TABLE POSSEDER(
	nationalite_id NUMBER(10,0)  NOT NULL,
	auteur_id NUMBER(10,0)  NOT NULL,
	CONSTRAINT POSSEDER_Pk PRIMARY KEY (nationalite_id,auteur_id)
);

------------------------------------------------------------
-- Table: EMPRUNTER
------------------------------------------------------------
CREATE TABLE EMPRUNTER(
	date_emprunt DATE,
	date_retour DATE,
	utilisateur_id NUMBER(10,0) NOT NULL,
	ouvrage_id NUMBER(10,0) NOT NULL,
	CONSTRAINT EMPRUNTER_Pk PRIMARY KEY (utilisateur_id,ouvrage_id)
);

------------------------------------------------------------
-- Table: CLASSIFIER
------------------------------------------------------------
CREATE TABLE CLASSIFIER(
	type_id NUMBER(10,0) NOT NULL,
	ouvrage_id NUMBER(10,0) NOT NULL,
	CONSTRAINT CLASSIFIER_Pk PRIMARY KEY (type_id,ouvrage_id)
);

------------------------------------------------------------
-- Table: THEMATISER
------------------------------------------------------------
CREATE TABLE THEMATISER(
	genre_id NUMBER(10,0) NOT NULL,
	ouvrage_id NUMBER(10,0) NOT NULL,
	CONSTRAINT THEMATISER_Pk PRIMARY KEY (genre_id,ouvrage_id)
);

------------------------------------------------------------
-- Table: ETIQUETER
------------------------------------------------------------
CREATE TABLE ETIQUETER(
	mot_cle_id NUMBER(10,0) NOT NULL,
	ouvrage_id NUMBER(10,0) NOT NULL,
	CONSTRAINT ETIQUETER_Pk PRIMARY KEY (mot_cle_id,ouvrage_id)
);

------------------------------------------------------------
-- Table: EDITER
------------------------------------------------------------
CREATE TABLE EDITER(
	ouvrage_id NUMBER(10,0) NOT NULL,
	editeur_id NUMBER(10,0) NOT NULL,
	CONSTRAINT EDITER_Pk PRIMARY KEY (ouvrage_id,editeur_id)
);




ALTER TABLE OUVRAGE ADD FOREIGN KEY (auteur_id) REFERENCES AUTEUR(auteur_id);
ALTER TABLE OUVRAGE ADD FOREIGN KEY (serie_id) REFERENCES SERIE(serie_id);
ALTER TABLE OUVRAGE ADD FOREIGN KEY (collection_id) REFERENCES COLLECTION(collection_id);
ALTER TABLE OUVRAGE ADD FOREIGN KEY (tome_id) REFERENCES TOME(tome_id);
ALTER TABLE AUTEUR ADD FOREIGN KEY (civilite_id) REFERENCES CIVILITE(civilite_id);
ALTER TABLE UTILISATEUR ADD FOREIGN KEY (ville_id) REFERENCES VILLE(ville_id);
ALTER TABLE UTILISATEUR ADD FOREIGN KEY (civilite_id) REFERENCES CIVILITE(civilite_id);
ALTER TABLE UTILISATEUR ADD FOREIGN KEY (grade_id) REFERENCES GRADE(grade_id);
ALTER TABLE POSSEDER ADD FOREIGN KEY (nationalite_id) REFERENCES NATIONALITE(nationalite_id);
ALTER TABLE POSSEDER ADD FOREIGN KEY (auteur_id) REFERENCES AUTEUR(auteur_id);
ALTER TABLE EMPRUNTER ADD FOREIGN KEY (utilisateur_id) REFERENCES UTILISATEUR(utilisateur_id);
ALTER TABLE EMPRUNTER ADD FOREIGN KEY (ouvrage_id) REFERENCES OUVRAGE(ouvrage_id);
ALTER TABLE CLASSIFIER ADD FOREIGN KEY (type_id) REFERENCES TYPE(type_id);
ALTER TABLE CLASSIFIER ADD FOREIGN KEY (ouvrage_id) REFERENCES OUVRAGE(ouvrage_id);
ALTER TABLE THEMATISER ADD FOREIGN KEY (genre_id) REFERENCES GENRE(genre_id);
ALTER TABLE THEMATISER ADD FOREIGN KEY (ouvrage_id) REFERENCES OUVRAGE(ouvrage_id);
ALTER TABLE ETIQUETER ADD FOREIGN KEY (mot_cle_id) REFERENCES MOT_CLE(mot_cle_id);
ALTER TABLE ETIQUETER ADD FOREIGN KEY (ouvrage_id) REFERENCES OUVRAGE(ouvrage_id);
ALTER TABLE EDITER ADD FOREIGN KEY (ouvrage_id) REFERENCES OUVRAGE(ouvrage_id);
ALTER TABLE EDITER ADD FOREIGN KEY (editeur_id) REFERENCES EDITEUR(editeur_id);

CREATE SEQUENCE Seq_OUVRAGE_ouvrage_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_AUTEUR_auteur_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_NATIONALITE_nationalite_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_TYPE_type_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_GENRE_genre_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_MOT_CLE_mot_cle_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_UTILISATEUR_utilisateur_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_VILLE_ville_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_CIVILITE_civilite_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_COLLECTION_collection_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_SERIE_serie_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_TOME_tome_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_EDITEUR_editeur_id START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Seq_GRADE_grade_id START WITH 1 INCREMENT BY 1 NOCYCLE;


CREATE OR REPLACE TRIGGER OUVRAGE_ouvrage_id
	BEFORE INSERT ON OUVRAGE 
  FOR EACH ROW 
	WHEN (NEW.ouvrage_id IS NULL) 
	BEGIN
		 select Seq_OUVRAGE_ouvrage_id.NEXTVAL INTO :NEW.ouvrage_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER AUTEUR_auteur_id
	BEFORE INSERT ON AUTEUR 
  FOR EACH ROW 
	WHEN (NEW.auteur_id IS NULL) 
	BEGIN
		 select Seq_AUTEUR_auteur_id.NEXTVAL INTO :NEW.auteur_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER NATIONALITE_nationalite_id
	BEFORE INSERT ON NATIONALITE 
  FOR EACH ROW 
	WHEN (NEW.nationalite_id IS NULL) 
	BEGIN
		 select Seq_NATIONALITE_nationalite_id.NEXTVAL INTO :NEW.nationalite_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER TYPE_type_id
	BEFORE INSERT ON TYPE 
  FOR EACH ROW 
	WHEN (NEW.type_id IS NULL) 
	BEGIN
		 select Seq_TYPE_type_id.NEXTVAL INTO :NEW.type_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER GENRE_genre_id
	BEFORE INSERT ON GENRE 
  FOR EACH ROW 
	WHEN (NEW.genre_id IS NULL) 
	BEGIN
		 select Seq_GENRE_genre_id.NEXTVAL INTO :NEW.genre_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER MOT_CLE_mot_cle_id
	BEFORE INSERT ON MOT_CLE 
  FOR EACH ROW 
	WHEN (NEW.mot_cle_id IS NULL) 
	BEGIN
		 select Seq_MOT_CLE_mot_cle_id.NEXTVAL INTO :NEW.mot_cle_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER UTILISATEUR_utilisateur_id
	BEFORE INSERT ON UTILISATEUR 
  FOR EACH ROW 
	WHEN (NEW.utilisateur_id IS NULL) 
	BEGIN
		 select Seq_UTILISATEUR_utilisateur_id.NEXTVAL INTO :NEW.utilisateur_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER VILLE_ville_id
	BEFORE INSERT ON VILLE 
  FOR EACH ROW 
	WHEN (NEW.ville_id IS NULL) 
	BEGIN
		 select Seq_VILLE_ville_id.NEXTVAL INTO :NEW.ville_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER CIVILITE_civilite_id
	BEFORE INSERT ON CIVILITE 
  FOR EACH ROW 
	WHEN (NEW.civilite_id IS NULL) 
	BEGIN
		 select Seq_CIVILITE_civilite_id.NEXTVAL INTO :NEW.civilite_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER COLLECTION_collection_id
	BEFORE INSERT ON COLLECTION 
  FOR EACH ROW 
	WHEN (NEW.collection_id IS NULL) 
	BEGIN
		 select Seq_COLLECTION_collection_id.NEXTVAL INTO :NEW.collection_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER SERIE_serie_id
	BEFORE INSERT ON SERIE 
  FOR EACH ROW 
	WHEN (NEW.serie_id IS NULL) 
	BEGIN
		 select Seq_SERIE_serie_id.NEXTVAL INTO :NEW.serie_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER TOME_tome_id
	BEFORE INSERT ON TOME 
  FOR EACH ROW 
	WHEN (NEW.tome_id IS NULL) 
	BEGIN
		 select Seq_TOME_tome_id.NEXTVAL INTO :NEW.tome_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER EDITEUR_editeur_id
	BEFORE INSERT ON EDITEUR 
  FOR EACH ROW 
	WHEN (NEW.editeur_id IS NULL) 
	BEGIN
		 select Seq_EDITEUR_editeur_id.NEXTVAL INTO :NEW.editeur_id from DUAL; 
	END;
CREATE OR REPLACE TRIGGER GRADE_grade_id
	BEFORE INSERT ON GRADE 
  FOR EACH ROW 
	WHEN (NEW.grade_id IS NULL) 
	BEGIN
		 select Seq_GRADE_grade_id.NEXTVAL INTO :NEW.grade_id from DUAL; 
	END;

