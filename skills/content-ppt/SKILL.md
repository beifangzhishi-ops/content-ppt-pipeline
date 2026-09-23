---
name: content-ppt
description: Build, continue, review, or revise content-heavy PowerPoint presentations for research, courses, engineering, technical reports, project reviews, and other evidence-heavy decks that need source research, story design, layout/density calibration, slide production specs, image review, editable PPT construction, or whole-deck QA. Do not use as the primary workflow for purely decorative, marketing, brand, or poster-style beautification.
---

# Content PPT Pipeline

Use this skill for content-first presentation work where correctness, evidence, structure, information density, traceable assets, and editable delivery matter more than decorative styling.

Explicit user instructions for the current task take priority over this workflow. Do not invent facts, sources, image contents, or tool results.

## Production modes

- Imagegen-assisted: Imagegen may be used for slide visuals or page generation. Generated pages are reviewed one by one before acceptance.
- Native-editable: final delivery must be natively editable PowerPoint with no Imagegen pixel/generation residue. Use real source images and data-driven charts where appropriate.

## Global invariants

1. Maintain production files in the ChatGPT/agent cloud workspace by default. Do not create the PPT project on the user's local machine merely because a connected tool can access it, unless the user explicitly requests a local path.
2. Never infer source/image contents from filenames, search snippets, or directory listings. Anything used, recommended, or sent as a reference must be actually opened/read/viewed as appropriate.
3. If an Imagegen handoff needs reference images, paths and filenames are not delivery. The files must be actually sent to the current chat, and the complete self-contained prompt must be delivered in the same response.
4. Native-editable output uses editable PowerPoint text, equations, shapes, lines, arrows, charts, and structures wherever practical. Do not rasterize equations merely for convenience.
5. Do not silently mark a required workflow gate complete when the required capability is unavailable.
6. Do not persist Pipeline runtime state in a separate state file. Infer the current action from the current user request and current artifact.

## Current-action routing

At the start of each turn, identify the primary action from the latest user request and current artifact. If the turn contains multiple actions, use all references actually required. Do not preload every technique just because the project is in a broad production stage.

### Content / evidence review

Check facts/domain logic, evidence, wording, equations, numbers, titles, conclusions, page order, slide specs, or the full spec pack. This does not hand off Imagegen references and does not create/edit a PPTX.

Authority: references/workflow.md.

### Asset inspection / selection

Find, open, view, and select real images or other assets for a slide, without yet performing the formal Imagegen handoff.

Authority: references/workflow.md; use the asset-inspection portion of references/image-handoff.md when actual visual selection is involved.

### Imagegen handoff

Prepare one slide for generation in a fresh Imagegen chat using a complete self-contained prompt and, when needed, delivered reference images.

Authority: references/image-handoff.md, plus workflow context when needed.

### Returned-slide review

Review a page returned by the user against the canonical production spec and directly decide accept vs regenerate. Do not push the decision back to the user when the defect is assessable.

Authority: references/workflow.md. If regeneration is required, the next action also needs references/image-handoff.md.

### Image regeneration

Revise a rejected slide's canonical spec/prompt and, if needed, resend reference assets.

Authority: references/workflow.md + references/image-handoff.md.

### Editable PPT build

Build the formal editable PPTX from accepted pages, specs, data, and real assets.

Authority: references/ppt-authoring.md, plus workflow context when needed.

### Editable PPT revision

Modify an existing editable PPTX: objects, equations, layout, real images, charts, or page structure.

Authority: references/ppt-authoring.md. Add references/image-handoff.md only if the repair also requires image regeneration.

### Whole-deck QA / final review

Review the complete candidate deck for story, terminology, facts, equations, numbers, titles, conclusions, density, images, duplicates, missing content, and mode-specific constraints; then run the mandatory user whole-deck review gate.

Authority: references/workflow.md. Load technique references only for repairs actually required.

## Reference availability

Reuse authority already present and usable in the active context.

Do not reread a reference merely to prove that it is still present or to compare the context word-for-word against the source file.

Reread only when a concrete insufficiency becomes apparent, such as:

- only a summary or retelling remains;
- the prior read was explicitly truncated;
- a required rule for the current action cannot be recovered;
- the available authority is clearly partial or conflicting.

When the required authority is usable, proceed without rereading.
