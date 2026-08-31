# Fitrix App — Team Memory Prompt

Copy/paste this entire prompt into your AI (OpenCode / Cursor / Claude / ChatGPT) on your machine to restore project memory.

---

## PROMPT START

You are working on **Fitrix App** — a Fitomatic clone (PayPer Software gym management portal).

**Repo:** `https://github.com/admis17/fitrix-app-` (note trailing `-`, folder locally is `fitrix-app`)
**Live file:** `index.html` (single-file vanilla HTML/CSS/JS, no framework, no build step)
**Primary owner:** `admis17` <admis17@users.noreply.github.com>

### Project Goal
Replicate Fitomatic portal UI in HTML — gym owner can manage gym from one portal:
Dashboard, Members, Enquiries/Leads, Attendance, Fees & Payments, Workout Plans, Diet Plans, Staff/Trainers, Inventory, Reports, Settings + Login/OTP screen.

### Current State (2026-08-31)
- `main` branch has single `index.html` (277 lines, ~21KB) — commit `4e071ee` by `admis17`
- Login page overlays app; `login()` hides `#loginPage` and shows `#app` (vanilla JS routing via `data-page` attributes, no router)
- All 11 pages are sections with `.page.active` toggling, sidebar is dark `#0f172a` with red `#ef4444` accent (Fitomatic branding)
- No backend yet — static frontend only, data is mocked in tables
- No dependencies, no npm, just open `index.html` in Chrome

### Architecture Rules
- Keep it single-file until backend needed (ponytail: fewest files, shortest diff)
- Vanilla CSS (no Tailwind/CDN), vanilla JS — no frameworks unless team agrees
- Mobile responsive: sidebar collapses to hamburger <900px, stats grid 4→2→1
- Colors: sidebar `#0f172a`, accent `#ef4444`, bg `#f1f5f9`, card border `#e2e8f0`

### Dev Setup (run on your machine)
```bash
git clone https://github.com/admis17/fitrix-app-.git fitrix-app
cd fitrix-app
git config user.name "YOUR_NAME"
git config user.email "YOUR_EMAIL"
# open
start index.html  # Windows
# or
open index.html   # Mac
```

### Git Conventions
- `main` is protected, direct push allowed for now
- Commit style: `feat: ...`, `fix: ...`, `chore: ...`
- Before push: `git status`, `git log --oneline -3`

### Known Issues / Next Steps
- Data is static — need to wire to API/localStorage for real CRUD
- `fitrix-app` vs `fitrix-app-` naming mismatch — remote is `fitrix-app-`, local folder is `fitrix-app` (keep as is)
- Need: member Add/Edit modal, real attendance marking, fee collection flow, auth with OTP
- File also exists at `C:\Users\Adarsh\fitomatic-portal.html` (backup)

### Memory Protocol (AGENTS.md)
If your AI supports memory/PROJECT_PROCESS.md, create `PROJECT_PROCESS.md` from this prompt and update it after every milestone: Current Task, Completed, In Progress, Next Steps, Architecture, Decisions, Files, Known Issues.

## PROMPT END

---

### How to use (for team)
1. Copy everything between PROMPT START and PROMPT END
2. Paste as first message to your AI
3. AI will have full context — then tell it what to build next

Generated: 2026-08-31 | Repo: admis17/fitrix-app- | Commit: 4e071ee
