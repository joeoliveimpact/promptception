---
name: premortem
description: Use when a plan, prompt, build spec, or any deliverable draft is complete but not yet shipped or presented - or when the user says "premortem this", "poke holes", "what breaks", "red-team this".
---

# Premortem

## Overview

Assume it is six weeks later and this FAILED. Work backwards — find why.

Verify cheap-to-verify claims yourself (read-only probes) rather than trusting the draft.

## Hunt List (minimum)

- Dependencies on unverified claims
- Ordering mistakes (step N needs step M's output)
- Hidden single points of failure
- Items sized small that are really big — and the reverse
- One-directional checks (out leg proven, back leg never probed)
- Failure modes that only appear when no human is watching
- Assumptions inherited from docs instead of probes
- The owner's hands needed at a moment they are unavailable

## Output Format

Return numbered findings, each with:
- **Severity:** KILLER / MAJOR / MINOR
- **Evidence:** what you probed or read, and what it showed
- **Fix:** the concrete change

Then state which parts of the draft must change.

**Fix the draft against findings BEFORE presenting; tell the user what changed.**

## Scaling

- **Standalone use:** the invoking session runs this protocol directly.
- **Inside orchestrator-mode:** the orchestrator owns the verdict; the orch-premortem agent does the legwork at max effort.

This skill is the single source of truth for the protocol; orchestrator-mode references it.
