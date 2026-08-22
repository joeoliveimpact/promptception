# The fitness gate — is this even the right tool?

Every builder in this plugin (goal / loop / schedule / plan) runs this **before shaping anything.** It's one quick pass over what they asked for, checking that the door they walked through is the right one.

**It warns. It never blocks.** Name the better door, say why in one sentence, then do what they say.

Same grammar as the escape hatch everywhere else in this plugin — name the cost, then obey:

*"Before I build this: what you've described is going to [problem], and [better tool] does this the way you actually want. Want me to switch, or build it as asked anyway?"*

On *"do it anyway"* — build it. No second warning, no nagging. State the trade in one line, declare it in the artifact, and move on.

Don't guess which surface they're on while doing this. If the gate's answer depends on whether a command exists here, probe it: `${CLAUDE_PLUGIN_ROOT}/references/capability-probe.md`.

## The two comparison tables

### Keeping a session running — Anthropic's own table, from the `/goal` docs

| Approach | Next turn starts when | Stops when |
|---|---|---|
| `/goal` | The previous turn finishes | A model confirms the condition is met or judges it impossible |
| `/loop` | A time interval elapses | You stop it, or Claude decides the work is done |
| Stop hook | The previous turn finishes | Your own script or prompt decides |

### Scheduling options — assembled from Anthropic's docs

| | Cloud routine | Desktop task | Cowork scheduled task | `/loop` |
|---|---|---|---|---|
| Runs on | Anthropic cloud | Your machine | Anthropic cloud — contested | Your machine |
| Machine on? | No | Yes, and awake | No — contested | Yes |
| App must be open? | n/a | Yes | No — contested | Yes |
| Open session? | No | No | No — inferred, never stated | Yes |
| Local file access | No (fresh clone) | Yes | Contested in docs | Yes |
| Minimum interval | 1 hour | 1 minute | hourly preset | 1 minute |
| Permission prompts | None, fully autonomous | Per task | Per task | Inherits session |
| Catch-up on a missed run | Not documented | One, most recent, within 7 days | Not documented | No |
| Once a year, or one single date | Yes — still recurring | Yes | Yes | **No** — expires in 7 days |

*"Contested in docs" means exactly that: Anthropic's own documentation disagrees with itself on whether a Cowork scheduled task can reach a folder on your computer. One line says it can't be tied to a local folder; the same article's setup screen has a "which local folder" field; a third line says "If a scheduled task requires local files or apps, it will only run locally." Don't promise it either way — set it up, do one test run, and see what actually happened.*

**Every contested cell in the Cowork column is that same dispute.** "Runs remotely" and "only run locally" can't both hold, so where it runs, whether the machine has to be on, and whether the app has to be open are all unsettled too — not settled at "No". The "open session?" cell is an inference from how scheduled tasks work, never a stated fact.

**Desktop's hard rule, in plain words.** *"Tasks only run while the desktop app is running and your computer is awake. If your computer sleeps through a scheduled time, the run is skipped."* And: *"Closing the laptop lid still puts it to sleep."* A plugged-in laptop with the lid shut is a sleeping laptop, and it gets nothing — or gets it hours late: *"A task scheduled for 9am might run at 11pm if your computer was asleep all day."* There's a **Keep computer awake** setting (Settings → Desktop app → General) for anyone choosing this column.

## Two rules on how you name the better door

**Only name doors this session actually has.** The entry gate's Phase A
(`${CLAUDE_PLUGIN_ROOT}/references/entry-gate.md`) looked at what responds here. Sending someone
after a tool that won't answer is worse than saying nothing — they'll assume they broke it. If
the better door isn't here, say that in the same breath.

**Never name it as a slash command.** Say it in words: *"want me to build this as a schedule
instead?"* Sibling skills trigger on plain language on every surface; a slash string is a
namespace-and-version bet, and this gate fires exactly when someone is already stuck.

**A long gap is still a schedule.** "Every April 15" is recurring, and a single fixed date is
still a scheduled job. Neither is a loop — loops expire after seven days, so a yearly job would
die nine months early.

## The question that changes the most decisions

**Does this job need files on their own computer, AND do they want it running while the laptop is shut?**

If both are yes, **a cloud routine cannot do it.** Cloud routines start from a fresh clone with no access to local files — and a routine is *"a prompt, one or more repositories, and a set of connectors"*, so it needs a code repository (a GitHub repo) to work inside and can only reach services you've connected to it. That one answer knocks out whole columns of the table faster than anything else in this gate, so ask it early rather than discovering it after you've shaped a routine that can never work.

**And answer the follow-up honestly: on the docs as written, there may be no scheduler that does both.** Desktop sees local files but skips any run the machine sleeps through; cloud runs lid-shut but never sees local files; Cowork is the only maybe and its docs contradict themselves. Say that plainly, then settle it with one test run instead of a promise.

## The mis-fits to catch, by name

- **A "loop" whose watched thing only changes once a day** → a **schedule**. A loop that wakes every few minutes to find nothing new is spending turns on nothing.
- **A "schedule" that's really a one-time reminder** → a **one-shot, not recurring**. Recurring is a standing commitment; they wanted Tuesday.
- **A "goal" that's one deliverable** → a **plain prompt**. `/goal` keeps starting fresh turns until a condition is met. If one turn produces the thing, there's nothing left to keep working toward.
- **Anything carrying 2+ deliverables** → a **plan**. Route it to `${CLAUDE_PLUGIN_ROOT}/references/plan-engine.md`.
- **An outward-firing loop with no "already done?" check** → **the strongest warning in the set.** If it sends, posts, or messages, and it has no way to tell whether it already did, it will do it again. Every single time it fires. Say this one out loud and plainly:

  *"This one can send the same thing to the same person five times. Before it goes live it needs a way to check whether it already ran — otherwise the first thing your list notices about your automation is that it spams them."*

  If they still want it live, it goes out draft-first, not auto-fire.
