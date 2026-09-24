# Close-out: making this repository safe and usable

Review date: 2026-09-24. Scope: every file on every branch and the full git history (one
commit, `7a80824`).

## Pull requests (none merged; the owner decides)

| # | What | Merge order |
|---|---|---|
| [#1](https://github.com/ai-for-marketing/afm-agentic-os-starter/pull/1) | Safety: remove personal and internal details from current files | First |
| [#2](https://github.com/ai-for-marketing/afm-agentic-os-starter/pull/2) | Usability: README from a blank machine; installer fixed and tested | After #1 (it is built on #1) |
| [#3](https://github.com/ai-for-marketing/afm-agentic-os-starter/pull/3) | Licence, .gitignore, shellcheck on every PR, this file | Any time |

## 1. Safety: what was found

**No credentials anywhere.** No passwords, API keys, tokens, private keys, IP addresses,
internal hostnames or email addresses appear in any file, current or historical. Checks run:
pattern search for addresses, hostnames, paths, key and token formats and private-key blocks;
a search for long random-looking strings. GitHub's own secret scanner could not run because
GitHub Advanced Security is not enabled on this repository. **Nothing needs rotating.**

Found and removed from the current files (PR #1):

| File | Kind of data | Action |
|---|---|---|
| `README.md` (3×), `install.sh` (1×) | A person's first name (personal data) | Replaced with "the author" / "AI for Marketing" / "see README.md" |
| `README.md` | A section addressed to people the owner contacted directly | Removed |
| `AFM-BUILD-OS.md` | Server filesystem path (reveals the admin account and an internal folder) | Removed; now says those prompts are not included |
| `AFM-BUILD-OS.md` | Internal project/product names with business notes | Replaced with a generic table |
| `AFM-BUILD-OS.md` | Reference to the internal "vault" as where the method lives | Made generic |
| `master-goal-prompt.txt` | Name of an internal infrastructure tool | Replaced with generic examples |

Kept on purpose: "GridOS" and "the vault" as feature names in the README's description of
the paid product. That is marketing, not a leak.

**Still in public history (owner's decision; not rewritten).** Only the kind of data is
listed here, never the value:

| Commit | Path | Kind of data |
|---|---|---|
| `7a80824` | author/committer metadata | Account name and a machine-local email address |
| `7a80824` | commit message | Internal work-plan task code and goal name |
| `7a80824` | `README.md` | Person's first name (3×); direct-contact section |
| `7a80824` | `install.sh` | Person's first name (1×) |
| `7a80824` | `AFM-BUILD-OS.md` | Server folder path; internal project names with business notes |
| `7a80824` | `master-goal-prompt.txt` | Internal infrastructure tool name |

None of these is a secret. To remove them from history as well, rewrite with
`git filter-repo` and force-push. That breaks existing clones and forks, and copies already
downloaded stay out there.

## 2. Usability: what broke and what was fixed (PR #2)

Found by actually running `install.sh` in a clean Ubuntu 24.04 container:

| Problem | Fix |
|---|---|
| `sh install.sh` failed on Ubuntu (`Illegal option -o pipefail`) | Script re-runs itself under bash |
| Script failed when run on its own or piped from `curl` | Downloads the files from GitHub (curl or wget) when they are not next to it |
| Clean Ubuntu has no git/curl/wget; the README never said how to get the files | README walks through git, ZIP and one-line install, including installing git |
| README didn't say an AI coding tool is required | Links to the official Claude Code, Codex and Gemini CLI setup pages |
| Re-running overwrote user edits silently | Keeps a `.bak` of edited files |

Tested: clean Ubuntu (apt → clone → install, with `bash` and with `sh`), a folder path containing
spaces, re-runs, the one-line download, missing curl/wget, bash 3.2 (the version macOS
ships), and shellcheck. **Not tested on a real Mac.** None was available. The first person
to run it on one should confirm.

## 3. Housekeeping (PR #3)

- `LICENSE`: MIT, © 2026 AI for Marketing. There was no licence before, so legally nobody
  could reuse the code. The owner may pick a different licence before merging.
- `.gitignore`: blocks `.env`, keys, credential files, OS/editor clutter and installer
  backups.
- `.github/workflows/shellcheck.yml`: runs shellcheck on every `*.sh` file and every file
  with a shell shebang, on every pull request (and on pushes to `master`). Verified that it
  passes on the real script and fails on a deliberately broken one (tested locally).
  **On GitHub it currently shows a red ❌ without running.** GitHub reports "The job was not
  started because your account is locked due to a billing issue." It was re-run once and got
  the same result. Once billing is sorted under the organisation's Settings → Billing, re-run
  it from the PR's Checks tab.

## Open decisions for the owner

1. Whether to rewrite public history to remove the items in the history table above.
2. Whether MIT is the right licence.
3. Fix the GitHub billing lock so automatic checks (GitHub Actions) can run at all.
4. Whether to turn on GitHub secret scanning (free for public repositories under
   Settings → Code security) so future leaks are caught automatically.
