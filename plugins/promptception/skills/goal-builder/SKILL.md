---
name: goal-builder
description: Use when the user wants Claude to keep working on its own until something is finished — the /goal command — and needs help shaping the condition that says when to stop. Triggers include "help me set a goal", "what should my goal be", "build my goal", "goal for this session", "/goal-builder", "keep going until it's done", or any messy description of a job that should run turn after turn until a finish line is true. This is the back-to-back-turns tool, not the timer one — if they want something checked on a clock, that's loop or schedule.
---

# Goal Builder — the ideal /goal condition, promptception-style

Claude Code's `/goal` is not a mission statement. It's an **engine**. You give it a condition that says when the work is finished. After every turn, a second smaller model reads the conversation and decides whether that condition is true yet. If it isn't, **Claude starts another turn by itself** — nobody has to type "keep going." It ends when the condition is met, or when that model decides the condition can never be met.

So the entire job of this skill is writing a condition an engine can actually settle. Most people type an activity ("work on my emails"). An activity has no finish line, so the engine grinds forever. This skill runs the promptception method on that gap.

**Voice:** plain English, zero jargon, no sycophancy. Their mess is the fuel. Every question carries its *why* — one plain sentence tying the gap to the output, framed as what it unlocks, never as what they forgot. `${CLAUDE_PLUGIN_ROOT}/references/entry-gate.md` decides whether the tool itself gets explained.

## Step 0 — Entry gate, Phase A

Run `${CLAUDE_PLUGIN_ROOT}/references/entry-gate.md` — Phase A: a read-only look at what this
session has, then the teach check. **The right-door check is Phase B and runs at Step 2**, once
they've told you what they want — it reads their actual request, so there is nothing for it to
judge yet.

If the teach check says explain, this is the explanation — 2–3 sentences, plain English, ending
with what it means for them:

*"`/goal` sets a finish line, then keeps me working toward it without you. After every turn a
second, smaller model reads our conversation and asks one question — is that finish line true
yet? If it isn't, I start another turn on my own, over and over, until it's true or until that
model decides it never can be. What this means for you: you paste one line and walk away,
instead of typing 'keep going' fourteen times."*

**If nobody's there to answer** (headless, scheduled, an unattended run), don't block on an ask:
take the safest stated default and say in the output which one you took and why, or stop and name
exactly what was missing. Full rule: `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`.

## Step 1 — Take the dump

Accept whatever they give — rambling, half-sentences, dictation. Never ask them to tidy it. Nothing attached? Say: *"Just talk. What has to be TRUE before I'm allowed to stop — tell me like you'd tell a friend."*

## Step 2 — Right door, then build THE CONDITION

**Phase B of the entry gate — B1 (right door) and B2 (ownership) — runs here, before you shape a line. B3 does NOT.** For `/goal`, "try it for real" means setting a goal, and setting a goal starts a turn immediately — firing it mid-interview would launch the engine on a condition they haven't agreed to. **B3 is deferred to Step 4**, where the zero-risk bare-`/goal` check does the job instead. Two mis-fits matter most for
`/goal`:

- **One deliverable is a plain prompt, not a goal.** `/goal` earns its keep by starting turn
  after turn until something is true. If a single turn produces the thing, there is nothing left
  for the engine to keep working toward.
- **"Every morning" is a schedule, not a goal.** `/goal` runs turns back to back, right now. It
  has no concept of tomorrow.

The gate warns; it never blocks. Name the better door in one line — in plain words, never as a
slash command — then build whichever they pick. Then the ownership question, once. Then shape.

Silently extract, then write the condition they'd have written if they were an expert. Four things go into it:

- **A state, not an activity** — something that is plainly true or false the moment a turn ends. *"All three launch emails are drafted and each full draft is printed in the chat"*, not *"work on the emails."*
- **Proof that lands in the conversation** — the single thing that decides whether this works. See the rubric below; it's the first thing you check.
- **A bound** — a clause inside the condition that lets it give up: `or stop after 20 turns`. Without one, a condition that can't be reached keeps burning turns.
- **Edges** — what's explicitly out of scope, and anything it must not touch while grinding away unattended.

**Keep it under about 4,000 characters** — roughly a page. Treat that as this skill's working ceiling rather than a stated platform limit: a condition anywhere near it is usually a plan wearing a goal's clothes, so run `${CLAUDE_PLUGIN_ROOT}/references/fitness-gate.md` again if you get there.

Mark missing pieces as blanks: `[WHICH 3 EMAILS]`. Blanks are gap markers, not shipping material — every blank gets resolved before delivery. Never assume.

**If shaping the condition needs files read** — checking what's already in a folder, what a document says, how something is currently set up — **dispatch `orch-scout` or `orch-reader` to read it** instead of pulling it into the user's chat. Their chat stays lean and cheap; you get the facts. One hard limit: **every question for the user stays in the main session.** A dispatched agent cannot ask them anything — it returns with the open question and you ask it. Full rule: `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`.

## Step 3 — Show it, then close the gaps

1. **"Here's the finish line hiding inside what you said:"** → the full `/goal` line in a copy-able block
2. **Goal Rubric** — score your understanding, then ask about any dimension still fuzzy. **Provability is first because it's the one that decides whether this works at all.**

   - **Provability — can the evaluator SEE this?** The model that judges the goal **reads only the conversation. It never runs a command, opens a file, or checks a website.** So a condition is unprovable unless Claude puts the proof into the transcript itself. *"All tests in test/auth pass"* works **because** Claude runs the tests and the result lands in the chat where the evaluator can read it. *"The site is live"* does not — nothing in the conversation shows it. This is the number one reason a goal spins forever: the work is genuinely done and the evaluator has no way to tell. Fix it by writing the proof into the condition — *"…and the passing test output is printed in the chat."*
   - **End state** — what is TRUE when it stops, not what Claude will be doing
   - **Bound** — what makes it give up if it can't get there (`or stop after 20 turns`)
   - **Edges** — what's out of scope, what must not be touched while it runs unattended
   - **End game** — what this result feeds (the launch, the client, the week). A finish line in the wrong place is a lot of turns spent well on the wrong thing.

   **How to ask:** follow `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md` — popup-first via the AskUserQuestion tool, the same questions as numbered text when that tool isn't there, and all the round rules. It's canonical if anything drifts.

   Re-show the updated condition between rounds — the visible sharpening IS the lesson. Escape hatch: only on explicit impatience, name what the remaining guesses cost, then obey "run anyway."

## Step 4 — Deliver

**Claude cannot type `/goal` for them.** It's a command they run, and no skill can host one — the real thing is engine machinery, not text. Hand it over paste-ready.

**This is B3 — check it's there, then get the permission mode right, both before they paste the real line.**
Setting a goal **starts a turn immediately**; there is no second prompt to catch. The zero-risk
availability probe (which is a **user** action — have them paste bare `/goal`), the auto-mode rules
and version gates, the trust settings that switch `/goal` off entirely, and the headless
print-nothing-until-finished behavior all live in
`${CLAUDE_PLUGIN_ROOT}/references/goal-mechanics.md`. Probe the capability, never announce which
app they're in (`${CLAUDE_PLUGIN_ROOT}/references/capability-probe.md`).

Then the line itself:

```
/goal [the crafted condition]
```

## Step 5 — Hand over the controls

Walk them through driving it — setting, checking status, clearing — and the three ways a goal
ends, because one of them is failure. **"Impossible" is a real outcome**, and the reason attached
to it is usually the most useful sentence in the whole run. The tables, the resume behavior, the
stall guard and the judge model are in `${CLAUDE_PLUGIN_ROOT}/references/goal-mechanics.md`.

## Step 6 — Orchestrator check

Before closing, test the job against the intricacy bar. If **2+** apply — spans multiple systems, spans multiple sessions, touches live infrastructure, touches a money/send path — say so:

*"This one is big enough that I'd run it in orchestrator mode — I lead a crew of specialist agents instead of doing all the reading myself, and nothing gets built on an unverified claim. Say 'go orchestrator' when you're ready to start."*

Below the bar? Skip the pitch entirely — orchestration overhead must earn itself.

One interaction to know if they do both: **a turn's evaluation appears to be skipped while a subagent or background job from that turn is still running** — nothing breaks, the check lands on the next turn instead. Observed behavior, not a documented guarantee; say it as "expect", not as "it will".

## Step 7 — Close it out

Run the closing debrief from `${CLAUDE_PLUGIN_ROOT}/references/mastery.md`: what we built, why
these choices beat the alternatives, what they can now do without me — then the one upgrade they
didn't ask for, if there genuinely is one.

Beat 3 of that debrief — the transferable part — for goals is: *"the condition says the passing
output has to be printed in the chat; the judge only reads our conversation, so if it can't see
the proof, the work isn't done as far as it's concerned."* Say it once, inside the debrief.
Never as a second closing line on top of it.
