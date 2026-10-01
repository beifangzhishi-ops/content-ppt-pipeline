# Content PPT Workflow

This file owns the business workflow: intake, research, narrative/source authority, material closure, deck design, canonical slide specs, pre-generation review, generation/reuse planning, rendered-page review, assembly transitions, post-generation revision, and whole-deck final review.

It does not own host/runtime mechanics, detailed CPA-generation execution, or PowerPoint object-authoring mechanics.

## 1. Intake and mode

Determine the presentation goal, audience, evidence base, desired length, available source materials, and delivery expectations from the current request and artifacts.

Use one of two production paths:

- CPA generation: CPA performs page visual production and returns output directly to the active project runtime.
- Native-editable: final PowerPoint must contain no generated-page pixel residue; final content is rebuilt from native PowerPoint objects, real source images, and data-derived charts.

Do not create a separate persistent mode/stage state file. The current mode and action should be inferable from the current request, project README/protocol, canonical files, and actual local artifacts. Cross-session page state is maintained as approved / rework-unreviewed / not-generated sets, not as scalar progress counters.

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

- **Evidence / project-specific factual visual**: proves or depicts an actual experiment, actual apparatus, actual measurement, actual project result, actual site, or specific named real-world object. Use traceable real sources or faithful reconstruction from real data; do not substitute a generated realistic-looking version.
- **Conceptual scientific illustration**: explains a mechanism, structure, process, physical relationship, or generic experimental concept. CPA generation may be used when it does not imply that the result is an actual measurement or actual project record.
- **Application / scene-setting illustration**: establishes engineering context, motivation, industry environment, or application background. CPA-generated visuals may be photorealistic here when they do not claim to depict a specific real project/site or carry the page's factual proof burden.

Photorealism itself is not the deciding factor. The deciding factor is whether the image is being used as evidence or as illustration.

If a slide discusses a specific named plant, facility, experiment, or case and the identity of that object is part of the factual claim, prefer a real source image rather than a generated lookalike.

### Project-local context and source registry

For a long-running PPT project, treat project files as durable context rather than relying only on chat history.

- Keep long-lived, cross-slide project rules, source conventions, workflow choices, and current project status in the project's existing README/protocol when that is how the project is organized.
- Keep slide-specific content, layout, asset roles, generation constraints, and slide feedback in that slide's canonical production spec.
- When user feedback changes a slide, write the change into the appropriate project file first, then regenerate the current prompt/production inputs from the updated canonical content. Do not maintain a separate chat-only version.
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

Default review priority is:

1. narrative continuity and scientific/domain correctness;
2. evidence source, role, identity, and independence;
3. traceable workload/coverage evidence;
4. whole-deck visual consistency;
5. single-slide decorative polish.

Each slide should have:

- a clear role in the story;
- one main information objective;
- a title that states the slide's purpose or conclusion;
- enough evidence to support its takeaway;
- a deliberate relationship to the previous and next slide.

The title, primary evidence, and closing takeaway should answer the same primary question. Secondary audits, sensitivity checks, or boundary tests must not steal the main evidence role.

Main-talk pages carry the main narrative. Q&A/appendix pages carry advanced evidence that the audience may ask for but that the main talk does not need to expand. They must not reverse-pollute the main narrative or upgrade exploratory results into primary conclusions.

Workload should be communicated with real, traceable evidence such as events, trajectories, frames, samples, scans, grids, windows, repetitions, or calculation coverage. If workload display competes with story continuity, preserve the story and compress/restructure the workload display.

Use derivation/process pages when the reasoning itself matters. Split overloaded slides instead of hiding important logic in tiny text.

## 5. Material and evidence closure

Before freezing the production pack, audit the current material as a system rather than only proofreading individual slides.

Treat an old deck or old page count as a material index, not as an immutable table of contents. Keep, replace, merge, split, reorder, or add pages when the authoritative narrative and current evidence require it.

When the user asks to "review the material" or equivalent, the default review surface is the current canonical specs, prompts, evidence/source indexes, source data, derived-figure scripts, QA/build scripts, and project current-state documents. Do not automatically review already generated slide images or invoke CPA generation unless the user asks for generated-page review or generation.

Review in this order:

1. narrative role: what job does each section/page perform in the authoritative story;
2. experiment/data grouping: whether evidence really belongs to the same experiment, condition, dataset, or statistical population;
3. evidence role: measured, calculated, estimated, fitted, predicted, verification, external validation/reference, consistency check, numerical audit, or other project-defined category;
4. quantitative definitions: units, denominators, sample/event counts, ROI, pooled vs event-wise/trajectory-wise definitions, equations, and source values;
5. current supplementary evidence: completed new experiments/calculations that belong at an existing narrative node;
6. wording, indexes, formatting, and other lower-level cleanup.

Evidence-strength guardrails:

- model comparison or candidate selection on the same dataset is not independent validation;
- repeated/continuous events from one experimental chain do not automatically become independent repeat experiments;
- a parameter scan or sensitivity study is not automatically an independent calibration from upstream state to parameter;
- a supplied boundary/input history is not a model output that was predicted and validated;
- a derived quantity is not a direct measurement;
- verification, external validation, external reference, consistency check, numerical audit, sensitivity analysis, and model discrimination are distinct roles and must not be rhetorically upgraded into one another.

Titles and summary statements must use evidence strength consistent with the body. Prefer accurate terms such as support, show, agree with, discriminate, or audit when independent validation/proof has not actually occurred.

Do not let local audit details or a newly discovered sub-project result become the deck's main story merely because they are fresh or visually strong.

Prefer real, traceable repeated evidence, parameter scans, audits, raw tables, structured CSV/JSON, and completed calculations over prose that merely claims workload or coverage.

Run review in complete passes. A pass follows: find a substantive issue -> trace it to authority/source -> fix the project files directly -> synchronize dependent prompts/indexes/scripts -> run QA -> rescan. Material closure is reached only after at least one complete pass finds no new substantive issue.

For long-running deep audits, use one fresh conversation per complete review pass. At the end of a pass, persist all durable state in project files; the next pass starts from the current README/AGENTS/canonical/index/QA rather than depending on an ever-growing chat transcript. README keeps current state and source/authority entry points; AGENTS keeps reusable rules, not a chronological audit log; concrete findings are fixed in the files they affect.

Do not fix only generated outputs when the real source of the defect is a builder, index generator, QA rule, prompt generator, derived-figure script, or maintenance script. Update the source that would otherwise recreate the error. Remove or clearly retire obsolete one-off scripts that can rewrite superseded logic back into current canonical files.

When a real error class is worth guarding, add a regression check if the project has a QA harness. Prefer semantic/evidence anchors over exact sentence locks or broad forbidden-word checks; necessary qualifiers, negations, and boundary statements must remain expressible. QA should also detect invisible control characters or equivalent text corruption that can survive superficial structure checks.

### Reproducible quantitative figures

When structured source data or a reliable reconstruction script exists, quantitative plots should be programmatically/reproducibly redrawn rather than fabricated by a generation model.

- Within one project and semantic category, align fonts, axes, grids, line weights, markers, legend hierarchy, number formatting, and semantic color roles.
- Keep semantic color roles stable across pages, but do not hard-code a universal plugin palette.
- Preserve scientific meaning when standardizing axes, units, or legend conventions.
- Do not alter original paper figures, experimental imagery, microscopy, or unreconstructable official plots merely to make them look stylistically uniform.
- Record enough provenance for a derived figure to identify the source data and reconstruction method/script, and actually inspect the rendered output.

Conceptual or relationship diagrams may use an authoritative source as a scientific relationship reference without copying its exact arrow geometry or layout. Preserve the relationships; redesign the geometry when that improves the presentation. Prefer short, clear horizontal/vertical/90-degree connectors over unnecessary long diagonal arrows, cross-module diagonal links, or crossings.

## 6. Canonical per-slide production spec

Create one canonical, self-contained production spec for every slide before generation or editable build.

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

## 7. Full-pack self-audit before production

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

## 8. CPA generation and review

Detailed execution mechanics are owned by cpa-generation.md. Persistent local state and artifact lifecycle are owned by runtime.md.

### Three distinct production gates

Do not collapse these into one:

1. **Material closure**: narrative authority, dataset/experiment identity, evidence role, definitions, page duty, and workload hierarchy are resolved.
2. **Pre-generation gate**: current prompt is executable and synchronized; reference eligibility/provenance is valid; stale or conflicting instructions are removed.
3. **Rendered-page/deck review**: the actual generated visual or assembled candidate deck is inspected.

`QA PASSED`, canonical/prompt synchronization, package validation, or material closure never substitute for visual review of the actual rendered artifact.

### Reuse / rebuild / new / retire planning

When an existing deck is reordered, renumbered, or partially redesigned, decide page disposition before generating again. Use project terminology such as `reuse / rebuild / new / retire` in an index or plan when useful.

- Reuse an already approved page when its communicative role, core content, evidence roles, and visual meaning remain valid. Renumbering or moving it to another chapter is not by itself a rebuild reason.
- Rebuild a page when its prior generated version failed and no later approved version exists, when the page has never been generated, or when its role/content/evidence materially changed.
- A failed page does not become reusable merely because the artifact still exists in a local output directory.
- A previously approved page does not automatically remain approved after material content or evidence roles change.
- Minor page-number/text/index updates may be handled in the editable stage instead of CPA regeneration when the selected production path and artifact make that safe.
- CPA generation should submit only pages that actually need generation.

### Generation and asynchronous review

Generation may proceed in parallel or out of order when useful. A later page may exist while an earlier page is missing or still unresolved.

Page status is independent of page order:

- approved;
- rework/unreviewed;
- not-generated.

A gap or failed earlier page never blocks review or approval of a later page. Fresh generated output enters rework/unreviewed until it is visually accepted.

CPA generation may use a bounded parallel queue. Review outputs as they return, and pause queue expansion when repeated pages show the same common failure.

### Status/review request

For a status/review request:

1. Inspect the project's local status and designated candidate/approved artifact locations.
2. Reconcile actual artifacts with approved / rework-unreviewed / not-generated page sets.
3. Review newly available unreviewed artifacts when review was requested.
4. Update the page-state sets and local approved-current artifact view.
5. Report meaningful missing/rework/approved deltas rather than a consecutive progress number.

If a page is marked approved but its current approved artifact cannot be located, report an artifact-availability/state inconsistency and reconcile it before reuse.

### Returned-page decision

When a generated page becomes available:

1. Actually inspect the returned image.
2. Compare it with the current canonical production spec, current complete prompt, and the real reference assets/roles used for that page.
3. Prioritize factual/domain errors, evidence mistakes, readability, hierarchy, structure, and obvious layout failures. Common blocking failures include wrong figure-to-role mapping; altered axes/units/numbers/formulas/legends; missing required evidence; conflating measured/calculated/predicted/validation roles; fabricated project-specific scientific imagery; placeholders/internal management text; or material drift from the current canonical spec.
4. Decide directly:
   - accept when the page is production-usable;
   - regenerate when a material defect remains.
5. Change canonical or prompt only when the review reveals a real source/instruction defect. Otherwise regenerate the page through CPA.

After regeneration, review the new generated artifact on its own merits. Prior failure reasons are regression targets, not an automatic verdict on the new version.

If a returned page is accepted and creates no new slide rule, no new project-wide rule, and no source change, do not modify canonical merely to leave an audit trail; update only the required project state/artifact mapping.

## 9. Transition to editable PowerPoint

Transition based on the selected production mode and the current delivery goal.

Detailed native PowerPoint construction is owned by ppt-authoring.md.

The CPA generation path may assemble accepted generated page visuals directly when that is part of the chosen final delivery.

Native-editable mode must rebuild the final deck with no generated-page pixel residue.

## 10. Whole-deck QA

Before asking the user for the final review, actually render/open and inspect the whole candidate deck. A successful build, valid file structure, or canonical/prompt QA is not enough.

Check:

- story and page order;
- terminology consistency;
- equations and numbers;
- titles and conclusions;
- evidence/source correctness;
- readability and density;
- image quality and image-to-claim fit;
- whether each evidence image is large/readable enough to perform its stated role;
- whether generated illustration has fabricated project-specific apparatus, data, or results;
- whether decorative content has displaced the main evidence;
- duplicated/missing slides;
- broken/cropped content;
- master/layout consistency;
- Native-editable mode: no generated-page pixel residue remains.

Repairs transition into the appropriate current action:

- content/story fix -> content/evidence review;
- regenerated page -> CPA regeneration;
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
