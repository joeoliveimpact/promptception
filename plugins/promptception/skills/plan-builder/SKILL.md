---
name: plan-builder
description: Use when the user wants a whole project planned and then run, not a single prompt — "build me a plan", "this is a big project", "plan this out", "map out the steps", "what's the order of operations", "plan and then do it", "/plan-builder". Also the escalation target from promptception's prompt-or-plan threshold — when a job clears the intricacy bar (2 or more of multi-system, multi-session, live infrastructure, a money or send path), promptception hands it here for a researched plan, a stress test before the user sees it, and orchestrated execution with an independent checker.
---

# Plan Builder — the heavy tier of the plan engine

Some jobs are too big for one prompt. A few of those are too big for one chat. This skill is the second kind: the plan gets researched first, stress-tested for what could go wrong before they ever see it, then run with a builder and an independent checker.

**What a plan IS — the threshold, the rubric, how it's shaped, how it gets reviewed — lives in `${CLAUDE_PLUGIN_ROOT}/references/plan-engine.md`.** Read that file first; it is the engine, and none of it is repeated here. This skill adds exactly one thing on top: the crew.

**Voice:** plain English, zero jargon, no sycophancy. Every question carries its *why* — one plain sentence tying the gap to the output, framed as what it unlocks, never as what they forgot. `${CLAUDE_PLUGIN_ROOT}/references/entry-gate.md` decides whether the tool itself gets explained.

## Two ways in

**Direct** — they invoked this skill themselves. Start at Step 0, like everything else; the
entry gate runs for every route in.

**Escalated from promptception** (its Step 3.5 hands over jobs clearing 2 or more of: multi-system, multi-session, live infrastructure, a money or send path). Part of the Plan Rubric is already answered over there, and so is the **right-door check** — promptception runs the fitness gate at its own Step 2, which is **B1**. So on this route: **don't re-run B1**, and **don't re-ask B2** either ... promptception's Step 1 already asked the ownership question, and that ask IS B2. Do still run **Phase A at Step 0** — promptception never ran it, so the preflight and the teach check are un-run, not already-done. Skipping them here is how a beginner silently loses the explanation and how you end up naming a door this session doesn't have. Carry the rubric answers across and ask only about what's still fuzzy. Re-asking something they already told promptception is the fastest way to make this feel like starting over — same never-re-ask rule as `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`.

## Step 0 — Entry gate, Phase A, and promise the gate

Run `${CLAUDE_PLUGIN_ROOT}/references/entry-gate.md` — Phase A: a read-only look at what this
session has, then the teach check. **The right-door check is Phase B and runs at Step 2**, on
what they actually said.

If the teach check says explain, this is the explanation — 2–3 sentences, said **once**, never
per step:

*"A few helper agents do the reading and the checking for me, off to the side, instead of
dumping it all into this chat. What that means for you: I stay sharp for the decisions, and you
only see the parts that actually need you."*

**Then promise the review gate out loud, before any plan exists.** This line gets said either
way, teach check or not: *"You'll see the whole plan and get to change anything in it before a
single step runs — nothing gets built until you say go."* The gate is real and enforced at
Step 6; they shouldn't have to discover it when the plan lands.

**Where the preflight finds an `EnterPlanMode` capability, ask one more question here:** run this
whole planning pass in plan mode, locked read-only until they approve? Wording, consent and
mechanics: `${CLAUDE_PLUGIN_ROOT}/references/plan-mode-gate.md`.

**Nobody there to answer?** On a headless or unattended run, don't block: take the safest stated
default and say in the plan which one and why, or stop and name exactly what was missing
(`${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`).

## Step 1 — Take the dump

Same intake as promptception. Rambling, out of order, half-finished, dictated with "um, and also, wait" all through it — take it as-is and **never ask them to tidy it up.** Nothing attached? *"Just talk. Tell me the whole project like you'd tell a friend — messy is perfect."*

## Step 2 — Right door check (entry gate, Phase B)

**Phase B runs here** — the right-door check reads their actual request, so it could not run at
Step 0. Run `${CLAUDE_PLUGIN_ROOT}/references/fitness-gate.md`. It warns, names the better door
in one sentence — in plain words, never as a slash command — and then does what they say. That
is **B1**. Then **B2**, the ownership question, once.

**B3 — the confirming probe — has no step number in this skill.** It fires wherever you promise
something runs unattended, which here is the branch under *Who has to be in the room*: try it for
real once, for the chosen tool only, before promising it runs. **Make no such promise and B3
never fires** ... that's correct, not a gap.

The three downshifts this door catches most:

- **One deliverable** → that's a prompt, not a plan. Offer to shape the prompt instead.
- **A clock job** ("every Monday morning…") → that's a schedule, not a plan. Offer to build the
  schedule instead. Annual and single-date jobs count — a long gap is still a schedule.
- **Plan-sized, but not heavy** → a real plan that does NOT clear the intricacy bar above. Offer the in-chat version instead: *"I can plan this right here without spinning up the research crew — same plan document, you just get it faster."* Orchestration has to earn itself; running the crew on a small job costs them time and buys nothing.

Then build whatever they choose. No second warning.

## Step 3 — Check the seat before promising a crew

Orchestrator mode needs an Opus-class or Fable lead. Run the **`orchestrator-mode` skill's Qualification Gate** — that skill is the source of truth for which seats qualify; don't restate it here.

Do this **before** the interview, not after. (`orchestrator-mode` calls its Qualification Gate the first action; running it here at Step 3 is a deliberate deferral — the entry gate owns Step 0 on every route in, and there is no crew to qualify until the right door is settled.) The gate has two below-ideal outcomes, and only one of them is a downgrade:

- **Seat qualifies but isn't the ideal one** — the gate's answer there is to say so, recommend the fix, and proceed on their confirm. Don't fire the message below at a seat that only needed a yes.
- **Seat genuinely can't drive the crew** — then they deserve to hear it now rather than at the end:

*"This session isn't running on a model that can drive the research crew. Two options: switch to one that can, or I build you the same plan right here in the chat — no research pass, no stress test, but a real plan you can run."*

That fallback is the light tier of the same engine. It's an honest downgrade, not a failure.

## Step 4 — The interview, all of it, up front

**Open with a silent skeleton.** Before asking anything, draft a skeleton plan straight from the
dump: steps in order, a guess at who owns each, and a blank marked `[LIKE THIS]` everywhere the
dump couldn't settle it. No research, no crew, no agents. **Never shown to the user.** Its blanks
generate the interview, one question per blank. When the answers land, the crew runs and the
researched plan replaces it.

Interview against the **Plan Rubric** in the engine file. Ask using `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md` — popup first, numbered text when the popup isn't there, same questions either way.

**No question cap here.** The 3-5-questions, max-3-rounds rule is for prompt-sized jobs; plans are
exempt. Rounds run until every blank is resolved, and 8 to 10 questions is normal for a real plan.
The only per-batch limit is the popup itself, 4 at a time: batches of up to 4, as many rounds as
the blanks demand. The trade flips because the crew runs unattended after this, so an unanswered
blank becomes a stall or a guess mid-flight: completeness beats brevity. Never-re-ask is
unchanged, new blanks only.

**The moment the last blank resolves, orchestrator mode kicks on by itself.** Finishing the
interview IS the trigger: no pause before the crew, no separate "go orchestrator" ask. Execution
is always orchestrated too, builder plus independent checker, no solo path. The only crew-less
exits are Step 2's downshift and Step 3's honest downgrade, both before the interview.

**This interview IS orchestrator-mode's Step 0.** Everything that needs a human decision gets batched and asked now, so the research half can run without stopping to tap them on the shoulder. A question you discover halfway through planning belonged in this round.

**Every question stays in this session. Always.** Helper agents read, search and report — they cannot ask the user anything. When an agent comes back holding an open question, **you** ask it here, in the main chat. That's a legitimate reason to fire another round under the round rules. Never write a dispatch that tells an agent to "ask the user" — it will stall or guess, and the interview breaks quietly.

## Step 5 — Plan in orchestrator mode

Now the crew. Follow the **`orchestrator-mode` skill's Plan Mode Protocol** — the dispatch rules, tiers and effort calls live there, not here:

1. **Tiered audit.** `orch-scout` finds and lists; `orch-reader` does the real reads and the verdicts. Anything live gets checked both directions. All of it happens in agents, so their chat stays lean.
2. **Design from verified findings only.** If nobody actually read it, it doesn't enter the plan as a fact. A document saying something is not the same as someone checking it.
3. **Premortem — before they ever see the plan.** Run the **`premortem` skill** against the draft: assume it's six weeks later and this failed, then work backwards to find why. The legwork can go to `orch-premortem`; the verdict stays yours.
4. **Fix the draft against the findings.** Then, and only then, present.

## Step 6 — Present it, then wait

Present the plan the way the engine says — one document, every step its own ready-to-run block, adjust by highlighting, one review pass.

Add one plain line naming what the stress test changed: *"The premortem caught that step 4 needs your Stripe login, so it's now step 2 and it's on your list, not mine."* That single line is what makes the extra pass feel worth it to them.

**Then stop and wait for an explicit go. Creating that pause is this skill's own job.**

**Where plan mode is active, `ExitPlanMode` IS this gate** ... it presents the finished plan and
requires approval before anything runs (`${CLAUDE_PLUGIN_ROOT}/references/plan-mode-gate.md`).
What follows is the fallback for where that tool is absent, and there it isn't optional.

Without that tool, do not lean on a permission mode to hold the gate for you. Some surfaces have no design-before-acting phase at all, so a gate handed off to one may simply not exist — and the plan runs unreviewed. Present, ask, wait for a yes. Never read enthusiasm about the plan as permission to start building it. And never tell them which app or environment they're in; probe the capability instead — `${CLAUDE_PLUGIN_ROOT}/references/capability-probe.md`.

## Step 7 — Execute in orchestrator mode

On their go, run the **`orchestrator-mode` skill's Execution Protocol**:

- `orch-builder` builds the steps the plan assigned to Claude.
- `orch-checker` independently runs each step's done-test, **both directions**, before the next step starts. The builder never grades its own work.
- **No premortem here.** That was Step 5's job; the plan is approved now.
- A deviation from the approved plan is something to **report, not decide** — same for anything the build finds that contradicts what the plan assumed.
- Steps the plan marked as **theirs** stay theirs. Stage them so their part is a five-minute review, and stop there. Anything outward-facing — send, post, publish, charge — still needs an explicit yes on that specific action.

## Who has to be in the room

**Planning needs them. Execution doesn't have to.** Which half needs a person, what an unattended
run may do, and the B3 probe before you promise it:
`${CLAUDE_PLUGIN_ROOT}/references/plan-mode-gate.md`.

## Step 8 — Close it out

Run the closing debrief from `${CLAUDE_PLUGIN_ROOT}/references/mastery.md`: what we built, why
the crew earned its extra passes on this job, what they can now do without me — then the one
upgrade they didn't ask for, if there is one.

Beat 3 of that debrief — the transferable part — for plans is: *"we found the login problem
before you spent a week building around it; that's what the stress test is for, and it's why the
plan you approved is the plan that runs."* Say it once, inside the debrief. Never as a second
closing line on top of it.
