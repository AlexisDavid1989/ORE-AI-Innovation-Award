# Copilot Usage Report

This file is auto-generated. Do not edit manually.

## Integrity Notice

- Contestants must not modify telemetry artifacts manually.
- Contestants must not ask any AI tool to modify telemetry artifacts.
- Any mismatch between raw logs and generated telemetry may lead to disqualification.

## Collection Metadata

- Generated at (UTC): 2026-09-09T14:09:58.9146065Z
- Submission ID: anon-97e1bca73db7
- Workspace: <WORKSPACE> (anonymized)
- Source: VS Code Copilot chat session logs
- Token confidence: exact for requests present in the local logs
- Activity attribution confidence: inferred

## Token Totals

- Requests counted: 242
- Prompt tokens: 21735220
- Completion tokens: 284364
- Total tokens: 22019584

> **Sub-agent usage notice:** These totals include only model requests present in the local VS Code logs. A sub-agent invocation can be visible without its child model calls being recorded here, so sub-agent token usage may not be included in the total.

## Activity Attribution (Inferred)

| Category | Estimated Tokens | Share % | Confidence |
|---|---:|---:|---|
| refactor_editing | 11298747 | 51.31 | medium |
| unknown | 4065690 | 18.46 | low |
| code_structure_reading | 3406977 | 15.47 | medium |
| debugging_testing | 1680483 | 7.63 | medium |
| code_generation | 1115641 | 5.07 | medium |
| planning_docs | 452046 | 2.05 | medium |

## Token Source Attribution (Where Usage Comes From)

| Token Source | Estimated Tokens | Share % of Total | Confidence |
|---|---:|---:|---|
| user_prompt_tokens | 9512772 | 43.2 | exact_or_mapped |
| reading_data_tokens | 6262867 | 28.44 | exact_or_mapped |
| system_overhead_tokens | 5362943 | 24.36 | exact_or_mapped |
| reading_code_structure_tokens | 571261 | 2.59 | exact_or_mapped |
| answer_generation_tokens | 284364 | 1.29 | exact_or_mapped |

Interpretation:
- reading_data_tokens: prompt tokens attributed to tool results (terminal/search outputs brought into context)
- reading_code_structure_tokens: prompt tokens attributed to files added to context
- answer_generation_tokens: completion tokens Copilot generated in reply (exact count; answer text is never read)
- user_prompt_tokens and system_overhead_tokens are included for transparency

## Top Token-Heavy Actions

| # | Category | Prompt Tokens | Completion Tokens | Total |
|---:|---|---:|---:|---:|
| 1 | unknown | 348440 | 1369 | 349809 |
| 2 | refactor_editing | 271463 | 3234 | 274697 |
| 3 | code_structure_reading | 271926 | 155 | 272081 |
| 4 | refactor_editing | 264030 | 1764 | 265794 |
| 5 | refactor_editing | 261336 | 2422 | 263758 |
| 6 | refactor_editing | 262924 | 235 | 263159 |
| 7 | refactor_editing | 262467 | 351 | 262818 |
| 8 | refactor_editing | 261677 | 280 | 261957 |
| 9 | code_structure_reading | 260862 | 209 | 261071 |
| 10 | code_generation | 257852 | 1746 | 259598 |
| 11 | refactor_editing | 258563 | 350 | 258913 |
| 12 | unknown | 255615 | 172 | 255787 |
| 13 | refactor_editing | 245681 | 1521 | 247202 |
| 14 | refactor_editing | 236879 | 4695 | 241574 |
| 15 | refactor_editing | 238686 | 2523 | 241209 |

## Model Usage by Prompt

| Model | Requests | Total Tokens | Share % of Total |
|---|---:|---:|---:|
| copilot/auto | 187 | 15930422 | 72.35 |
| copilot/claude-opus-4.8 | 33 | 3374794 | 15.33 |
| copilot/claude-sonnet-5 | 7 | 1760343 | 7.99 |
| copilot/gpt-5.6-sol | 15 | 954025 | 4.33 |

## Mode Usage (Agent, Plan, Ask Workflow)

| Mode | Requests | Total Tokens | Share % of Total |
|---|---:|---:|---:|
| agent | 225 | 21374000 | 97.07 |
| Plan | 13 | 468342 | 2.13 |
| Ask | 4 | 177242 | 0.8 |

## Custom Agent and Prompting Maturity

- Maturity score (0-100): 8
- Authored customizations: 0 (custom agents: 0, custom modes: 0, prompt files: 0, instruction files: 0)
- Custom mode usage: 0 requests (0% of tokens)
- Subagent delegation: 4 invocations (1.65% of requests)

Interpretation: higher scores reflect building and using reusable customizations (custom agents/modes, prompt files, instructions) and delegating scoped work to subagents. Only counts are recorded; no file names or content are collected.

## Prompt and Answer Allocation

- The collector never reads the text of prompts or answers. Only token counts and structured metadata (model, mode, tools) are processed.
- Per-request token allocation (no content) is in: telemetry/output/prompt-answer-log.jsonl
- Structured per-request records (no content) are also embedded in: telemetry/output/usage-summary.json under request_records

## Submission Guidance

Submit this file, telemetry/output/usage-summary.json, and telemetry/output/prompt-answer-log.jsonl with the project.

Do not edit these telemetry files manually or through AI-assisted edits.
