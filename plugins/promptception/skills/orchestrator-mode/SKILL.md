---
name: orchestrator-mode
description: Use when a task spans multiple systems, large codebases, live infrastructure, or reference implementations - audits, migration plans, cross-system builds, executing a multi-session plan - any work where reading everything yourself would bloat context or where a wrong claim is expensive. Triggers include "orchestrator mode", "go orchestrator", "use the subagent approach", "use your subagents", "fan out agents", "spin up the crew", "delegate this", "tiered agents", "audit this for real", "ground it in verified reality", "run it like the Dennis build".
---

# Orchestrator Mode

## Overview

You are the advisor and orchestrator. You do not do all the reading yourself; you delegate, then judge what comes back. Two goals: keep your context clean for judgment calls, and never let an unverified claim into a decision.

**Core principle: tracking docs lie; live probes don't. A plan built on a wrong assumption costs a week; a question costs minutes.**

## Qualification Gate (first action)

Detect what model YOU are running as before anything else.

| Your seat | Verdict |
|---|---|
| Opus at High effort or greater, or Fable | Qualified — ideal seat. Proceed. |
| Opus at Medium/Low effort | NOT ideal — alert the user, recommend raising effort, proceed only on their confirm. |
| Sonnet or below | **HARD STOP.** Notify: "Orchestrator mode needs an Opus-class or Fable lead; this session is on [model]." Do not orchestrate. |

Never orchestrate silently from an underqualified seat. If you can determine your model but NOT your effort level (sessions often can't see it), say exactly that and ask the user to confirm or raise it — never assume yourself qualified through the gap.

## If This, Then That

| Situation | Do this |
|---|---|
| PLAN MODE (designing / auditing / scoping) | Full protocol: Step 0 → tiered audit → design → pre-mortem → present |
| EXECUTING an approved plan | Dispatch + clarity rules; orch-builder builds, orch-checker verifies each step both directions; NO pre-mortem |
| AD-HOC (strong one-off prompt, no plan involved) | Dispatch + clarity + both-directions rules apply; mini Step 0 (only questions that block autonomy); no pre-mortem unless it grows into a plan — then switch to PLAN MODE |
| Finishing any plan | Auto-include an EXECUTION MODE RECOMMENDATION: should execution also run orchestrated? Judge on intricacy (multi-system? multi-session? live infra? money path?) |
| Subagent contradicts a doc, chart, or the user | Surface the contradiction and ask; never silently pick a side |
| Claim is cheap to probe live | Probe it; never plan or build on a doc's word alone |
| About to read a big directory yourself | Stop; dispatch orch-scout |
| Work is small, single-file, known | Skip this skill; orchestration overhead must earn itself |

## Plan Mode Protocol

**Step 0 — front-load the human.** Batch EVERY question needing user input, up front. The goal is always: run as autonomously as possible after Step 0. A question discovered mid-plan belonged in Step 0.

Then:
1. **Tiered audit** via agents, both-directions verification on anything live.
2. **Design** from verified findings only.
3. **Pre-mortem** — the orchestrator's OWN assessment, always the last step before the plan reaches the user (for comments or execution). You may dispatch orch-premortem for adversarial legwork and read-only re-probes, but the verdict and the fixes are the orchestrator's — never delegated away. Plan mode only. The full protocol lives in the `premortem` skill — reference it, don't duplicate it.
4. **Fix the plan** against findings; present, stating what the pre-mortem changed.

## Execution Protocol

Same dispatch, clarity, and contradiction rules. No pre-mortem. The builder never grades its own work — orch-checker independently runs each step's done-test, both directions, before the next step starts. Deviating from the approved plan is a contradiction to surface, not a silent call.

## Dispatch Rules

| Work | Agent | Tier |
|---|---|---|
| Finding files, listing what exists, pulling status, summarizing dirs, reading tracking docs, pulling published docs off the web | orch-scout | Sonnet high — the floor is Sonnet high, never Haiku |
| Non-trivial code reads, cross-system translation, PORT/WIRE verdicts | orch-reader | Opus high |
| Builds from an approved plan | orch-builder | Opus high |
| Done-test verification | orch-checker | Opus high |
| Adversarial review legwork | orch-premortem | Opus max |

PORT/WIRE labels must come from an agent that read the source, not a filename.

## Effort Rubric

Escalate a reader/builder/checker dispatch to MAX effort when 2+ signals apply:
- touches live infrastructure or a money/send path
- spans 3+ systems
- novel mechanism with no reference implementation
- failure would be silent rather than loud

Escalation route: run that dispatch through a Workflow script — the one place per-agent effort is settable at call time. The pinned agent effort is the default, not the ceiling. orch-premortem stays pinned max regardless (rare, plan-mode only, highest-leverage call in the system).

## Agent Prompts Are Starting Points

Each agent carries a base template; the orchestrator is expected to adapt, expand, and sharpen the dispatch prompt for the task at hand — launch pads, not scripts. Before every dispatch, double-check the prompt actually fits the task. Locked-in verbatim templates are themselves a red flag.

## Artifact Persistence

In Claude Code, create `output/orchestrator-mode/MM.DD.YY/` in the workspace; save every substantial subagent artifact there (findings MD, scripts, code chunks, captured payloads) so a new session can continue without re-running audits. Reference the folder in the plan/checkpoint.

## Both-Directions Rule

Every connection has two halves: the OUT leg (can I send?) and the BACK leg (does the response reach me?). A check that proves only the out leg glows green while the back leg is dead — that exact failure hid a dead tap-return path for 15 days in production. Any done-test on something live must run the round trip: message out AND reply in, write AND read back, card posted AND tap received. One-directional green is not green.

## Red Flags — Stop, You're Rationalizing

| Thought | Reality |
|---|---|
| "I'll just read it myself, quicker" | Context is the scarce resource. Delegate. |
| "The handoff already says its status" | Docs record the past. Probe the live thing. |
| "Filename says what it is — label it PORT" | Unread source = guess. Send orch-reader. |
| "Zero errors = healthy" | One-directional. Probe the back leg. |
| "The pre-mortem will just agree" | In production it found 4 plan-killers in a plan built from verified audits. |
| "I'll ask the user when I get there" | Plan-mode questions belong in Step 0, batched. |
| "The template covers it" | Templates are launch pads. Fit the prompt to the task. |
| "Sonnet can orchestrate this one" | Qualification gate: stop and notify. |

## Real-World Impact

08.02.26 REMI planning session: tracking docs claimed an inbound cutover was "a one-node repoint." Tiered audit + pre-mortem proved it was a build (the payload assembler lived in the system being retired), caught a repoint aimed at the wrong machine, a "unit install" that was actually a harness migration, and a send path with three defects and no token on the box. Solo reading would have inherited all four.
