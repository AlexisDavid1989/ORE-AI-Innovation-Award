# ORE AI Innovation Award 2026 — Website

Static marketing + rules site for the award, built to deploy on **GitLab Pages**.

## Structure

```
public/
  index.html        Home (hero, about, categories, dates, CTA)
  submit.html       How to enter (5 steps + checklist + Copilot tracking)
  rules.html        Full rules + FAQ accordion
  assets/
    styles.css      Shared brand styles (gold / blue / purple, Cinzel + Inter)
    logo-icon.svg   Compass-instrument mark used in nav/hero/footer
.gitlab-ci.yml      Deploys public/ to GitLab Pages on the default branch
```

## Local preview

Open `public/index.html` directly in a browser, or serve the folder:

```powershell
cd public
python -m http.server 8080   # then visit http://localhost:8080
```

## Deploy (GitLab Pages)

1. Push this repository to GitLab.
2. On the default branch, the `pages` CI job publishes everything in `public/`.
3. The site appears at your project's Pages URL (Settings → Pages).

No build tooling is required — the site is plain HTML/CSS/SVG.

## Before publishing — fill in placeholders

Most values are now finalized (GitLab submission repo, contact email
`alexis.david@lseg.com`, eligibility = Post-Trade Solutions, voting = October 2026).

Search the `public/` files for `[BRACKETS]` and replace what's left:

- `[SHAREPOINT_LINK]` — the award SharePoint page for demo-video uploads (to be created)
