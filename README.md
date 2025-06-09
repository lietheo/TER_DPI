<p align="center">
  <img src="logo/fac_geo.png" alt="Université de Strasbourg" width="200" />
</p>

# Projet TER DPI — Harmonisation et Automatisation des Données Réseaux  
**Diplôme Observation de la Terre et Géomatique (OTG)**  
**Master 1 — Année universitaire 2024/2025**  
**Université de Strasbourg**

---

## **Contexte et objectifs**

Ce projet s’inscrit dans le cadre du **Travail d’Étude et de Recherche (TER)** du Master 1 OTG de l’Université de Strasbourg.  
L’objectif principal est de partir de **données DAO (AutoCAD)**, sans données SIG initiales, pour automatiser :
- la **conversion** des données vers un format SIG exploitable,
- le **contrôle qualité et réglementaire**,
- ainsi que l’**analyse de vulnérabilité** des réseaux techniques.

---

## **Contenu du dépôt**

### **Dossier `colab/`**  
Contient les **notebooks Google Colab** (`.ipynb`) regroupant les scripts Python commentés pour les différentes étapes du projet.

Ce dossier comprend trois sous-ensembles principaux :
- **`TER_CONTROLE_REGLEMENTATION/`** : Scripts pour le contrôle réglementaire et la qualité des données.
- **`TER_TRAITEMENT_AUTOMATISATION/`** : Scripts pour l’automatisation de la conversion DAO → SIG.
- **`TER_ANALYSE/`** : Scripts pour l’analyse de vulnérabilité et de robustesse des réseaux.

Tous les scripts sont documentés et identifiés (ex. : `py1`, `py2`, etc.).  
Un **graphique explicatif** (disponible dans `images_colab/`) facilite la compréhension de l’enchaînement des scripts.

---

### **Dossier `images_colab/`**  
Contient les **illustrations utilisées dans les notebooks**, pour documenter visuellement chaque étape.  
Les **liens relatifs** sont utilisés dans les notebooks.

---

### **Dossier `arcgis_modelbuilder/`**  
Contient les **modèles créés avec ModelBuilder (ArcGIS)** permettant d’automatiser certaines tâches SIG.

---

### **Dossier `lisp_script/`**

- Contient le fichier **`DPI.xtp`**, une palette AutoCAD avec les outils personnalisés.
- Contient le dossier **`LISP/`**, avec les **scripts AutoLISP** utilisés pour l’extraction et la conversion initiale des données DAO.

**Remarque** : sur GitHub, le nom du dossier `LISP/` peut être **modifié automatiquement** à cause d’un bug lié aux accents (il peut apparaître comme `ZÉZAYER`, par exemple).  
Ce comportement est **documenté** dans le dépôt.

---

### **Dossier `documentation/`**

- Un **graphique `.png`** synthétise l’ensemble des étapes d’automatisation, avec les identifiants des scripts (`py1`, `lisp2`, etc.).
- Un **fichier `.pdf`** récapitule les scripts AutoLISP, chacun illustré et référencé par un identifiant (`lisp1`, `lisp2`, etc.).

---

## **Notes importantes**

- Chaque script (Python ou LISP) possède un **identifiant unique** (`py1`, `py2`, `lisp1`, etc.), visible dans le nom du fichier et dans la documentation.
- Le fichier **`DPI.xtp`** doit être placé dans le **même dossier que `LISP/`** pour être correctement chargé dans AutoCAD.
- La distinction entre les scripts à exécuter dans **Google Colab** ou dans **ArcGIS Pro** est indiquée **dans le titre de chaque script**.

---

## **Contact**

**Projet réalisé par Théo Liégeon**  
Dans le cadre du **Master 1 OTG – Université de Strasbourg**  
**Année universitaire 2024/2025**
