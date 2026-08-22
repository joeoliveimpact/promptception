# Asking questions — the house rule

Every skill in this plugin asks the user things. This file is the whole rule for how. Any skill can say *"follow `${CLAUDE_PLUGIN_ROOT}/references/asking-questions.md`"* and needs no further detail.

## Use the AskUserQuestion tool whenever it's available

**Default: fire the AskUserQuestion tool.** Questions pop up on screen as options they click, instead of arriving as a wall of text they have to read, parse, and answer in order. That is the normal way this plugin asks — not an enhancement, not a bonus.

Cowork has its own version of the same thing: an inline card for multiple-choice questions where you pick an option, step through each question, and your choices go back as a single reply. So the popup path is real there too.

## When the tool isn't there, ask in text. Same questions.

**Never hard-require it.** A skill that breaks when AskUserQuestion is missing is a broken skill on that surface. Attempt the popup; if it isn't available, ask the same questions as a short numbered list.

Same questions, same wording, same why-lines, same round rules. Only the delivery changes.

## Round rules (identical on both paths)

**The popup carries at most 4 questions per call.** That is the tool's own limit, not a style choice ... a round needing more than 4 becomes consecutive batches of up to 4.

- **3–5 questions per round.** More than five is an interrogation.
- **Up to 3 rounds.** Round 1 covers every fuzzy dimension. Rounds 2 and 3 fire only if the answers opened new gaps, and ask only about what's still fuzzy.
- **Batched, never scattered.** Ask them together, in one round. Never drip one question per turn.
- **Never re-ask something already answered.**
- **Re-show the improved artifact between rounds** — the prompt, the routine, the goal, the plan, whatever this skill is building. They watch it get sharper with each answer. That visible before → after IS the lesson.
- **One question per real ambiguity.** If the answer wouldn't change what gets built, don't ask it.

## Beginner teach mode: the why rides in the option description

Beginner is the default. In beginner mode every question carries its **why** — one plain sentence tying the gap to the result.

In a popup, that sentence goes in the **option's description**, not in a separate line of chat. The description is where a popup carries explanation, so use it. Each option should say what choosing it means for their result:

*Question: "Who's this email going to?"*
- *Past clients* — *I can assume they already trust you, so it opens warm instead of selling from scratch.*
- *Cold leads* — *I'll spend the first two lines earning attention; the email runs longer but stops reading like spam.*
- *Both, one email* — *I'll aim at the middle, which is safe but softer than either version aimed properly.*

In the text fallback, that same why becomes the one-line gloss under the question. Nothing is lost.

Framing rule on both paths: the explanation is about maximizing **their** result, never about their question being deficient. *"Here's what this unlocks"* — not *"you forgot this."*

## Three places a question can land — and only one of them can pop

Before you ask anything, know which one you're in:

| Where you are | How the question gets asked |
|---|---|
| **Main session** | Fire AskUserQuestion. This is the default and it is not optional. |
| **Dispatched subagent** | You cannot ask. Return the open question; the main session asks it. |
| **Headless / unattended** (`claude -p`, a scheduled run, a loop tick) | Nobody is there. The popup cannot fire and text will not be read. |

**The headless branch needs a decision written into the skill, not a question.** Every ask must
have a documented not-asked path: either proceed on a stated default and say in the output which
default you took and why, or stop and report exactly what you needed. Never block silently
waiting for an answer that cannot arrive — an unattended run that stalls on a question is a run
that did nothing, and nobody finds out until they check.

## Questions stay in the main session. Always.

**A dispatched subagent generally CANNOT ask the user anything.** Tool availability follows the agent's role, not the environment — this was demonstrated directly: a session exported `CLAUDE_CODE_ENABLE_ASK_USER_QUESTION_TOOL=true` while the subagent it dispatched had no AskUserQuestion tool at all. That is measured behavior, not a preference.

So:

- Dispatch agents to **read, search, and gather.** That's what keeps the user's chat lean and the token spend down.
- An agent that hits something needing a human decision **returns and reports the open question.** The parent session asks it.
- **Never design a flow where a subagent tries to prompt the user.** It won't get an answer — it will stall, or guess, and the interview silently breaks.

Rule of thumb when writing a dispatch: if the instructions to the agent contain the words *"ask the user"*, they're wrong. Have it report the open question instead.
