# promptception

Prompts that write prompts. You talk or type messy, and it hands you a clear, complete prompt... then runs it.

## What it does
You brain-dump what you want, out loud or in half-sentences ... *"okay I need an email to my clients about the new program, not salesy, mention the July thing"* ... and Promptception builds the prompt you would have written if you were a prompt expert, shows it to you, asks only the questions that close real gaps, and executes on your go. You get the result AND you absorb what good prompts look like, without studying anything. Rambling is the input. That's the point.

## Use
Start any message with **"promptception:"** and just talk, or run `/promptception`.
- **Dictate it.** Use voice typing and ramble. Messy beats tidy.
- Say **"tweak it"** to adjust the prompt before it runs.
- **Bigger than one prompt?** If your dump is really several jobs (a launch, a week of content), it offers to build a **plan** instead ... every step laid out, adjusted by highlighting the text you want changed. One review pass, no ping-pong.
- Every question comes with the *why*, so the prompting lesson is built into the ask. Say **"standard mode"** to skip the explanations; **"beginner mode"** brings them back.

## Orchestrator Mode (new in 0.2.0)
For the big stuff ... audits, migrations, cross-system builds, multi-session plans ... run `/orchestrator-mode` or just say "go orchestrator". Instead of reading everything itself (and filling up its own head), Claude leads a crew of five specialist subagents: a scout that finds and lists, a reader that actually reads the code before calling anything done, a builder that executes the approved plan, a checker that independently verifies every step in both directions, and a premortem reviewer that assumes the plan already failed and works backwards to find why. Nothing gets built on a doc's word alone ... claims get probed live.

`/premortem` also works standalone: hand it any draft plan and it hunts for what breaks before you ship it. Say "poke holes", "what breaks", or "red-team this".

## The builders
Claude Code has three newer commands most people never use well: `/goal` (keeps working turn after turn on its own until a condition you set is actually true), `/loop` (check or do something over and over on a timer), and `/schedule` (make it happen on a clock while you sleep). Each has its own builder that works exactly like Promptception ... brain-dump what you want, it builds the expert version, asks only the questions that close real gaps, and hands you the finished thing.

- `/goal-builder` ... turns "work on my emails" into a finish line the engine can actually settle. The catch it saves you from: the model that judges your goal reads only the conversation, so if the proof never lands in the chat, the work is never done as far as it is concerned.
- `/loop-builder` ... builds a loop that knows what to watch, what to do, and ... the part everyone forgets ... when to STOP.
- `/schedule-builder` ... writes routines that survive running at 6am with nobody watching, then creates the schedule for you on your go.

There is a fourth builder for the jobs none of those fit:

- `/plan-builder` ... for work too big for a single prompt. It researches first, stress-tests the plan for what could go wrong before you ever see it, then runs it with a builder and an independent checker.

Each one also tells you when the job is big enough to run in Orchestrator Mode instead.

## What's a skill?
A set of instructions Claude loads automatically when you need it. Install once, then Claude just knows how to do the thing... no prompts to memorize. This is how you stop prompting and start building systems.

## License
MIT ... see [LICENSE](LICENSE).
