# CPA ImageGen Production

This file owns image/reference inspection, reference eligibility, pre-generation checks, CPA submission, bounded parallel production, generated-page review, regeneration, and local output handling.

The Imagegen-assisted production stack is:

`ChatGPT Plus / GPT -> CCM workspace -> CPA ImageGen -> local candidate -> review -> approved-current`

There is no manual generation/handoff branch in the normal workflow.

## 1. CPA is the production backend

Use CPA ImageGen for Imagegen-assisted page production.

CPA-specific endpoint/model discovery, authorization, quota, and credentials belong to the local execution environment. Do not place secrets or provider configuration in canonical specs, prompt TXT files, README state, or Git-tracked skill authority.

If CPA is unavailable, report the generation action as blocked. Do not silently switch to a manual upload/download workflow.

## 2. Inspect before use

Any image used as evidence or supplied to CPA as an ImageGen reference must be actually viewed.

Do not infer content from filenames, directory names, metadata, search snippets, or another model's description alone.

When many assets exist, previews/contact sheets may narrow candidates, but every final selected reference still requires actual inspection.

Track enough provenance to know:

- source;
- target page;
- evidence/structural/style role;
- whether it was actually viewed;
- whether it is current and eligible.

## 3. Reference eligibility

### Eligible factual references

Real, traceable, inspected source images may be supplied when project policy allows it, such as:

- experiment/apparatus photographs;
- real site/object images;
- paper/source figures used for qualitative factual content;
- traceable numerical/measurement imagery when CPA only needs qualitative physical context.

They provide factual content, not permission to copy the source visual style.

### Keep quantitative evidence out of ImageGen when exact values matter

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

### Not eligible as CPA reference inputs by default

Do not upload:

- old generated slide pages;
- ImageGen/AI outputs;
- rejected generations;
- Content PPT Pipeline-generated diagrams;
- project-script-generated presentation schematics;
- temporary defense/report redraws;
- internal relationship/layout calibration images.

These may be inspected internally for diagnosis or factual/logic comparison, but they do not enter the next CPA generation input unless the user explicitly overrides this rule for the current task.

### Independent style/layout references

A style/layout reference may be used only when explicitly selected by the user/project and it is not a generated artifact from the current deck.

Example files are non-authoritative.

## 4. Reference file format

CPA ImageGen reference inputs must be actual images such as:

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

## 5. Canonical, prompt, reference, and output separation

Keep these roles distinct:

- canonical spec: source of truth;
- current prompt TXT: derived generation instruction;
- eligible references: factual visual inputs;
- candidate output: CPA result awaiting review;
- approved-current artifact: accepted current page.

When canonical changes, overwrite/synchronize the one current prompt in the same work cycle.

## 6. Pre-generation gate

Before CPA submission, check:

- canonical and current prompt are synchronized;
- prompt is self-contained;
- no stale experiment/condition/title/conclusion/layout language remains;
- no "same as previous slide" or hidden cross-slide dependency remains;
- composition instructions do not materially conflict;
- prompt does not ask ImageGen to fabricate project-specific evidence or quantitative plots;
- every referenced asset is current, inspected, eligible, and available;
- no stale/forbidden reference filename remains;
- PDF-derived references were converted and inspected;
- conceptual diagrams communicate relationships/facts rather than inheriting old generated geometry;
- current output state is known so a new candidate cannot ambiguously overwrite approved-current.

## 7. Prompt completeness

Include, as applicable:

- slide title and role;
- purpose/takeaway;
- facts, numbers, equations, and terminology that must be preserved;
- evidence roles;
- conceptual illustration role;
- reading order and density;
- layout/composition constraints;
- high-value prohibitions;
- prior reproducible rendering problem that must not recur.

The prompt should specify the page to produce, not merely summarize the canonical spec.

## 8. CPA production loop

Default loop:

`select page -> pre-generation gate -> CPA submit -> local candidate -> mark unreviewed -> inspect -> approve or regenerate -> approved-current`

The agent owns the mechanical loop. User involvement is needed only for:

- a scientific/content decision requiring judgment;
- a material design choice the user has not delegated;
- CPA authorization/configuration action;
- persistent CPA unavailability.

## 9. Bounded parallel queue

CPA production may be asynchronous.

Use a small bounded queue when useful:

- multiple pages may be in flight;
- prepare another eligible page while one job waits;
- review returned outputs as they arrive;
- revise prompts for reproducible rendering failures while other jobs continue;
- archive approved pages immediately;
- keep page-state sets independent of return order.

The concurrency limit is project/provider specific. Do not hard-code a universal value in the generic skill.

If repeated pages show the same visual failure, stop expanding the queue and fix the common instruction/style cause first.

## 10. Generated-page review

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
- layout/density/style failure;
- accidental cross-page contamination.

Decide approved vs rework directly.

**Page approved means pipeline-reviewed and usable as the current artifact. It does not mean the user has completed final whole-deck approval.**

## 11. Regeneration

When a CPA page fails review:

- if canonical and prompt remain correct, regenerate;
- if review reveals a real source/instruction defect, fix the owning source, synchronize the complete current prompt, then regenerate;
- do not infer a canonical defect merely from a poor render.

Use the complete current prompt/reference set for regeneration rather than a chat-only delta instruction.

Rejected generations may be inspected diagnostically but are not fed back into CPA as references by default.

CPA authorization, quota, timeout, network, or backend failures block generation execution; they are not page-review conclusions and do not justify canonical changes.

## 12. Local output handling

CPA output stays local to the CCM project.

Use project-declared candidate and approved-current locations.

- fresh outputs -> candidate/rework;
- accepted outputs -> approved-current;
- failed outputs -> remove from current view; archive/delete according to project policy;
- never infer approval from file presence.

ChatGPT Library is not part of the generated-artifact path.

## 13. Secrets and provider configuration

Keep CPA API keys, tokens, endpoint configuration, model discovery, and provider-specific setup outside canonical/prompt/plugin authority.

Use ignored local configuration or secure runtime mechanisms. Never commit secrets.
