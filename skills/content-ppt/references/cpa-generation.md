# CPA Generation

This file owns reference inspection, reference eligibility, pre-generation checks, CPA submission, fresh-request behavior, bounded parallel production, generated-page review, regeneration, and local output handling.

The production path is:

`active project runtime -> CPA -> local candidate -> review -> approved-current`

## 1. CPA generation backend

Use CPA for slide visual generation/regeneration.

CPA-specific endpoint/model discovery, authorization, quota, and credentials belong to the active execution environment. Do not place secrets or provider configuration in canonical specs, prompt TXT files, README state, or Git-tracked skill authority.

If CPA is unavailable, the generation action is blocked until CPA is available again.

## 2. Fresh-request rule

Every slide generation uses a **fresh CPA HTTP request**.

For each page `Pxx`:

1. create a new request;
2. send that page's current prompt;
3. attach only that page's selected eligible references;
4. if the page has no references, send no reference images;
5. do not carry forward any previous page generation/session/conversation identifier or prior-page request context.

Conceptually:

`P41 = fresh request`
`P42 = fresh request`
`P43 = fresh request`

Bounded parallel generation may place multiple independent fresh requests in flight at once. Parallelism does not change the per-page request rule.

## 3. Inspect before use

Any image used as evidence or supplied to CPA as a reference must be actually viewed.

Do not infer content from filenames, directory names, metadata, search snippets, or another model's description alone.

When many assets exist, previews/contact sheets may narrow candidates, but every final selected reference still requires actual inspection.

Track enough provenance to know:

- source;
- target page;
- evidence/structural/style role;
- whether it was actually viewed;
- whether it is current and eligible.

## 4. Evidence and illustration boundary

### Project/practice evidence

If a visual is part of the proof chain or represents actual project work, apparatus, experiment, measurement, simulation result, site, or another factual record, do **not** use CPA to fabricate a realistic-looking substitute.

Use:

- a traceable real source image; or
- a faithful deterministic reconstruction from real data when appropriate.

If a specific named facility, site, experiment, or case is itself part of the factual claim, prefer a real source image rather than a generated lookalike.

### Conceptual scientific illustration

CPA generation may be used to explain a mechanism, structure, process, relationship, or generic apparatus concept when the generated image is not presented as an actual project record or measured result.

### Engineering application / scene-setting

Generated visuals, including photorealistic scenes, are allowed for background, motivation, industrial/application context, or generic engineering environments when they do not carry the deck's factual proof burden.

Titles, captions, and surrounding copy must not make a generated illustration appear to be actual experimental/project evidence.

## 5. Reference eligibility

### Eligible factual references

Real, traceable, inspected source images may be supplied when project policy allows it, such as:

- experiment/apparatus photographs;
- real site/object images;
- paper/source figures used for qualitative factual content;
- traceable numerical/measurement imagery when CPA only needs qualitative physical context.

They provide factual content, not permission to copy the source visual style.

### Keep quantitative evidence out of generation when exact values matter

If a figure's scientific role depends on preserving exact:

- axes;
- values;
- legends;
- color bars;
- uncertainty;
- category/series mapping;
- numeric annotations;

do not send it to CPA for reinterpretation.

Instead:

- reproduce it deterministically from data/code when possible;
- retain the real source figure when reconstruction is not appropriate;
- place/composite it directly in the final PPT or editable assembly layer.

### Not eligible as CPA references by default

Do not use:

- old generated slide pages;
- AI/generated outputs;
- rejected generations;
- Content PPT Pipeline-generated diagrams;
- project-script-generated presentation schematics;
- temporary defense/report redraws;
- internal relationship/layout calibration images.

These may be inspected internally for diagnosis or factual/logic comparison, but they do not enter the next CPA request unless the user explicitly overrides this rule for the current task.

### Independent style/layout references

A style/layout reference may be used only when explicitly selected by the user/project and it is not a generated artifact from the current deck.

Example files are non-authoritative.

## 6. Reference file format

CPA reference inputs must be actual images such as:

- PNG;
- JPG / JPEG;
- WebP.

Do not pass PDFs directly as image references.

When an authoritative source exists only in PDF:

1. locate the exact page/figure;
2. render/export it to an image;
3. inspect the converted image;
4. verify crop, readability, resolution, and meaning;
5. use the converted image in the current reference mapping.

## 7. Canonical, prompt, reference, and output separation

Keep these roles distinct:

- canonical spec: source of truth;
- current prompt TXT: derived generation instruction;
- eligible references: visual inputs for the current page;
- candidate output: CPA result awaiting review;
- approved-current artifact: accepted current page.

When canonical changes, overwrite/synchronize the one current prompt in the same work cycle.

## 8. Pre-generation gate

Before CPA submission, check:

- canonical and current prompt are synchronized;
- prompt is self-contained;
- no stale experiment/condition/title/conclusion/layout language remains;
- no "same as previous slide" or hidden cross-slide dependency remains;
- composition instructions do not materially conflict;
- prompt does not ask CPA to fabricate project-specific evidence or quantitative plots;
- every referenced asset is current, inspected, eligible, and available;
- no stale/forbidden reference filename remains;
- PDF-derived references were converted and inspected;
- conceptual diagrams communicate relationships/facts rather than inheriting old generated geometry;
- the prompt distinguishes visible page copy from visual-construction instructions and non-displayed source/verification notes;
- current output state is known so a new candidate cannot ambiguously overwrite approved-current.

## 9. Prompt completeness

Include, as applicable:

- slide title and role;
- purpose/takeaway;
- facts, numbers, equations, and terminology that must be preserved;
- evidence roles;
- conceptual/application illustration role;
- reading order and density;
- layout/composition constraints;
- high-value prohibitions;
- prior reproducible rendering problem that must not recur.

The prompt should specify the page to produce, not merely summarize the canonical spec.

Separate three prompt roles explicitly:

1. **Must display**: exact intended page-visible title, copy, formulae, numeric values, citations, and labels.
2. **Visual duty**: relationships to illustrate, geometry, reading path, and design constraints; these are instructions, not prose to place on the slide.
3. **Do not display / source checks**: asset provenance, raw source URLs, internal project identifiers, review notes, and scientific or construction guardrails unless the canonical spec explicitly designates a visible attribution.

Do not paste internal source checks and construction directions into a visible-copy block. If CPA repeatedly renders them as slide text, repair prompt structure and regenerate rather than editing the pixels of its PNG.

## 10. CPA production loop

Default loop:

`select page -> pre-generation gate -> fresh CPA request -> local candidate -> mark unreviewed -> inspect -> approve or regenerate -> approved-current`

The agent owns the mechanical loop. User involvement is needed only for:

- a scientific/content decision requiring judgment;
- a material design choice the user has not delegated;
- CPA authorization/configuration action;
- persistent CPA unavailability.

## 11. Bounded parallel queue

CPA production may be asynchronous.

Use a small bounded queue when useful:

- multiple independent page requests may be in flight;
- prepare another eligible page while one request waits;
- review returned outputs as they arrive;
- revise prompts for reproducible rendering failures while other requests continue;
- archive approved pages immediately;
- keep page-state sets independent of return order.

The concurrency limit is project/provider specific. Do not hard-code a universal value in the generic skill.

If repeated pages show the same visual failure, stop expanding the queue and fix the common instruction/style cause first.

## 12. Generated-page review

Every CPA result starts as rework/unreviewed.

Actually inspect it against:

- current canonical;
- current prompt;
- eligible real references and their declared roles;
- required numbers/equations/labels;
- visual hierarchy and page role;
- neighboring approved pages when whole-deck consistency matters.

Check for:

- wrong experiment/condition/data identity;
- invented apparatus/data/evidence;
- numeric/formula/label errors;
- evidence too small to read;
- decorative content replacing main evidence;
- stale page identity;
- layout/density/style failure.
- arrows or relationship diagrams whose actual meaning cannot be explained;
- visuals that are technically correct but do not explain the page's message;
- unnecessary empty spaces, font fallback, out-of-frame items, or broken math rendering (not the mere presence of regular columns, formula boxes, or arrows).

Decide **generation-stage approved vs rework** directly:

- **Approve with logged downstream fixes** only when main composition, reading path, visual hierarchy, core evidence configuration, and scientific relationships are sound, and the remaining flaws (such as a typo, page number, local label, formula text, or arrow) can reliably be corrected as editable objects. Use the existing project canonical/fix-list tracking, not a new parallel state system.
- **Rework in CPA** when the structure, main explanation, evidence, scientific meaning, or page relationships cannot safely be salvaged through downstream editable adjustments.
- A deferred fix remains outstanding until editable-stage correction and review; generation approval is never final PPTX or whole-deck approval. If the final delivery path is raster-only, visible defects cannot be deferred to nonexistent editable work.

**Approved-current means visually reviewed and reusable at the CPA stage, not defect-free editable or user-approved final delivery.**

## 13. Regeneration

When a CPA page fails review:

- if canonical and prompt remain correct, regenerate with another fresh request;
- if review reveals a real source/instruction defect, fix the owning source, synchronize the complete current prompt, then regenerate;
- do not infer a canonical defect merely from a poor render.

Use the complete current page prompt/reference set for regeneration rather than a chat-only delta instruction.

Rejected generations may be inspected diagnostically but are not fed back into CPA as references by default.

Do **not** repair the authoritative generated PNG by script-based erasing, patching, compositing, pixel repainting, or stitching to manufacture an approved result. If the generation-stage image needs a structural change, correct the owning prompt/source if warranted and send a fresh CPA request. Native objects constructed over an unchanged temporary base **after** entering editable reconstruction are downstream authoring, not PNG pixel patching.

CPA authorization, quota, timeout, network, or backend failures block generation execution; they are not page-review conclusions and do not justify canonical changes.

## 14. Local output handling

CPA output stays in the active project runtime.

Use project-declared candidate and approved-current locations:

- fresh outputs -> candidate/rework;
- accepted outputs -> approved-current;
- failed outputs -> remove from current view; archive/delete according to project policy;
- never infer approval from file presence.

## 15. Secrets and provider configuration

Keep CPA API keys, tokens, endpoint configuration, model discovery, and provider-specific setup outside canonical/prompt/plugin authority.

Use ignored local configuration or secure runtime mechanisms. Never commit secrets.
