---
name: content-ppt
description: Build, continue, review, or revise content-heavy PowerPoint presentations for research, courses, engineering, technical reports, project reviews, and other evidence-heavy decks that need source research, story design, layout/density calibration, slide production specs, image review, editable PPT construction, or whole-deck QA. Do not use as the primary workflow for purely decorative, marketing, brand, or poster-style beautification.
---

# Content PPT Pipeline

Use this skill for content-first presentation work where correctness, evidence, structure, information density, traceable assets, and editable delivery matter more than decorative styling.

Explicit user instructions for the current task take priority over this workflow. Do not invent facts, sources, image contents, or tool results.

## Production modes

- Imagegen-assisted: GPT / ChatGPT native image generation ("Imagegen" in this skill) may be used for slide visuals or page generation. This term does not mean arbitrary third-party image-generation providers. Per-slide review may happen opportunistically during production; the mandatory acceptance gate is the whole-deck user review.
- Native-editable: final delivery must be natively editable PowerPoint with no Imagegen pixel/generation residue. Use real source images and data-driven charts where appropriate.

## Global invariants

1. Maintain production files in the ChatGPT/agent cloud workspace by default. Do not create the PPT project on the user's local machine merely because a connected tool can access it, unless the user explicitly requests a local path.
2. Never infer source/image contents from filenames, search snippets, or directory listings. Anything used, recommended, or sent as a reference must be actually opened/read/viewed as appropriate.
3. If an Imagegen handoff needs reference images, paths and filenames alone are not delivery. On chat-file delivery, the files must be actually sent to the current chat and the complete self-contained prompt delivered in the same response. On an explicitly selected local-file delivery surface, the required files and current prompt must instead be actually present and usable in the agreed project location.
4. Native-editable output uses editable PowerPoint text, equations, shapes, lines, arrows, charts, and structures wherever practical. Do not rasterize equations merely for convenience.
5. Do not silently mark a required workflow gate complete when the required capability is unavailable.
6. Do not create a separate Pipeline runtime-state file. For an existing project, treat its explicit README/protocol and canonical project files as durable project context. If the project needs cross-session continuity, current generation/review position may be kept in the README's current-status section rather than in a separate state file.

## Current-action routing

At the start of each turn, identify the primary action from the latest user request and current artifact. If the turn contains multiple actions, use all references actually required. Do not preload every technique just because the project is in a broad production stage.

### Project continuation / status control

Resume an existing PPT project, apply its project-level README/protocol, determine the current slide/action, handle "next slide" versus explicit status/review requests, and keep canonical project files synchronized with user feedback.

Authority: references/workflow.md. Add references/image-handoff.md when the turn also performs GPT ImageGen handoff or changes the delivery surface.

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

Review a page returned by the user against the canonical production spec and directly decide accept vs regenerate when the user has supplied a page for review. Do not push an assessable decision back to the user.

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

### Post-generation whole-deck repair

Use this action when a complete candidate deck already exists and the user identifies one or more issues during or after whole-deck review.

Do not restart the full pipeline by default. Triage the affected slides, preserve accepted content, reconstruct stale/missing slide specs when needed, and repair only the affected scope plus real dependencies.

Authority:

- revision triage, scope, dependencies, and whole-deck follow-up: references/workflow.md;
- regenerated pages and reference handoff: references/image-handoff.md;
- editable PowerPoint reconstruction, native objects, equations, overlays, and compatibility validation: references/ppt-authoring.md.

## Reference availability

Reuse authority already present and usable in the active context.

Do not reread a reference merely to prove that it is still present or to compare the context word-for-word against the source file.

Reread only when a concrete insufficiency becomes apparent, such as:

- only a summary or retelling remains;
- the prior read was explicitly truncated;
- a required rule for the current action cannot be recovered;
- the available authority is clearly partial or conflicting.

When the required authority is usable, proceed without rereading.
