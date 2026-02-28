---
name: techdebt
description: Nettoyage de dette technique en fin de session. Trouve le code dupliqué, les imports inutilisés, le dead code, les TODO oubliés, et les inconsistances. Use when user says "techdebt", "nettoyer le code", "clean up", "dette technique", "fin de session".
disable-model-invocation: true
argument-hint: [path]
---

# Tech Debt — Nettoyage de session

Analyse le codebase (ou le path `$ARGUMENTS` si spécifié) pour identifier et corriger la dette technique accumulée.

## Instructions

### Step 1 : Identifier le scope

- Si `$ARGUMENTS` fourni : analyser uniquement ce path
- Sinon : analyser les fichiers modifiés récemment (`git diff --name-only HEAD~5` ou depuis la dernière branche)

### Step 2 : Scanner les catégories de dette

**Code dupliqué :**
- Chercher les blocs de code similaires (3+ lignes identiques ou quasi-identiques)
- Proposer l'extraction dans une fonction/composant commun (règle B4)

**Imports inutilisés :**
- Python : imports non référencés dans le fichier
- TypeScript : imports non utilisés (le linter devrait les catch, mais vérifier)

**Dead code :**
- Fonctions/méthodes jamais appelées
- Variables assignées mais jamais lues
- Branches conditionnelles impossibles
- Code commenté (supprimer plutôt que laisser en commentaire)

**TODO / FIXME / HACK oubliés :**
- Lister tous les TODO/FIXME/HACK dans le scope
- Classifier : résolvable maintenant vs nécessite une décision

**Inconsistances :**
- Nommage incohérent (camelCase vs snake_case dans le même contexte)
- Patterns différents pour la même chose (ex: deux façons de fetch des données)
- Types manquants dans du TypeScript strict

**Console/Debug oubliés :**
- `print()`, `console.log()`, `debugger`, `breakpoint()` laissés dans le code
- `logger.debug()` trop verbeux en production

### Step 3 : Produire le rapport

Format en français :

```
# Rapport Tech Debt

## Résumé
- X problèmes trouvés (Y auto-fixables, Z nécessitent une décision)

## Auto-fixable (je peux corriger maintenant)
1. [fichier:ligne] — Import inutilisé `unused_module`
2. [fichier:ligne] — console.log de debug

## Nécessite une décision
1. [fichier:ligne] — Code dupliqué entre service_a.py et service_b.py
   → Proposition : extraire dans utils/common.py
2. [fichier:ligne] — TODO: "refactor this later" (3 mois)
   → Toujours pertinent ?

## Rien à signaler
- Dead code : aucun trouvé ✅
```

### Step 4 : Corriger

- Demander confirmation avant de corriger les "auto-fixables"
- Pour les "nécessite une décision" : attendre la réponse de l'utilisateur
- Après correction : relancer les tests pour vérifier qu'on n'a rien cassé
