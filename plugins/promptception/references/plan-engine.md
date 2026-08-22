# The plan engine — two tiers, one engine

Some jobs are bigger than a prompt. When that happens, the answer is a **plan**: one document, every step laid out as its own ready-to-run block, in order. They review the whole thing once instead of prompting piece by piece.

Two skills call this file, and they share everything in the SHARED section:

- **Light tier** — promptception's Step 3.5. The plan happens right there in the chat.
- **Heavy tier** — the plan-builder skill. The same plan, built and run with the orchestrator crew. Offer it in plain words, never as a slash command.

Both tiers ask questions the same way: `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`. Both run `${CLAUDE_PLUGIN_ROOT}/references/fitness-gate.md` before shaping anything.

---

## SHARED — both tiers

### The threshold: when it's a plan, not a prompt

Suggest a plan when **any** of these hit:

- The dump contains **2+ separate deliverables** ("an email AND my bio AND content ideas…")
- After round 2, **two or more dimensions are still fuzzy** — the job is too big for Q&A to close
- The end game spans **multiple steps, days, or tools** (a launch, a funnel, a week of content)

Say it in their language:

*"This is bigger than one prompt — let's make it a plan instead. One document, every step laid out as its own ready-to-run prompt, in order. You review the whole thing once instead of prompting piece by piece."*

The threshold moment is a **teach moment**: they just learned the difference between a prompt and a plan. Most people never do.

**Keep the teaching short — beginner voice, 2-3 sentences maximum, once.** The point is that they feel the difference, not that they receive a lecture about it.

### The Plan Rubric

When the threshold trips, the questions change. Same five-dimension shape as the Clarity Rubric, same beginner why-lines, different targets:

- **End game** — what the whole plan is for
- **Steps & order** — the pieces, what comes first, what blocks what
- **Ownership** — which steps Claude runs vs which need THEM (their voice, their approval, their call)
- **Inputs per step** — what each step needs to start (links, lists, assets, access)
- **Done looks like** — per step and overall; how they'll know it worked

Ask 3–5, batched, same round rules. The why-lines now teach *planning*:

*"Which steps need your voice? — anything I own runs while you're with clients; anything you own I'll stage so it's a 5-minute review, not an hour."*

### One review pass — adjust by highlighting

The plan is built as **one structured document**, each step a prompt-shaped block.

- **Adjust by highlighting, not re-prompting.** Where the app supports it (claude.ai / Desktop artifacts), they highlight the exact text they want changed and say what to change — and **stack several adjustments into one pass**. Where it doesn't, they quote the lines back. Either way: one review pass, not prompt/response ping-pong.
- When the plan reads right, they run it step by step — or hand the whole thing over to be executed in order.

### Frame the win: more plans, less prompts

This is how a whole workday gets optimized. **One plan batches ten prompt-and-wait round-trips into a single review pass.** Say it once, in one line, and move on.

---

## LIGHT TIER ONLY — promptception Step 3.5

- Stays **in the chat.** No agents dispatched, no crew, no premortem.
- The plan is one artifact the user reads in the conversation they're already in.
- Execution is theirs: run it step by step, or hand it back to be executed in order.
- **Escalate to the heavy tier** — in plain words, never as a slash command — when the job outgrows the chat — the same intricacy bar orchestrator-mode uses: **2 or more of** multi-system, multi-session, live infrastructure, a money or send path. Below that bar, don't pitch it; the chat plan is the right size and switching tools costs them time for nothing.

  *"This one's big enough that I'd rather build it properly — I'd research it first, stress-tests the plan for what could go wrong, then runs it with a checker on the back end. Want that, or is the version we've got here enough?"*

---

## HEAVY TIER ONLY — the plan-builder skill

Everything in SHARED, plus orchestration layered on top. Nothing in SHARED gets restated in that skill — it calls this file.

- **Plans in orchestrator mode:** tiered audit → design → **premortem** before the plan is shown. The reading is done by dispatched agents so the user's chat stays lean.
- **Agents read; they never ask.** Any open question an agent hits comes back as a report and the main session asks it. See `asking-questions.md`.
- **The review gate lives inside the skill's own flow.** Where a real plan-mode tool responds, use it ... it enforces the pause instead of promising it. Where it doesn't (some surfaces have no design-before-acting phase at all ... probe, never name the surface), the skill presents the plan and waits, itself.
- **Executes in orchestrator mode:** builder/checker, both-directions verification.
- **A human is present for the planning half.** Only execution can ever run unattended, and unattended execution runs orchestrator **execution mode**, never plan mode — no premortem, no batched questions, deviations reported rather than decided.
