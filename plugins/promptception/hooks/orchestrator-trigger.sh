#!/bin/bash
# UserPromptSubmit hook: if the prompt contains an orchestrator-mode or premortem
# trigger phrase, inject a reminder to invoke the matching skill before responding.
# Greps raw stdin rather than parsing a specific JSON field so it survives
# input-schema drift across Claude Code versions. Exit 0 always; stdout (if any)
# is added to context.
set -euo pipefail

input=$(cat)

# Deliberately narrower than the skills' trigger lists: generic phrases
# ("delegate this", "what breaks") false-positive on everyday prompts.
# The skill descriptions still carry them; the hook only fires on the
# unambiguous invocations.
ORCH_PATTERN='orchestrator mode|go orchestrator|subagent approach|use your subagents|fan out agents|spin up the crew|tiered agents|audit this for real|ground it in verified reality|run it like the dennis build'
PREMORTEM_PATTERN='premortem this|pre-mortem this|poke holes|red-team this|red team this'

if echo "$input" | grep -qiE "$ORCH_PATTERN"; then
  echo "orchestrator-mode skill applies - invoke it (Skill tool) before responding."
elif echo "$input" | grep -qiE "$PREMORTEM_PATTERN"; then
  echo "premortem skill applies - invoke it (Skill tool) before responding."
fi

exit 0
