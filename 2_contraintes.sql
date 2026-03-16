-- 2_contraintes.sql
-- Contraintes de validation supplémentaires
-- Syntaxe compatible MySQL Workbench / MySQL 8+

ALTER TABLE utilisateur
ADD CONSTRAINT chk_utilisateur_langue
CHECK (langue_interface IN ('fr', 'en', 'es', 'de', 'it'));

ALTER TABLE utilisateur
ADD CONSTRAINT chk_utilisateur_theme
CHECK (theme_interface IN ('light', 'dark', 'sepia'));

ALTER TABLE dossier
ADD CONSTRAINT chk_dossier_couleur_hex
CHECK (couleur_dossier IS NULL OR couleur_dossier REGEXP '^#[0-9A-Fa-f]{6}$');

ALTER TABLE morceau
ADD CONSTRAINT chk_morceau_bpm
CHECK (bpm IS NULL OR (bpm BETWEEN 20 AND 400));

ALTER TABLE morceau
ADD CONSTRAINT chk_morceau_tonalite
CHECK (
    tonalite IS NULL OR tonalite IN (
        'C','Cm','Db','Dbm','D','Dm','Eb','Ebm','E','Em','F','Fm',
        'Gb','Gbm','G','Gm','Ab','Abm','A','Am','Bb','Bbm','B','Bm'
    )
);

ALTER TABLE morceau
ADD CONSTRAINT chk_morceau_signature
CHECK (signature_rythmique IS NULL OR signature_rythmique IN ('2/4','3/4','4/4','5/4','6/8','7/4','12/8'));

ALTER TABLE morceau
ADD CONSTRAINT chk_morceau_statut
CHECK (statut_apprentissage IS NULL OR statut_apprentissage IN ('a_apprendre','en_cours','maitrise'));

ALTER TABLE grille
ADD CONSTRAINT chk_grille_nom_non_vide
CHECK (nom_version IS NULL OR LENGTH(TRIM(nom_version)) > 0);

ALTER TABLE mesure
ADD CONSTRAINT chk_mesure_numero
CHECK (numero_mesure > 0);

ALTER TABLE mesure
ADD CONSTRAINT chk_mesure_contenu_non_vide
CHECK (contenu_mesure IS NULL OR LENGTH(TRIM(contenu_mesure)) > 0);

ALTER TABLE analyse
ADD CONSTRAINT chk_analyse_texte_non_vide
CHECK (texte_analyse IS NULL OR LENGTH(TRIM(texte_analyse)) >= 10);
