---
name: loop-builder
description: Use when the user wants something checked or done repeatedly and needs the /loop command shaped for it — "keep checking", "monitor this", "every 5 minutes", "run this until", "watch for", "help me set up a loop", "/loop-builder" — "notify me when", "poll this", "let me know if it changes" — or when they try to phrase a recurring task and it comes out vague. This is the on-a-timer tool, not the back-to-back-turns one.
---

# Loop Builder — the ideal /loop prompt, promptception-style

`/loop` re-runs one instruction on a timer: check something, act if needed, wait, repeat. That's what makes a loop prompt a different animal from a normal prompt — it fires over and over **with nobody watching**, so a vague one doesn't just underperform once. It repeats the same miss every single time it fires. This skill runs the promptception method on that problem.

**Voice:** plain English, zero jargon, no sycophancy. Beginner teach mode is the default — every question carries its *why* — one plain sentence tying the gap to the output, framed as what it unlocks, never as what they forgot. Ask the way the house asks: `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`.

## Step 0 — Entry gate, Phase A

Run `${CLAUDE_PLUGIN_ROOT}/references/entry-gate.md` — Phase A: a read-only look at what this
session actually has, then the teach check. Phase B runs at Step 2 — B1 (right door) and B2
(ownership); **B3, the confirming probe, is deferred to Step 4**, where you check `/loop` actually
runs here before promising it,
after you've heard what they want.

If the teach check says explain, this is the explanation — 2–3 sentences, plain English, ending
with what it means for them:

*"`/loop` makes Claude re-run one instruction over and over on a timer — check something, act if
needed, wait, repeat. Like asking an assistant to 'check the inbox every 20 minutes and flag me
if the client replies.' What this means for you: you stop babysitting things that change on
their own — the loop watches so you don't have to."*

**If nobody's there to answer** (headless, scheduled, an unattended tick), don't block on an ask:
take the safest stated default and say in the output which one you took and why, or stop and name
exactly what was missing. Full rule: `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`.

## Step 1 — Take the dump

Accept the mess as-is. Nothing attached? Say: *"Just talk. What do you want checked or done over and over — and what should happen when it's found?"*

## Step 2 — Right door, then build THE LOOP PROMPT

**Phase B of the entry gate runs here, before you shape a line** — the right-door check reads
what they actually asked for, so it could not run at Step 0. Two mis-fits bite loops hardest:

- **The watched thing only changes once a day.** A loop waking every few minutes to find nothing
  new is spending turns on nothing — that's a schedule. Offer it in plain words: *"want me to
  build this as a schedule instead?"* Never as a slash command.
- **A loop needs an open session.** If what they want is "this happens while my laptop is shut,"
  no loop can do it, ever. That's a scheduler job, and it's better to say so now than after
  they've built the loop.

Then B2, the ownership question, once. Then shape. (B3 waits for Step 4 — see Step 0.)

**Read `${CLAUDE_PLUGIN_ROOT}/references/loop-mechanics.md` before you shape**, not after: the three
shapes, the timing rules and the expiry all change what a good loop prompt says.

Silently extract, then write the loop prompt an expert would have written. A good one nails all five:

- **Watch target** — the ONE thing each tick checks (a status, an inbox, a metric, a file)
- **Per-tick action** — if found/changed, do X; otherwise do nothing and wait. One check, one action — a loop doing three jobs badly should be three loops or a plan
- **Stop condition** — when the loop ENDS (found it, N times, a date, "until I say stop"). Write it in even though loops expire on their own after seven days: expiry is a backstop, not a plan. A wrong loop with no stop condition doesn't run forever — it runs a week, which at five-minute ticks is about two thousand repeats of the same mistake
- **Safe to repeat** — the action can't double-fire damage (send the same email twice, re-post, re-charge). If it could, the prompt must check "already done?" first. **This is the one that matters most.** An outward-firing loop with no "already done?" check is the strongest warning in `${CLAUDE_PLUGIN_ROOT}/references/fitness-gate.md` — say it out loud, in the plain words that file uses, and send it draft-first if they still want it live
- **Interval** — matched to how fast the watched thing actually changes. Checking a daily report every 5 minutes is 287 wasted runs

Blanks for anything missing: `[WHAT COUNTS AS A REPLY]`. Every blank resolved before delivery. Never assume.

## The mechanics you're shaping around

They live in `${CLAUDE_PLUGIN_ROOT}/references/loop-mechanics.md` — the three shapes, running a
skill on a tick and the silent failure that comes with it, the timing rules, the seven-day
expiry, what stops a loop, the limits, and how company-cloud setups differ.

Read it before you shape or hand over. Give them only the parts that touch their loop, in their
language. Never dump it at them.

## Step 3 — Show it, then close gaps

1. **"Here's the loop hiding inside what you said:"** → the full command in a copy-able block
2. **Loop Rubric** — ask about any fuzzy dimension (3–5 questions per round, up to 3 rounds, batched, never re-ask — `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`):
   - **Repeat safety** — what breaks if it fires twice. **Repeat safety is first because it's the
     one that decides whether this loop is safe to exist at all** ... an outward-firing loop with
     no "already done?" check is the strongest warning in the fitness gate.
   - **Watch target** — what exactly gets checked each tick
   - **Per-tick action** — and what happens on the quiet ticks
   - **Stop condition** — how this ends
   - **Interval** — how fast does the watched thing really change
   - Re-show the updated command between rounds. Escape hatch only on explicit impatience, costs named first.

## Step 4 — Deliver

Claude cannot start a loop for them — the client runs the command. Hand it over paste-ready:

```
/loop [INTERVAL] [the crafted loop prompt]
```

**Does it run here? Probe, don't guess ... and mind which probe.** Never tell them which app or environment they're in (`${CLAUDE_PLUGIN_ROOT}/references/capability-probe.md`). Phase A's read-only inventory already answers the question you need first: does the scheduling machinery exist in this session at all. **Do not create anything to find out.** For `/loop` that is not a harmless test ... a real probe arms a real recurring task on the same scheduler family everything else here uses, it counts against the 50-task session cap, and a cron-backed one survives the ordinary stop call. **That is B3, and it happens only after they've said go.** When it does fire: create it, read it back, then delete it immediately, and say exactly what you saw. Say what you saw either way, probed or not. If it can't be probed, say that plainly and hand them the fallback in the same breath: *"I can't verify from here whether `/loop` runs in your setup. The command is written out and ready to paste. If it isn't in your version, a scheduled routine does the same job on a clock — just say the word and I'll build that instead."*

**The operating facts every loop owner needs** — one line each, only the ones that apply:

- It **expires after seven days** on its own: one last run, then it's gone.
- **How to stop it — name the switch for the flavor you just built.** Esc while it's waiting
  clears a pending `/loop` wakeup. Beyond that the switch depends on the flavor: a cron-backed
  fixed-interval loop needs its entry deleted, and a monitor needs its task stopped — the
  scheduler's own stop call does not reach either. Use the off-switch table in
  `${CLAUDE_PLUGIN_ROOT}/references/loop-mechanics.md` and hand them the right one, in this
  message. **A loop they can't turn off is the worst thing this skill can ship.**
- It **only runs while this is open and idle** — close the terminal and it stops, unless they background the session first, which carries the loop into a background session that keeps running without a terminal.
- A fixed-interval loop fires late by design — **up to 30 minutes for hourly-or-slower loops, or up to half the interval for anything faster.** A 20-minute loop can run ~10 minutes late; that's not a fault. (A self-paced loop picks its own next wakeup, so that lateness doesn't apply — but its waits still run slightly long and land on whole minutes, so the cadence drifts later over a long run.)

**On cost, tell the truth.** Anthropic's documentation says nothing about what a `/loop` consumes while it runs, so never claim it "burns usage" as though that were a documented fact, and never quote a number. What is honestly sayable: every tick is a real turn doing real work, so a tighter interval means more work happening — pick the loosest interval that still catches the thing in time.

## Step 5 — Orchestrator check (both directions)

**(a) While you're shaping the loop, in this session.** If working out the loop needs files read — logs, a spreadsheet, a folder of notes — dispatch `orch-scout` / `orch-reader` to go read and report back, instead of pulling all of it into their chat. **Every question stays here in the main session.** A dispatched agent cannot ask the user anything; it returns the open question and you ask it (`${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`).

**(b) Inside the loop itself.** If the per-tick action clears the intricacy bar (**2+** of: multi-system, multi-session, live infrastructure, money/send path), write orchestrator mode **into the loop prompt** so each tick delegates its work instead of stuffing one context:

*"Each tick of this loop is doing heavyweight work — I'd build the tick to run in orchestrator mode, so every tick's claims get verified instead of assumed and nothing piles up in one context. Say 'go orchestrator' and we'll set it up that way."*

**A tick runs unattended, so it runs in EXECUTION mode only.** Never plan mode, no premortem, no Step-0 questions inside the loop prompt — there's nobody there to answer them, and a tick that stops to ask is a tick that did nothing. **So give the tick its not-asked path in writing:** name the default it should take when something is ambiguous and have it say which default it took, or have it stop and report exactly what it needed. Never leave a tick with an unanswerable question and no instruction (`${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`).

Execution mode needs something to execute, so **the plan has to be built and approved now, while they're sitting here.** A tick set to execution mode with no agreed plan behind it has nothing to run against.

Below the bar? Don't pitch it.

## Step 6 — Close it out

Run the closing debrief from `${CLAUDE_PLUGIN_ROOT}/references/mastery.md`: what we built, why
these choices beat the alternatives, and what they can now do without me. Then the one upgrade
they didn't ask for, if there genuinely is one.

Beat 3 of that debrief — the transferable part — for loops is: *"the loop says when to STOP;
that's the line most people forget, and without it you don't get a helper, you get a week of the
same mistake on repeat."* Say it once, inside the debrief. Never as a second closing line on top.
