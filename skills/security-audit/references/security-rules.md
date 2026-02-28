# Règles de Sécurité — Référence

> Source de vérité : `~/Documents/my-standards/rules/SECURITY.md`
>
> Ce fichier est un raccourci. En cas de doute, toujours consulter la source.

## Règles couvertes

### Web / API (S1-S19)
- S1 : Timing-safe secret comparison
- S2 : Generic error messages
- S3 : Security headers
- S4 : Parameterized SQL
- S5 : Rate limiting
- S6 : MIME validation by magic bytes
- S7 : Fail-closed in production
- S8 : No secrets in git
- S9 : Audit trail on downloads
- S10 : Restrictive CORS
- S11 : CSRF protection
- S12 : Pydantic input validation
- S13 : bcrypt/Argon2 password hashing
- S14 : Dependency audit (supply chain)
- S15 : No unsafe deserialization
- S16 : Content-Security-Policy
- S17 : Extended error handling (OWASP A10:2025)
- S18 : Next.js Server Components security
- S19 : Next.js middleware auth bypass

### Agentic AI / MCP (AG1-AG10)
- AG1 : Agent goal hijack prevention
- AG2 : Least privilege on tools
- AG3 : No shared credentials between agents
- AG4 : MCP supply chain verification
- AG5 : Code execution sandboxing
- AG6 : Memory & context poisoning protection
- AG7 : Prompt injection detection
- AG8 : MCP OAuth 2.1 authentication
- AG9 : MCP server isolation
- AG10 : Agent audit trail

Pour le détail de chaque règle avec exemples de code, consulter :
`~/Documents/my-standards/rules/SECURITY.md`
