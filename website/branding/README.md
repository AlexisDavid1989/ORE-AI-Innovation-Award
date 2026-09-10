# ORE AI Innovation Award 2026 - Visual Identity Package

This folder contains the updated branding system for the ORE AI Innovation Award.

## What Changed in v3.0

- Final logo concept selected: Compass Instrument
- Production logo family rebuilt around the approved ring-and-needle mark
- Brand guidance updated to match the new symbol logic

## Files Included

### Documentation
- BRANDING_GUIDE.md: Full creative direction and usage rules
- COLOR_PALETTE.md: Color tokens and technical values
- QUICK_START.md: Fast implementation checklist

### Logo Assets
- logos/ore-ai-awards-full-logo.svg: Stacked lockup for ceremony and print
- logos/ore-ai-awards-horizontal.svg: Primary digital lockup
- logos/ore-ai-awards-icon.svg: Icon only for app, social, favicon
- logos/ore-ai-awards-monochrome.svg: One-color production version
- logos/ore-ai-awards-monochrome-white.svg: One-color reversed version for dark backgrounds
- logos/ore-ai-awards-dark-theme.svg: Optimized for dark backgrounds

### Templates
- templates/email-invitation.html
- templates/certificate-template.html
- templates/social-media-graphics.html
- templates/copilot-submission-kit/

## Recommended Usage

- Email header: horizontal logo (200px to 320px)
- Certificate top: full logo (240px to 320px)
- Social avatar: icon logo (96px to 160px)
- Dark slides: dark-theme logo
- To embed a logo directly in email HTML, run `templates/convert-svg-to-email-data-uri.ps1` and paste the generated data URI into an `img` tag.

## Award Categories (Official Naming)

1. AI Game Changer Award
2. Boldest AI Idea Award
3. Customer Wow Award
4. Workday Hero Award
5. Crowd Favorite Award
6. J.A.R.V.I.S's Pick

Category descriptions and judging language are in BRANDING_GUIDE.md.

## Quick Start

1. Read QUICK_START.md.
2. Use the horizontal logo first.
3. Keep color usage simple: deep blue base, gold emphasis, purple accents.
4. Apply the same logo variant across each communication channel.

## Copilot Prompt and Token Submission (Automatic)

For competition telemetry, use the auto-collection kit:

- `templates/copilot-submission-kit/INSTALL.md`
- `templates/copilot-submission-kit/root/.vscode/tasks.json`
- `templates/copilot-submission-kit/root/.github/copilot-usage/generate-copilot-usage-report.ps1`

When installed in contestant repos, VS Code generates:

- `.github/copilot-usage/usage-summary.json`
- `COPILOT_USAGE_REPORT.md`

This supports automatic submission of prompt/token usage without manual contestant logging.

## Version

- Version: 3.0
- Updated: August 2026
