# Changelog: promptception

Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.3.1] - 2026-08-22

### Added
- **`commands/` directory** ... seven thin routers (/promptception plus the six builders and review skills) so every command the README names exists as a real file. On the Claude Code CLI, bare names already resolve to the namespaced skills; the routers cover surfaces where a command registers and shadows a same-named skill, and each routes straight back to its skill.
- **plan-builder: the review gate is now enforced, not promised**, where the session has a real plan-mode tool. Consent is asked once, up front, in plain language; the finished plan is presented through the plan-approval gate; where the tool is absent the skill's own pause remains, unchanged. Mechanics live in `references/plan-mode-gate.md`.
- **plan-builder: the silent skeleton draft is back as the question generator.** A skeleton plan is drafted silently first ... steps, ownership guesses, blanks ... and its blanks generate the interview, so you are only ever asked what the draft proved it needed.
- **plan-builder: no question cap for plans.** Batches of up to four, as many rounds as the blanks demand; eight to ten questions is normal for a real plan. The crew engages automatically the moment the last blank resolves, and execution always runs with a builder and an independent checker.

### Fixed
- **The permission-mode claim was too flat.** Claude can move a session to a MORE restrictive mode itself, with your consent (verified live); only loosening still needs your own controls. goal-mechanics now says exactly that.
- **loop-builder's capability probe could arm a real recurring task without your go.** Now: read-only inventory first, create-and-read-back only after an explicit yes, and anything created for the probe is deleted the moment it has been read back.
- **loop-builder's rubric leads with Repeat safety**, with the reason stated: it is the dimension that decides whether the loop is safe to exist.
- **loop-mechanics contradicted itself on Esc.** Now precise: Esc clears the pending wakeup; a self-paced loop is done, a cron-backed fixed-interval loop fires again until its entry is deleted.
- **The ownership question was asked twice** when promptception escalated into plan-builder. The escalation carve-out now covers it.
- **promptception's teach explanation existed nowhere.** When teaching is on, it now explains itself in two sentences.
- **The entry gate hard-required the question popup**, which the asking rules forbid. Popup-first, plain-text fallback.
- **Headless runs had no instructed behavior at an ask.** Every builder now carries the not-asked path: take the stated default and say so, or stop and name what was missing. Never block.

## [0.3.0] - 2026-08-21

### Added
- **`/plan-builder`** ... the heavy tier of the plan engine, for jobs too big for one prompt and sometimes too big for one chat. Researches first, stress-tests the plan before you see it, then runs it with a builder and an independent checker.
- **Shared entry gate** (`references/entry-gate.md`) ... one routine every builder runs, in two phases. Phase A before your brain-dump: a read-only look at what this session actually has, then the teach decision. Phase B after it: the right-door check, the ownership question, and later the confirming probe. Two phases because half those checks cannot be judged until you have said what you want.
- **Mastery layer** (`references/mastery.md`) ... a closing debrief covering what was built and why those choices beat the alternatives, reasoning stated at real decision points, one next-level suggestion you did not ask for, and progressive ownership where a repeat user drafts first and gets coached. Nothing to switch on, nothing stored.
- **Per-tool reference files** ... `goal-mechanics.md`, `loop-mechanics.md`, `schedule-mechanics.md`, each with a dated sources block naming the page every fact came from. Facts observed in live runs rather than documented are labeled as observation.
- **Off-switch rule** ... every builder that creates something which runs later hands back the specific way to stop it. Loops have three flavors with three different switches, and stopping the wrong way leaves one firing while you believe it is dead.

### Fixed
- **Teaching was forced on a `verbosity: standard` workspace.** The old skip rule needed a session toggle AND a non-beginner workspace, so a plain standard workspace matched neither branch and got beginner explanations anyway. Now a true partition: only the exact value `standard` turns teaching off, and anything unclear, including an unreadable file, means on.
- **Dead escape hatch.** The builders told you to type `/schedule-builder` when a tool was missing, firing exactly when you were already stuck. The plugin has no commands directory at any version and its skills surface namespaced, so sibling skills are now offered in plain language.
- **`/plan-builder` contradicted itself** about whether a direct invocation starts at Step 0 or Step 1.
- **The capability probe named no routes to try.** It now lists what to look for per capability, and stays read-only until a promise is actually made ... probing a scheduler by trying it creates a real task on your account.
- **Loop timing was understated.** The interval is a floor, not a metronome: a 60 second interval was observed reporting 72 seconds and firing on the next whole minute, so cadence drifts later over a long run. The lateness rule now carries its sub-hourly qualifier, which matters because the template loop is 20 minutes.

### Changed
- The four builders shrank as their shared routine moved out, and all now sit inside the house length standard.
- `/goal-builder` no longer risks setting a live goal during the interview. The confirming probe is deferred to delivery, where a zero-risk availability check does the job instead.

## [0.2.0] - 2026-08-02

### Added
- **Orchestrator Mode** (`/orchestrator-mode`): runs big cross-system work (audits, migrations, multi-session plans) through a tiered subagent crew instead of solo reading. Qualification gate (Opus-class/Fable lead required), Step-0 batched questions, tiered audit, both-directions verification on anything live, plan-mode premortem, execution-mode recommendation, artifact persistence to `output/orchestrator-mode/MM.DD.YY/`.
- **Premortem** (`/premortem`): standalone red-team pass on any completed draft plan, prompt, or spec ... assumes it failed six weeks out and works backwards. KILLER/MAJOR/MINOR findings with evidence and fixes; single source of truth for the protocol referenced by orchestrator-mode.
- **5 agents**: `orch-scout` (Sonnet retrieval), `orch-reader` (Opus code reads + PORT/WIRE verdicts), `orch-builder` (Opus plan execution), `orch-checker` (Opus independent done-tests, read-only), `orch-premortem` (Opus max-effort adversarial review). All carry the clarity contract: never fill a gap with a guess, always report a COULD-NOT-DETERMINE section.
- **Trigger hook**: UserPromptSubmit hook that spots orchestrator/premortem trigger phrases in a prompt and reminds Claude to invoke the matching skill.
- **Three command builders** for Claude Code's newest stock commands, each running the promptception method (brain-dump in, expert prompt out, gap questions with the why attached, beginner teach-mode default): `/goal-builder` (outcome + done-test + scope edges, paste-ready `/goal` line), `/loop-builder` (watch target, per-tick action, stop condition, repeat safety, interval ... paste-ready `/loop` line), `/schedule-builder` (self-contained unattended routines with snag behavior and draft-first outward actions ... creates the schedule on explicit go). Each ends with an orchestrator-mode recommendation when the job clears the intricacy bar. Each opens with a Step-0 teach check: in beginner teach mode (or when the workspace's `.claude/workspace.yml` has `verbosity: beginner`), the skill first explains what the command IS in plain English with a "what this means for you" line before taking the dump.

## [0.1.0] - 2026-07-06

### Added
- Initial release. One skill (`/promptception`) that turns a messy, spoken-style brain-dump into a clear, complete prompt, shows the prompt it built, closes real gaps with 3 to 5 targeted questions (up to 3 rounds, never assume), runs it, and ends with a one-line lesson. Beginner teach-mode is the default (every question carries its "why"); "standard mode" drops the explanations for speed. Detects when an ask is bigger than one prompt and offers to build a step-by-step plan instead. Any outward action (send, post, publish, schedule) gets an explicit ask with the real routes available in the session.
