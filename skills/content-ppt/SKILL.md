---
name: content-ppt
description: Build, continue, review, generate, or revise evidence-heavy PowerPoint presentations in ChatGPT Plus, with CCM as the preferred persistent project runtime and direct image generation as the preferred Imagegen-assisted production path when an authorized backend is available.
---

# Content PPT Pipeline

Use this skill for content-first presentation work where correctness, evidence, structure, information density, traceable assets, generation review, and editable delivery matter more than decorative styling.

This skill is designed primarily for ChatGPT Plus users running persistent PPT projects with CCM. Explicit user instructions for the current task always take priority.

## Product model

- **ChatGPT Plus / GPT**: interaction, reasoning, research, review, and orchestration.
- **CCM workspace**: preferred durable project runtime for canonical files, prompts, references, status, scripts, generated candidates, approved artifacts, and Git.
- **Direct image-generation backend**: preferred Imagegen-assisted execution path when the current environment has a user-authorized, project-allowed capability that can submit prompts/references and return results to the local workspace.
- **Manual handoff**: fallback when direct generation is unavailable or explicitly requested.
- **Native-editable PowerPoint**: formal editable output path when required.

Recommended deployment for Plus users: **ChatGPT Plus + Content PPT Pipeline + CCM + CPA ImageGen**. CPA is a recommended direct-generation backend, not a hard dependency; Plus does not itself imply CPA/API authorization.

ChatGPT Library is not a production-state or artifact-registry dependency. Treat a Library file as an ordinary external input only when the user explicitly supplies or selects it.

## Global invariants

1. For a persistent project, prefer the selected CCM workspace as the durable runtime. Do not create a parallel cloud/local project copy merely for convenience.
2. At project entry or resume, read the project README/protocol and AGENTS/agent rules before changing tracked files.
3. Never infer source/image contents from filenames, listings, snippets, or another model's description. Anything used as evidence or an Imagegen reference must be actually inspected.
4. Keep one canonical slide spec and, when used, one current derived prompt per slide. Do not create v2/final/revised forks unless the user explicitly requests version history.
5. Do not create a separate Pipeline runtime-state file. Persist project status in the existing README/protocol and actual local artifacts.
6. Cross-session page state is a **set model**, not a scalar progress counter:
   - approved;
   - rework/unreviewed;
   - not-generated.
   Pages may be generated and reviewed out of order. A gap never blocks later page review.
7. A generated file is not reusable merely because it exists. Reuse requires current canonical compatibility and a clearly approved current artifact.
8. New generation results always enter rework/unreviewed first. Move them to approved only after actual visual review.
9. Before changing canonical after a bad result, classify the failure:
   - canonical/evidence/prompt defect;
   - generation execution/input mismatch;
   - model rendering defect;
   - infrastructure/provider failure.
   Wrong prompt/reference upload or other execution mismatch must not be used to justify changing correct canonical content.
10. Imagegen reference inputs must be actual image files such as PNG, JPG/JPEG, or WebP. Do not pass PDFs directly; convert the exact needed page/figure and inspect the converted image first.
11. Do not recursively use old generated pages, rejected generations, Pipeline-generated diagrams, or presentation-specific derived visuals as new Imagegen references unless the user explicitly overrides this rule for the current task.
12. Quantitative plots are evidence. Reproduce them deterministically from data/code when possible; do not ask Imagegen to reinterpret numeric axes, legends, or data values.
13. Native-editable output uses editable PowerPoint objects wherever practical.
14. Do not silently mark a workflow gate complete when a required capability is unavailable.

## Current-action routing

At each turn, identify the current action and load only the authority required for that action.

### Start / resume / status

Resume an existing CCM project, restore state from README/protocol, canonical files, and local artifacts, or initialize a durable project structure.

Authority: references/ccm-runtime.md + references/workflow.md.

### Content / evidence review

Review scientific/domain logic, narrative, evidence, wording, equations, numbers, titles, conclusions, page roles, source identity, or the full spec pack.

Authority: references/workflow.md.

### Material audit / evidence closure

Deep-review a long-running deck across canonical specs, prompts, source/evidence indexes, data, derived-figure scripts, and QA/build logic. Lock the project-declared narrative authority first. Fix findings directly in owning project files and continue complete passes until one full pass finds no new substantive issue.

Material closure does **not** mean generated pages or the final deck have passed visual review.

Authority: references/workflow.md + references/ccm-runtime.md for persistence.

### Asset inspection / selection

Find, open, inspect, and select real source images or other visual inputs.

Authority: references/workflow.md + references/image-generation.md.

### Pre-generation production gate

Before any generation, validate current canonical/prompt synchronization, prompt executability, reference eligibility, and the selected page's local output status.

Authority: references/workflow.md + references/image-generation.md + references/ccm-runtime.md.

### Direct Imagegen production

When an authorized direct-generation capability is available and project policy allows it, use it as the default Imagegen-assisted path. Generate to the local CCM workspace, review returned outputs, update page state, regenerate failures, and archive approved current artifacts.

Use a bounded parallel queue when useful; do not hard-code a universal concurrency value.

Authority: references/image-generation.md + references/ccm-runtime.md + workflow context.

### Manual Imagegen handoff

Use only when direct generation is unavailable, degraded, or explicitly requested. Prepare complete current prompt TXT files plus eligible image references for the required pages and deliver them on the selected surface.

Authority: references/image-generation.md.

### Deck reuse / regeneration planning

Classify existing pages as reuse / rebuild / new / retire based on current canonical compatibility and approved-artifact status.

Authority: references/workflow.md + references/ccm-runtime.md.

### Returned/generated page review

Actually view the current generated page, compare it with canonical, prompt, and eligible real references, decide approve vs rework, classify the failure cause, and update local state.

Authority: references/workflow.md + references/image-generation.md + references/ccm-runtime.md.

### Editable PPT build or revision

Build or modify the formal editable PPTX from approved pages, canonical specs, real assets, data, and native objects.

Authority: references/ppt-authoring.md + references/ccm-runtime.md.

### Whole-deck QA / final review

Actually review the complete rendered deck for narrative, terminology, facts, equations, numbers, titles, density, evidence readability, visual consistency, duplicates, omissions, and mode-specific constraints.

Material QA, prompt QA, or page-state bookkeeping cannot substitute for rendered-deck review.

Authority: references/workflow.md + references/ppt-authoring.md.

### Optional layout example

Use references/examples/ only when the user explicitly selects an example or the current project protocol selects one. Examples are not authority.

## Reference availability

Reuse authority already present and usable in the active context. Reread a reference only when the available context is truncated, partial, conflicting, or insufficient for the current action.
