# Copilot Submission Kit

This template kit enables near-zero-touch collection of Copilot prompt/token usage for submissions.

## Goal

Contestants should not manually track prompts or tokens.

## How It Works

1. Organizer copies the `root` folder contents into each contestant project before the contest starts.
2. When contestants open the project in VS Code, a task runs automatically.
3. The task generates:
   - `.github/copilot-usage/usage-summary.json`
   - `.github/copilot-usage/prompt-answer-log.jsonl`
   - `COPILOT_USAGE_REPORT.md`
4. Those generated files are submitted with the final project.

## Important Constraint

A markdown file alone cannot collect telemetry. It must be paired with an executable script and VS Code task.

## What Is Natural vs. What This Kit Adds

The token data itself is **not** created by this kit. Understanding the split matters:

- **Natural (every project, no kit needed):** VS Code + GitHub Copilot automatically save every chat conversation to disk as `chatSessions/*.jsonl` under `%APPDATA%/Code/User/workspaceStorage/...`, including exact per-request token counts, model, mode, and prompt token details. This happens for all users whether or not the kit is installed.
- **Injected (added by this kit):** the reading, structuring, and reporting of that pre-existing data, plus automation and docs. The kit adds exactly three files:
  - `root/.vscode/tasks.json` — runs the collection automatically on folder open.
  - `root/.github/copilot-usage/generate-copilot-usage-report.ps1` — the actual collector (parses, categorizes, aggregates the natural logs).
  - `root/.github/copilot-usage/README.md` — documentation only.

Implications:
- The collection consumes **zero Copilot tokens** — the script is local PowerShell that reads existing logs and never calls an LLM.
- Because the raw logs pre-exist, the script can analyze **past** chat activity in a project, not just activity after the kit is installed.

## Scoring Privacy

- Contestant-facing files in `root/` collect raw telemetry only.
- Official grading weights and thresholds are kept in `judge-only/` tools for organizers.
- Do not distribute `judge-only/` files to contestants.

## Confidence Model

- Token counts: exact (from Copilot chat session logs when available)
- Activity attribution: inferred (heuristic categorization)
