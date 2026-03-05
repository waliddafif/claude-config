---
description: Security rules for web/API and agentic AI code
globs: ["**/*.py", "**/*.ts", "**/*.tsx", "**/*.js", "**/*.jsx"]
---

# Security Rules

Full reference: `~/Documents/my-standards/rules/SECURITY.md`

## Web/API (S1-S19)

- `hmac.compare_digest()` pour comparer les secrets
- Jamais `detail=str(e)` — messages d'erreur generiques
- SQL parametre uniquement, jamais de f-string
- Rate limiting sur tout endpoint public/auth sensible
- Validation MIME par magic bytes
- Fail-closed en production
- Secrets jamais dans git, `echo -n` pour GCP
- CORS restrictif, CSRF protection, input validation Pydantic strict
- Passwords : bcrypt/Argon2, jamais MD5/SHA
- Next.js : pas de secrets dans les Client Components, re-verifier l'auth hors middleware

## Agentic AI/MCP (AG1-AG10)

- Outputs d'agents = non fiables, valider avant d'executer
- Moindre privilege sur les outils
- Pas de credentials partages entre agents, token pass-through interdit
- Verifier les MCP servers (tool poisoning)
- Jamais `eval()` ou `exec()` sur du contenu LLM
- Detection prompt injection, MCP auth via OAuth 2.1
- Logger toutes les actions d'agents
