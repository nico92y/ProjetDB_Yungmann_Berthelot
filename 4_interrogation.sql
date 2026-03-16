-- 4_interrogation.sql
-- Scénario : un musicien organise son répertoire et analyse son avancement.

-- =====================================================
-- 1) Projections / sélections / tris / masques / IN / BETWEEN
-- =====================================================

-- 1. Afficher les titres et auteurs de tous les morceaux de style jazz.
SELECT titre, auteur
FROM morceau
WHERE style = 'jazz';

-- 2. Afficher les morceaux dont le BPM est compris entre 90 et 140.
SELECT titre, bpm
FROM morceau
WHERE bpm BETWEEN 90 AND 140
ORDER BY bpm ASC;

-- 3. Afficher les morceaux dont le titre contient le mot "Blue".
SELECT id_morceau, titre
FROM morceau
WHERE titre LIKE '%Blue%';

-- 4. Afficher les styles musicaux distincts présents dans la base.
SELECT DISTINCT style
FROM morceau
ORDER BY style;

-- 5. Afficher les morceaux dont le style est jazz, blues ou funk.
SELECT titre, style
FROM morceau
WHERE style IN ('jazz', 'blues', 'funk')
ORDER BY titre;

-- 6. Afficher les morceaux triés du plus rapide au plus lent.
SELECT titre, bpm
FROM morceau
ORDER BY bpm DESC, titre ASC;

-- =====================================================
-- 2) Agrégations / GROUP BY / HAVING
-- =====================================================

-- 7. Compter le nombre de morceaux par utilisateur.
SELECT id_utilisateur, COUNT(*) AS nb_morceaux
FROM morceau
GROUP BY id_utilisateur
ORDER BY nb_morceaux DESC;

-- 8. Calculer le BPM moyen par style.
SELECT style, ROUND(AVG(bpm), 2) AS bpm_moyen
FROM morceau
GROUP BY style
ORDER BY bpm_moyen DESC;

-- 9. Compter le nombre de morceaux par statut d'apprentissage.
SELECT statut_apprentissage, COUNT(*) AS nb_morceaux
FROM morceau
GROUP BY statut_apprentissage
ORDER BY nb_morceaux DESC;

-- 10. Afficher les styles ayant au moins 3 morceaux.
SELECT style, COUNT(*) AS nb_morceaux
FROM morceau
GROUP BY style
HAVING COUNT(*) >= 3
ORDER BY nb_morceaux DESC;

-- 11. Compter le nombre de mesures par grille.
SELECT id_grille, COUNT(*) AS nb_mesures
FROM mesure
GROUP BY id_grille
HAVING COUNT(*) >= 8
ORDER BY id_grille;

-- 12. Compter le nombre d'analyses par utilisateur.
SELECT id_utilisateur, COUNT(*) AS nb_analyses
FROM analyse
GROUP BY id_utilisateur
ORDER BY nb_analyses DESC;

-- =====================================================
-- 3) Jointures internes / externes / simples / multiples
-- =====================================================

-- 13. Afficher chaque morceau avec le nom de l'utilisateur propriétaire.
SELECT m.titre, u.nom_affiche
FROM morceau m
INNER JOIN utilisateur u ON m.id_utilisateur = u.id_utilisateur
ORDER BY u.nom_affiche, m.titre;

-- 14. Afficher les morceaux contenus dans chaque dossier.
SELECT d.nom_dossier, m.titre
FROM dossier d
INNER JOIN dossier_morceau dm ON d.id_dossier = dm.id_dossier
INNER JOIN morceau m ON dm.id_morceau = m.id_morceau
ORDER BY d.nom_dossier, m.titre;

-- 15. Afficher les grilles associées à chaque morceau.
SELECT m.titre, g.nom_version
FROM morceau m
INNER JOIN grille g ON g.id_morceau = m.id_morceau
ORDER BY m.titre, g.nom_version;

-- 16. Afficher les mesures de chaque grille avec le morceau correspondant.
SELECT m.titre, g.nom_version, me.numero_mesure, me.contenu_mesure
FROM morceau m
INNER JOIN grille g ON g.id_morceau = m.id_morceau
INNER JOIN mesure me ON me.id_grille = g.id_grille
ORDER BY m.titre, g.nom_version, me.numero_mesure;

-- 17. Afficher les dossiers, y compris ceux qui ne contiennent encore aucun morceau.
SELECT d.nom_dossier, m.titre
FROM dossier d
LEFT JOIN dossier_morceau dm ON d.id_dossier = dm.id_dossier
LEFT JOIN morceau m ON dm.id_morceau = m.id_morceau
ORDER BY d.nom_dossier, m.titre;

-- 18. Afficher les analyses avec l'utilisateur et le morceau concernés.
SELECT u.nom_affiche, m.titre, a.date_creation
FROM analyse a
INNER JOIN utilisateur u ON a.id_utilisateur = u.id_utilisateur
INNER JOIN morceau m ON a.id_morceau = m.id_morceau
ORDER BY a.date_creation DESC;

-- =====================================================
-- 4) Requêtes imbriquées : IN / NOT IN / EXISTS / NOT EXISTS / ANY / ALL
-- =====================================================

-- 19. Afficher les morceaux ayant au moins une analyse.
SELECT titre
FROM morceau
WHERE id_morceau IN (
    SELECT id_morceau
    FROM analyse
)
ORDER BY titre;

-- 20. Afficher les morceaux n'ayant encore aucune analyse.
SELECT titre
FROM morceau
WHERE id_morceau NOT IN (
    SELECT id_morceau
    FROM analyse
)
ORDER BY titre;

-- 21. Afficher les utilisateurs ayant déjà écrit au moins une analyse.
SELECT nom_affiche
FROM utilisateur
WHERE id_utilisateur IN (
    SELECT id_utilisateur
    FROM analyse
)
ORDER BY nom_affiche;

-- 22. Afficher les morceaux dont le BPM est supérieur à au moins un morceau de style blues.
SELECT titre, bpm
FROM morceau
WHERE bpm > ANY (
    SELECT bpm
    FROM morceau
    WHERE style = 'blues' AND bpm IS NOT NULL
)
ORDER BY bpm DESC;

-- 23. Afficher les morceaux dont le BPM est supérieur à tous les morceaux de style ballad (si présents).
SELECT titre, bpm
FROM morceau
WHERE bpm > ALL (
    SELECT bpm
    FROM morceau
    WHERE style = 'ballad' AND bpm IS NOT NULL
)
ORDER BY bpm DESC;

-- 24. Afficher les utilisateurs pour lesquels il existe au moins un dossier sans parent.
SELECT u.nom_affiche
FROM utilisateur u
WHERE EXISTS (
    SELECT 1
    FROM dossier d
    WHERE d.id_utilisateur = u.id_utilisateur
      AND d.id_dossier_parent IS NULL
)
ORDER BY u.nom_affiche;

-- 25. Afficher les morceaux pour lesquels il n'existe aucune grille.
SELECT m.titre
FROM morceau m
WHERE NOT EXISTS (
    SELECT 1
    FROM grille g
    WHERE g.id_morceau = m.id_morceau
)
ORDER BY m.titre;
