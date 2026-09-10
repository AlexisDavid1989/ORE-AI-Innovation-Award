# Copilot Auto Usage Submission Kit

This kit is designed so contestants do not have to log prompts or tokens manually.

## What This Kit Does

- Automatically reads VS Code Copilot chat session logs.
- Generates a machine-readable usage file.
- Generates a markdown report file that can be submitted with the project.
- Runs automatically when the project folder opens in VS Code.

## Organizer Install Steps (Before Giving Project to Contestants)

Copy these files into the root of each contestant project:

1. `.vscode/tasks.json`
2. `.github/copilot-usage/generate-copilot-usage-report.ps1`
3. `SUBMISSION.md` — the standard submission form every team fills in.

Do not copy anything from `judge-only/` to contestant projects.

After these files are in place, VS Code will auto-generate:

1. `.github/copilot-usage/usage-summary.json`
2. `.github/copilot-usage/prompt-answer-log.jsonl`
3. `COPILOT_USAGE_REPORT.md`

Contestants only need to use Copilot normally and submit the project.

## Included Source Files in This Kit

- `root/.vscode/tasks.json`
- `root/.github/copilot-usage/generate-copilot-usage-report.ps1`
- `root/SUBMISSION.md`

## Judge-Only Files (Keep Private)

- `judge-only/score-submission.ps1`
- `judge-only/README.md`

## Notes

- A markdown file alone cannot execute telemetry collection; the script and task are required.
- Token totals are collected from local Copilot chat session data when available.
- The collector never reads the text of prompts or answers. It processes only token counts and structured metadata (model, mode, tools invoked, and Copilot's own per-request token breakdown).
- Activity attribution (reading data, reading code structure, answer generation) is inferred from tools and mode only, and is marked as inferred.
- Contestants must not modify telemetry artifacts manually or via AI tools. Telemetry integrity checks may be applied during judging.
