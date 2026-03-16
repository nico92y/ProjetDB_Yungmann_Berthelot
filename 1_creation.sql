-- 1_creation.sql
-- MPD de la base de données du projet musical
-- Syntaxe compatible MySQL Workbench / MySQL 8+

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS analyse;
DROP TABLE IF EXISTS mesure;
DROP TABLE IF EXISTS grille;
DROP TABLE IF EXISTS dossier_morceau;
DROP TABLE IF EXISTS morceau;
DROP TABLE IF EXISTS dossier;
DROP TABLE IF EXISTS utilisateur;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE utilisateur (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(254) NOT NULL UNIQUE,
    nom_affiche VARCHAR(50),
    date_creation DATE NOT NULL DEFAULT (CURRENT_DATE),
    theme_interface VARCHAR(10),
    langue_interface VARCHAR(5)
);

CREATE TABLE dossier (
    id_dossier INT AUTO_INCREMENT PRIMARY KEY,
    nom_dossier VARCHAR(60) NOT NULL,
    couleur_dossier VARCHAR(7),
    date_creation DATE NOT NULL DEFAULT (CURRENT_DATE),
    id_utilisateur INT NOT NULL,
    id_dossier_parent INT NULL,
    CONSTRAINT fk_dossier_utilisateur
        FOREIGN KEY (id_utilisateur)
        REFERENCES utilisateur(id_utilisateur)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_dossier_parent
        FOREIGN KEY (id_dossier_parent)
        REFERENCES dossier(id_dossier)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE morceau (
    id_morceau INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(120) NOT NULL,
    auteur VARCHAR(80),
    style VARCHAR(40),
    bpm INT,
    tonalite VARCHAR(6),
    signature_rythmique VARCHAR(5),
    statut_apprentissage VARCHAR(12),
    date_ajout DATE NOT NULL DEFAULT (CURRENT_DATE),
    id_utilisateur INT NOT NULL,
    CONSTRAINT fk_morceau_utilisateur
        FOREIGN KEY (id_utilisateur)
        REFERENCES utilisateur(id_utilisateur)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE dossier_morceau (
    id_dossier INT NOT NULL,
    id_morceau INT NOT NULL,
    PRIMARY KEY (id_dossier, id_morceau),
    CONSTRAINT fk_dm_dossier
        FOREIGN KEY (id_dossier)
        REFERENCES dossier(id_dossier)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_dm_morceau
        FOREIGN KEY (id_morceau)
        REFERENCES morceau(id_morceau)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE grille (
    id_grille INT AUTO_INCREMENT PRIMARY KEY,
    nom_version VARCHAR(40),
    id_morceau INT NOT NULL,
    CONSTRAINT fk_grille_morceau
        FOREIGN KEY (id_morceau)
        REFERENCES morceau(id_morceau)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE mesure (
    id_grille INT NOT NULL,
    numero_mesure INT NOT NULL,
    contenu_mesure VARCHAR(255),
    PRIMARY KEY (id_grille, numero_mesure),
    CONSTRAINT fk_mesure_grille
        FOREIGN KEY (id_grille)
        REFERENCES grille(id_grille)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE analyse (
    id_analyse INT AUTO_INCREMENT PRIMARY KEY,
    texte_analyse TEXT,
    date_creation DATE NOT NULL DEFAULT (CURRENT_DATE),
    id_utilisateur INT NOT NULL,
    id_morceau INT NOT NULL,
    CONSTRAINT uq_analyse_unique UNIQUE (id_utilisateur, id_morceau),
    CONSTRAINT fk_analyse_utilisateur
        FOREIGN KEY (id_utilisateur)
        REFERENCES utilisateur(id_utilisateur)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_analyse_morceau
        FOREIGN KEY (id_morceau)
        REFERENCES morceau(id_morceau)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
