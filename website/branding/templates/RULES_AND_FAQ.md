# ORE AI Innovation Award 2026 — Rules & FAQ

*Best AI Creation for ORE — September 2026*

> The official-but-friendly guide to entering. It covers everything you need to know, so
> read it once, then go build something great. Stuck on a detail? The award team is a
> quick email away at **alexis.david@lseg.com**. (Housekeeping note: if this ever disagrees with
> another document, this one wins.)

---

## 1. What this is all about

The ORE AI Innovation Award 2026 celebrates the best AI creation built for ORE — or for
a great ORE use case. We're looking for work that's original, genuinely useful, nicely
executed, and worth showing off in front of the whole team. Winners get their moment in
the spotlight as part of ORE's **10-year anniversary celebrations**. Winners will be
announced sometime in November. No pressure. (Okay, a little pressure — the fun kind.)

## 2. Mark your calendar

| Milestone | Date |
| --- | --- |
| Applications open | **September 14, 2026** |
| Applications close | **October 7, 2026, 23:59 UK time** |
| Judging period | October 2026 |
| Crowd Favorite voting | October 2026 |
| Winners announced | Sometime in November 2026, as part of ORE's 10-year anniversary celebrations |

## 3. Who can enter

- Open to **all Post-Trade Solutions employees**.
- Fly solo or bring a **team** — your call. There's no team-size cap, so gather as many
  co-conspirators as you like.
- Got ideas for days? A person can pitch in on more than one entry.
- Each distinct project counts as **one entry**, and you're welcome to submit several —
  as long as each is genuinely its own thing, not the same project wearing a hat.
- The project must be **AI-centered** and relevant to ORE or an ORE use case.
- New or recently built is perfect. It should be substantially your team's own work for
  this award cycle. Already-running production systems may also be considered on a
  case-by-case basis — be upfront about it and make sure the AI contribution is genuinely yours.

## 4. How to enter

**Five steps from idea to submission.** Build your project, tell us about it, and let the automatic Copilot tracking handle the rest.

1. **Grab the submission kit:** Clone the [GitLab repository](https://gitlab.dx1.lseg.com/app/app-51172/qs/ore-ai-innovation-award) and create your own branch. It includes the standard submission form and automatic Copilot usage tracking.
2. **Build your project:** Make something AI-centered and relevant to ORE. Everyone uses GitHub Copilot for this award, and usage is captured automatically, so there is nothing to track by hand.
3. **Fill in `SUBMISSION.md`:** Complete the standard form: the problem, your approach, technologies and models used, setup instructions, the value it delivers, and who is behind it.
4. **Include your Copilot usage files:** Add the auto-generated Copilot files unchanged: `COPILOT_USAGE_REPORT.md`, `usage-summary.json`, and `prompt-answer-log.jsonl`.
5. **Submit before the deadline:** Push your project to its own branch in the [GitLab repository](https://gitlab.dx1.lseg.com/app/app-51172/qs/ore-ai-innovation-award), and upload any demo video to the award SharePoint page ([SHAREPOINT_LINK]), before **October 7, 2026, 23:59 UK time**.

Prefer a walkthrough? See the How to Enter page.

## 5. What to bring

Every entry should show up with:

- ✅ A completed **`SUBMISSION.md`** — the problem, your approach, technologies/models,
  setup instructions, the value, and who's behind it.
- ✅ The **working project** — source code, or a hosted demo / recording if it can't be
  run locally.
- ✅ **Screenshots or a short demo** wherever they help tell the story.
- ✅ The untouched Copilot usage files: `COPILOT_USAGE_REPORT.md`, `usage-summary.json`, and `prompt-answer-log.jsonl`.

Half-finished submissions are hard to judge fairly, so a missing piece may cost you
points — or a spot in the running.

## 6. Award categories

Every project is automatically entered into **all six categories**. You do not need to
choose a category on the submission form; judges will consider the project wherever it
clearly shines.

| Category | The one for… |
| --- | --- |
| **AI Game Changer** | The strongest all-around entry |
| **Boldest AI Idea** | The most original concept and biggest creative leap |
| **Customer Wow** | The best-looking, most delightful user experience |
| **Workday Hero** | The idea that quietly makes everyone's workday better |
| **Crowd Favorite** | The people's champion, decided by community vote |
| **J.A.R.V.I.S.'s Pick** | The AI judge's favorite, based on build quality and Copilot telemetry (prompting effectiveness, token efficiency, process transparency) |

And yes — one project can sweep multiple categories. Dream big.

## 7. How judging works

- Human-judged categories are scored by the award panel on the overall quality of the
  work: how well it cracks a real ORE problem, the strength of the idea, how well it's
  built, the user experience, and the value it delivers.
- Judges lean on your `SUBMISSION.md`, your demo, and the running project — so make it
  easy to understand and easy to run. Future-you will thank present-you.
- Ties are settled at the panel's discretion — usually over spirited debate.
- The judging panel: **alexis.david@lseg.com** (organiser & judge),
  **joseph.o'brien@lseg.com**, and **jacob.ullman@lseg.com**.

## 8. J.A.R.V.I.S.'s Pick & Copilot usage

J.A.R.V.I.S. is our AI judge, and it has a soft spot for projects that are both well
built *and* built smart. Here's the deal:

- **Usage is captured automatically.** Open the project in VS Code and a task quietly
  reads your local Copilot chat logs to generate the usage report, JSON summary, and
  transcript. No spreadsheets, no manual tallying — you just build.
- **Sub-agent token notice.** The totals include only model requests present in the
  local VS Code logs. A sub-agent invocation may be visible without its child model
  calls being recorded, so sub-agent token usage may not be included in the total.
- **It costs zero Copilot tokens.** The collector is a local script that reads logs
  that already exist and never calls a model. Free of charge.
- **Please don't touch the telemetry files.** No hand-edits, no AI polishing. Their
  integrity is part of the judging, and we do check. Doctored files take you out of the
  running for J.A.R.V.I.S.'s Pick and can affect other categories too.
- **Copilot is part of the entry.** Every participant uses it, and the untouched
  telemetry files are included with every submission.

## 9. Crowd Favorite voting

- The winner is crowned by community vote during **October 2026**.
- Voting is **one vote per person**, and rallying support for your project **is**
  fair game (within reason — keep it friendly).
- Ballot-stuffing (duplicate accounts, bots, and other creative schemes) is an instant
  exit. Win hearts, not scripts.

## 10. Keeping it fair

- Enter your own team's work, and give credit where it's due — call out any third-party
  code, models, datasets, assets, or templates you built on.
- Play nice with licenses for the models, libraries, and data you use.
- Nothing offensive, discriminatory, or against ORE policy. Easy.
- Tell it straight — no overselling what your project does or how it was built.

## 11. Data, security & privacy

- **Leave the secrets at home.** No API keys, passwords, or tokens in your submission.
  Use placeholders and hand any needed keys to judges separately.
- Using sensitive or ORE-internal data? Flag it on the submission form and make sure
  you're cleared to use it.
- Follow ORE's data-handling and security policies. Real customer data only if it's
  properly authorized and anonymized.
- Give your Copilot transcript files a quick once-over before submitting, just to
  confirm there's nothing in there you wouldn't want to share.

## 12. Who owns what

- You (and your team / ORE, per the usual employment and contractor terms) keep
  ownership of your work. It's yours.
- By entering, you're giving the award team the green light to **present, demo,
  screenshot, and reference** your submission to run and celebrate the award — think
  the anniversary event and internal shout-outs.
- If your project involves external partners or third-party IP, have a quick chat with
  the award team to sort out the specifics.

## 13. Prizes & bragging rights

- Winners are announced sometime in November as part of ORE's **10-year anniversary
  celebrations** and take home an official award certificate (and, let's be honest,
  serious bragging rights).
- There's no cash or other prize — this one's about recognition in front of the whole
  team.

## 14. What gets you disqualified

We'd rather never use this section, but for the record, an entry can be pulled for:

- Missing required submission materials.
- Edited, fabricated, or tampered Copilot telemetry files.
- Plagiarism or borrowing others' work without saying so.
- Vote manipulation.
- Breaking ORE policy, security, or this document.

---

## Frequently Asked Questions

**Who can enter?**
All Post-Trade Solutions employees are welcome. Solo acts and full-blown teams are equally welcome.

**Can I enter more than one project?**
Absolutely — as long as each is genuinely its own thing. Every project is a separate
entry with its own `SUBMISSION.md`.

**Can I be on more than one team?**
Yep. Just make sure you're named on every submission you helped build.

**Do I have to use GitHub Copilot?**
Yes. Copilot is part of the award workflow for every participant, and the untouched
telemetry files are submitted with the project.

**How is Copilot usage measured? Do I have to track prompts and tokens myself?**
Not a single spreadsheet required. Opening the project in VS Code auto-generates the
usage report from your local Copilot logs — it costs zero tokens and reads data that's
already there. Sub-agent child model calls may not be included when they are absent
from those logs.

**Can I edit the usage report to clean it up?**
Please don't. The telemetry files must be submitted exactly as generated. Hand-edits or
AI touch-ups take you out of the running for J.A.R.V.I.S.'s Pick and can affect other
categories.

**Does using more tokens help or hurt my score?**
J.A.R.V.I.S. rewards *smart* use of AI — sharp prompting and efficient, purposeful token
use — not raw volume. Burning tokens for the sake of it won't move the needle.

**My project can't be run locally. What do I do?**
No sweat — drop in a hosted demo link and/or a short screen recording, and explain in
the setup section why it can't run locally.

**Can I submit a project I built before September?**
The AI work should be your team's own and relevant to this award cycle. Already-running
production systems may also be considered on a case-by-case basis if you're upfront
about it and the AI contribution is yours. When in doubt, just ask the award team.

**What if my project uses ORE-internal or customer data?**
Flag it on the submission form, make sure you're cleared to use it, follow ORE data
policies, and never include secrets. Anonymize wherever you can.

**Can I use open-source code, models, or templates?**
Go for it — respect the licenses and give credit. The standout AI work should still be
your team's.

**What does a strong submission look like?**
A clear problem, an approach that makes sense, honest technology details, setup steps
that actually work, a demo that lands, and a concrete statement of value. Clarity beats
flash.

**When and where are winners announced?**
Winners will be announced sometime in November as part of ORE's 10-year anniversary
celebrations, once the October judging wraps up.

**Are the judging weights published?**
Nope — the rubrics stay behind the curtain. Focus on solving a real problem well and
making your work easy to understand and run.

**I have a question that isn't here.**
We'd love to hear it — email **alexis.david@lseg.com**.

---

*ORE AI Innovation Award 2026 — September 2026. Now go build something worth
celebrating.*
*Placeholders in [BRACKETS] must be finalized by the award team before publishing.*
