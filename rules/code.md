---
description: Coding rules and DB/serialization best practices
globs: ["**/*.py", "**/*.ts", "**/*.tsx", "**/*.js", "**/*.jsx"]
---

# Code Rules

Full reference: `~/Documents/my-standards/rules/CODING.md`

- Lire les modeles DB/schemas avant d'ecrire du code (rule B1)
- Verifier les signatures de service avant d'appeler (rule B2)
- `float()` sur `Decimal`, `str()` sur `UUID` avant serialisation Pydantic/JSON
- Pas de PII dans les logs (IDs uniquement)
- Patcher au module source dans les tests, pas au module qui importe
- Pas de fonctions SQL dialecte-specifiques (`func.strftime()` = SQLite only)
