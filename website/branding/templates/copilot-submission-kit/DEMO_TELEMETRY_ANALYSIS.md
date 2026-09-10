# Demo Telemetry Analysis (Example Judge Review)

This is an example of the kind of analysis an AI judge can produce **from the anonymized
summary files alone** (no prompt/answer content). It accompanies `DEMO_COPILOT_USAGE_REPORT.md`.

- Submission ID: `anon-97e1bca73db7`
- Basis: anonymized metrics only (token counts exact; activity categories inferred)

## Headline Numbers (Derived)

- 102 requests, 10.73M total tokens -> ~105k tokens/request average
- Prompt : completion ratio = ~85 : 1 (completions are only 1.16% of all tokens)
- Top 15 actions each carry ~250-260k prompt tokens for tiny outputs (172-2,600 completion)
- Customization maturity score: 9 / 100 (0 authored customizations, 0 custom-mode use, 2 subagent invocations)

## Verdict

Strong discipline in *choices*, weak in *context efficiency*.

### Good Practices Evident

- **Model discipline** - 96% on `copilot/auto`, reserving `claude-opus-4.8` for only 9 targeted
  requests. Premium models are not wasted on trivial turns.
- **Some planning before acting** - 9 requests (3.4%) in Plan mode, showing work is scoped rather
  than always diving straight in.
- **Look-before-edit behavior** - 9% `code_structure_reading` plus explicit reading turns suggest
  context is inspected before changes are made.
- **Low debugging churn** (2.35%) - little time lost to error-chasing.

### The Dominant Problem: Context Bloat

- ~98% of every token is input context/overhead, not output. Source split: `user_prompt` 54%
  (mostly accumulated chat history), `reading_data` 23% (tool results kept in context),
  `system_overhead` 20%. Only ~1.2% is actual generated content.
- The top actions - ~260k prompt tokens to produce a 235-token answer - are the signature of one
  long, ever-growing conversation where the entire history is resent each turn.
- 63% `refactor_editing` with small completions = many micro-iterations (trial-and-error tweaking)
  rather than fewer, well-scoped edits.

### Low Custom Agent / Prompting Maturity

- Maturity score 9/100. The submission used only built-in modes (`agent`, `Plan`) and authored no
  reusable customizations (custom agents, custom modes, prompt files, or instruction files).
- Delegation was minimal: 2 subagent invocations across 106 requests (1.87%).
- Encoding standards once in custom instructions would also directly cut the context bloat above,
  since repeated context would not need to be re-sent each turn.

## Illustrative Scorecard

Weights/thresholds are hidden (judge-only). Grades below are illustrative.

| Dimension | Read | Grade |
|---|---|---|
| Model selection | Auto-first, opus sparingly | A |
| Mode/workflow fit | Some Plan use, mostly agent | B |
| Token efficiency | 85:1 prompt:completion, ~100k/req | D |
| Context management | 98% context/overhead | D+ |
| Iteration discipline | Heavy micro-refactor loop | C |
| Custom agent / prompting maturity | Built-in only, no customizations, 9/100 | D |

## Top Recommendations (Biggest Lever First)

1. **Manage session length** - start fresh chats per task; long threads resend all history
   (the #1 cost driver here).
2. **Trim context** - do not keep large tool outputs/files in context after they are used.
3. **Batch edits** - combine related tweaks into one scoped request instead of many small turns.
4. **Keep the good habits** - model discipline and Plan-mode usage are genuinely strong; do more
   Plan-first.
5. **Invest in reusable customizations** - author custom instructions, prompt files, or a custom
   agent, and delegate scoped work to subagents; this raises prompting maturity and cuts token cost.
