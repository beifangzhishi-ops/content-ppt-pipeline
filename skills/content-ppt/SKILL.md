---
name: content-ppt
description: Build, continue, review, generate, or revise evidence-heavy PowerPoint presentations using either ChatGPT with CCM or Codex with its native runtime. CPA is the separate visual-generation backend when needed.
---

# Content PPT Pipeline

Use this skill for content-first presentations where correctness, evidence, structure, information density, traceable assets, and editable delivery matter more than decorative styling.

## Runtime and backend contract

- **ChatGPT + CCM:** first-class project execution route; CCM provides the persistent workspace, files, tooling, and Git.
- **Codex native:** equally first-class route; use its native workspace and execution environment without CCM.
- **CPA:** use for page visual generation/regeneration. CPA is an independent backend, not the project runtime.
- **Content PPT Pipeline:** owns orchestration policy, evidence rules, page lifecycle, review gates, and PowerPoint delivery rules.

User instructions for the current task take priority over workflow defaults.

## Core contract

1. **Reground before each actual revision round.** Enter the active runtime; reread project README/protocol, AGENTS/AGENT, the current layout/master authority, and the primary source passages relevant to this revision. Inspect Git status before tracked edits. Do not rely solely on prior-chat recall; keep source reads scoped.
2. **Use project files as durable authority.** Chat history is transient context. Do not create a parallel state system.
3. **Inspect evidence and references.** Never infer image/source content from filenames, listings, snippets, or another model's description.
4. **Keep one current canonical spec and one current derived prompt per page.** Do not create v2/final/revised forks unless explicitly requested.
5. **Track page state as stage-scoped sets, not scalar progress:** approved / rework-unreviewed / not-generated within the active gate. Pages may be reviewed out of order; a generation-stage approval is not final editable or whole-deck approval.
6. **Every CPA result starts unreviewed.** File existence is not approval. A generated visual can enter approved-current only after actual visual review; reliably editable local fixes may be recorded for downstream work.
7. **One slide = one fresh CPA HTTP request.** Each request contains that page's current prompt and only that page's selected references. If the page has no references, send none. Do not carry forward any prior-page generation/session/conversation identifier or request context.
8. **Do not recursively feed generated presentation visuals back into CPA.** Old generated pages, rejected outputs, Pipeline-generated diagrams, and presentation-specific derived visuals are not CPA references unless the user explicitly overrides this for the current task.
9. **Protect the evidence boundary.** Actual project/practice evidence must come from traceable real sources or faithful deterministic reconstruction from real data. Do not generate realistic-looking substitutes for actual experiments, apparatus, measurements, results, sites, or project records. Conceptual illustrations and generic engineering/application scene-setting visuals may be generated when they do not carry the proof burden.
10. **Keep quantitative evidence deterministic.** Rebuild plots from data/code when possible; do not ask generation models to reinterpret exact axes, legends, values, uncertainty, or series mappings.
11. **Only change canonical/prompt when review identifies a real source/instruction defect.** A poor CPA render by itself is not evidence that canonical content is wrong.
12. **Material QA is not rendered QA.** The actual generated pages and final assembled deck must be visually reviewed.
13. **Use audience-facing, evidence-led language.** Prefer real, inspected apparatus/engineering images when available; avoid internal project codes in visible copy and defensive caveats without evidentiary value.
14. **Honor the established layout authority and explanatory purpose.** Diagrams need semantically meaningful relationships; review whether every visual supports the page's question and takeaway, not just whether it looks correct.

Project README/canonical may specialize workflow defaults, but do not silently weaken this core contract.

## Action routing

Load only the references needed for the current action.

### Start / resume / status

Restore current project state from the active runtime, project files, Git state, and local artifacts.

Read: `references/runtime.md` + `references/workflow.md`.

### Content / evidence review

Review narrative, evidence, numbers, equations, terminology, page roles, source identity, or the full material pack.

Always cover: narrative authority; experiment/condition/dataset identity; evidence role and strength; numeric/equation/statistical definitions; page duty; main-talk vs Q&A boundary; traceable workload; cross-page consistency.

Read: `references/workflow.md`.

### Material audit / evidence closure

Deep-review canonical specs, prompts, source/evidence indexes, data, derived figures, and QA/build logic. Continue complete passes until one pass finds no new substantive issue.

Read: `references/workflow.md` + `references/runtime.md`.

### Asset inspection / selection

Inspect and select real source/reference assets. Apply the evidence boundary before deciding whether an asset may be generated, reconstructed, or must remain a real source.

Read: `references/workflow.md` + `references/cpa-generation.md`.

### Pre-generation gate

Check canonical/prompt sync, prompt executability, reference eligibility, fresh-request inputs, and local output state before CPA submission.

Read: `references/workflow.md` + `references/cpa-generation.md` + `references/runtime.md`.

### CPA generation

Generate only pages that require generation. Every page uses a fresh CPA HTTP request with its own prompt and selected references only. Returned output enters candidate/rework-unreviewed until visually reviewed.

Read: `references/cpa-generation.md` + `references/runtime.md`.

### Generated-page review

Actually view the current generated page, compare it with canonical/prompt/eligible references, and decide approved vs rework.

Always check: wrong source/condition; invented evidence; numeric/formula/label errors; evidence readability; decorative content displacing evidence; stale page identity; density/layout; neighboring-page consistency.

Read: `references/cpa-generation.md` + `references/workflow.md` + `references/runtime.md`.

### Reuse / rebuild / new / retire planning

Classify existing pages using current canonical compatibility and approved-current artifact status.

Read: `references/workflow.md` + `references/runtime.md`.

### Editable PPT build or revision

Build or modify the formal PPTX from approved pages, canonical specs, real assets, data, and native objects.

For ImgGen-to-editable reconstruction, retain the current approved image as a temporary bottom alignment guide, reconstruct editable objects above it, and allow temporary double imagery. Preserve true scientific figure aspect ratios; redraw from source code/data rather than distorting them to fit.

Read: `references/ppt-authoring.md` + `references/runtime.md`.

### Research / thesis / proposal / midterm defense

When the deck is an academic or scientific defense, additionally apply the specific research-question, motivation, model-comparison, and evidence-claim narrative guidance.

Read: `references/research-defense.md` along with the action-specific references above.

### Whole-deck QA / final review

Actually inspect the complete rendered deck for narrative, terminology, facts, equations, numbers, titles, evidence readability, density, visual consistency, duplicates, omissions, and production-path constraints.

Read: `references/workflow.md` + `references/ppt-authoring.md`.

### Optional layout example

Use `references/examples/` only when explicitly selected by the user/project. Examples are not authority.

## Reference loading

For each actual revision round, reread current project authority and the directly relevant primary sources; the layout/master authority must already be established. Load only the action-specific skill references needed, and reread those when context is partial, stale, conflicting, or insufficient.
