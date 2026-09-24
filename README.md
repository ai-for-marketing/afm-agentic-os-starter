# AFM Agentic OS — Starter (v0.1)

The minimal, portable taste of the **AFM Agentic OS**: a written method, plus one
self-looping "commander" prompt. You give the prompt to an AI coding tool inside your
project, and it keeps working toward the project's goal, checking its own results, until
the job is verifiably done.

This is a **starter, not the working harness.** It gives you the *recipe*, not the *kitchen*.
The full OS (272 skills, 6 conduct loops, watchdog, the vault, GridOS) is the integrated
product. See the bottom of this file.

---

## What you get

| File | What it is |
|------|------------|
| `AFM-BUILD-OS.md` | The method: North Star → Blueprint → Build → QA → **Value → UX** → Harden. It explains why projects stall at 90% and how an up-front blueprint plus an "owner-gate manifest" (every key and permission the AI will need, collected in one go) fixes that. Plain reading, no setup. |
| `master-goal-prompt.txt` | The self-looping `/goal` prompt. Paste it into Claude Code, Codex or Gemini CLI inside your project. |
| `install.sh` | Copies the two files above (and this README) into `~/afm-agentic-os/` and prints the next step. It needs no admin rights and doesn't change any other settings. |

## Requirements

- **macOS** or **Linux** (tested on Ubuntu 24.04 and on bash 3.2, the version macOS ships).
  On Windows, use WSL (Ubuntu).
- A terminal. On a Mac: press Cmd+Space, type *Terminal* and press Enter.
- An **AI coding tool** that runs in the terminal (step 3 below).

You don't need an account with us or access to any of our servers.

---

## Install, from a blank machine

### 1. Get the files

**Option A: with git (recommended).**

Ubuntu/Debian (a clean install has no git):

```bash
sudo apt-get update && sudo apt-get install -y git
```

macOS: git comes with Apple's command-line tools. The first time you type `git`, macOS
offers to install them. Click **Install** and wait for it to finish.

Then, on either system:

```bash
git clone https://github.com/ai-for-marketing/afm-agentic-os-starter.git
cd afm-agentic-os-starter
```

**Option B: without git.** On the GitHub page click **Code → Download ZIP**, unzip it, then
in the terminal `cd` into the unzipped folder (for example
`cd ~/Downloads/afm-agentic-os-starter-master`).

**Option C: one line.** This needs `curl`, which macOS has built in. On Ubuntu:
`sudo apt-get install -y curl`.

```bash
curl -fsSL https://raw.githubusercontent.com/ai-for-marketing/afm-agentic-os-starter/master/install.sh | bash
```

Option C downloads the files for you and installs them, so you can skip step 2.

### 2. Run the installer

```bash
bash install.sh
```

You should see `AFM Agentic OS starter installed -> /home/you/afm-agentic-os` (on a Mac,
`/Users/you/afm-agentic-os`) followed by the next steps.

Options:

- `bash install.sh --dir ~/somewhere/else` installs to a different folder.
  Setting `AFM_STARTER_DIR=~/somewhere/else` does the same.
- Running it again is safe. If you edited an installed file, your version is kept as
  `<file>.bak`.
- `bash install.sh --help` shows all options.

### 3. Install an AI coding tool (if you don't have one)

Any one of these works. Follow the official instructions, which also cover signing in:

- **Claude Code**: <https://code.claude.com/docs/en/setup>
- **OpenAI Codex CLI**: <https://github.com/openai/codex>
- **Gemini CLI**: <https://github.com/google-gemini/gemini-cli>

### 4. Run the commander loop in your project

1. Open `~/afm-agentic-os/master-goal-prompt.txt` in any text editor and copy the whole file
   (it starts with `/goal`).
2. In the terminal, go to the project you want to build (`cd ~/path/to/your-project`)
   and start your AI tool there (`claude`, `codex` or `gemini`).
3. Paste the prompt and press Enter.

The loop reads your project first (its README, `CLAUDE.md`/`AGENTS.md`, a `NORTH-STAR` file
if you have one) to work out what "done" means. Then it audits, plans, builds, verifies and
repeats until it reaches one of its end states. If your project doesn't say what it's
for, the loop asks you one question. Writing a short `NORTH-STAR.md` (what the product must
do for its user, in a few lines) before you start gives much better results.

Read `AFM-BUILD-OS.md` to understand the method the loop follows.

### Uninstall

```bash
rm -rf ~/afm-agentic-os
```

---

## Troubleshooting

| Problem | Fix |
|---|---|
| `ERROR: need curl or wget` | Ubuntu: `sudo apt-get install -y curl`, or use Option A/B. |
| `git: command not found` (Ubuntu) | `sudo apt-get install -y git` |
| `Permission denied` running `./install.sh` | Run it as `bash install.sh` instead. |
| `could not download ...` | Check your internet connection, or use Option A/B. |

## What this is NOT (honest scope)

- **Not the working harness.** There's no skills pack, conduct loops, watchdog, vault or
  GridOS. Those make up the integrated system the author runs in production across 6 live
  projects.
- **Not a wizard.** It won't auto-discover your stack or seed your memory. You read the
  method, run the /goal, and the loop does the rest inside *your* environment.
- **v0.1.** The method and loop are battle-tested (6 projects, 89+ conduct commits). The
  *packaging* of this starter is new.

## The full AFM Agentic OS

The starter gives you the *method*. The *machine* is the integrated harness that runs the
method unattended across many projects, with Telegram-to-session wiring, a real-time fleet
dashboard, cross-project dreaming and a skill ROI ledger. AI for Marketing operates it. For
access (consulting, retained or hosted), open an issue on this repository.

## Licence

MIT. See `LICENSE`.
