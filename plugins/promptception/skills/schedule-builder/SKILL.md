---
name: schedule-builder
description: Use when the user wants something to happen automatically at a set time or on a recurring rhythm — "every morning", "weekly report", "remind me", "run this every Friday", "do this while I'm asleep", "while my laptop is closed", "help me schedule", "/schedule-builder" — or when they ask about the /schedule command, scheduled routines, cloud routines, desktop scheduled tasks, or Cowork scheduled tasks.
---

# Schedule Builder — the ideal scheduled routine, promptception-style

A scheduled routine is a prompt that runs on a clock with **no chat and no human present**. It can't ask a follow-up question, can't say "like we discussed", and nobody is there when it hits a snag. This skill runs the promptception method on that reality — and picks the right scheduler *before* writing a word of the prompt.

**Voice:** plain English, zero jargon, no sycophancy. Every question carries its *why* — one plain sentence tying the gap to the output, framed as what it unlocks, never as what they forgot. `${CLAUDE_PLUGIN_ROOT}/references/entry-gate.md` decides whether the tool itself gets explained.

## Step 0 — Entry gate, Phase A

Run `${CLAUDE_PLUGIN_ROOT}/references/entry-gate.md` — Phase A: a read-only look at what this
session has, then the teach check. **The right-door check is Phase B and runs at Step 1**, on
what they actually said.

If the teach check says explain, this is the explanation — two or three sentences, **once**,
ending with what it means for them:

*"Scheduling means work that runs on a clock — every morning, every Friday, once next Tuesday —
whether you're at the computer or not. There are three different schedulers and they are not
interchangeable: one runs on Anthropic's computers, one runs on yours, one runs inside Cowork.
What this means for you: picking the wrong one is how a routine 'runs fine' every day and never
touches the files you actually wanted it to."*

**If nobody's there to answer** (headless, or this skill running inside a routine), don't block on
an ask: take the safest stated default and say in the output which one you took and why, or stop
and name exactly what was missing. Full rule:
`${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`.

## Step 1 — Take the dump

Accept the mess as-is. Nothing attached? Say: *"Just talk. What do you want to happen on its own — and when?"*

**Right-door check — always run it.** Run `${CLAUDE_PLUGIN_ROOT}/references/fitness-gate.md` here, every time, before shaping anything. That pass is what decides whether this is really a schedule at all or a one-off prompt, a repeating watch, or a run-until-done condition — so it can't be skipped on the grounds that you already think it's a schedule. Name the better door in one line, **in plain words, never as a slash command**, then build whichever they choose. That is **B1**.

**Then B2 — the ownership question, once:** have they built a schedule with you before? If yes, they draft and you coach (`${CLAUDE_PLUGIN_ROOT}/references/mastery.md`). One ask per session, never a toll booth. **B3, the confirming probe, is deferred to Step 6** — for a scheduler, trying it for real means creating a real task on their account, so it waits for their go.

## Step 2 — Pick the scheduler

Do this **before** shaping the routine. The scheduler decides what the routine is even allowed to do.

**The one question that decides it:** *"Does this job need files that live on your own computer — AND run while your laptop is shut?"*

If both are yes, **a cloud routine cannot do it.** Cloud routines start from a fresh clone, not from their machine. A coach asking for "a morning report on my files" gets nothing useful out of one.

**Then say the honest part out loud: on the docs as written, there may be no scheduler that does both.** Desktop reaches their local files but is skipped whenever the machine is asleep; cloud runs with the lid shut but starts from a fresh clone and never sees their files; Cowork is the only maybe, and Anthropic's docs contradict themselves about it — the contradiction, and the one-shot test that settles it, are both in `${CLAUDE_PLUGIN_ROOT}/references/schedule-mechanics.md`. So don't pick a winner: offer them that test, read what actually happened, and let that decide.

**Probe before you name it — read-only at this stage.** Look at which schedulers respond here (`${CLAUDE_PLUGIN_ROOT}/references/capability-probe.md`) and name the one that exists, not the one that ought to. **Do not create anything to find out.** For a scheduler, "trying it" means putting a real task on their account — that is B3, and it happens at Step 6, after they've said go.

The matrix — what each scheduler can reach, what it costs, what a cloud routine actually
requires, the whole contested Cowork column and the local-folder contradiction — is in
`${CLAUDE_PLUGIN_ROOT}/references/schedule-mechanics.md`. Read it before you name a scheduler.

**Annual and one-off jobs are still scheduling.** "Every April 15" is recurring — a long
interval is not the same as a one-shot, and a single fixed date is a scheduled job too. Neither
belongs in a loop: loops expire after seven days, so a yearly job dies nine months early.

## Step 3 — Build the routine

Silently extract, then write the routine prompt an expert would have written. The unattended test governs everything:

- **Self-contained** — the prompt carries EVERYTHING the job needs (names, links, formats, examples). It fires in a fresh context with zero memory of this conversation — "the usual report" means nothing at 6am
- **Timing** — when, how often, one-time or recurring, and the time zone
- **Deliverable + destination** — what gets produced and WHERE it lands so they actually see it (a file, an email draft, a message)
- **Snag behavior** — what it does when an input is missing or a step fails with nobody watching: skip and report, or stop. Never guess-and-send
- **Outward-action rule** — anything that leaves the machine (send, post, publish) defaults to DRAFT for their review, not auto-fire, unless they explicitly choose otherwise right now

Blanks for anything missing: `[WHICH INBOX]`. Every blank resolved before creating. Never assume.

**Reading while you shape.** If shaping this needs real reading — their existing files, a repo, last month's reports — hand that to the orchestrator's scout/reader agents instead of doing it inline. **Questions never go to an agent:** every question for the user gets asked here, in this session, by you.

## Step 4 — Show it, then close gaps

1. **"Here's the routine hiding inside what you said:"** → the full routine prompt, its schedule, and which scheduler, in a copy-able block
2. **Routine Rubric** — ask about any fuzzy dimension:
   - **Scheduler fit** — local files? laptop shut? does the interval clear that scheduler's floor?
   - **Self-contained** — could a stranger run this from the text alone
   - **Timing** — exact clock, rhythm, time zone
   - **Deliverable + destination** — what shows up, and where
   - **Snag behavior** — the no-human-watching branch
   - **End game** — what this rhythm ultimately feeds

   3–5 questions per round, up to 3 rounds, batched, never re-ask. Popup-first via **AskUserQuestion** with a numbered-text fallback, beginner why-line on each — the canonical rule is `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`. Re-show the updated routine between rounds. Escape hatch only on explicit impatience, costs named first.

## Step 5 — Orchestrator mode inside the routine

Orchestrator mode normally needs a person in plan mode. A routine has no person — so inside a routine it runs in **execution mode only**, against a plan built while the user was present. Recommend the split when the job clears the intricacy bar (**2+** of: multi-system, multi-session, live infrastructure, money/send path):

- The plan gets built **now**, with them here
- Inside the run: **no premortem, no Step-0 questions** — there's nobody to answer them
- The **qualification gate still applies** — an underqualified seat writes a NOT-RUN report instead of guessing
- Anything it would have asked becomes a **declared assumption in its run report**, so they can see what it decided on their behalf

Below the bar? Don't pitch it.

## Step 6 — Create it

**Probe, don't assume.** Whether this session can create a schedule at all depends on where you're running — run `${CLAUDE_PLUGIN_ROOT}/references/capability-probe.md` and find the real route before you promise anything.

Then the gate, because a standing automation is a real commitment:

*"Ready to create: [one-line summary], as a [which scheduler], running [schedule]. Say go and it's live."*

On the explicit yes, create it — then read back name, schedule, and next run so they see it exists. No route from here? Say so plainly and hand them the paste-ready request to run where the scheduler does live.

## Step 7 — Now that it's live (the part nobody tells them)

Say this one **verbatim**, every time:

> **"A green status in the run list means the session started and exited without an infrastructure error. It does not mean the task in your prompt succeeded."**

So read the actual output of the first few runs, not the status dot. **Say it as the safe reading of a status dot, not as a quote from Anthropic** — no vendor page states it in these words, and the three schedulers don't share one run list. What IS sourced is the case that proves the point: a Cowork run can hit a permission request, have it auto-denied after ten minutes, and finish green with the work missing (`${CLAUDE_PLUGIN_ROOT}/references/schedule-mechanics.md`).

Then brief them on what actually happens now it's live — the 10-minute permission trap, why
start times drift, what a sleeping machine does to a desktop task, missed-run behavior, run
history, time zones, and where the prompt lives. All of it, with the sourcing, is in
`${CLAUDE_PLUGIN_ROOT}/references/schedule-mechanics.md`. Give them only the lines that touch
their routine.

**Hand them the off-switch, in this message.** Pause, resume, edit and delete are available on
every scheduler — say it plainly: *"to stop it, just ask me to delete the task by name."* If you
built a `/loop` instead of a real schedule, stopping it is a different question with three
different answers — use the off-switch table in
`${CLAUDE_PLUGIN_ROOT}/references/loop-mechanics.md` and name the right one. A standing automation the user can't turn off runs unattended, on a clock.
A schedule isn't a tattoo, but only if they know that.

## Step 8 — Close it out

Run the closing debrief from `${CLAUDE_PLUGIN_ROOT}/references/mastery.md`: what we built, why
this scheduler beat the others for their job, what they can now do without me — then the one
upgrade they didn't ask for, if there is one.

Beat 3 of that debrief — the transferable part — for schedules is: *"the routine carries
everything it needs inside itself; at 6am there's no conversation to remember, so the prompt IS
the memory."* Say it once, inside the debrief. Never as a second closing line on top of it.
