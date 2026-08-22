# Promptception

Prompts that write prompts. You talk or type messy, and it hands you a clear, complete prompt... then runs it.

A free Claude skill by [Joe Olive / Engine For Impact](https://engineforimpact.com).

## Install (about 2 minutes)

1. Open Claude (desktop app or claude.com). In the message box, click the **+** button → **Plugins** → **Manage plugins**.
2. Top right of that window, click **Add** → **Add marketplace**.
3. Paste this in and hit **Sync**:
   ```
   joeoliveimpact/promptception
   ```
4. Find **Promptception** in the list and click **Install**. (Claude will warn you it's a third-party plugin... that's just because it's mine and not Anthropic's. You're good.)
5. Start a new chat, type `/promptception`, and just talk. Messy is perfect... that's the whole point.

Because you installed it as a plugin, it updates itself whenever it improves. Nothing to re-download.

*Nothing happening when you type /promptception? Go to Settings → Capabilities and make sure "Code execution and file creation" is turned on, restart the app, then try again.*

## What it does

You brain-dump what you want, out loud or in half-sentences ... *"okay I need an email to my clients about the new program, not salesy, mention the July thing"* ... and Promptception builds the prompt you would have written if you were a prompt expert, shows it to you, asks only the questions that close real gaps, and executes on your go. You get the result AND you absorb what good prompts look like, without studying anything. Rambling is the input. That's the point.

## Use

Start any message with **"promptception:"** and just talk, or run `/promptception`.
- **Dictate it.** Use voice typing and ramble. Messy beats tidy.
- Say **"tweak it"** to adjust the prompt before it runs.
- **Bigger than one prompt?** If your dump is really several jobs (a launch, a week of content), it offers to build a **plan** instead ... every step laid out, adjusted by highlighting the text you want changed. One review pass, no ping-pong.
- Every question comes with the *why*, so the prompting lesson is built into the ask. Say **"standard mode"** to skip the explanations; **"beginner mode"** brings them back.

## Also inside (new since 0.1.0)

The plugin has grown well past one skill. Same install, no extra steps:

- **Four builders** for Claude Code's newest commands ... `/goal-builder` (a finish line the engine can actually settle), `/loop-builder` (watch, act, and know when to STOP), `/schedule-builder` (routines that survive 6am with nobody watching), and `/plan-builder` (jobs too big for one prompt: researched first, stress-tested before you see it, then run with a builder and an independent checker).
- **Orchestrator Mode** ... big cross-system work runs through a crew of specialist subagents, and nothing gets built on an unverified claim.
- **Premortem** ... hand it any draft plan and it assumes the plan already failed, then works backwards to find why, before you ship.

Each builder teaches as it works, and every one tells you when your job is really a different tool's job before it builds anything.

## Want more like this?

Join the free community — **[Mastering Claude for Coaches](https://www.skool.com/mastering-claude-for-coaches/about)** — where tools like this drop first.

## License

MIT ... see [LICENSE](plugins/promptception/LICENSE).
