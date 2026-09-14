# Rules & FAQ

## One-paste full-page SharePoint AI prompt

Paste this entire prompt into **Build a new page with AI**:

```text
Build a new full-width SharePoint page titled "Rules & FAQ" for the ORE AI Innovation Award 2026, matching the existing website as closely as standard SharePoint web parts allow. Use a compact midnight-blue hero with the eyebrow "THE OFFICIAL-BUT-FRIENDLY GUIDE", the title "Rules & FAQ" in white with FAQ accented in gold or sky blue, and the lead text below. Follow it with a centered, readable single-column white rules area, approximately 820px wide where supported, with a soft gold or neutral housekeeping callout, generous vertical spacing, deep-blue section headings separated from their content by subtle rules, standard bullets and numbered lists, inline-code styling for filenames, full-width tables with navy header rows and white header text, and alternating pale rows. Put the FAQ in a separate soft blue-gray full-width band with the eyebrow "QUICK ANSWERS" and use an accordion if available, otherwise use Heading 3 questions, Normal text answers, and dividers. Finish with a compact midnight-blue call-to-action band containing "All set?", "Now go build something worth celebrating.", and a filled gold or primary button labeled "How to Enter". Use only standard SharePoint web parts, keep the page responsive and accessible, and do not add stock images, decorative icons, a countdown, custom HTML, scripts, judging weights, prizes, eligibility groups, dates, links, claims, rules, or FAQ items beyond the exact content supplied below. Preserve all wording, dates, email addresses, links, filenames, headings, lists, tables, and ordering exactly.

HERO
Eyebrow: THE OFFICIAL-BUT-FRIENDLY GUIDE
Title: Rules & FAQ
Lead: Everything you need to know to enter. Read it once, then go build something great. Stuck on a detail? The award team is a quick email away.

CALLOUT
Housekeeping note: if this ever disagrees with another document, this one wins. Questions? Email alexis.david@lseg.com and make the email address a mailto link.

1. What this is all about
The ORE AI Innovation Award 2026 celebrates the best AI creation built for ORE - or for a great ORE use case. We're looking for work that's original, genuinely useful, nicely executed, and worth showing off in front of the whole team. Winners get their moment in the spotlight as part of ORE's 10-year anniversary celebrations. Winners will be announced sometime in November. No pressure. (Okay, a little pressure - the fun kind.)

2. Mark your calendar
Create a two-column table headed "Milestone" and "Date" with these rows:
Applications open | September 14, 2026
Applications close | October 18, 2026, 23:59 UK time
Judging period | 19–31 October 2026
Crowd Favorite voting | 19–31 October 2026
Winners announced | Sometime in November 2026, as part of ORE's 10-year anniversary celebrations

3. Who can enter
- Open to all Post-Trade Solutions employees.
- Fly solo or bring a team - your call. There's no team-size cap, so gather as many co-conspirators as you like.
- Got ideas for days? A person can pitch in on more than one entry.
- Each distinct project counts as one entry, and you're welcome to submit several - as long as each is genuinely its own thing, not the same project wearing a hat.
- The project must be AI-centered and relevant to ORE or an ORE use case.
- New or recently built is perfect. It should be substantially your team's own work for this award cycle. Already-running production systems may also be considered on a case-by-case basis - be upfront about it and make sure the AI contribution is genuinely yours.

4. How to enter
Six steps from idea to submission. Fill in the form, grab the kit, build the project, complete SUBMISSION.md, upload the project, and add your video.
1. Fill in the form: Fill in the online form and let us know you're in the game. Tell us what you're going to build, who's with you, the name of the project, and the data used. We will then provide you access to the GitLab repository.
2. Grab the submission kit: Clone the GitLab repository at https://gitlab.dx1.lseg.com/Alexis.David/ore-ai-innovation-award and create your own branch. It includes the standard submission form and automatic Copilot usage tracking. You can also grab the submission kit from Documents / Submission Kit.
3. Build your project: Make something AI-centered and relevant to ORE. Everyone uses GitHub Copilot for this award, and usage is captured automatically, so there is nothing to track by hand.
4. Fill in SUBMISSION.md: Complete the standard form with the problem, your approach, technologies and models used, setup instructions, the value it delivers, and who is behind it.
5. Upload your project: Push your project to its own branch in the GitLab repository, and don't forget to add the auto-generated Copilot files unchanged: COPILOT_USAGE_REPORT.md, usage-summary.json, and prompt-answer-log.jsonl.
6. Upload your video: Upload your demonstration video to the award SharePoint page in Documents / Submissions / Videos. This is necessary if you want people to vote for your project.
Prefer a walkthrough? See the How to Enter page.

5. What to bring
Every entry should show up with:
- A completed SUBMISSION.md - the problem, your approach, technologies/models, setup instructions, the value, and who's behind it.
- The working project - source code, or a hosted demo / recording if it can't be run locally.
- Screenshots or a short demo wherever they help tell the story.
- The untouched Copilot usage files: COPILOT_USAGE_REPORT.md, usage-summary.json, and prompt-answer-log.jsonl.
Half-finished submissions are hard to judge fairly, so a missing piece may cost you points - or a spot in the running.

6. Award categories
Every project is automatically entered into all six categories. You do not need to choose a category on the submission form; judges will consider the project wherever it clearly shines.
Create a two-column table headed "Category" and "The one for..." with these rows:
AI Game Changer | The strongest all-around entry
Boldest AI Idea | The most original concept and biggest creative leap
Customer Wow | The best-looking, most delightful user experience
Workday Hero | The idea that quietly makes everyone's workday better
Crowd Favorite | The people's champion, decided by community vote
J.A.R.V.I.S.'s Pick | The AI judge's favorite, based on build quality and Copilot telemetry (prompting effectiveness, token efficiency, process transparency)
And yes - one project can sweep multiple categories. Dream big.

7. How judging works
- Human-judged categories are scored by the award panel on the overall quality of the work: how well it cracks a real ORE problem, the strength of the idea, how well it's built, the user experience, and the value it delivers.
- Judges lean on your SUBMISSION.md, your demo, and the running project - so make it easy to understand and easy to run. Future-you will thank present-you.
- Ties are settled at the panel's discretion - usually over spirited debate.
- The judging panel: alexis.david@lseg.com (organiser & judge), joseph.o'brien@lseg.com, and jacob.ullman@lseg.com. Make all three addresses mailto links.

8. J.A.R.V.I.S.'s Pick & Copilot usage
J.A.R.V.I.S. is our AI judge, and it has a soft spot for projects that are both well built and built smart. Here's the deal:
- Usage is captured automatically. Open the project in VS Code and a task quietly reads your local Copilot chat logs to generate the usage report, JSON summary, and transcript. No spreadsheets, no manual tallying - you just build.
- It costs zero Copilot tokens. The collector is a local script that reads logs that already exist and never calls a model. Free of charge.
- Please don't touch the telemetry files. No hand-edits, no AI polishing. Their integrity is part of the judging, and we do check. Doctored files take you out of the running for J.A.R.V.I.S.'s Pick and can affect other categories too.
- Copilot is part of the entry. Every participant uses it, and the untouched telemetry files are included with every submission.

9. Crowd Favorite voting
- The winner is crowned by community vote during 19–31 October 2026.
- Voting is one vote per person, and rallying support for your project is fair game (within reason - keep it friendly).
- Ballot-stuffing (duplicate accounts, bots, and other creative schemes) is an instant exit. Win hearts, not scripts.

10. Keeping it fair
- Enter your own team's work, and give credit where it's due - call out any third-party code, models, datasets, assets, or templates you built on.
- Play nice with licenses for the models, libraries, and data you use.
- Nothing offensive, discriminatory, or against ORE policy. Easy.
- Tell it straight - no overselling what your project does or how it was built.

11. Data, security & privacy
- Leave the secrets at home. No API keys, passwords, or tokens in your submission. Use placeholders and hand any needed keys to judges separately.
- Using sensitive or ORE-internal data? Flag it on the submission form and make sure you're cleared to use it.
- Follow ORE's data-handling and security policies. Real customer data only if it's properly authorized and anonymized.
- Give your Copilot transcript files a quick once-over before submitting, just to confirm there's nothing in there you wouldn't want to share.

12. Who owns what
- You (and your team / ORE, per the usual employment and contractor terms) keep ownership of your work. It's yours.
- By entering, you're giving the award team the green light to present, demo, screenshot, and reference your submission to run and celebrate the award - think the anniversary event and internal shout-outs.
- If your project involves external partners or third-party IP, have a quick chat with the award team to sort out the specifics.

13. Prizes & bragging rights
- Winners are announced sometime in November as part of ORE's 10-year anniversary celebrations and take home an official award certificate (and, let's be honest, serious bragging rights).
- There's no cash or other prize - this one's about recognition in front of the whole team.

14. What gets you disqualified
We'd rather never use this section, but for the record, an entry can be pulled for:
- Missing required submission materials.
- Edited, fabricated, or tampered Copilot telemetry files.
- Plagiarism or borrowing others' work without saying so.
- Vote manipulation.
- Breaking ORE policy, security, or this document.

FAQ SECTION
Eyebrow: QUICK ANSWERS
Heading: Frequently Asked Questions

Question: Who can enter?
Answer: All Post-Trade Solutions employees are welcome. Solo acts and full-blown teams are equally welcome.

Question: Can I enter more than one project?
Answer: Absolutely - as long as each is genuinely its own thing. Every project is a separate entry with its own SUBMISSION.md.

Question: Can I be on more than one team?
Answer: Yep. Just make sure you're named on every submission you helped build.

Question: Do I have to use GitHub Copilot?
Answer: Yes. Copilot is part of the award workflow for every participant, and the untouched telemetry files are submitted with the project.

Question: How is Copilot usage measured? Do I have to track prompts and tokens myself?
Answer: Not a single spreadsheet required. Opening the project in VS Code auto-generates the usage report from your local Copilot logs - it costs zero tokens and reads data that's already there.

Question: Can I edit the usage report to clean it up?
Answer: Please don't. The telemetry files must be submitted exactly as generated. Hand-edits or AI touch-ups take you out of the running for J.A.R.V.I.S.'s Pick and can affect other categories.

Question: Does using more tokens help or hurt my score?
Answer: J.A.R.V.I.S. rewards smart use of AI - sharp prompting and efficient, purposeful token use - not raw volume. Burning tokens for the sake of it won't move the needle.

Question: My project can't be run locally. What do I do?
Answer: No sweat - drop in a hosted demo link and/or a short screen recording, and explain in the setup section why it can't run locally.

Question: Can I submit a project I built before September?
Answer: The AI work should be your team's own and relevant to this award cycle. Already-running production systems may also be considered on a case-by-case basis if you're upfront about it and the AI contribution is yours. When in doubt, just ask the award team.

Question: What if my project uses ORE-internal or customer data?
Answer: Flag it on the submission form, make sure you're cleared to use it, follow ORE data policies, and never include secrets. Anonymize wherever you can.

Question: Can I use open-source code, models, or templates?
Answer: Go for it - respect the licenses and give credit. The standout AI work should still be your team's.

Question: What does a strong submission look like?
Answer: A clear problem, an approach that makes sense, honest technology details, setup steps that actually work, a demo that lands, and a concrete statement of value. Clarity beats flash.

Question: When and where are winners announced?
Answer: Winners will be announced sometime in November as part of ORE's 10-year anniversary celebrations, once the October judging wraps up.

Question: Are the judging weights published?
Answer: Nope - the rubrics stay behind the curtain. Focus on solving a real problem well and making your work easy to understand and run.

Question: I have a question that isn't here.
Answer: We'd love to hear it - email alexis.david@lseg.com and make the address a mailto link.

FINAL CALL TO ACTION
Heading: All set?
Text: Now go build something worth celebrating.
Button: How to Enter
```

## SharePoint AI page prompt

Create a modern internal SharePoint page titled "Rules & FAQ" for the ORE AI Innovation Award 2026. Match the existing award homepage with a professional, restrained palette of midnight blue, navy, sky blue, teal, gold, coral, white, and soft blue-gray. Use standard SharePoint web parts only. This is policy content: preserve the supplied rules and FAQ wording exactly, including qualifications, dates, email addresses, category names, filenames, and links. Do not summarize, rewrite, omit, merge, or invent rules.

Use a dark midnight-blue title area with white text and the small eyebrow "THE OFFICIAL-BUT-FRIENDLY GUIDE". Add the centered award logo below the title without cropping it. Build the page in this order:

1. A soft gold or neutral one-column notice containing the approved introduction and the linked contact email alexis.david@lseg.com.
2. A white single-column rules area containing all numbered sections 1 through 14 in order. Use Heading 1 for each numbered rule title, Heading 2 for nested subjects, Normal text for paragraphs, and standard bullets and numbered lists. Use 48-pixel spacers before major rule headings.
3. Keep the milestone and award-category tables full width. Use a dark navy header row with white text and default body text size.
4. A separate white single-column section titled "Frequently Asked Questions". Format each approved question as Heading 3 and its answer as Normal text, with dividers between questions. Include every FAQ in the supplied source and keep the original order.
5. A compact midnight-blue final section with centered white text and a gold or primary button labeled "How to Enter".

Do not add a countdown, images other than the supplied award logo, stock photography, decorative icons, custom HTML, scripts, judging weights, prizes, eligibility groups, dates, or legal terms. Do not place long-form rules in columns or cards. Leave the demo-video destination and the How to Enter button destination ready for the editor to insert.

Generate only the page structure and visual treatment. Then paste the exact maintained rules source specified below into the generated Text web parts.

## AI section prompts

Paste these one at a time if SharePoint AI cannot generate the full layout reliably.

### Notice and rules layout

```text
Create a full-width, single-column SharePoint rules section for the ORE AI Innovation Award 2026. Start with a soft gold or neutral notice using the approved introduction and contact email. Below it, create space for numbered rules 1 through 14 on a white background. Use Heading 1 for each numbered rule title, Normal text for paragraphs, standard list formatting, and generous spacing. Keep tables full width with dark navy header rows and white header text. Do not write, summarize, reorder, or omit any rule; I will paste the approved copy after the layout is generated.
```

### FAQ layout

```text
Create a white, full-width, single-column SharePoint section titled "Frequently Asked Questions". Provide a clean long-form FAQ layout using Heading 3 for each question, Normal text for each answer, and a divider between entries. Do not generate questions or answers; I will paste the approved FAQ copy. Do not use cards or multiple columns.
```

### Final action

```text
Create a compact full-width final section with a midnight-blue background and centered white text for the ORE AI Innovation Award 2026. Add one filled gold or primary button labeled "How to Enter". Do not add other links, images, or copy. Leave the destination ready for the editor to insert.
```

## Page formatting

| Area | SharePoint section and web part | Formatting |
| --- | --- | --- |
| Title area | Full-width page title area | Midnight-blue `#010469` background; white page title; small bold, all-caps eyebrow in gold or sky. |
| Official notice | One-column Text web part | Put the housekeeping note first in a soft gold/neutral callout, if the tenant provides one. Use Normal text with the contact email as a link. |
| Rules 1-14 | One-column Text web part | Rule number and rule title use Heading 1. Any nested subject uses Heading 2. Use Normal text for paragraphs and default bullets for lists. Keep the body left-aligned. |
| Date and category tables | One-column Text web part | Use a dark theme header row with white text; retain default body text size; do not place tables in a narrow multi-column section. |
| FAQ | Separate one-column Text web part | Each question uses Heading 3 in deep blue; answer below it uses Normal text. Add a Divider between questions, or use a tenant-approved collapsible/accordion web part. |
| Final action | Full-width, one-column section | Midnight-blue background; centered white Heading 1 and body; gold or primary filled button. |

**Formatting:** Keep rules and FAQ content in a single full-width column for comfortable reading. Use 48 px Spacers before each major rule heading, and do not apply colored backgrounds to the detailed rules text.

Copy the complete, maintained rules source into the generated single-column **Text** web parts on the Rules & FAQ SharePoint page:

[Open the source rules and FAQ](../branding/templates/RULES_AND_FAQ.md)

Replace `[SHAREPOINT_LINK]` in Section 4 with the `Demo videos` folder sharing link before publishing.

For the FAQ, use a separate **Text** web part after the rules. Apply **Heading 3** to each question, with dark-blue theme text, and place its answer in the Normal-text paragraph immediately below it. This preserves the content in tenants where a collapsible/accordion web part is not enabled.

Add this final Button web part:

**How to Enter** -> `how-to-enter`