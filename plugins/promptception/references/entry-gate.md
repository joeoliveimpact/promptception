# The entry gate — run this before shaping anything

Every builder runs this. Two phases, because half of these checks cannot be judged until the
user has actually said what they want.

**Phase A** happens before you take their dump. **Phase B** happens after it, before you shape
a single line. Do not collapse them into one block at the top — that was the bug this file
exists to kill.

---

## Phase A — before the dump

### A1. Preflight — what does this session actually have?

Take stock of what responds here: which commands exist, which connectors are attached, which
tools are loaded, whether anything can schedule. You need this before you recommend a door,
because recommending a door that isn't in the building is worse than recommending nothing.

**Read-only. Always.** Look at what is present. Do not create anything to find out.

This is a real constraint, not a nicety. `capability-probe.md` defines probing as *"try the
thing"* — and for a scheduler, trying it **creates a real scheduled task on their account**.
Doing that here, before they have even told you what they want, litters their account every
single time a builder opens. The create-and-read-back probe is real and it still happens — at
**B3**, once, for the one tool they chose.

**When something is missing, say what the TOOL needs — never where the USER is.**

Use this shape:

> *"I checked — `/goal` isn't available in this session. It's a Claude Code command, and not
> every surface has it."*

Never this shape:

> ~~*"You're in Cowork, so use `/schedule`."*~~

The second one is a guess about their environment, and `capability-probe.md` forbids it: there
is no reliable way to know which surface someone is on. When the guess is wrong they are left
holding an instruction that doesn't work, with no idea why — they will assume they broke it.
Saying what the tool requires gives them the same useful information and cannot be wrong.

### A2. Teach check — do you explain what this tool even is?

**The rule in one line: teach is ON unless a scaffolded workspace says `verbosity: standard`.**

| Situation | Teach |
|---|---|
| No `.claude/workspace.yml` — the normal case for most people | **ON** |
| `workspace.yml` says exactly `verbosity: standard` | **OFF** |
| `workspace.yml` says anything else, or has no `verbosity` key at all | **ON** |
| They toggled it this session ("standard mode" / "beginner mode") | **That wins, immediately** |

Read the third row literally: **only the exact value `standard` turns teach off.** `beginner`,
`intermediate`, a typo, an empty value, an unreadable file — all of it means ON. That is
deliberate. Every case lands on exactly one row and no case lands on none; the bug this replaces
was a rule where a plain `verbosity: standard` workspace matched neither branch and got beginner
speech forced on it anyway. Defaulting to ON when the signal is unclear costs a returning user
three sentences they can turn off. Defaulting to OFF costs a beginner the explanation they
needed and never knew existed.

Teach ON means: deliver your skill's own two-or-three sentence explanation of what the tool is,
in plain English, ending with what it means for them. Once. Never per step.

Teach OFF means: skip the explanation only. Everything else in the house voice still applies —
the why-lines on questions, naming what improved, the closing lesson. Those are not a mode.

---

## Phase B — after the dump, before you shape anything

### B1. Right door — run the fitness gate

Run `${CLAUDE_PLUGIN_ROOT}/references/fitness-gate.md` now, on what they actually said. It could
not run in Phase A: every test in it reads their real request, so there was nothing to test yet.

It warns, it never blocks. Name the better door in one line, then build whichever they pick.

Two constraints from Phase A:

- **Only name doors this session has.** If the better door isn't here, say that plainly in the
  same breath — don't send them after something that won't answer.
- **Never hand them a slash command for another skill in this plugin.** Say it in words:
  *"Want me to build you a schedule instead? Just say so."* Sibling skills trigger on plain
  language on every surface. A slash string is a version-and-namespace bet you don't need to
  make, and the place it fires — the escape hatch from a missing tool — is exactly where the
  user is already stuck.

### B2. Ownership — who writes the first draft?

Ask once per session, the way the house asks: popup first via **AskUserQuestion**, and the same
question as plain text wherever that tool isn't available. Never hard-require the popup
(`${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`).

> *"Have you built one of these with me before?"*

- **No, or first time** — you draft. Normal flow.
- **Yes** — they draft first, you coach. Ask for their attempt, then sharpen it against the
  rubric out loud so they can see what changed and why. They keep the skill; that is the point.

One ask. Do not re-ask it later in the same session, and never make them prove anything.

**The promptception skill asks this same question at its own Step 1.** A builder reached by
escalation from promptception must not re-ask it, the answer is already in the session.

### B3. Confirming probe — at the moment of the promise, once

**B3 is not the fourth thing you do in a row.** It fires when you are about to promise that
something actually runs — which in most builders is at delivery, several steps after B1 and B2.
Each builder says where its own B3 lands, and why; follow that, not the numbering.

When it does fire: try it for real — create it, read it back, tell them exactly what you saw.
Once, for the chosen tool only, and never as a background side effect of a question they didn't
ask. **Before that moment, stay read-only.** Creating a scheduler to see whether schedulers work
puts a real task on their account; setting a goal to see whether `/goal` exists starts a turn on
a condition they haven't agreed to.

If it cannot be probed, say so plainly and give the fallback route. Unverified is a fine
answer. Wrong is not.
