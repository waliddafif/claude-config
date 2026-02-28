---
name: pr-ready
description: Workflow complet de vérification avant PR. Orchestre code review, audit sécurité, tests et deploy check en séquence. Use when user says "prêt pour la PR", "pr ready", "vérifier avant PR", "pré-PR check", "ready to merge".
disable-model-invocation: true
argument-hint: [base-branch]
---

# PR Ready — Vérification pré-PR complète

Orchestre 4 phases de vérification avant de créer une PR. La branche de référence est `$0` (défaut : `main`).

## Instructions

### Phase 1 : Code Review

1. Récupérer le diff : `git diff ${base}...HEAD` (où base = `$0` ou `main`)
2. Lister les fichiers modifiés : `git diff --name-only ${base}...HEAD`
3. Pour chaque fichier modifié, vérifier :

**Qualité (règles B1-B5) :**
- B1 : Les modèles DB ont été lus avant d'écrire les queries ?
- B2 : Les signatures de service sont correctes ?
- B3 : Chaque code path DB a un test d'intégration ?
- B4 : Pas de duplication de logique métier ?
- B5 : Types stricts dans les requêtes DB (UUID, pas str) ?

**Sérialisation :**
- `Decimal` converti en `float()` avant JSON/Pydantic ?
- `UUID` converti en `str()` ?
- Pas de PII dans les logs (IDs uniquement) ?

**Performance :**
- Index DB sur les colonnes filtrées ?
- Pas de N+1 queries ?
- Pagination sur les endpoints qui retournent des listes ?

**SQL :**
- Requêtes paramétrées uniquement (pas de f-string) ?
- Pas de fonctions dialecte-spécifiques (`func.strftime()`) ?
- Patch au module source dans les tests ?

Format de sortie par fichier :
```
📄 app/services/my_service.py
  ✅ Logique métier correcte
  ⚠️ Ligne 42 : Decimal non converti → float() manquant
  ❌ Pas de test d'intégration (règle B3)
```

### Phase 2 : Security Audit (fichiers modifiés uniquement)

Scanner uniquement les fichiers du diff pour les règles S1-S9 :
- S1 : Comparaison de secrets avec `==` / `!=`
- S2 : `detail=str(e)` dans les HTTPException
- S3 : Security headers présents
- S4 : SQL injection via f-string
- S5 : Rate limiting sur endpoints auth/publics
- S6 : Validation MIME par magic bytes
- S7 : Fail-closed en production
- S8 : Secrets dans le code
- S9 : Audit trail sur les downloads

Format :
```
🔒 Sécurité : X/9 règles vérifiées — Y violations
  ❌ S2 : app/routes/auth.py:15 — detail=str(e)
  ✅ S4 : Pas d'injection SQL
```

### Phase 3 : Tests

1. Détecter le type de projet :
   - `pyproject.toml` ou `requirements.txt` → Python
   - `package.json` → Node.js/Next.js

2. **Python** :
   ```bash
   pytest tests/ -x -v --tb=short 2>&1 | tail -30
   ```

3. **Node.js** :
   ```bash
   npm run test:run 2>&1 | tail -30
   npm run build 2>&1 | tail -20
   ```

4. Résumer : tests passés/échoués, build OK/KO

Format :
```
🧪 Tests : X passés, Y échoués
🏗️ Build : ✅ OK / ❌ Échoué
```

### Phase 4 : Deploy Check

Vérifier la checklist de déploiement :
- [ ] Pas de `print()`, `console.log()`, `debugger` oubliés
- [ ] Pas de `TODO` ou `FIXME` bloquants
- [ ] Pas de secrets hardcodés
- [ ] Variables d'environnement documentées dans `.env.example`
- [ ] Migrations DB écrites si changement de schéma
- [ ] Logs structurés sur les nouveaux endpoints

### Verdict Final

Produire un verdict en français :

```
═══════════════════════════════════════
  VERDICT : 🟢 PRÊT / 🟡 RÉSERVES / 🔴 BLOQUÉ
═══════════════════════════════════════

📝 Code Review    : ✅/⚠️/❌ — X points
🔒 Sécurité       : ✅/⚠️/❌ — X/9 conformes
🧪 Tests          : ✅/❌ — X passés, Y échoués
🏗️ Build          : ✅/❌
🚀 Deploy Check   : ✅/⚠️/❌ — X/Y validés

Actions requises :
1. [action prioritaire]
2. [action suivante]
```

**Règles de verdict :**
- 🟢 **Prêt** : 0 violation critique, tests OK, build OK
- 🟡 **Réserves** : warnings ou points d'attention, mais rien de bloquant
- 🔴 **Bloqué** : violation sécurité critique, tests échoués, ou build cassé
