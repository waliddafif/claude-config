---
name: security-audit
description: Audit de sécurité OWASP complet du codebase avec scoring et rapport structuré. Use when user says "audit sécurité", "security audit", "vérifier la sécurité", "OWASP check", "scan sécurité".
disable-model-invocation: true
allowed-tools: Read, Grep, Glob
---

# Security Audit

Audit de sécurité basé sur les règles OWASP définies dans `references/security-rules.md`.

## Instructions

### Step 1 : Identifier le scope

- Si argument fourni (`$ARGUMENTS`), auditer uniquement ces fichiers/dossiers
- Sinon, auditer tout le codebase (exclure `node_modules/`, `.venv/`, `__pycache__/`, `.next/`)
- Identifier les fichiers Python (.py) et TypeScript (.ts, .tsx) pertinents

### Step 2 : Scanner chaque règle

Pour chaque règle S1-S9, utiliser Grep pour détecter les violations :

**S1 — Timing attacks :**
- Chercher : `== .*token`, `!= .*secret`, `== .*api_key`, `!= .*password`
- Exclure les fichiers de test
- Vérifier que `hmac.compare_digest()` est utilisé

**S2 — Information disclosure :**
- Chercher : `detail=str(e)`, `detail=f"`, `detail=f'`
- Dans les HTTPException et réponses d'erreur

**S3 — Security headers :**
- Vérifier la présence d'un middleware avec les headers obligatoires
- X-Frame-Options, X-Content-Type-Options, Referrer-Policy, HSTS

**S4 — SQL injection :**
- Chercher : `f"SELECT`, `f"INSERT`, `f"UPDATE`, `f"DELETE`, `f'SELECT`
- Chercher : `text(f"`, `text(f'`
- Vérifier que les requêtes utilisent des bind parameters

**S5 — Rate limiting :**
- Identifier les endpoints login, reset-password, verify, magic-link
- Vérifier qu'un rate limiter est en place

**S6 — Validation MIME :**
- Chercher les endpoints d'upload
- Vérifier que `magic.from_buffer()` ou équivalent est utilisé

**S7 — Fail-closed :**
- Chercher les patterns `if not.*key:` suivis de `return` (fail-open)
- Vérifier la logique en production

**S8 — Secrets dans git :**
- Vérifier `.gitignore` couvre `.env`, `*.key`, `*.pem`, `credentials*`
- Chercher des secrets hardcodés (patterns : `password =`, `api_key =`, `secret =` avec des valeurs littérales)

**S9 — Audit trail :**
- Identifier les endpoints de download/export
- Vérifier qu'un log d'audit est présent

### Step 3 : Attribuer les statuts

Pour chaque règle :
- ✅ **Conforme** : aucune violation trouvée, bonnes pratiques en place
- ⚠️ **Attention** : pas de violation mais protection manquante ou non vérifiable
- ❌ **Violation** : violation explicite trouvée (fichier:ligne)

Sévérité des violations :
- **Critique** : S1 (timing attack), S2 (info disclosure), S4 (SQL injection)
- **Haute** : S5 (rate limiting), S7 (fail-open), S8 (secrets dans git)
- **Moyenne** : S3 (headers), S6 (MIME), S9 (audit trail)

### Step 4 : Produire le rapport

Format du rapport (en français) :

```
# Rapport d'Audit Sécurité

## Résumé
- **Score** : X/9 règles conformes
- **Violations** : Y critiques, Z hautes, W moyennes

## Détail par règle

### S1 — Timing attacks [✅/⚠️/❌]
[Détail des findings avec fichier:ligne]

### S2 — Information disclosure [✅/⚠️/❌]
...

## Checklist pré-PR
- [ ] point 1
- [ ] point 2

## Actions requises
1. [Action prioritaire avec correction recommandée]
```

## Ressources

Pour le détail complet des règles avec exemples de code, consulter [references/security-rules.md](references/security-rules.md).
