---
name: project-init
description: Initialise un nouveau projet à partir des templates standards (nextjs, nextjs-saas, python-fastapi, bun-saas-ai). Use when user says "nouveau projet", "init project", "créer un projet", "bootstrap", "scaffolder".
disable-model-invocation: true
argument-hint: [template] [project-name]
---

# Project Init

Initialise un nouveau projet à partir des templates dans `~/Documents/my-standards/template/`.

## Templates disponibles

| Template | Stack |
|----------|-------|
| `nextjs` | Next.js, TypeScript, Tailwind |
| `nextjs-saas` | Next.js, TypeScript, Tailwind, Auth (Supabase/Firebase), shadcn/ui |
| `python-fastapi` | Python 3.12, FastAPI, SQLAlchemy async, PostgreSQL |
| `bun-saas-ai` | Bun, Elysia, React 19, Tailwind v4, shadcn/ui, assistant-ui, Vercel AI SDK, Better Auth, Drizzle, pgvector |

## Instructions

### Step 1 : Identifier le template et le nom

- Template : `$0` (si absent, demander à l'utilisateur de choisir parmi les templates disponibles)
- Nom du projet : `$1` (si absent, demander à l'utilisateur)
- Répertoire cible : `./$1` (dans le répertoire courant)

### Step 2 : Challenger le template (best practices)

Avant de copier, utiliser WebSearch pour vérifier les dernières best practices de la stack choisie :

**Si nextjs ou nextjs-saas :**
- Rechercher la dernière version stable de Next.js et ses breaking changes
- Vérifier les recommandations actuelles : App Router vs Pages, Turbopack, server components
- Vérifier la version de Tailwind CSS (v3 vs v4) et ses changements
- Vérifier les versions de shadcn/ui, React, TypeScript

**Si python-fastapi :**
- Rechercher la dernière version stable de FastAPI et ses nouveautés
- Vérifier les versions de SQLAlchemy, Pydantic (v1 vs v2), uvicorn
- Vérifier les recommandations actuelles pour la structure de projet

**Si bun-saas-ai :**
- Rechercher les dernières versions de : Elysia, Better Auth, Drizzle ORM, Vercel AI SDK (`ai`), `@ai-sdk/openai`, `@ai-sdk/anthropic`
- Vérifier les versions de : Tailwind CSS v4, shadcn/ui, assistant-ui, React, Vite
- Vérifier les breaking changes de Better Auth (1.x → 2.x?) et AI SDK (v6 → v7?)
- Vérifier les recommandations Bun runtime (version minimum, bugs connus)

**Pour tous les templates :**
- Comparer les versions du template local avec les dernières versions stables
- Identifier les dépendances obsolètes ou dépréciées
- Identifier les nouvelles best practices qui ne sont pas dans le template

Présenter un résumé à l'utilisateur :
```
🔍 Analyse du template $0 :

Dépendances à mettre à jour :
  - next: 14.x → 15.x (breaking changes: ...)
  - tailwindcss: 3.x → 4.x (migration nécessaire)

Nouvelles best practices :
  - Turbopack recommandé pour le dev server
  - ...

Aucun problème détecté :
  - TypeScript: 5.x ✅
  - ...
```

Demander confirmation avant de continuer. Si l'utilisateur valide les mises à jour, les appliquer dans les fichiers du template après la copie (Step 3).

### Step 3 : Créer le projet

1. Vérifier que le répertoire `$1` n'existe pas déjà
2. Créer le répertoire `$1`
3. **Si `bun-saas-ai`** : Cloner le repo GitHub et nettoyer le git :
   ```bash
   git clone https://github.com/waliddafif/saas-ai-template.git ./$1
   rm -rf ./$1/.git
   ```
   Puis renommer les références dans les `package.json` :
   - `saas-ai-template` → `$1`
   - `@saas-ai-template/*` → `@$1/*`
   - Mettre à jour le titre dans `index.html`, `AppLayout.tsx`, `README.md`

   **Sinon (autres templates)** : Copier depuis les templates locaux :
   - `cp -r ~/Documents/my-standards/template/$0/* ./$1/`
4. Copier les fichiers communs (sauf pour `bun-saas-ai` qui les inclut déjà) :
   - `cp -r ~/Documents/my-standards/template/.github ./$1/`
   - `cp ~/Documents/my-standards/template/.gitignore ./$1/`
   - `cp ~/Documents/my-standards/template/CLAUDE.md ./$1/CLAUDE.md`
   - `cp ~/Documents/my-standards/template/.cursorrules ./$1/` (si existe)

### Step 4 : Personnaliser CLAUDE.md

Dans `./$1/CLAUDE.md`, remplacer `[Nom du Projet]` par le nom du projet `$1`.

### Step 5 : Appliquer les mises à jour validées

Si l'utilisateur a validé des mises à jour au Step 2 :

**package.json (nextjs/nextjs-saas) :**
- Mettre à jour les versions des dépendances validées
- `npm install` pour recréer le lock file

**pyproject.toml (python-fastapi) :**
- Mettre à jour les versions des dépendances validées
- Réinstaller avec les nouvelles versions

**Fichiers de config :**
- Adapter `next.config.mjs`, `tailwind.config.ts`, etc. si les nouvelles versions l'exigent
- Appliquer les migrations nécessaires (ex: Tailwind v3 → v4)

### Step 6 : Initialiser git

```bash
cd ./$1
git init
git add .
git commit -m "chore: init project from $0 template"
```

### Step 7 : Installer les dépendances

**Si python-fastapi :**
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -e ".[dev]"
```

**Si nextjs ou nextjs-saas :**
```bash
npm install
```

**Si bun-saas-ai :**
```bash
bun install
```
Puis rappeler à l'utilisateur :
- Copier `.env.example` → `.env` et remplir `DATABASE_URL`, `BETTER_AUTH_SECRET`, `OPENAI_API_KEY`
- Créer la DB PostgreSQL et lancer `bun run db:generate && bun run db:migrate`
- Lancer avec `bun run dev:api`, `bun run dev:web`, `bun run dev:worker`

### Step 8 : Résumé

Afficher un résumé en français :
- Template utilisé
- Répertoire créé
- Fichiers copiés
- Dépendances installées
- Prochaines étapes recommandées (`cd $1`, lancer le dev server, etc.)
