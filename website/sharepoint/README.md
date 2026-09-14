# ORE AI Innovation Award 2026 - SharePoint Publishing Kit

This kit translates the static award website into three **modern SharePoint Site Pages**. It does not embed the existing HTML: modern SharePoint sanitizes page CSS and scripts, which would remove the site's layout and countdown behavior.

## Create the pages

Create these pages in the award SharePoint site, all using the **Blank** page template and **Full-width** layout:

| Page title | Suggested URL name | Page copy source |
| --- | --- | --- |
| ORE AI Innovation Award 2026 | `ore-ai-innovation-award-2026` | `HOME_PAGE.md` |
| How to Enter | `how-to-enter` | `HOW_TO_ENTER.md` |
| Rules & FAQ | `rules-and-faq` | `RULES_AND_FAQ.md` |

Upload [the SharePoint title lockup](ore-ai-innovation-award-2026-logo.svg) to the site's **Site Assets** library. Set it as the site's logo and place it in a single Image web part at the top of the home page. Set its alternative text to `ORE AI Innovation Award 2026 logo`.

Use the page title area as a plain dark-blue banner. In the Title field use the page title from the table; in the Text above title field use `ORE AI's 10-Year Anniversary` on the home page, `It's easier than you think` on the entry page, and `The official-but-friendly guide` on the rules page. If the tenant theme allows it, use the LSEG midnight blue `#010469` as the title area overlay. Do not add the countdown yet.

After publishing `ORE AI Innovation Award 2026`, select **Promote** (or **Page details**) and choose **Make homepage**. This makes the award page the site landing page at the site root. Do not create a separate generic homepage.

## Shared navigation

Add the following links to the site's top navigation. Put **Submit Your Project** last and use the emphasized navigation style if the site theme supports it.

| Label | Destination |
| --- | --- |
| Home | Site root (`/`) |
| Award Categories | Site root `#award-categories` |
| Key Dates | Site root `#key-dates` |
| How to Enter | `how-to-enter` |
| Rules & FAQ | `rules-and-faq` |
| Submit Your Project | `https://gitlab.dx1.lseg.com/Alexis.David/ore-ai-innovation-award` |

For the two home-page anchors, use a Text web part heading named exactly `Award Categories` and `Key Dates`, then copy its SharePoint-generated anchor link after publishing once. Replace the provisional destinations above with those copied links.

## Build rules

- Use the **Text**, **Hero**, **Image**, **Button**, **Quick Links**, **Spacer**, and **Divider** web parts only. These are standard modern SharePoint web parts and need no custom development.
- Use one section per major heading. Use three columns for short cards, two columns for the entry checklist, and one column for long-form rules.
- Keep default SharePoint fonts for accessibility and tenant consistency. Use the official LSEG theme colors where available: `#010469`, `#020F98`, `#029BE3`, `#5CCADF`, `#FBDD65`, and `#FF585D`.
- Create a folder named `Demo videos` in the site's Documents library. Grant contributors the ability to upload files but not edit pages. Add its folder link wherever the copy says `DEMO_VIDEO_UPLOAD_LINK`.
- Publish all three pages only after replacing `DEMO_VIDEO_UPLOAD_LINK` with the `Demo videos` folder's sharing link.

## Visual specification

Modern SharePoint applies the site's active font and responsive font scale, so authors cannot set reliable pixel sizes or arbitrary font families in a Text web part. Use the built-in styles below rather than pasting custom HTML or CSS.

| Content role | SharePoint style | Intended visual weight |
| --- | --- | --- |
| Page title | Page title | Largest text; white on the midnight-blue title area |
| Overline / eyebrow | Normal text, all caps, bold | Small label above a title; sky or gold theme accent |
| Main section heading | Heading 1 | Large, deep-blue heading |
| Subsection / card heading | Heading 2 | Medium, deep-blue heading |
| FAQ question / technical subheading | Heading 3 | Compact, bold, deep-blue heading |
| Body and table detail | Normal text | Standard body size and dark-gray text |
| Dates, category status, action labels | Normal text, bold | Small but high-contrast accent label |

Use full-width sections in this sequence: white, very light blue/gray, white, then midnight blue for the final CTA. If a custom section color is unavailable in the tenant, select the closest available **Neutral** or **Soft** theme background. Never use a bright background behind long-form rules or tables.

| Brand purpose | Hex reference | Native SharePoint use |
| --- | --- | --- |
| Midnight blue | `#010469` | Page title area; final CTA section; dark text only when the theme maps it safely |
| Navy | `#020F98` | Section headings or primary theme color |
| Sky | `#029BE3` | Links, eyebrow labels, and secondary accent |
| Teal | `#5CCADF` | Optional soft section background or decorative accent |
| Gold | `#FBDD65` | Primary button emphasis and category-status accent |
| Coral | `#FF7459` | Secondary callout accent only |
| Dark gray | `#464646` | Body text |

For an accessible contrast result, use white text only on the midnight-blue or navy background. On white or pale sections, use deep blue for headings and dark gray for body text. Use gold as a background only with midnight-blue text. Do not rely on color alone to communicate a category status.

### Buttons and images

- Use the built-in **Button** web part in its filled/primary style for `Submit Your Project`; use outline/secondary for page-to-page links such as `See How It Works`.
- Use the site theme's primary color for filled buttons; when custom button colors are permitted, use gold `#FBDD65` with midnight-blue text for the primary action.
- Keep button labels in title case and do not put more than four words in a label.
- Render the horizontal SVG logo at **500-620 px wide** in a centered Image web part on the home page. Use **320-400 px wide** on the two supporting pages. Retain its proportions; do not crop it.
- Use 32 px or 48 px Spacers above each main section, and a Divider between content sections where the background color does not already separate them.

## Source preservation

The source HTML stays in `public/` for the GitLab Pages version. The Markdown files in this directory are the native SharePoint authoring source. Update both when award facts change.

## Acceptance check

Before publishing, verify that:

1. `ORE AI Innovation Award 2026` is published as the site homepage, and top navigation reaches each page.
2. The logo is served from Site Assets and has alternative text.
3. The GitLab repository button opens the existing submission repository.
4. The demo-video link opens the `Demo videos` folder and contributors can upload a video.
5. Home includes all six categories and four dates; How to Enter includes five steps and four checklist items; Rules & FAQ includes rules 1-14 and all FAQ answers.