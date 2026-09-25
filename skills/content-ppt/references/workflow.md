# Content PPT Workflow

This file owns the business workflow: intake, research, calibration, deck design, canonical slide specs, pack-level review, returned-page review, assembly transitions, post-generation revision, and whole-deck final review.

It does not own detailed file-handoff mechanics or PowerPoint object-authoring mechanics.

## 1. Intake and mode

Determine the presentation goal, audience, evidence base, desired length, available source materials, and delivery expectations from the current request and artifacts.

Use one of two production modes:

- Imagegen-assisted: GPT / ChatGPT native image generation may participate in page visual production. In this skill, "Imagegen" refers specifically to that native GPT / ChatGPT capability, not to arbitrary third-party image-generation providers. Per-slide review is optional/opportunistic; the mandatory acceptance gate is the user whole-deck review.
- Native-editable: final PowerPoint must contain no Imagegen pixel/generation residue; final content is rebuilt from native PowerPoint objects, real source images, and data-derived charts.

Do not create a separate persistent mode/stage state file. The current mode and action should be inferable from the current request, project README/protocol, canonical files, and current artifacts. If an existing project keeps cross-session production status, the project's README current-status section contains exactly two production values: generated progress and consecutively reviewed/approved progress.

For an existing project, use this precedence unless the user explicitly says otherwise:

1. the user's latest explicit instruction;
2. the project's explicit README/protocol and canonical project files;
3. this skill's reusable defaults.

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

### Project-local context and source registry

For a long-running PPT project, treat project files as durable context rather than relying only on chat history.

- Keep long-lived, cross-slide project rules, source conventions, workflow choices, and current project status in the project's existing README/protocol when that is how the project is organized.
- Keep slide-specific content, layout, asset roles, generation constraints, and slide feedback in that slide's canonical production spec.
- When user feedback changes a slide, write the change into the appropriate project file first, then regenerate the prompt/handoff from the updated canonical content. Do not maintain a separate chat-only version.
- Do not turn the project README into a chronological list of per-slide mistakes or retries. Keep it as durable project description, reusable rules, source registry, and concise current status.
- When a materially important new paper, deck, dataset, experiment record, figure source, or asset directory is discovered, register it in the project's existing source index/README when that information will matter across later slides. Record enough provenance to identify the source, its role, version/date when available, review status, and whether any working copy was made.
- A readable source location does not imply permission to modify it. If a source tree is designated read-only, keep canonical files and derived work in the working project and leave the source untouched.
- Do not copy a large source tree merely for convenience when a stable read-only original can remain the source of truth; copy only the production subset that is actually needed.
- Describe required capabilities, not one hard-coded OS utility or MCP implementation. Use the available equivalent tool that satisfies the workflow gate.

Project text files such as README, canonical Markdown, prompt text, and indexes should be UTF-8. After cross-tool or Windows writes involving non-ASCII text, actually read back a sample and reject runs of placeholder question marks, replacement characters, or mojibake before continuing delivery.

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

## 7. Imagegen-assisted generation and review

Formal package/delivery mechanics are owned by image-handoff.md.

### Start-of-generation batch

Before the user starts Imagegen generation for a selected slide range, prepare the complete usable generation package for that range in one batch by default.

The normal user-facing package contains only:

- one complete current prompt TXT file per slide;
- the actual reference images required by those prompts.

Materialize the user-facing batch as one validated ZIP by default so it can be delivered as a single artifact. A different container is acceptable only when the user or selected delivery surface explicitly requires it.

Canonical Markdown remains internal project authority and is not part of the normal user generation package unless the user explicitly requests project-source files.

Validate the package before delivery:

- no canonical MD files;
- no PDF files;
- every image filename referenced by a prompt exists in the package;
- every included reference image has actually been inspected;
- prompt and image filenames are current, with no stale references.

Once a usable batch has been delivered on the selected surface, normal production/status/review turns reuse it. Do not repeatedly resend unchanged prompts or assets. Re-deliver only when regeneration or a canonical/material change requires new content, package contents are missing/corrupt, the delivery surface changes, or the user explicitly asks.

A user may explicitly request a single-slide generation package. Regeneration may also produce a single-slide package. These are targeted actions, not the default production cadence.

### Generation and ordered review

Generation may proceed in parallel or out of order when useful. A later page may exist while an earlier page is missing or still unresolved.

If the project uses ordered review, reviewed/approved progress advances only through consecutive resolved pages. A later accepted page may be retained, but it does not move the consecutive approved position past an earlier gap.

For projects that need cross-session continuity, the README current-status section keeps only:

- generated progress: the furthest generated page position, with gaps derived from actual artifacts;
- reviewed/approved progress: the last consecutively accepted page in the ordered review sequence.

Overwrite those values. Do not append a page-by-page activity log and do not create a separate runtime-state file.

### Status/review request

For a status/review request:

1. Inspect the project's explicitly designated generated-output source. Do not guess another folder/store merely because another project used it.
2. Determine what has actually been generated, including gaps.
3. Review from the next unresolved page according to the project's review policy.
4. Update generated progress and consecutively reviewed/approved progress.
5. Report missing pages and pages that require regeneration.
6. Do not automatically emit another generation package unless the user explicitly asks for generation materials or the project protocol explicitly requires that action.

If a page was previously approved but its formal generated artifact cannot currently be located, report it as an artifact-availability problem. Do not silently revoke the historical review decision, and do not substitute canonical text for the missing generated image.

### Returned-page decision

When the user returns a generated page:

1. Actually inspect the returned image.
2. Compare it with the current canonical production spec.
3. Prioritize factual/domain errors, evidence mistakes, readability, hierarchy, structure, and obvious layout failures.
4. Decide directly:
   - accept when the page is production-usable;
   - regenerate when a material defect remains.
5. If regenerating, update the canonical spec first, synchronize the complete current prompt, and use the Imagegen regeneration workflow.

If a returned page is accepted and creates no new slide rule, no new project-wide rule, and no source/status change, do not modify the canonical spec or README merely to leave an audit trail.

If no per-slide review is requested, production may continue from the delivered batch and rely on whole-deck review as the mandatory user gate.

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
