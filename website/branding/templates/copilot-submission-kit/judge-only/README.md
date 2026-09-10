# Judge-Only Scoring Tools

This folder is for organizers and judges only.

Do not distribute these files to contestants.

## Purpose

- Apply hidden rubric weights and thresholds to submission telemetry.
- Generate final scorecards for judging.

## Usage

Run:

```powershell
& "./score-submission.ps1" -UsageSummaryJson "<path-to-usage-summary.json>" -OutJson "judge-score.json" -OutMarkdown "JUDGE_SCORE_REPORT.md"
```

Input file expected from contestant submission:

- `.github/copilot-usage/usage-summary.json`

Output files:

- `judge-score.json`
- `JUDGE_SCORE_REPORT.md`
