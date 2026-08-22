# Loop mechanics — what you're shaping around

You need these to shape a loop that actually works and to brief them at handoff. Give them in
their language, only the parts that touch their loop. **Never dump this file at them.**

### The three shapes

- **`/loop 5m check if the deploy finished`** — fixed timer. Units are `s` seconds, `m` minutes, `h` hours, `d` days. The interval can lead as a bare token (`5m`) or trail as words ("every 2 hours").
- **`/loop check whether the client replied`** — no interval, so Claude picks the wait itself after each pass, somewhere between one minute and one hour, and prints why it picked that. Good when the pace is unpredictable: short waits while something's live, longer waits when it's quiet.
- **`/loop` on its own** — runs a built-in maintenance prompt (pick up unfinished work, tend the current pull request, tidy up when nothing else is pending). If a `.claude/loop.md` file exists in the project, or `~/.claude/loop.md` for every project, that file's instructions replace the built-in one — the project file wins when both exist. Keep it short: anything past 25,000 bytes gets cut off.

**The interval is a floor, not a metronome.** Seconds round up to a whole minute, and odd intervals like `7m` or `90m` get rounded to the nearest step the timer can actually hold — Claude says which one it picked, so if they ask for 90m and see something else confirmed back, nothing is broken. On top of that, each wait runs *at least* as long as asked and then lands on the next whole minute: a 60-second interval was observed reporting a 72-second wait and firing on the clean minute boundary. Every cycle runs a little longer than requested. Tell a long-running owner this at handoff — over hundreds of ticks the cadence drifts later, and someone who expected a metronome will think it's broken.

### A loop can run a whole skill

`/loop 20m /review-pr 1234` re-runs that skill every 20 minutes. Worth offering whenever they already have a skill that does the per-tick job — the loop becomes one clean line instead of a paragraph of instructions.

**The silent failure to warn about:** a scheduled fire only runs skills Claude is allowed to invoke on its own. These arrive as **plain text instead of executing** — nothing errors, nothing happens, the tick just quietly does nothing:

- built-in commands such as `/permissions`, `/model`, `/clear`
- skills marked `disable-model-invocation: true` (including the bundled `/verify`)
- skills held back by a `skillOverrides` setting or a skill deny rule
- MCP prompts such as `/mcp__github__list_prs`

If their per-tick action is one of those, say so before they run it, not after a day of nothing.

### The timing is loose on purpose

Recurring tasks fire **up to 30 minutes after** the scheduled time — or up to half the interval for anything running more often than hourly. It's deliberate spreading so every session doesn't hit at the same instant. One-shots set for :00 or :30 can fire **up to 90 seconds early**. Tell them this at handoff: someone who doesn't know it watches the clock tick past, decides the loop is broken, and kills a loop that was working.

**Self-paced loops are the exception.** A loop with no interval schedules its own next wakeup, so the lateness rules don't apply to it at all — only the seven-day expiry does. Don't hand a self-paced owner the "up to 30 minutes late" line; it isn't true for them.

### It ends itself after seven days

Recurring tasks **expire 7 days after they're created** — one final fire, then the task deletes itself. A forgotten loop is bounded, not eternal. If they need it running longer than a week, they either re-create it before it expires or move to real scheduling — offer it in plain words (*"want me to build this as a schedule instead?"*), never as a slash command.

### It only runs while the app is open and idle

- Fires only while Claude Code is **running and idle**. Closing the terminal or letting the session exit stops it — with one carve-out: **backgrounding the session** carries `/loop` tasks over to a background session, which keeps running without a terminal. Backgrounding is not the same as the machine being off, so "while my laptop is shut" is still a no.
- Fires **between turns**, never mid-response. Busy means the fire waits for the current turn to end.
- **No catch-up.** Miss six fires while something long is running and they get one when things go idle, not six.
- Starting a **fresh conversation clears** every scheduled task. Resuming with `--resume` or `--continue` restores the ones that haven't expired.

### Stopping it

- **Esc while it's waiting** clears the **pending wakeup** of a `/loop` task. Whether that kills the loop depends on the flavor: a self-paced loop is done, but a **cron-backed fixed-interval loop still has its cron entry and fires again** ... killing that one means deleting the entry (off-switch table below). Esc only reaches `/loop` tasks — anything they scheduled by just asking Claude in plain English is untouched by it and stays in place until they delete it.
- In self-paced mode (no interval), Claude can end the loop itself once the job is genuinely done.
- If an iteration ends without either scheduling the next one or stopping, one fallback wakeup fires about **20 minutes later**, and then the loop ends.
- A fixed-interval loop keeps going until it's stopped or the seven days are up.

### Three flavors, three different off-switches

**This is the one that generates support tickets.** How a loop is stopped depends on how it was
built, and using the wrong switch leaves it firing while the user believes it's dead:

| What got built | How it stops |
|---|---|
| Self-paced / dynamic loop | the wake-up scheduler's own stop call |
| Fixed-interval loop backed by cron | **deleting the cron entry** — it survives the stop call above |
| An armed monitor | **stopping the task** |

Never hand back a generic "you can stop it later." Name the switch for the flavor you just
built, in the same message you hand them the loop. A loop they can't turn off runs unattended,
on a clock, doing the wrong thing on a schedule.

### Limits and off-switches

- **50 scheduled tasks per session.** Hard cap.
- **All times are local.** `0 9 * * *` means 9am where they are, not UTC.
- If `CLAUDE_CODE_DISABLE_CRON=1` is set in their environment, the scheduler is off entirely — `/loop` and the scheduling tools are unavailable, and nothing already scheduled fires. Worth checking when a loop "won't start" for no visible reason.

### Company-cloud setups behave differently

On Amazon Bedrock, Claude Platform on AWS, Google Cloud's Agent Platform, or Microsoft Foundry, two things change: a `/loop` with **no interval** runs on a fixed **10-minute** schedule instead of pacing itself, and a **bare `/loop`** prints a usage message instead of running the maintenance prompt. If their loop behaves that way, this is why — it isn't broken.

### One-time reminders aren't loops

*"Remind me at 3pm to push the release branch."* *"In 45 minutes, check whether the tests passed."* Plain English, no command needed — Claude schedules a single fire that deletes itself afterwards. If their dump is really a one-time nudge, hand them that sentence instead of building a loop.

**Say how to cancel one, because it isn't Esc.** Tasks scheduled by asking Claude directly are not affected by Esc; they stay put until they're deleted. Tell them to ask Claude to delete it by name.

## Sources

Doc-sourced, retrieved **08.17.26**:

- `/loop`, the three shapes, timing, expiry, limits, the comparison table —
  <https://code.claude.com/docs/en/scheduled-tasks>
- company-cloud behavior and skill-invocation rules — same page plus
  <https://code.claude.com/docs/en/agent-sdk/slash-commands>

**Observed, not documented — 08.20.26.** Two facts here come from a live run, not from Anthropic:

- **The interval is a floor and fires land on whole minutes.** A 60-second interval reported a
  72-second wait and fired on the next clean minute boundary. Observed once, in one session.
- **The three off-switches.** Which stop call actually ends a loop depends on how it was built.
  Observed in the same run.

Both are marked as observation deliberately. Treat them as real behavior worth warning users
about, and as unconfirmed by any vendor page — do not cite them as documented.

**If a user reports different behavior, they are right.** Re-check the page and correct this file.
