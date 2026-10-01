---
name: content-ppt
description: Build, continue, review, generate, or revise evidence-heavy PowerPoint presentations for ChatGPT Plus users with CCM as the persistent project runtime and CPA ImageGen as the Imagegen-assisted production backend.
---

# Content PPT Pipeline

This skill is designed for **ChatGPT Plus + CCM + CPA ImageGen**.

- GPT: reasoning, research, review, and orchestration.
- CCM workspace: durable project runtime.
- CPA ImageGen: Imagegen-assisted production backend.
- PowerPoint authoring: final deck assembly/editable output when required.

ChatGPT Library is not part of the production runtime.

## Core contract

These are the requirements most likely to cause serious drift if missed.

1. **Enter the CCM project first.** Read the project README/protocol and AGENTS/AGENT before changing tracked files.
2. **Use project files as durable authority.** Chat history is transient context; do not create a parallel state system.
3. **Inspect evidence and references.** Never infer image/source content from filenames, listings, snippets, or another model's description.
4. **Keep one current canonical spec and one current derived prompt per page.** Do not create v2/final/revised forks unless explicitly requested.
5. **Track page state as sets, not progress counters:** approved / rework-unreviewed / not-generated. Pages may be generated and reviewed out of order.
6. **Every CPA result starts unreviewed.** File existence is not approval. Only visually reviewed output enters approved-current.
7. **Do not recursively feed generated presentation visuals back into ImageGen.** Old generated pages, rejected outputs, Pipeline-generated diagrams, and presentation-specific derived visuals are not CPA reference inputs unless the user explicitly overrides this for the current task.
8. **Keep quantitative evidence deterministic.** Rebuild plots from data/code when possible; do not ask ImageGen to reinterpret numeric axes, legends, or values.
9. **Only change canonical/prompt when review identifies a real source/instruction defect.** A bad CPA render by itself is not evidence that canonical content is wrong.
10. **Material QA is not rendered QA.** The actual generated pages and final assembled deck must be visually reviewed.

User instructions for the current task take priority over workflow defaults. Project README/canonical may specialize workflow defaults, but do not silently weaken the core contract.

## Action routing

Load only the references needed for the current action.

### Start / resume / status

Restore current project state from CCM workspace files and local artifacts.

Read: `references/ccm-runtime.md` + `references/workflow.md`.

### Content / evidence review

Review narrative, evidence, numbers, equations, terminology, page roles, source identity, or the full material pack.

Always cover: narrative authority; experiment/condition/dataset identity; evidence role and strength; numeric/equation/statistical definitions; page duty; main-talk vs Q&A boundary; traceable workload; cross-page consistency.

Read: `references/workflow.md`.

### Material audit / evidence closure

Deep-review canonical specs, prompts, source/evidence indexes, data, derived figures, and QA/build logic. Continue complete passes until one pass finds no new substantive issue.

Do not stop at wording cleanup. A pass is substantive only when source identity, evidence strength, quantitative definitions, page responsibility, and owning-source consistency have been checked.

Read: `references/workflow.md` + `references/ccm-runtime.md`.

### Asset inspection / selection

Inspect and select real source/reference assets.

Read: `references/workflow.md` + `references/image-generation.md`.

### Pre-generation gate

Check canonical/prompt sync, prompt executability, reference eligibility, and local output state before CPA submission.

Read: `references/workflow.md` + `references/image-generation.md` + `references/ccm-runtime.md`.

### CPA ImageGen production

Use CPA as the Imagegen-assisted production path. Generate into the local CCM project, review returned outputs, regenerate failed renders, and archive approved-current artifacts. Use a bounded parallel queue when useful.

Read: `references/image-generation.md` + `references/ccm-runtime.md`.

### Generated-page review

Actually view the current generated page, compare it with canonical/prompt/eligible references, and decide approved vs rework.

Always check: wrong source/condition; invented evidence; numeric/formula/label errors; evidence readability; decorative content displacing evidence; stale page identity; density/layout; neighboring-page consistency.

Read: `references/image-generation.md` + `references/workflow.md` + `references/ccm-runtime.md`.

### Reuse / rebuild / new / retire planning

Classify existing pages using current canonical compatibility and approved-current artifact status.

Read: `references/workflow.md` + `references/ccm-runtime.md`.

### Editable PPT build or revision

Build or modify the formal PPTX from approved pages, canonical specs, real assets, data, and native objects.

Read: `references/ppt-authoring.md` + `references/ccm-runtime.md`.

### Whole-deck QA / final review

Actually inspect the complete rendered deck for narrative, terminology, facts, equations, numbers, titles, evidence readability, density, visual consistency, duplicates, omissions, and mode-specific constraints.

Read: `references/workflow.md` + `references/ppt-authoring.md`.

### Optional layout example

Use `references/examples/` only when explicitly selected by the user/project. Examples are not authority.

## Reference loading

Reuse authority already available in the active context. Reread a reference when current context is partial, stale, conflicting, or insufficient.
