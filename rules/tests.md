---
description: Testing rules and CI best practices
globs: ["**/*test*", "**/*spec*", "**/conftest.py", "**/pytest.ini", "**/jest.config.*", "**/vitest.config.*"]
---

# Test Rules

Full reference: `~/Documents/my-standards/rules/TESTING.md`

- PostgreSQL via Docker (testcontainers) si prod = PostgreSQL
- `npm run build` obligatoire en CI (le mode dev cache les erreurs)
- Git hooks : pre-commit (lint/format), pre-push (tests)
- Un test d'integration par code path DB (pas uniquement des mocks)
