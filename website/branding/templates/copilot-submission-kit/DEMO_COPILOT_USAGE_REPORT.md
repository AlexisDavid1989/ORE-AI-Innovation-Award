# Copilot Usage Report

This file is auto-generated. Do not edit manually.

## Integrity Notice

- Contestants must not modify telemetry artifacts manually.
- Contestants must not ask any AI tool to modify telemetry artifacts.
- Any mismatch between raw logs and generated telemetry may lead to disqualification.

## Collection Metadata

- Generated at (UTC): 2026-08-18T14:57:20.3802709Z
- Submission ID: anon-97e1bca73db7
- Workspace: <WORKSPACE> (anonymized)
- Source: VS Code Copilot chat session logs
- Token confidence: exact
- Activity attribution confidence: inferred

## Token Totals

- Requests counted: 107
- Prompt tokens: 11222269
- Completion tokens: 133726
- Total tokens: 11355995

## Activity Attribution (Inferred)

| Category | Estimated Tokens | Share % | Confidence |
|---|---:|---:|---|
| refactor_editing | 6784250 | 59.74 | medium |
| unknown | 1637894 | 14.42 | low |
| code_structure_reading | 1228781 | 10.82 | medium |
| code_generation | 952184 | 8.38 | medium |
| debugging_testing | 382277 | 3.37 | medium |
| planning_docs | 370609 | 3.26 | medium |

## Token Source Attribution (Where Usage Comes From)

| Token Source | Estimated Tokens | Share % of Total | Confidence |
|---|---:|---:|---|
| user_prompt_tokens | 6018420 | 53 | exact_or_mapped |
| reading_data_tokens | 2715253 | 23.91 | exact_or_mapped |
| system_overhead_tokens | 2336410 | 20.57 | exact_or_mapped |
| reading_code_structure_tokens | 141326 | 1.24 | exact_or_mapped |
| answer_generation_tokens | 133726 | 1.18 | exact_or_mapped |

Interpretation:
- reading_data_tokens: prompt tokens attributed to tool results (terminal/search outputs brought into context)
- reading_code_structure_tokens: prompt tokens attributed to files added to context
- answer_generation_tokens: completion tokens Copilot generated in reply (exact count; answer text is never read)
- user_prompt_tokens and system_overhead_tokens are included for transparency

## Top Token-Heavy Actions

| # | Category | Prompt Tokens | Completion Tokens | Total |
|---:|---|---:|---:|---:|
| 1 | refactor_editing | 262924 | 235 | 263159 |
| 2 | refactor_editing | 262467 | 351 | 262818 |
| 3 | refactor_editing | 261677 | 280 | 261957 |
| 4 | code_structure_reading | 260862 | 209 | 261071 |
| 5 | code_generation | 257852 | 1746 | 259598 |
| 6 | refactor_editing | 258563 | 350 | 258913 |
| 7 | unknown | 255615 | 172 | 255787 |
| 8 | refactor_editing | 245681 | 1521 | 247202 |
| 9 | refactor_editing | 238686 | 2523 | 241209 |
| 10 | refactor_editing | 238522 | 415 | 238937 |
| 11 | code_structure_reading | 195321 | 812 | 196133 |
| 12 | refactor_editing | 189234 | 1431 | 190665 |
| 13 | refactor_editing | 185670 | 1947 | 187617 |
| 14 | refactor_editing | 183716 | 2613 | 186329 |
| 15 | refactor_editing | 183045 | 1666 | 184711 |

## Model Usage by Prompt

| Model | Requests | Total Tokens | Share % of Total |
|---|---:|---:|---:|
| copilot/auto | 93 | 10343793 | 91.09 |
| copilot/claude-opus-4.8 | 14 | 1012202 | 8.91 |

## Mode Usage (Agent, Plan, Ask Workflow)

| Mode | Requests | Total Tokens | Share % of Total |
|---|---:|---:|---:|
| agent | 98 | 10990083 | 96.78 |
| Plan | 9 | 365912 | 3.22 |

## Custom Agent and Prompting Maturity

- Maturity score (0-100): 9
- Authored customizations: 0 (custom agents: 0, custom modes: 0, prompt files: 0, instruction files: 0)
- Custom mode usage: 0 requests (0% of tokens)
- Subagent delegation: 2 invocations (1.87% of requests)

Interpretation: higher scores reflect building and using reusable customizations (custom agents/modes, prompt files, instructions) and delegating scoped work to subagents. Only counts are recorded; no file names or content are collected.

## Prompt and Answer Allocation

- The collector never reads the text of prompts or answers. Only token counts and structured metadata (model, mode, tools) are processed.
- Per-request token allocation (no content) is in: .github/copilot-usage/prompt-answer-log.jsonl
- Structured per-request records (no content) are also embedded in: .github/copilot-usage/usage-summary.json under request_records

## Submission Guidance

Submit this file, .github/copilot-usage/usage-summary.json, and .github/copilot-usage/prompt-answer-log.jsonl with the project.

Do not edit these telemetry files manually or through AI-assisted edits.
