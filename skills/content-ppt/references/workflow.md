# Content PPT Workflow

This file owns the business workflow: intake, research, narrative/source authority, material closure, deck design, canonical slide specs, pack-level review, generation/reuse planning, returned-page review, assembly transitions, post-generation revision, and whole-deck final review.

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
- Prefer a directory/source-level entry map in README/protocol: source/path, status, and intended use. Do not turn README into a per-slide source table; keep per-slide asset/source mappings in canonical specs, an image index, material audit, or an equivalent project file.
- Source authority is a declared project property, not something inferred from filename, folder name, modification time, or whichever working copy was seen most recently. A newer working draft may supply updated data while an older stable report/thesis still owns the narrative structure.
- Useful source-status labels may include current, frozen, raw/traceable, historical, obsolete, or confusing. Historical/obsolete material must not silently overwrite current authority.
- A readable source location does not imply permission to modify it. If a source tree is designated read-only, keep canonical files and derived work in the working project and leave the source untouched.
- Do not copy a large source tree merely for convenience when a stable read-only original can remain the source of truth; copy only the production subset that is actually needed.
- Describe required capabilities, not one hard-coded OS utility or MCP implementation. Use the available equivalent tool that satisfies the workflow gate.

Project text files such as README, canonical Markdown, prompt text, and indexes should be UTF-8. After cross-tool or Windows writes involving non-ASCII text, actually read back a sample and reject runs of placeholder question marks, replacement characters, or mojibake before continuing delivery.

### Narrative authority before local evidence

Before a deep material audit, identify which source owns the presentation's narrative backbone and which sources only supplement it.

- The narrative authority owns chapter/section order, experiment grouping, evidence roles, and the relationship from evidence to conclusion.
- Specialized projects, newer calculations, follow-up experiments, and working drafts may update the relevant node's data, figure, method detail, or verified boundary. They must not reorganize the narrative merely because they are newer or locally more detailed.
- Unfinished calculations, exploratory reruns, unstable definitions, or work that still needs experiments are not formal evidence until they are completed and reviewed to the project's required standard.
- When the user explicitly designates a thesis, report, previous deck, protocol, or other source as the main reference, use that declared authority rather than automatically choosing the latest timestamp.
- Backup/Q&A material may contain additional audits and edge cases, but it must not reverse-pollute the main narrative, upgrade exploratory evidence into a formal conclusion, or contradict the evidence roles already established in the main deck.

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

## 5. Material and evidence closure

Before freezing the production pack, audit the current material as a system rather than only proofreading individual slides.

Treat an old deck or old page count as a material index, not as an immutable table of contents. Keep, replace, merge, split, reorder, or add pages when the authoritative narrative and current evidence require it.

When the user asks to "review the material" or equivalent, the default review surface is the current canonical specs, prompts, evidence/source indexes, source data, derived-figure scripts, QA/build scripts, and project current-state documents. Do not automatically review already generated slide images or invoke Imagegen unless the user asks for generated-page review or generation.

Review in this order:

1. narrative role: what job does each section/page perform in the authoritative story;
2. experiment/data grouping: whether evidence really belongs to the same experiment, condition, dataset, or statistical population;
3. evidence role: measured, calculated, estimated, fitted, predicted, verification, external validation/reference, consistency check, numerical audit, or other project-defined category;
4. quantitative definitions: units, denominators, sample/event counts, ROI, pooled vs event-wise/trajectory-wise definitions, equations, and source values;
5. current supplementary evidence: completed new experiments/calculations that belong at an existing narrative node;
6. wording, indexes, formatting, and other lower-level cleanup.

Do not let local audit details or a newly discovered sub-project result become the deck's main story merely because they are fresh or visually strong.

Prefer real, traceable repeated evidence, parameter scans, audits, raw tables, structured CSV/JSON, and completed calculations over prose that merely claims workload or coverage.

Run review in complete passes. A pass follows: find a substantive issue -> trace it to authority/source -> fix the project files directly -> synchronize dependent prompts/indexes/scripts -> run QA -> rescan. Material closure is reached only after at least one complete pass finds no new substantive issue.

For long-running deep audits, use one fresh conversation per complete review pass. At the end of a pass, persist all durable state in project files; the next pass starts from the current README/AGENTS/canonical/index/QA rather than depending on an ever-growing chat transcript. README keeps current state and source/authority entry points; AGENTS keeps reusable rules, not a chronological audit log; concrete findings are fixed in the files they affect.

Do not fix only generated outputs when the real source of the defect is a builder, index generator, QA rule, prompt generator, derived-figure script, or maintenance script. Update the source that would otherwise recreate the error. Remove or clearly retire obsolete one-off scripts that can rewrite superseded logic back into current canonical files.

When a real error class is worth guarding, add a regression check if the project has a QA harness. Prefer semantic/evidence anchors over exact sentence locks or broad forbidden-word checks; necessary qualifiers, negations, and boundary statements must remain expressible. QA should also detect invisible control characters or equivalent text corruption that can survive superficial structure checks.

### Reproducible quantitative figures

When structured source data or a reliable reconstruction script exists, quantitative plots should be programmatically/reproducibly redrawn rather than fabricated by Imagegen.

- Within one project and semantic category, align fonts, axes, grids, line weights, markers, legend hierarchy, number formatting, and semantic color roles.
- Keep semantic color roles stable across pages, but do not hard-code a universal plugin palette.
- Preserve scientific meaning when standardizing axes, units, or legend conventions.
- Do not alter original paper figures, experimental imagery, microscopy, or unreconstructable official plots merely to make them look stylistically uniform.
- Record enough provenance for a derived figure to identify the source data and reconstruction method/script, and actually inspect the rendered output.

Conceptual or relationship diagrams may use an authoritative source as a scientific relationship reference without copying its exact arrow geometry or layout. Preserve the relationships; redesign the geometry when that improves the presentation.

## 6. Canonical per-slide production spec

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

## 7. Full-pack self-audit before batch production

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
- narrative-authority alignment;
- experiment/condition/dataset identity;
- evidence-role and statistical-definition consistency;
- source data vs derived values/plots;
- README/canonical/prompt/index/QA/build-script synchronization;
- absence of stale maintenance logic that can recreate superseded content.

Run more than one review pass when the deck is complex. The purpose is to make the pack production-ready before expensive page generation.

## 8. Imagegen-assisted generation and review

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

### Reuse / rebuild / new / retire planning

When an existing deck is reordered, renumbered, or partially redesigned, decide page disposition before generating again. Use project terminology such as `reuse / rebuild / new / retire` in an index or plan when useful; this classification is not a third global production-progress counter.

- Reuse an already approved page when its communicative role, core content, evidence roles, and visual meaning remain valid. Renumbering or moving it to another chapter is not by itself a rebuild reason.
- Rebuild a page when its prior generated version failed and no later approved version exists, when the page has never been generated, or when its role/content/evidence materially changed.
- A failed page does not become reusable merely because the artifact still exists in Library or the project directory.
- A previously approved page does not automatically remain approved after material content or evidence roles change.
- Minor page-number/text/index updates may be handled in the editable stage instead of Imagegen regeneration when the selected production mode and artifact make that safe.
- Build the generation package from the pages currently marked new/rebuild. Do not repackage approved reusable pages merely because neighboring pages changed.

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
2. Compare it with the current canonical production spec, current complete prompt, and the real reference assets/roles used for that page.
3. Prioritize factual/domain errors, evidence mistakes, readability, hierarchy, structure, and obvious layout failures. Common blocking failures include wrong figure-to-role mapping; altered axes/units/numbers/formulas/legends; missing required evidence; conflating measured/calculated/predicted/validation roles; fabricated project-specific scientific imagery; placeholders/internal management text; or material drift from the current canonical spec.
4. Decide directly:
   - accept when the page is production-usable;
   - regenerate when a material defect remains.
5. If regenerating, update the canonical spec first, synchronize the complete current prompt, and use the Imagegen regeneration workflow.

After regeneration, review the new generated artifact on its own merits. Prior failure reasons are regression targets, not an automatic verdict on the new version.

If a returned page is accepted and creates no new slide rule, no new project-wide rule, and no source/status change, do not modify the canonical spec or README merely to leave an audit trail.

If no per-slide review is requested, production may continue from the delivered batch and rely on whole-deck review as the mandatory user gate.

## 9. Transition to editable PowerPoint

Transition based on the selected production mode and the current delivery goal.

Detailed native PowerPoint construction is owned by ppt-authoring.md.

Imagegen-assisted mode may assemble accepted generated page visuals directly when that is part of the chosen final mode.

Native-editable mode must rebuild the final deck with no Imagegen pixel/generation residue.

## 10. Whole-deck QA

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

## 11. Mandatory user whole-deck review

After internal whole-deck QA, the user must have a chance to review the complete deck as a whole.

Treat this as a real gate, not a courtesy phrase.

If the user requests targeted changes, enter the post-generation revision round below.

After repairs, repeat the relevant QA checks before final delivery.

## 12. Post-generation revision round

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
