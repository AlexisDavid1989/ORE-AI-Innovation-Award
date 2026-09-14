# How to Enter

## SharePoint AI page prompt

Create a modern internal SharePoint page titled "How to Enter" for the ORE AI Innovation Award 2026. Use a professional, energetic visual style consistent with the existing award homepage: midnight blue, navy, sky blue, teal, gold, coral, white, and soft blue-gray. Use standard SharePoint web parts only. Keep the page easy to scan, accessible, and responsive. Do not add facts, dates, links, claims, images, or steps that are not supplied below.

Use a dark midnight-blue title area with white text and the small eyebrow "IT'S EASIER THAN YOU THINK". Add a centered award logo image below the title without cropping it. Build these sections in order:

1. A white introduction section headed "Five steps from idea to submission" with the text "Build your project, tell us about it, and let the automatic Copilot tracking handle the rest."
2. A white single-column process containing five numbered steps separated by dividers: grab the submission kit, build the project, fill in SUBMISSION.md, include the Copilot usage files, and submit before October 7, 2026 at 23:59 UK time.
3. A soft blue-gray two-column section titled "What to bring" containing four checklist items: a completed SUBMISSION.md, the working project, screenshots or a short demo, and the untouched Copilot usage files.
4. A white educational section titled "What is a token?" explaining tokens with a compact three-column example table.
5. A white section titled "About the Copilot tracking" showing the four stages "You build", "Local read", "Count only", and "Report".
6. A soft blue-gray two-column section titled "What it does - and never does", contrasting the two lists without relying on color alone.
7. White single-column sections titled "How token sources are calculated" and "How activity is categorized", each with an accessible table.
8. A compact midnight-blue final section with centered white text and a filled gold or primary button labeled "Submit Your Project".

Use Heading 1 for main section titles, Heading 2 for steps and checklist labels, Normal text for body copy, and default SharePoint table text. Do not add a countdown, stock images, decorative icons, custom HTML, or custom scripts. Leave button and folder destinations ready for the editor to insert.

Generate the page structure first. Then replace any AI-written wording with the exact approved copy below.

## AI section prompts

Paste these one at a time if SharePoint AI cannot generate the full page reliably.

### Introduction and five steps

```text
Create a clean one-column process section for the ORE AI Innovation Award 2026. Add the Heading 1 "Five steps from idea to submission" and the introduction "Build your project, tell us about it, and let the automatic Copilot tracking handle the rest." Below it, create five numbered steps using Heading 2 and Normal text, with a divider between steps. Use exactly the supplied copy and links. Keep the background white and do not add images, icons, dates, or steps.
```

### Submission checklist

```text
Create a soft blue-gray two-column SharePoint section titled "What to bring". Arrange four checklist items in two rows: "A completed SUBMISSION.md", "The working project", "Screenshots or a short demo", and "Copilot usage files". Use Heading 2 for each label and Normal text for its approved detail. Make the checklist responsive and accessible. Do not add or rewrite requirements.
```

### Token explanation

```text
Create a white one-column educational SharePoint section titled "What is a token?" Use the approved explanation and a compact three-column table headed "Text", "Simplified token split", and "Why". Add the Heading 2 "How text becomes tokens". Preserve code examples as inline code. Keep the tone clear and factual, and do not invent tokenizer claims.
```

### Copilot tracking

```text
Create a white one-column SharePoint section titled "About the Copilot tracking". Present the four approved stages in an accessible four-column layout: "1. You build", "2. Local read", "3. Count only", and "4. Report". Follow it with a soft blue-gray two-column section titled "What it does - and never does" using the labels "It does" and "It never does". Use the exact approved copy. Do not add telemetry claims or imply that conversation text is collected.
```

### Calculation tables and action

```text
Create two white one-column SharePoint sections titled "How token sources are calculated" and "How activity is categorized" using the approved tables. Use a dark theme header row with white text and normal body text. Finish with a compact midnight-blue section containing a filled gold or primary button labeled "Submit Your Project". Do not add rows, classifications, links, or claims.
```

## Page formatting

| Area | SharePoint section and web part | Formatting |
| --- | --- | --- |
| Title area | Full-width page title area | Midnight-blue `#010469` background; white page title; eyebrow is small, bold, all caps, in gold or sky. |
| Five steps | One-column section; one Text web part per step | Use Heading 2 for the step number and title. Use Normal text for the explanation. Add a Divider after every step except the last. |
| Checklist | Soft/neutral full-width section with two columns | Each item is a Text web part. Use Heading 2 for the label and Normal text for its detail. |
| Token and tracking explanations | White, one-column sections | Main subjects are Heading 1; explanatory subheads are Heading 2 or Heading 3. Keep prose left-aligned and use tables only for comparisons. |
| Data assurance | Soft/neutral full-width section, two columns | One column: `It does`; second column: `It never does`. Use Heading 2 for each and bold the first sentence of each row. |
| Final action | Midnight-blue full-width section | Centered white Heading 1 and body; filled gold/primary `Submit Your Project` button. |

**Five steps from idea to submission.** Build your project, tell us about it, and let the automatic Copilot tracking handle the rest.

## 1. Grab the submission kit

Clone the [GitLab repository](https://gitlab.dx1.lseg.com/Alexis.David/ore-ai-innovation-award) and create your own branch. It includes the standard submission form and automatic Copilot usage tracking.

## 2. Build your project

Make something AI-centered and relevant to ORE. Everyone uses GitHub Copilot for this award, and usage is captured automatically, so there is nothing to track by hand.

## 3. Fill in `SUBMISSION.md`

Complete the standard form: the problem, your approach, technologies and models used, setup instructions, the value it delivers, and who is behind it.

## 4. Include your Copilot usage files

Add the auto-generated Copilot files unchanged: `COPILOT_USAGE_REPORT.md`, `usage-summary.json`, and `prompt-answer-log.jsonl`.

## 5. Submit before the deadline

Push your project to its own branch in the [GitLab repository](https://gitlab.dx1.lseg.com/Alexis.David/ore-ai-innovation-award), and upload any demo video to [the award video folder](DEMO_VIDEO_UPLOAD_LINK), before **October 7, 2026, 23:59 UK time**.

---

## What to bring

**Formatting:** Use a soft blue/gray full-width section background. Make the title Heading 1. Keep each checklist label as Heading 2 and its description as Normal text. Use two columns rather than one dense four-column table on narrow pages.

| A completed `SUBMISSION.md` | The working project |
| --- | --- |
| Problem, approach, technologies/models, setup instructions, value, and owners. | Source code, or a hosted demo / recording if it cannot be run locally. |

| Screenshots or a short demo | Copilot usage files |
| --- | --- |
| Wherever they help tell the story of what you built. | The untouched auto-generated Copilot report, JSON summary, and transcript. |

---

## What is a token?

**Formatting:** White, one-column section. Make this Heading 1. Use Heading 2 for `How text becomes tokens`; use Normal text for explanations; keep tables at the default SharePoint font size for readability.

A token is the unit of text an AI model counts when it reads input or generates output. It is not the same as a word, character, or line of code.

### How text becomes tokens

A tokenizer breaks text into pieces the model can process. A token may be a whole word, part of a word, punctuation, whitespace, a number, or a code symbol. The exact split depends on the model.

| Text | Simplified token split | Why |
| --- | --- | --- |
| `Please summarize this file` | `Please` / `summarize` / `this` / `file` | Common whole words are usually a single token each. |
| `internationalization` | `international` / `ization` | Long, uncommon words can be split into smaller pieces. |
| `2026-08-27` | `2026` / `-` / `08` / `-` / `27` | Numbers and punctuation are usually counted separately. |
| `for (i = 0; i < 10; i++)` | Words, punctuation, and symbols | Code syntax rarely maps cleanly to whole words. |

These are simplified illustrations, not Copilot's exact tokenizer. One word is not always one token, and one token is not always one word.

Once text is tokenized, each token is read by the model as part of its input sequence. When generating a reply, the model predicts and outputs one token at a time until the response is complete. A rough English-text estimate from OpenAI is about four characters per token, or 750 words per 1,000 tokens. This is an approximation and varies by model and tokenizer.

---

## About the Copilot tracking

**Formatting:** White, one-column section. Heading 1 for the section title, then a four-column table for the four stages. Bold each stage title and use Normal text for its description.

J.A.R.V.I.S., our AI judge, values projects that are both well built and built smart.

| 1. You build | 2. Local read | 3. Count only | 4. Report |
| --- | --- | --- | --- |
| Use GitHub Copilot in VS Code normally. | A local script reads VS Code's own Copilot log files. | It counts tokens and notes the model, mode, and tools used - never the words. | It writes anonymized summary files into your project. |

## What it does - and never does

**Formatting:** Use a soft blue/gray full-width section. Heading 1 for the title. Use two columns: use teal/sky accent for `It does` and coral accent for `It never does`, with the labels written in bold as well as color.

| It does | It never does |
| --- | --- |
| Runs 100% locally. No network calls or uploads. | Reads, stores, or sends your prompt and answer text. |
| Costs zero tokens because it never calls an AI model. | Keeps conversation content. Only token counts and structured metadata are collected. |
| Matches this workspace and is fully inspectable in the project. |  |

## How token sources are calculated

**Formatting:** White, one-column section. Heading 1 for the title. Set the table header row to the site theme's navy or midnight-blue style with white text. Do not use colored text inside body cells.

For prompt sources, the script applies each JSON percentage to `promptTokens`. Answer tokens come directly from `completionTokens`.

**Sub-agent token notice:** Totals include only model requests present in the local VS Code logs. A sub-agent invocation may be visible without its child model calls being recorded, so sub-agent token usage may not be included in the total.

| JSON field | Classification |
| --- | --- |
| User Context / Messages | `user_prompt_tokens` |
| User Context / Tool Results | `reading_data_tokens` |
| User Context / Files | `reading_code_structure_tokens` |
| System | `system_overhead_tokens` |
| `completionTokens` | `answer_generation_tokens` |

## How activity is categorized

**Formatting:** White, one-column section. Heading 1 for the title. Apply the same table header treatment as the token source table. End with a pale callout section using the site's soft theme background.

Each request receives one category based on its tool IDs. The category receives the full `promptTokens + completionTokens` amount.

| Activity | Examples |
| --- | --- |
| Refactor and editing | `applypatch`, `replacestring`, `insertedit` |
| Reading code structure | `readfile`, `findfiles`, `findtextinfiles`, `listdirectory` |
| Code generation | `createfile` |
| Debugging and testing | `run_in_terminal`, `geterrors`, `testfailure` |
| Planning and docs | Plan mode |

In short: tracking is a local, zero-cost tally of where token counts went and which tools were used. It cannot see, keep, or share the text of your Copilot conversation. Leave the generated files untouched because their integrity is part of judging.

**Button:** Submit Your Project -> https://gitlab.dx1.lseg.com/Alexis.David/ore-ai-innovation-award