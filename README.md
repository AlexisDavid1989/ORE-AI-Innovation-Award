# ORE AI Innovation Award 2026 Website

Static GitLab Pages website and its authoring sources for the ORE AI Innovation Award.

## Contents

- `public/` - deployable HTML, CSS, JavaScript, and assets.
- `website/` - branding, SharePoint authoring, templates, and design sources.
- `branding/templates/RULES_AND_FAQ.md` - award rules source.
- `sharepoint/` - SharePoint content sources.
- `.gitlab-ci.yml` - publishes `public/` with GitLab Pages.

## Local preview

```powershell
cd public
python -m http.server 8080
```

Open `http://localhost:8080`.

Participant telemetry is maintained in the separate `ore-ai-innovation-award-participant-telemetry` repository.
