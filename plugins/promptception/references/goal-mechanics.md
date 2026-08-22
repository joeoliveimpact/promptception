# `/goal` mechanics — what you're shaping around

The engine's real behavior: whether it's available, what permission mode it needs, how the user
drives it, and how it ends. Read this before you deliver or hand over. Give them only the parts
that touch their goal, in their language. **Never dump this file at them.**

## Availability and permission mode

**Check it's there first, with a zero-risk probe.** Have them paste `/goal` on its own. Bare `/goal` only reports status — it starts nothing. If it answers with a status (something like `No goal set`), the engine is live here. Probe the capability; never announce which app they're in — `${CLAUDE_PLUGIN_ROOT}/references/capability-probe.md`.

**Then get the permission mode right, before they paste the real line** — because setting a goal **starts a turn immediately**. There's no second prompt to hit; the engine is running the moment they press enter.

- **`/goal` does not change permission mode.** It removes the per-turn prompts, not the per-tool ones. For unattended turns they want **auto mode**, which removes the per-tool approvals — the two are designed to pair.
- On Pro, Max and Team plans, **auto is often already the default** — but only in a terminal or the VS Code extension, and only on Claude Code v2.1.228+ on macOS/Linux/WSL, or **v2.1.233+ on native Windows**. Earlier versions start in Manual, so have them look at the mode indicator rather than assume it's handled.
- **Headless runs start in Manual.** `claude -p` and the Agent SDK ignore that plan default, so that auto default never covers an unattended run — the mode has to be set when the run starts (`--permission-mode`).
- **Claude can tighten the permission mode itself, but never loosen it.** Verified live: a session moved itself into plan mode (a more restrictive mode) with the user's consent. No tool grants a looser mode ... that half is inferred from tool absence, not tested ... which is exactly why auto mode has to come from the user's own controls. Hand them that plainly instead of promising to flip it for them.

### When bare `/goal` isn't recognized

That's an availability answer, not a mystery. `/goal` runs on the same trust machinery as hooks,
so it needs the workspace to be trusted, and it is switched off entirely when `disableAllHooks`
is on or when `allowManagedHooksOnly` is set in managed settings — a work laptop with locked-down
settings is the usual cause. The command explains why rather than failing silently, so read what
it says back. Anthropic's docs say `/goal` works in the desktop app, in headless `claude -p` runs
and in Remote Control; the probe is what tells you it works *here*.

### The headless gotcha, worth saying out loud

`claude -p "/goal ..."` runs the whole loop in one go and, by default, **prints nothing until the
run finishes** — it looks frozen for as long as the work takes. `--output-format stream-json
--verbose` shows it happening. `Ctrl+C` interrupts it.

## Handing over the controls

Once it's running, they drive it with three things:

| What they type | What happens |
|---|---|
| `/goal <condition>` | Sets it and **starts a turn immediately**. One goal per session — a new one replaces the old one |
| `/goal` | Status: the condition, how long it's been running, turns evaluated, tokens spent, and the evaluator's latest reason |
| `/goal clear` | Clears it. `stop`, `off`, `reset`, `none` and `cancel` all do the same thing |

`/clear` — starting a fresh conversation — removes an active goal too.

**How a goal ends.** Three verdicts, and one of them is failure:

| Verdict | What happens |
|---|---|
| **Not yet met** | Claude keeps working, and takes the evaluator's reason as guidance for the next turn |
| **Met** | The goal clears itself. Done |
| **Impossible** | The evaluator judged the condition can never be satisfied. The goal clears and records a failure **with a reason** |

Tell them "impossible" is a real outcome. A goal can fail, and the reason attached to it is usually the most useful sentence in the whole run.

Three more things worth knowing before they walk away:

- **The reason is readable any time** — `Ctrl+O` shows the evaluator's latest verdict and why.
- **Resuming keeps the goal, resets the counters.** Come back with `--resume` or `--continue` and the goal is still set, but the turn count, the timer and the token baseline all start from zero. A `stop after 20 turns` bound gets a fresh 20.
- **A stall guard is watching.** If several turns go by with no tool use at all, the loop halts and prints a warning; the goal stays set and picks back up next time they prompt.

The judge is the small fast model configured for their setup — Haiku by default on Anthropic's own API. Its evaluation cost is typically negligible.

## Sources

Every fact in this file traces to Anthropic's own documentation, retrieved **08.17.26**:

- `/goal`, the evaluator, verdicts, controls — <https://code.claude.com/docs/en/goal>
- permission modes and auto mode — <https://code.claude.com/docs/en/auto-mode-config>
- headless behavior — the Agent SDK pages under <https://code.claude.com/docs/en/agent-sdk/>

**If a claim here is contradicted by what a user actually sees, the user is right.** Re-check the
page above and correct this file — dated facts go stale, and a fact older than the running
release is worth re-reading before you repeat it.
