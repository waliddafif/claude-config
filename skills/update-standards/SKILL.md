---
name: update-standards
description: Vérifie les dernières best practices et propose des mises à jour pour les skills standards-enforcer, security-audit, project-init et claude-workflow. Use when user says "update standards", "mettre à jour les standards", "vérifier les mises à jour", "what's new in security".
disable-model-invocation: true
---

# Update Standards

Vérifie les évolutions des best practices et propose des mises à jour pour les skills existants.

## Sources à vérifier

### Sécurité Web (impacte standards-enforcer S1-S19, security-audit)
1. **OWASP Top 10** — WebSearch "OWASP Top 10 latest changes updates"
2. **CVEs Next.js** — WebSearch "Next.js security vulnerabilities CVE [année en cours]"
3. **CVEs FastAPI** — WebSearch "FastAPI security vulnerabilities CVE [année en cours]"
4. **Python security** — WebSearch "Python security advisories [année en cours]"

### Agentic AI & MCP (impacte standards-enforcer AG1-AG10)
5. **OWASP Agentic** — WebSearch "OWASP Top 10 agentic applications updates [année en cours]"
6. **MCP Spec** — WebSearch "Model Context Protocol specification changes [année en cours]"
7. **Anthropic security** — WebSearch "Anthropic Claude security updates [année en cours]"

### Stacks (impacte project-init)
8. **Next.js** — WebSearch "Next.js latest stable version release notes"
9. **FastAPI** — WebSearch "FastAPI latest version release notes"
10. **Tailwind CSS** — WebSearch "Tailwind CSS latest version"
11. **SQLAlchemy** — WebSearch "SQLAlchemy latest version changes"
12. **Pydantic** — WebSearch "Pydantic latest version"

### Claude Code (impacte claude-workflow)
13. **Anthropic blog** — WebSearch "Anthropic Claude Code new features [année en cours]"
14. **Claude Code docs** — WebSearch "Claude Code changelog updates [année en cours]"

## Instructions

### Step 1 : Scanner les sources

Exécuter les WebSearch ci-dessus. Limiter à 2-3 recherches par catégorie pour économiser les tokens. Prioriser les catégories sécurité (1-7) qui bougent le plus vite.

### Step 2 : Comparer avec les skills actuels

Lire les skills existants :
- `~/.claude/skills/standards-enforcer/SKILL.md`
- `~/.claude/skills/security-audit/SKILL.md`
- `~/.claude/skills/security-audit/references/security-rules.md`
- `~/.claude/skills/project-init/SKILL.md`
- `~/.claude/skills/claude-workflow/SKILL.md`

Pour chaque source, identifier :
- Nouvelles règles/CVEs non couvertes
- Règles existantes devenues obsolètes ou à modifier
- Versions de stacks à mettre à jour dans les templates

### Step 3 : Produire le rapport

Format en français :

```
# Rapport de Mise à Jour des Standards
Date : [date du jour]

## Résumé
- X nouvelles règles à ajouter
- Y règles à mettre à jour
- Z versions de stacks obsolètes
- W inchangé

## Nouvelles règles proposées

### [Catégorie] — [Source]
- **Règle** : [description]
- **Skill impacté** : standards-enforcer / security-audit / ...
- **Sévérité** : Critique / Haute / Moyenne / Info
- **Proposition** : [texte exact à ajouter]

## Mises à jour proposées

### [Règle existante] — [Source]
- **Changement** : [ce qui a changé]
- **Action** : modifier / supprimer / remplacer
- **Avant** : [texte actuel]
- **Après** : [texte proposé]

## Versions de stacks

| Stack | Version actuelle (template) | Dernière stable | Action |
|-------|-----------------------------|-----------------|--------|
| Next.js | X.x | Y.y | Mettre à jour |

## Aucun changement détecté
- [liste des sources sans nouveautés]
```

### Step 4 : Appliquer (sur validation)

- Attendre la validation de l'utilisateur pour CHAQUE modification
- Appliquer les changements validés dans les fichiers SKILL.md concernés
- Ne jamais modifier sans accord explicite
- Après modification, proposer de regénérer les zips pour Claude.ai :
  `cd ~/.claude/skills && zip -r ~/Downloads/[skill].zip [skill]/`
