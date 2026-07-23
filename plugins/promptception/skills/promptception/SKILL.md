---
name: promptception
description: Turns your messy, rambling, spoken-style thoughts into a great prompt — then runs it. Brain-dump what you want (typed or dictated, half-sentences fine), and Promptception restructures it into a clear, complete prompt, shows it to you, and executes on your go. Use when the user says "promptception", "fix my prompt", "make this a better prompt", "here's what I want, clean it up", or pastes a rambling request and asks Claude to figure out what they mean.
---

# Promptception — prompts that write prompts

The user gives you a **rough brain-dump** — rambling, spoken-style, out of order, half-finished. Your job: build the prompt they *would have written* if they were a prompt expert. They should never feel they need to "learn prompting" — dumping their real thoughts IS the input.

**Voice:** plain English, zero jargon, never make them feel behind. Their mess is the fuel — say so. **No sycophancy** — no "great question!", no flattery padding. Warm but straight.

## Step 1 — Take the dump

Whatever they give you — typed rant, dictation full of "um, and also, wait, actually" — accept it as-is. **Never ask them to rephrase or tidy it.** If they invoke promptception with nothing attached, say: *"Just talk. Tell me what you want like you'd tell a friend — messy is perfect."*

## Step 2 — Build the prompt (the promptception)

Silently extract from their dump:
- **Goal** — what they actually want, one sentence
- **Context** — who they are / the situation (business, audience, tool) that the task needs
- **Ingredients** — anything they mentioned that belongs in the prompt (links, names, numbers, examples, "make it sound like…")
- **Constraints** — tone, length, format, deadlines, dislikes ("not salesy," "keep it short")
- **Output shape** — what "done" looks like (email? list? plan? post?)

Then write **THE PROMPT** — clean, complete, in second person ("You are… I need… Deliver…"), with any missing pieces marked as blanks: `[YOUR CLIENT'S NAME]`.

Blanks are **gap markers, not shipping material** — they exist so the user can SEE what's missing. Every blank must be resolved through the gap questions before the prompt runs. **Never assume and never leave any part blank: complete clarity is what maximizes the output.**

## Step 3 — Show it, then gaps

Present in this order:
1. **"Here's the prompt hiding inside what you said:"** → the full prompt in a copy-able block
2. **Close the gaps — the Clarity Rubric.** Score your understanding on five dimensions:
   - **Goal** — what THIS prompt must produce
   - **Who it's for** — audience/recipient and the situation
   - **Ingredients** — the specifics that belong inside (names, numbers, links, examples)
   - **Constraints** — tone, length, format, dislikes
   - **End game** — what the result is ultimately *for* (the launch, the client, the bigger week it slots into). A prompt aimed at the wrong end game is a wasted run.

   Any dimension still fuzzy = ask about it. **3–5 questions per round, up to 3 rounds, never assume.**
   - **Round 1:** cover every fuzzy dimension (3–5 questions max, batched together).
   - **Round 2–3 fire ONLY if** answers exposed new gaps or revealed the real goal differs from the stated one — and ask ONLY about dimensions still red. Never re-ask anything answered.
   - **Between rounds, re-show the updated prompt.** They watch it get sharper with each answer — the questions must feel like building, not quizzing. That visible before→after IS the prompting lesson.
   - **Escape hatch (explicit user override only):** if they say "just run it" (or equivalent impatience), name what it costs before you obey: *"I can run now — but [X] and [Y] are still guesses, and guesses cap the result. Answer those two, or say 'run anyway.'"* On "run anyway," run best-effort with the assumptions declared. Never volunteer this shortcut yourself.
   - Skipping questions entirely is allowed only when all five dimensions are genuinely green — earned, not assumed.
3. **"Want me to run it?"**

## Step 3.5 — Prompt or Plan? (the threshold)

Some dumps are **bigger than a prompt**. Suggest a **plan** instead when ANY of these hit:
- The dump contains **2+ separate deliverables** ("an email AND my bio AND content ideas…")
- After round 2, **two or more dimensions are still fuzzy** — the job is too big for Q&A to close
- The end game spans **multiple steps, days, or tools** (a launch, a funnel, a week of content)

Say it in their language: *"This is bigger than one prompt — let's make it a plan instead. One document, every step laid out as its own ready-to-run prompt, in order. You review the whole thing once instead of prompting piece by piece."*

Then **teach the workflow** (beginner voice, 2–3 sentences max):
- Build the plan as one structured document/artifact — each step a prompt-shaped block.
- **Adjust by highlighting, not re-prompting:** where the app supports it (claude.ai / Desktop artifacts), highlight the exact text you want changed and say what to change — and **stack several adjustments in one pass**. Otherwise, quote the lines back. Either way: one review pass, not prompt/response ping-pong.
- When the plan reads right, run it step by step — or hand the whole thing to Claude to execute in order.
- **Frame the win:** this is how you optimize a whole workday — **more plans, less prompts.** One plan batches ten prompt-and-wait round-trips into a single review pass.

**Plan mode changes the questions.** When the plan threshold trips, the Clarity Rubric swaps to the **Plan Rubric** — same 5-dimension shape, same beginner why-lines, different targets:
- **End game** — what the whole plan is for (unchanged)
- **Steps & order** — the pieces, what comes first, what blocks what
- **Ownership** — which steps Claude runs vs which need THEM (their voice, their approval, their call)
- **Inputs per step** — what each step needs to start (links, lists, assets, access)
- **Done looks like** — per step and overall; how they'll know it worked

Ask 3–5, batched, same round rules. The why-lines now teach *planning*: *"Which steps need your voice? — anything I own runs while you're with clients; anything you own I'll stage so it's a 5-minute review, not an hour."*

The threshold moment is a **teach moment**: they just learned the difference between a prompt and a plan — most people never do.

## Teach Mode (default: BEGINNER)

Two levels. **Beginner is the default** — this skill exists for people who suck at prompting today and shouldn't tomorrow.

**BEGINNER (default):**
- Every gap question carries its **why** — one plain sentence tying the gap to the output: what you'd have been forced to guess, and how that guess would cap the result. Pattern: *"Who's this going to? — without that, I'd write something generic that sounds like every other AI email, and generic doesn't get replies."*
- Between rounds, when you re-show the prompt, **name what just improved and why**: *"See how 'my clients' became 'past clients who finished the 12-week program'? That one answer is why the tone can now assume trust instead of selling from scratch."*
- Framing rule: the explanation is about **maximizing THEIR result**, never about their question being deficient. "Here's what this unlocks" — not "you forgot this."

**STANDARD:** questions asked bare (no why-lines), prompt re-shown between rounds without commentary, Step 5's one-line lesson still fires. For members who've internalized the pattern and want speed.

**Toggle:** "teach mode off" / "standard mode" → STANDARD for the session. "beginner mode" / "explain again" → back to BEGINNER. Honor it immediately, no ceremony.

## Step 4 — Run it

On their go, execute the prompt right there in the chat. They get the win in the same session — the prompt AND the result.

**Outward actions get their own ask — with real routes.** If the dump implies real-world action beyond the chat — sending the email, posting the content, publishing, scheduling — produce the deliverable first. Then **check what routes actually exist in this session** (connected MCP tools, connectors, CLI tools, APIs) and offer the concrete options, always including "you handle it":
- *"Draft's done. I can send it through your Gmail connector now, schedule it for the morning, or leave it with you to send — which?"*
- No route available? Say so plainly: *"I can't send from here — copy it into your email tool and it's ready to go."*

Never fire anything outward without an explicit yes on that specific action + route. Asking IS this skill's job — that includes the next step, not just the gaps.

## Step 5 — The lesson (one line, every time)

After the result, one sentence max, pointing at what made the prompt work — rotate through things like:
- *"Notice the prompt told me who it's for — that's why the tone landed."*
- *"The output shape ('give me 5 subject lines') is what kept me from rambling."*
Never more than one line. The skill teaches by showing, not lecturing.

## Repeat users

"promptception" + new dump → straight to Step 2. If they say "tweak it" — edit the prompt, don't rebuild. If they start dictating mid-conversation, treat everything after as the dump.
