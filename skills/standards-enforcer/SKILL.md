---
name: standards-enforcer
description: Enforce coding standards automatically. Loaded when Claude writes Python/FastAPI, TypeScript/Next.js, SQL, tests, or agentic AI code. Ensures compliance with CODING.md, SECURITY.md, TESTING.md, OWASP 2025, and OWASP Agentic Top 10 2026. Use when writing code, creating endpoints, writing tests, working with databases, building AI agents, or integrating MCP servers.
user-invocable: false
---

# Standards Enforcer

Applique automatiquement les règles définies dans `~/Documents/my-standards/rules/`.

## Avant d'écrire du code

- **B1** : Lire le modèle DB avant d'accéder aux champs
- **B2** : Vérifier la signature de service avant d'appeler

→ Détails : `~/Documents/my-standards/rules/CODING.md`

## Sécurité Web (S1-S19)

Règles critiques à vérifier systématiquement :
- **S1** : `hmac.compare_digest()` pour comparer les secrets
- **S2** : Jamais `detail=str(e)` — messages d'erreur génériques
- **S4** : SQL paramétré uniquement — jamais de f-string
- **S5** : Rate limiting sur les endpoints auth/publics
- **S10** : CORS restrictif — jamais `allow_origins=["*"]` avec credentials
- **S12** : Input validation Pydantic strict sur tous les endpoints
- **S13** : Passwords hashés avec bcrypt/Argon2
- **S15** : Jamais `pickle.loads()`, `eval()`, `yaml.load()` sur des données non fiables
- **S18-S19** : Next.js — pas de secrets dans les Client Components, middleware non fiable pour l'auth

→ Détails complets S1-S19 : `~/Documents/my-standards/rules/SECURITY.md`

## Sécurité Agentic AI & MCP (AG1-AG10)

Règles critiques pour le code impliquant des agents IA ou MCP :
- **AG1** : Outputs d'agents = non fiables, valider avant d'exécuter
- **AG2** : Moindre privilège sur les outils, jamais `allowed-tools: *`
- **AG3** : Pas de credentials partagés entre agents, token pass-through interdit
- **AG4** : Vérifier les MCP servers (tool poisoning), SAST + SCA obligatoires
- **AG5** : Jamais `eval()`/`exec()` sur du contenu LLM, sandbox obligatoire
- **AG7** : Détection prompt injection sur inputs ET données externes
- **AG8** : MCP auth via OAuth 2.1, jamais de session IDs
- **AG10** : Logger toutes les actions d'agents (OpenTelemetry)

→ Détails complets AG1-AG10 : `~/Documents/my-standards/rules/SECURITY.md`

## Sérialisation

| Type | Conversion obligatoire |
|------|----------------------|
| `Decimal` | `float(value)` |
| `UUID` | `str(value)` |
| `datetime` | `.isoformat()` |

## SQL & DB

- Requêtes paramétrées, types stricts, pas de dialecte-spécifique
- Async : `expire_on_commit=False`, `pool_pre_ping=True`

→ Détails : `~/Documents/my-standards/rules/CODING.md`

## Tests

- **T1** : PostgreSQL réelle (testcontainers), jamais SQLite
- **T4** : Un test d'intégration par code path DB
- Patching au module source, `npm audit` / `pip audit` en CI

→ Détails : `~/Documents/my-standards/rules/TESTING.md`

## Langue

- Interface utilisateur : **français**
- Code, logs, documentation technique : **anglais**
