# Scheduling mechanics — the three schedulers, and life after launch

Everything the scheduler choice depends on, and everything that bites after the routine is live.
Read this before naming a scheduler and before handing over. Give them only the parts that touch
their routine, in their language. **Never dump this file at them.**

## Which scheduler — the matrix

**What a cloud routine actually is — and the part that stops most coaches.** It isn't just a prompt on a timer. A routine is *"a prompt, one or more repositories, and a set of connectors"* — and: *"What a routine can reach is determined by the repositories you select, the environment's network access and variables, and the connectors you include."* In plain English: a cloud routine works inside a code repository (a GitHub repo) that it clones fresh each run, and it can only touch outside services you've connected to it. What this means for them: no repo, no cloud routine — check that they have one before you point them down this column.

| | Cloud routine | Desktop scheduled task | Cowork scheduled task | `/loop` |
|---|---|---|---|---|
| Runs on | Anthropic's computers | Your machine | Anthropic's computers — contested | Your machine |
| Your machine on? | No | **Yes — and awake** | No — contested | Yes |
| App must be open? | n/a | **Yes** | No — contested | Yes |
| Session open? | No | No | No — inferred, never stated | Yes |
| Reads your local files | **No — fresh clone** | Yes | Contested (below) | Yes |
| Shortest interval | **1 hour** | 1 minute | Hourly preset | 1 minute |
| Permission prompts | None — fully autonomous | Per task | Per task | Inherits the session |
| Catch-up after a miss | Not documented | One, most recent, within 7 days | Not documented | No |
| Once a year, or one single date | Yes — it's still recurring | Yes | Yes | **No** — loops expire in 7 days |

**The whole Cowork column is contested, not just one cell.** Every cell marked contested rests on the same disputed pair of sentences below — if the *"it will only run locally"* line is the true one, then Cowork isn't purely remote and it does need your machine. Read those cells as "unsettled", not as "No".

**Desktop's hard rule — say this out loud whenever desktop is on the table.** *"Tasks only run while the desktop app is running and your computer is awake. If your computer sleeps through a scheduled time, the run is skipped."* And: *"Closing the laptop lid still puts it to sleep."* What this means for them: a laptop left plugged in with the lid shut is a **sleeping** laptop, and a sleeping laptop gets nothing. If they're going desktop, the app stays open and they turn on **Keep computer awake** (Settings → Desktop app → General).


**Cowork's scheduler is the least known, and on paper the strongest — on paper being the operative words.** In any Cowork task, `/schedule` sets one up, and it runs *"even when your computer is asleep or the Claude Desktop app is closed."* It's on all paid plans.

**The local-folder contradiction — surface it, don't resolve it.** Anthropic's own docs disagree with themselves about Cowork scheduled tasks: one line says they *"can't be tied to a folder on your computer"*, the manual setup screen on that same page has a field asking which local folder to use, and a third line says *"If a scheduled task requires local files or apps, it will only run locally."* Say that out loud and settle it with evidence, not opinion:

*"The docs contradict each other on whether a scheduled Cowork task can reach your local folder, so I'm not going to promise you either answer. Set one to run once, ten minutes from now, pointed at a single file of yours. We read the result, and then we know."*

Never promise either behavior.

**One-shot or recurring.** "Run once next Tuesday at 9" and "every Tuesday at 9" are different commitments — confirm which, out loud.

**Pace the cost.** For the two where the docs put a price on it, every run costs you whether or not anything worth reporting happened: cloud routines *"count against your account's daily run allowance"*, and Cowork work *"consumes more of your usage allocation than chatting with Claude."* (The docs don't state a separate cost for desktop tasks or `/loop`.) Either way, hourly is almost never the real need; daily or weekly usually is. Pick the slowest rhythm that still does the job.

## Now that it's live — the part nobody tells them

- **The 10-minute trap (Cowork).** If a run hits a permission request with nobody there, it waits 10 minutes, then that request is **automatically denied and the task continues without that action**. Green status, missing work. This is exactly why outward actions default to draft.
- **Start times drift on purpose.** Schedulers stagger fire times so everything doesn't hit at once. Cloud routines document *"a few minutes"* of stagger (*"consistent for each routine"*) and desktop tasks *"a small delay of a few minutes"* (deterministic). On `/loop` it's documented and it is much bigger: a recurring job fires **up to 30 minutes late** (an hourly job set for :00 can land anywhere up to :30), and a one-shot set for :00 or :30 fires up to 90 seconds early. If exact timing matters, pick an odd minute — 9:03, not 9:00. Either way, never chain two jobs back-to-back assuming exact times.
- **A sleeping computer skips the run (desktop).** Desktop tasks fire only while the app is open and the machine is awake — and closing the laptop lid counts as going to sleep. Sleep through 9am and that 9am run simply doesn't happen; the one catch-up run fires whenever the machine next wakes, which is why the docs warn: *"A task scheduled for 9am might run at 11pm if your computer was asleep all day."* What this means for them: write the prompt so an 11pm run still reads sensibly (say "since the last run", not "this morning"), or keep the machine awake.
- **Missed runs.** Desktop tasks catch up once — most recent missed run only, within 7 days. `/loop` states *"No catch-up for missed fires."* For cloud routines and Cowork the docs say nothing either way, so "no catch-up" there is our assumption, not a documented fact — plan around it, and confirm on their account if it matters.
- **Run history.** Every run is its own session; open it to see what actually happened.
- **The controls.** Pause, resume, edit, delete — anytime, just ask. A schedule isn't a tattoo.
- **Where the prompt lives (desktop tasks).** `~/.claude/scheduled-tasks/<task-name>/SKILL.md` — edit the wording there. The schedule, folder, model, and on/off state are **not** in that file; change those where you created the task.
- **Time zone.** Documented as your local one for cloud routines (*"entered in your local zone and converted automatically"*) and for `/loop` (*"All times are interpreted in your local timezone"*); desktop's time picker defaults to local time. **For Cowork, time zone handling isn't addressed in any source at all** — don't tell them it's local; have them verify on a test run. And what happens across a daylight-saving switch isn't documented for any of these schedulers — if that week's run time matters, check it yourself.
- **If you went with `/loop` instead:** it lives in that session, expires 7 days after creation (one last run, then it deletes itself), and a session holds at most 50 scheduled tasks.

## Sources

Doc-sourced, retrieved **08.17.26**:

- `/loop` and the scheduler comparison — <https://code.claude.com/docs/en/scheduled-tasks>
- cloud routines, what a routine is, repos and connectors — <https://code.claude.com/docs/en/routines>
- desktop scheduled tasks, sleep behavior, catch-up —
  <https://code.claude.com/docs/en/desktop-scheduled-tasks>
- Cowork scheduled tasks — <https://claude.com/docs/cowork/> and the Anthropic Help Center

**Where this file says "contested", the sources genuinely disagree with each other** — that is
reported, not resolved. Where it says "not documented", the pages are silent and the surrounding
claim is our inference, labeled as such. Neither gets upgraded to fact without new evidence.

**A note on Cowork, 08.20.26:** a sub-hour repeating cadence was observed running inside Cowork
via the loop machinery — which is **not** the same as a Cowork *scheduled task* doing it. The
contested column below stays contested. What that observation does settle: never tell someone to
leave Cowork in order to repeat something.

**If a user reports different behavior, they are right.** Re-check the page and correct this file.
