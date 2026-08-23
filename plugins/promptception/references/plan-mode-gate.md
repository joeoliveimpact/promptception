# The plan-mode gate, and who has to be in the room

Two things the plan-builder skill points at from one line each: how a real plan mode holds the
review gate when the session has one, and which half of this work needs a person in the room.

## Plan mode, where the session has one

### Step 0 - ask for it, once

Phase A's preflight is read-only, so it can see whether an `EnterPlanMode` capability responds
here without firing anything. **Where it does, one more question joins the Step 0 ask** (house
rules: `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`, popup first, the same question as
plain text where the popup isn't available):

> *"I can put this behind plan mode ... I'll research and draft first, then lock myself
> read-only the moment the plan is ready, so nothing can get built until you approve it.
> Want that?"*

**Their consent is the tool's own requirement, not a courtesy.** Entering plan mode takes their
yes; the popup is simply how that yes gets asked for. Never enter it silently, and never treat
enthusiasm about the project as the answer to this question.

**Probe the capability, never name the surface.** *"I checked whether plan mode is available
here"* is testable and either true or visibly false. *"You're in [app], so..."* is a guess
(`${CLAUDE_PLUGIN_ROOT}/references/capability-probe.md`).

### Where they say yes, the plan document IS the harness plan file

In plan mode the harness designates a plan file, and it is the one file the session can write.
**That is the design, not a limitation to route around: write the plan there.** It is the same
one document, every step its own ready-to-run block, that the engine file describes.

Steps 1 to 5 run before the call, so the crew's findings and working artifacts land in
`output/orchestrator-mode/` as normal. From the call onward the session is read-only apart from
the plan file, so anything still unwritten waits and arrives during execution. Nothing is lost,
it just arrives on the far side of the gate.

### Step 6 - enter, write, exit

**This is where `EnterPlanMode` actually gets called.** Their yes at Step 0 changes nothing on
its own; the tool is what changes the mode. A pass that collected a yes and never fired the tool
has been describing a mode it never entered.

1. **Call `EnterPlanMode`.** The harness answers by designating the plan file.
2. **Write the finished plan into that designated file.** It does not exist before the call,
   which is exactly why the call cannot come earlier.
3. **Call `ExitPlanMode`.** It presents the plan and requires their approval before anything can
   run. That is exactly the pause Step 6 exists to create, enforced by the tool instead of by
   prose, so don't stack a hand-rolled pause on top of it.

**Never call `EnterPlanMode` before Step 6.** Everything Steps 1 to 5 produce ... the silent
skeleton, the crew's findings, the premortem ... is written while the session can still write
anywhere, and entering early costs the skill the ability to write its own working artifacts.

**Where the tool is absent, the skill's own pause IS the gate, and it isn't optional.** Some
surfaces have no design-before-acting phase at all, so a gate handed to one may simply not exist,
and the plan runs unreviewed. Present, ask, wait for a yes.

### Where nobody can answer

Consent cannot arrive in a headless or unattended run, so plan mode isn't available to one.
**Fall through to the skill's own pause and never block** waiting for an answer that cannot come.
A planning run that stalls on a consent popup nobody will ever see is a run that did nothing, and
nobody finds out until they check.

## Who has to be in the room

**Planning needs them. Execution doesn't have to.**

The planning half batches questions, runs a premortem, and waits at a review gate. All three of those need a person. The execution half needs nobody: it has an approved plan, a builder and a checker, and anything it can't decide it reports instead of guessing.

What that means for them: once a plan is approved here, the execution half can be handed to a scheduled routine and run while the laptop is shut. That routine runs orchestrator **execution mode** — never plan mode. No premortem, no batched questions, and any deviation gets written into the run report rather than settled alone. **This is the B3 moment** — don't promise the unattended run until you've tried it for real: create it, read it back, say what you saw. Once, for the chosen scheduler only (`${CLAUDE_PLUGIN_ROOT}/references/entry-gate.md`, B3; routes in `${CLAUDE_PLUGIN_ROOT}/references/capability-probe.md`). Keep outward actions draft-first.
