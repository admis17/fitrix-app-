# Fitrix App — PROJECT_PROCESS.md

> Generated: 2026-08-31 | Repo: https://github.com/admis17/fitrix-app- | Commit: 4e071ee
> Primary owner: admis17 <admis17@users.noreply.github.com> | Collaborator: vedantduilkar <vedantdugilkar@gmail.com>

## Project Goal
Replicate Fitomatic portal UI in HTML — gym owner can manage gym from one portal:
Dashboard, Members, Enquiries/Leads, Attendance, Fees & Payments, Workout Plans, Diet Plans, Staff/Trainers, Inventory, Reports, Settings + Login/OTP screen.

## Current State (2026-08-31)
- `main` branch: `index.html` (277 lines, ~21KB, commit `4e071ee` by `admis17`) + empty commit `924489f` by `vedantduilkar` (2026-08-31)
- Login overlay: `login()` hides `#loginPage` shows `#app` (vanilla JS, `data-page` routing, no router)
- 11 pages as sections with `.page.active` toggling, sidebar dark `#0f172a` / accent `#ef4444`
- Static frontend only, mocked table data, no backend, no dependencies
- Served via `python -m http.server 8000` at http://127.0.0.1:8000 — open `index.html` directly also works
- Local path: `C:\Users\vedan\source\repos\fitrix-app-` (remote `fitrix-app-` with trailing `-`)

## Architecture Rules
- Keep single-file until backend needed (fewest files, shortest diff)
- Vanilla CSS (no Tailwind/CDN), vanilla JS — no frameworks unless team agrees
- Mobile responsive: sidebar collapses to hamburger <900px, stats grid 4→2→1
- Colors: sidebar `#0f172a`, accent `#ef4444`, bg `#f1f5f9`, card border `#e2e8f0`, ok `#dcfce7`, due `#fee2e2`

## Architecture
- Single file: `index.html` — `<style>` block (lines 7-73), `<body>` login + app shell, 11x `.page` sections, inline `<script>` routing (lines 240-275)
- Routing: `titles{}` map + `.menu a[data-page]` click handler toggles `.active` on menu and pages, updates `#pageTitle`/`#pageSub`
- No build, no npm, just Chrome

## Dev Setup
```bash
git clone https://github.com/admis17/fitrix-app-.git fitrix-app
cd fitrix-app
git config user.name "YOUR_NAME"
git config user.email "YOUR_EMAIL"
python -m http.server 8000  # or: start index.html (Windows) / open index.html (Mac)
# login: admin@fitomatic.com / 123456
```

## Git Conventions
- `main` protected (direct push allowed for now)
- Commits: `feat: ...`, `fix: ...`, `chore: ...`
- Before push: `git status`, `git log --oneline -3`
- Remote: `origin https://github.com/admis17/fitrix-app-.git` (https, gh auth via `vedantdugilkar`)

## Current Task
- Team memory restored; localhost running at http://127.0.0.1:8000

## Completed
- [2026-08-31] Init repo `fitrix-app-` with `index.html` 11-page replica (`4e071ee`)
- [2026-08-31] Auth: `vedantduilkar` added as collaborator, gh CLI login (`gho_***`), git config `vedantduilkar <vedantdugilkar@gmail.com>`
- [2026-08-31] Empty commit `924489f feat: initial empty commit` (allow-empty) rebased and pushed `4e071ee..924489f`
- [2026-08-31] Local server verified `200 OK` on port 8000, PROJECT_PROCESS.md created

## In Progress
- None

## Next Steps
- Decide next feature (member Add/Edit modal, real attendance marking, fee collection flow, OTP auth, localStorage CRUD)
- Wire static tables to JS data (API or localStorage) for real CRUD
- Resolve `fitrix-app` vs `fitrix-app-` naming (keep remote as-is for now)

## Files
- `index.html` (277 lines) — main portal (login + 11 pages)
- `PROJECT_PROCESS.md` — this file (memory protocol)
- Backup: `C:\Users\Adarsh\fitomatic-portal.html` (per prompt)

## Known Issues
- Data is static — no persistence
- Naming mismatch: remote `fitrix-app-` vs local `fitrix-app`
- No modals/forms — `+ Add` buttons are inert
- No real auth — `login()` just toggles display, OTP links are placeholders

## Decisions
- 2026-08-31: Keep vanilla single-file until backend required (team rule)
- 2026-08-31: Use `python -m http.server` for local dev (no npm)
- 2026-08-31: Allow empty commits for sync (`--allow-empty`)

## How to Restore Memory
Copy/paste the Fitrix App Team Memory Prompt (PROMPT START → PROMPT END) as first message to any AI. This file is the canonical memory; update after each milestone.
