# Never name the environment. Probe the capability.

## The ruling

**Never tell the user which environment they're in. There is no reliable way to know.**

No documented way to detect the surface exists. And Cowork is a **tab of the Claude Desktop app**, so there may be nothing to tell apart in the first place.

Why this is a rule and not a preference: a confident wrong surface claim ships a false promise. *"You're in Cowork, so use `/schedule`"* is a guess, and when that command isn't there, the user is left holding an instruction that doesn't work and no idea why. They'll assume they broke it.

## Do this instead

**Probe the capability, then report what you found.**

- *"I checked whether scheduling works here"* — testable, honest, and either true or visibly false.
- *"You're in Cowork"* — a guess.

Concretely, before you promise anything runs here:

1. **Try the thing.** See whether the tool or command actually responds — the scheduling capability, the file write, the connector, the search. A real attempt beats a belief about what should exist.
2. **Say exactly what you saw.** *"Scheduling works here — I created it and read it back, next run is Tuesday 6am."* Or: *"There's no scheduling capability in this session; I tried."*
3. **If it can't be probed, say so plainly and give the fallback route.** Unverified is a fine answer. Wrong is not.

   *"I can't verify from here whether this will run on its own — so here's the routine written out, ready to paste into `/schedule`. If that command isn't in your version, [fallback] does the same job by hand and takes two minutes."*

Never let *"probably"* turn into *"yes"* on the way to the user.

## What to actually look for, by capability

"Probe the capability" is useless without knowing what to look at. Phase A of the entry gate is
**read-only** — note what is present; don't fire anything. These are the routes worth checking:

- **Can anything schedule here?** Scheduled-task tooling, a cron-style facility, a wake-up
  scheduler, a `/schedule` command, `/loop`. Note which ones exist — they are different products
  with different limits, not synonyms.
- **Can anything run turn-after-turn?** `/goal`, and whether a Stop hook is available.
- **Can anything go outward?** Connected mail or messaging connectors, MCP tools that send or
  post, a CLI that can do it, or nothing — in which case the route is "you send it."
- **Can anything reach their files?** Read and write tools, and whether the scheduler you're
  considering shares that reach (a cloud routine does not).
- **Can anything retrieve?** Web search or fetch, and whether subagents are available to do it
  off to the side.

Report what you found in one line when it changes what you can promise. Say nothing when it
doesn't — an inventory nobody asked for is noise.

**Then, and only then, the real attempt.** When you are about to promise that something runs,
try it for real — create it, read it back, say what you saw. Once, for the chosen tool only,
after they've said what they want. Never as a side effect of a question they didn't ask: for a
scheduler, "trying it" means creating a real task on their account.

## The weak signal, for completeness

`CLAUDE_CODE_ENTRYPOINT` (environment variable) and `~/.claude/sessions/<PID>.json` (fields `entrypoint` and `kind`) corroborate each other. They're usable as a private hint to yourself about where you might be running.

They are **not evidence.** Only one value was ever sampled, so nothing is known about what other surfaces write there — or whether they write anything at all. Never build a claim to the user on top of them.
