# AFM Build Operating System -- How We Build (v1.0, 2026-06-14)

Canonical methodology for taking any AFM product from vision to a shipped, valuable, hardened reality. Every project (new or existing) follows this. Project `CLAUDE.md`/`AGENTS.md` should point here.

## The revelation (why everything sat at 90%)

The products were never blocked by AI capability. They were blocked by **missing structure**: a vision was handed to a vague auto-loop ("make the North Star real") with no blueprint underneath it, so agents built on an unspecified foundation, invented scope (buttons that do nothing), and stalled every time they needed a key or a SQL run -- making the owner a manual robot. The fix is not more building. It is a **blueprint and an owner-gate manifest defined up front**, so the auto-loop runs end-to-end without the human as the bottleneck.

## Core principles

- **The value chain is a weakest-link chain:** interface → input → output → outcome. Output can't beat input; input can't beat what the interface elicits; the interface can't elicit what the blueprint never specified. **The blueprint is the headwaters.** A vague blueprint silently poisons everything downstream.
- **The output is the moat,** not the interface. Anyone can clone software; nobody clones output that's genuinely top-1%. The interface's only job in the AI era is *high-fidelity input capture*.
- **The blueprint is an enforced contract.** Build, test, and change ONLY what's in it. Need something new? Add it to the blueprint and flag it -- **never silently add a button.**
- **Thin, living spine -- not a 2005 monument.** Spec enough to build one real vertical slice, ship, learn, let the blueprint grow. A perfect plan for the wrong thing is the most expensive object in software.
- **Judgment doesn't parallelize.** Execution loops scale to many; the human's deep-judgment gates (vision, blueprint-review, first-user-test) are serial and expensive. A shallow gate launders a bad plan with the owner's authority -- fake-green at the human layer.
- **The human is highest-leverage at the start and the end:** crystallise the North Star (step 1), interrogate the blueprint (step 3), test as first user (step 8). Everything between is agent work.

## The lifecycle

**Human gate** → STAGE 0 **NORTH STAR** (human crystallises the vision + the one-line guarantee a user would pay for).

STAGE 0.5 **BLUEPRINT** (greenfield or brownfield -- see below). Produces the contract + the access manifest.
→ **Human gate:** interrogate the blueprint, resolve the ambiguity queue, provision the owner-gate manifest in one sitting.

Then the loops (each a self-localising, anti-fake-green `/goal`, each terminating on a binary state):
1. **BUILD** → `CLOSED` -- `/auto-loop` spine; makes the blueprint a runtime-verified reality.
2. **QA-PROVE** → `GREEN_100` -- exhaustive test ledger + browser proof; includes the CORE-OUTCOME PROOF row (the core value event must produce a stored, rubric-passing output).
3. **UX/UI** → `TOP1_UX` -- perfects the input-gathering surface. Universal simplicity; input→output→outcome / voice / multi-channel only if the North Star calls for it.
4. **VALUE** → `VALUE_TOP1` (standing) -- makes the OUTPUT top-1%: derive guarantees → per-output rubric + anti-AI-slop gate → score real outputs → trace fault to INPUT-gathering vs WORKFLOW → fix that layer → loop.
5. **HARDEN + OBSERVE** → `OBSERVED_GREEN` (standing) -- survive 1→10k: RLS/CAPTCHA/rate-limit/pool/cost-cap + Sentry/uptime/canary alerting in plain English to Telegram + load test + feedback-to-fix (detect → root-cause → fix-plan → Telegram [Approve]/[Reject] → fix/deploy/test/close).

→ **Human gate:** sign up and use it as the first real user.

**OUTCOME-MONITORING** (engagement/revenue) sits deliberately OUTSIDE all loops -- pure data-engineering (an `outcome_events` table + poller → a Grid pane). VALUE scores the output *before* it ships; outcome watches its *shadow* after.

Run order: BUILD → QA → UX in sequence to ship a verified, well-fronted product; VALUE + HARDEN run as standing parallel loops every cycle/deploy.

## The Blueprint (Stage 0.5) -- the keystone artifact

Lives **in each project repo** (`BLUEPRINT.md` + a traceability matrix / CSV), versioned, living. This methodology lives in one shared place; each repo holds its own blueprint. Two modes:

- **GREENFIELD** (new project): North Star → research market/audience/competitors/required surfaces → draft the blueprint.
- **BROWNFIELD** (existing project): North Star + the **actual code and database, read fresh** (never the building-chat's memory -- that agent rationalises its own mess; use a fresh adversarial read) → reverse-engineer what exists → structure it → produce the gap-plan. **Do not rebuild; fix forward.**

Every blueprint produces FOUR outputs, not one:
1. **The traceability matrix** -- one row per surface (page / feature / button / function), two layers: VISIBLE (what the user sees/does) and INVISIBLE (data model, states [empty/loading/error/offline], permissions, edge cases). Each row carries a binary acceptance test. Three keep/kill columns: *serves a North-Star promise* (keep) / *serves nothing* (**kill -- remove the noise**) / *promised but missing* (build).
2. **The ambiguity & decision queue** -- everything the blueprint can't resolve without the owner. The human gate is "resolve these N decisions," not "approve the plan" -- because omissions are invisible to a reader and this surfaces them.
3. **The North-Star gap list** -- ambiguities the blueprint exposes in the North Star itself (e.g. "is the guarantee a *publishable* post or a post that *gets engagement*?"), fed back to sharpen the vision.
4. **The OWNER-GATE ACCESS MANIFEST** -- see below.

## The Owner-Gate Access Manifest (removes the human-as-robot bottleneck)

The reason auto-loops stall is missing standing access. The blueprint front-loads **every key, token, ID, OAuth connection, migration, and dashboard toggle the loop will need**, gathered in ONE batch up front with clickable steps, so the owner provisions everything in one sitting and the loop then runs uninterrupted. Where possible the goal is **standing execution access** (e.g. a service-role DB connection so the agent runs its own migrations and never hands the owner SQL). Tradeoff: powerful keys in agent hands is exactly why HARDEN exists -- provision broadly, then harden. Anything unknowable until build is batched and surfaced as a single owner-gate, never dripped one at a time.

## Choosing the outcome per project

Not every project is a money-maker. Pick the outcome the North Star actually promises:

| Project shape | Outcome to measure |
|---|---|
| Paid product for individuals or businesses | Engagement / measurable results for the user |
| Services (consulting, development) | Client results; not yet a productised input→output SaaS |
| Free / mission-driven | Reach and impact, NOT revenue -- do not force a revenue lens |
| Internal tooling | Operator efficiency ("user" = the operator/fleet) |

The 5-loop system fits productised projects cleanly; free projects get a reach outcome; internal tools get an operator-efficiency outcome.

## Goal-prompt index (the executable loops)

The full system has one goal prompt per loop (not included in this starter, which ships only the commander prompt `master-goal-prompt.txt`): `master-blueprint-goal.txt` (GOAL 0 BLUEPRINT, greenfield + brownfield in one self-detecting prompt) · `master-build-goal-v2.txt` (BUILD) · `master-qa-proof-goal-v2.txt` (QA-PROVE) · `master-uxui-goal.txt` (UX) · `master-value-goal.txt` (VALUE) · `master-harden-observe-goal.txt` (HARDEN+OBSERVE). All six authored, em-dash-clean, under 4000 chars. Run order: BLUEPRINT (+ human sign-off) -> BUILD -> QA -> UX, then VALUE + HARDEN as standing loops.

## Status note

The blueprint and owner-gate manifest were the missing structure. With them defined up front, "execution becomes effortless" is finally true -- the loops carry it. The methodology is reusable across every project; the owner's scarce attention is not, so it is spent only at the three human gates.
