# ProjetDB_Yungmann_Berthelot
Base de donnée
# Mini-Projet TI404 – Partie 1  
## Conception d’une base de données – Méthode MERISE

## 1.1 Domaine choisi

Le domaine choisi est celui d’une application web de gestion de répertoire musical et d’analyses personnelles pour musiciens.

L’organisation modélisée est une application numérique permettant :
- à un utilisateur de gérer ses morceaux,
- d’organiser ces morceaux dans des dossiers hiérarchiques,
- d’ajouter des grilles d’accords,
- d’écrire des analyses personnelles sur les morceaux.

Cette organisation est comparable à des applications comme :
- iReal Pro
- musictheory.net
- Teoria-

## 1.2 Prompt utilisé (Framework RICARDO)

Tu travailles dans le domaine de la gestion de répertoire musical numérique pour musiciens. Ton organisation est une entreprise de développement d’applications web dont l’activité principale est la création d’un outil permettant aux musiciens de gérer leurs morceaux, organiser des dossiers hiérarchiques, créer des grilles d’accords et rédiger des analyses personnelles.  

C’est une entreprise comparable à des applications comme iReal Pro, musictheory.net ou Teoria, mais centrée sur la gestion personnalisée d’un répertoire musical.  

Les données ont été collectées à partir de l’observation du fonctionnement d’applications similaires, de la structure d’une bibliothèque musicale personnelle et des besoins réalistes d’un musicien utilisant une application de gestion de morceaux.  

Inspire-toi des sites suivants :  
- https://www.irealpro.com  
- https://www.musictheory.net  
- https://www.teoria.com  

Ton organisation veut appliquer MERISE pour concevoir un système d'information. Tu es chargé de la partie analyse, c’est-à-dire de collecter les besoins auprès de l’organisation. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet, tu dois lui fournir les informations nécessaires pour qu’il applique ensuite lui-même les étapes suivantes de conception et développement de la base de données.  

D’abord, établis les règles de gestion des données de ton organisation, sous la forme d'une liste à puce. Elles doivent correspondre aux informations que fournit quelqu’un qui connaît le fonctionnement de l’entreprise, mais pas comment se construit un système d’information.  

Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau : signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données. Il sert à fournir des informations supplémentaires sur chaque donnée (taille et type) mais sans a priori sur comment les données vont être modélisées ensuite.  

Fournis donc les règles de gestion et le dictionnaire de données.

---

## 1.3 Règles de gestion obtenues

- Un utilisateur est identifié par un identifiant unique et un email unique.
- Un utilisateur possède un thème d’interface et une langue.
- Un utilisateur peut posséder plusieurs dossiers.
- Chaque dossier appartient à un seul utilisateur.
- Un dossier peut contenir des sous-dossiers.
- Un dossier peut contenir plusieurs morceaux.
- Un morceau peut appartenir à plusieurs dossiers.
- Un morceau appartient à un seul utilisateur.
- Un morceau possède un titre obligatoire.
- Un morceau peut avoir un auteur, un style, un BPM, une tonalité, une signature rythmique et un statut.
- Un morceau peut avoir plusieurs grilles.
- Une grille appartient à un seul morceau.
- Une grille est composée d’au moins une mesure.
- Une mesure appartient à une seule grille.
- Un utilisateur peut écrire plusieurs analyses.
- Une analyse est écrite par un seul utilisateur.
- Une analyse concerne un seul morceau.
- Un utilisateur ne peut écrire qu’une seule analyse par morceau.

---

## 1.4 Dictionnaire de données

| Signification | Type | Taille |
|---------------|------|--------|
| Identifiant utilisateur | INT | 10 |
| Email utilisateur | VARCHAR | 254 |
| Nom affiché | VARCHAR | 50 |
| Date création utilisateur | DATE | - |
| Thème interface | VARCHAR | 10 |
| Langue interface | VARCHAR | 5 |
| Identifiant dossier | INT | 10 |
| Nom dossier | VARCHAR | 60 |
| Couleur dossier | VARCHAR | 7 |
| Date création dossier | DATE | - |
| Identifiant morceau | INT | 10 |
| Titre morceau | VARCHAR | 120 |
| Auteur morceau | VARCHAR | 80 |
| Style musical | VARCHAR | 40 |
| BPM par défaut | INT | 3 |
| Tonalité par défaut | VARCHAR | 6 |
| Signature rythmique | VARCHAR | 5 |
| Statut apprentissage | VARCHAR | 12 |
| Date ajout morceau | DATE | - |
| Identifiant grille | INT | 10 |
| Nom version grille | VARCHAR | 40 |
| Numéro mesure | INT | 4 |
| Contenu mesure | VARCHAR | 255 |
| Identifiant analyse | INT | 10 |
| Texte analyse | TEXT | 2000 |
| Date création analyse | DATE | - |

---

# 2. Modèle Conceptuel de Données (MCD)

Le MCD a été réalisé avec l’outil Looping.

Il respecte :
- la 3FN,
- l’identification claire des entités, associations, attributs et cardinalités,
- l’intégration d’éléments avancés de modélisation :
  - une association récursive (DOSSIER parent/enfant),
  - une entité faible (MESURE dépendante de GRILLE).

## 2.2 Éléments avancés

### Association récursive
Un dossier peut contenir d’autres dossiers :  
Cardinalités (0,1) – (0,N).

### Entité faible
Une mesure est identifiée par son numéro et la grille à laquelle elle appartient.  
Identifiant composite : (id_grille, m_nombre).

---

# Conclusion

Le modèle conceptuel obtenu correspond aux règles métier identifiées et respecte les exigences de normalisation et de modélisation avancée demandées. Il servira de base pour la génération du MLD et du MPD lors de la seconde partie du projet.
