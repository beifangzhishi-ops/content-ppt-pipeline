# Content PPT Workflow

This file owns the business workflow: intake, research, calibration, deck design, canonical slide specs, pack-level review, returned-page review, assembly transitions, post-generation revision, and whole-deck final review.

It does not own detailed file-handoff mechanics or PowerPoint object-authoring mechanics.

## 1. Intake and mode

Determine the presentation goal, audience, evidence base, desired length, available source materials, and delivery expectations from the current request and artifacts.

Use one of two production modes:

- Imagegen-assisted: Imagegen may participate in page visual production. Per-slide review is optional/opportunistic; the mandatory acceptance gate is the user whole-deck review.
- Native-editable: final PowerPoint must contain no Imagegen pixel/generation residue; final content is rebuilt from native PowerPoint objects, real source images, and data-derived charts.

Do not create a persistent mode/stage state file. The current mode and stage should be inferable from the current task and artifacts.

## 2. Source understanding

Read the source materials systematically enough to understand:

- the central claim or purpose;
- major sections and dependencies;
- terms, entities, equations, numeric results, and constraints;
- which claims require citation or visual evidence;
- which source figures/tables/images may be useful.

Do not infer a document/image's contents from its filename, search result, path, or metadata alone.

When searching external references, favor sources suitable for the deck's level of formality and evidentiary burden. Keep claims traceable to their real sources.

### Visual-role classification

Before deciding whether to find a real image, rebuild a figure, or generate a visual, classify what role the image plays:

- **Evidence / project-specific factual visual**: proves or depicts an actual experiment, actual apparatus, actual measurement, actual project result, actual site, or specific named real-world object. Use traceable real sources or faithful reconstruction from real data; do not substitute Imagegen.
- **Conceptual scientific illustration**: explains a mechanism, structure, process, physical relationship, or generic experimental concept. Imagegen may be used when it does not imply that the result is an actual measurement or actual project record.
- **Application / scene-setting illustration**: establishes engineering context, motivation, industry environment, or application background. Imagegen may be photorealistic here when it does not claim to depict a specific real project/site or carry quantitative evidence.

Photorealism itself is not the deciding factor. The deciding factor is whether the image is being used as evidence or as illustration.

If a slide discusses a specific named plant, facility, experiment, or case and the identity of that object is part of the factual claim, prefer a real source image rather than a generated lookalike.

## 3. Visual and information-density calibration

Before producing the full deck, calibrate:

- formality level;
- information density;
- title/body hierarchy;
- use of equations, tables, charts, and real images;
- representative page patterns;
- master anchors and density range.

Do not enforce a universal fixed text-to-image ratio. The correct density depends on the material and slide role.

For a content-heavy deck, visual quality means disciplined hierarchy and readable evidence, not decorative emptiness.

## 4. Deck design

Design the story and page order autonomously from the content. Avoid simply mirroring source document headings.

Each slide should have:

- a clear role in the story;
- one main information objective;
- a title that states the slide's purpose or conclusion;
- enough evidence to support its takeaway;
- a deliberate relationship to the previous and next slide.

Use derivation/process pages when the reasoning itself matters. Split overloaded slides instead of hiding important logic in tiny text.

## 5. Canonical per-slide production spec

Create one canonical, self-contained production spec for every slide before batch production.

Each spec should contain, as applicable:

- slide number and title;
- communicative purpose;
- key facts/claims;
- equations and numeric values;
- source attribution requirements;
- real images/figures/tables that may be used;
- generated visual instructions when applicable;
- layout structure and reading order;
- target information density;
- slide conclusion/takeaway;
- explicit prohibitions or common failure modes.

Do not write specs that depend on “same as previous slide” or other hidden cross-slide instructions. A production spec should be usable on its own.

## 6. Full-pack self-audit before batch production

Before generating or building the full deck, audit the entire spec pack as one system.

Check at least:

- factual/domain correctness;
- story continuity;
- equations and numbers;
- title/conclusion alignment;
- source traceability;
- real images actually viewed before being selected;
- asset-to-slide fit;
- information density and master consistency;
- self-contained slide specs;
- missing slides or orphan slides;
- unnecessary repetition;
- conflicting terminology or numeric values;
- broken encoding/file references.

Run more than one review pass when the deck is complex. The purpose is to make the pack production-ready before expensive page generation.

## 7. Imagegen-assisted per-slide loop

When using Imagegen-assisted mode, production may proceed slide by slide, but user review of every slide is not a mandatory gate.

Formal handoff mechanics are owned by image-handoff.md.

When the user returns a generated page:

1. Actually inspect the returned image.
2. Compare it with the current canonical production spec.
3. Prioritize factual/domain errors, evidence mistakes, readability, hierarchy, structure, and obvious layout failures.
4. Decide directly:
   - accept when the page is production-usable;
   - regenerate when a material defect remains.
5. If regenerating, update the canonical spec/prompt only where needed, then use the Imagegen handoff workflow again.
6. If accepted, immediately move to the next slide handoff unless the user has changed the task.

If no per-slide review is requested, continue production and rely on whole-deck review as the mandatory user gate.

Do not ask “continue?” after every accepted page when the planned workflow clearly calls for the next slide.

## 8. Transition to editable PowerPoint

Transition based on the selected production mode and the current delivery goal.

Detailed native PowerPoint construction is owned by ppt-authoring.md.

Imagegen-assisted mode may assemble accepted generated page visuals directly when that is part of the chosen final mode.

Native-editable mode must rebuild the final deck with no Imagegen pixel/generation residue.

## 9. Whole-deck QA

Before asking the user for the final review, inspect the whole candidate deck.

Check:

- story and page order;
- terminology consistency;
- equations and numbers;
- titles and conclusions;
- evidence/source correctness;
- readability and density;
- image quality and image-to-claim fit;
- duplicated/missing slides;
- broken/cropped content;
- master/layout consistency;
- Native-editable mode: no Imagegen residue remains.

Repairs transition into the appropriate current action:

- content/story fix -> content/evidence review;
- regenerated page -> Imagegen regeneration;
- editable object/layout fix -> editable PPT revision.

## 10. Mandatory user whole-deck review

After internal whole-deck QA, the user must have a chance to review the complete deck as a whole.

Treat this as a real gate, not a courtesy phrase.

If the user requests targeted changes, enter the post-generation revision round below.

After repairs, repeat the relevant QA checks before final delivery.

## 11. Post-generation revision round

Use this phase when a complete candidate deck already exists and the user identifies problems after whole-deck generation/assembly.

Do not restart source intake, visual calibration, deck design, or full-pack generation by default. Start from:

- the current deck/page;
- the user's latest feedback;
- authoritative source material;
- already accepted cross-slide constraints.

### Revision triage

For each affected slide, classify the problem as one or more of:

- scientific/content/logic;
- asset/evidence;
- generated visual/layout;
- editable-object;
- structural deck change such as add/delete/split/reorder.

Repair the smallest scope that fully resolves the defect and its real dependencies.

### Canonical spec recovery

If the current canonical slide spec still exists and matches the accepted state, update it.

If it is missing, stale, hard to recover, or conflicts with the current page, reconstruct a new canonical spec from the current artifact, latest feedback, authoritative sources, and accepted constraints. Missing old prompts must not block repair.

### Preserve accepted content

Preserve user-accepted scientific content, unaffected correct content, confirmed numbers/equations, asset choices, and visual constraints.

Change only the defect and dependent content. If newly verified evidence overturns an accepted item, the new evidence wins and affected dependent slides must be updated.

The user may explicitly accept a non-blocking defect and continue. Per-slide acceptance is not a mandatory gate.

### Structural changes

If the repair changes slide count or order:

- update numbering/order;
- re-check adjacent-slide logic;
- re-check cross-slide terminology, equations, claims, and conclusions;
- rerun QA on affected neighbors;
- rerun whole-deck QA before final delivery.
