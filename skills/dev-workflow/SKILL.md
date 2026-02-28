---
name: dev-workflow
description: Best practices for working effectively with Claude Code. Guides Claude on planning, context management, self-verification, subagent delegation, and session hygiene. Loaded automatically when Claude works on code tasks.
user-invocable: false
---

# Claude Workflow — Best Practices

Règles de travail pour maximiser l'efficacité et la qualité des sessions Claude Code.
Basé sur les recommandations de Boris Cherny (créateur de Claude Code) et de la doc Anthropic.

## 1. Planifier avant de coder

- **Toujours lire le code existant** avant de proposer des modifications
- Utiliser le plan mode pour les tâches non triviales (plus de 2-3 fichiers)
- Lire les modèles DB, les signatures de service, les patterns en place AVANT d'écrire
- Pour les features complexes : rédiger un plan, le présenter pour validation, puis coder

## 2. Self-verification — vérifier son propre travail

- Après avoir écrit du code, exécuter les tests pertinents pour vérifier
- Ne pas attendre que l'utilisateur trouve les bugs : les chercher activement
- Si un test existe déjà pour le code modifié, le relancer systématiquement
- Pour les changements critiques : relire le diff avant de considérer la tâche terminée

## 3. Context management — garder le contexte propre

- Le context window est une ressource limitée. Ne pas le polluer avec des outputs volumineux
- Utiliser `| tail -30` ou `| head -20` pour limiter les sorties de commandes longues
- Déléguer la recherche exploratoire à des subagents (Agent tool avec Explore) pour préserver le contexte principal
- Si l'utilisateur corrige 2 fois la même erreur : c'est un signal que le contexte est pollué. Recommander /clear et reformuler le prompt

## 4. Subagents — déléguer intelligemment

- Utiliser des subagents pour les recherches exploratoires (Explore agent)
- Utiliser des subagents pour les tâches indépendantes parallélisables
- Ne PAS dupliquer le travail d'un subagent dans le contexte principal
- Lancer les recherches indépendantes en parallèle (plusieurs Agent calls dans un seul message)

## 5. Prompts ultra-spécifiques

- Préférer les instructions précises aux instructions vagues
- Mauvais : "ajoute des tests pour auth.py"
- Bon : "ajoute des tests pour auth.py couvrant l'expiration de session mid-request, sans mocks, focus sur les tokens expirés mais visuellement valides"
- Inclure les contraintes, le format de sortie attendu, et les cas edge

## 6. Worktrees pour sessions parallèles

- Utiliser git worktrees pour faire tourner plusieurs sessions en parallèle
- Pattern recommandé : une session qui code, une qui review
- Chaque worktree a son propre état git isolé

## 7. Notes par projet — mémoire scalable

- Plutôt qu'un CLAUDE.md monolithique, utiliser un répertoire `notes/` par projet
- Référencer les notes depuis CLAUDE.md : `Voir notes/ pour le contexte détaillé`
- Mettre à jour les notes après chaque PR ou décision architecturale
- Garder CLAUDE.md concis (règles universelles uniquement) et notes/ pour le contexte évolutif

## 8. Hygiène de session

- `/compact` quand le contexte devient long mais la tâche continue
- `/clear` quand on change de sujet ou après trop de corrections
- Committer régulièrement pour créer des "checkpoints" permettant de rewind si une approche échoue
- En fin de session : vérifier qu'il n'y a pas de code dupliqué ou de TODO oubliés

## 9. Debug — dump brut plutôt que description

- Pour les bugs : coller les logs, stack traces, messages d'erreur directement
- Les dumps bruts sont plus riches en contexte que les descriptions humaines
- Laisser Claude analyser les données brutes plutôt que se baser sur une interprétation

## 10. Output explicatif

- Quand l'utilisateur apprend ou découvre le code : expliquer le pourquoi des changements, pas juste le quoi
- Quand l'utilisateur est expert et veut aller vite : être concis, focus sur l'action
- S'adapter au style de la conversation
