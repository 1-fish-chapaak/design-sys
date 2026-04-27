# Next.js 16 gotchas — auditify-fe

Source: `auditify-fe/AGENTS.md`. Next 16 has breaking changes from typical training data. **Read `node_modules/next/dist/docs/` for the area you're touching before writing code.**

## Hard rules (refuse to violate)

- **Build tool: Next.js.** Never propose Vite / CRA migration.
- **Styling: Tailwind 4 only.** No Chakra, no MUI, no styled-components. Class-based composition.
- **State: hooks + RSC.** No Redux / Zustand without globally-agreed team decision.
- **App router** in `src/app/`. Layouts via `layout.tsx`. Don't use pages-router.
- **API base: `/api`** (proxied through nginx → backend:8000). Use relative URLs from FE — `fetch('/api/...')`. Never `fetch('http://localhost:8000/...')`.

## Source layout (don't reshape)

- `src/app/` — pages + layouts + providers (server-component-first)
- `src/components/<domain>/` — by domain: `workflow/`, `governance/`, `execution/`, `data-sources/`, `recents/`
- `src/hooks/` — custom hooks (e.g. `useAppState`)
- `src/data/` — mock data (replace with real API calls as backend lands)
- `src/assets/` — static assets

## Quality gates

- `npm run lint` — eslint
- `npm run typecheck` — `tsc --noEmit`
- `npm run format` — prettier
- `npm run review:local` — AI-driven preflight reviewer (`tools/preflight-review.sh`)
- Pre-commit hooks via `tools/setup-hooks.js` (postinstall)

## Things to verify against `node_modules/next/dist/docs/` before coding

- Server Actions signature and where they can be defined
- Caching directives (`'use cache'`, `revalidatePath`, etc.) — defaults differ from earlier versions
- Layout / template / loading / error file conventions
- RSC ↔ client boundaries — `'use client'` placement
- Image / fonts / metadata APIs
- Route handlers vs Server Actions — when to use which

When in doubt: read the docs, then code. Don't guess from training data.
