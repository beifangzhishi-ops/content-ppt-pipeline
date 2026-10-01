# Imagegen Production

This file owns image inspection, reference eligibility, pre-generation checks, direct generation, bounded parallel production, generated-page review, regeneration, and manual handoff fallback.

For ChatGPT Plus users, the recommended stack is:

`Content PPT Pipeline + CCM workspace + CPA ImageGen`

CPA is the recommended direct-generation backend for this workflow when available and authorized. The workflow itself is capability-based: do not hard-code an endpoint, model name, quota, or secret into project authority.

## 1. Execution priority

Use this order:

1. **Direct generation — default** when an authorized project-allowed backend can submit the current prompt/reference set and return results to the local CCM workspace.
2. **Manual handoff — fallback** when direct generation is unavailable/degraded or the user explicitly wants manual generation.

Do not require a ZIP or user file搬运 before direct generation.

Manual handoff remains supported but is not the primary production route.

## 2. Inspect before use

Any image used as evidence or supplied as an Imagegen reference must be actually viewed.

Do not infer content from filenames, directory names, metadata, search snippets, or another model's description alone.

When many assets exist, contact sheets or previews may narrow candidates, but every final selected reference still needs actual inspection.

Track enough provenance to know:

- where the asset came from;
- what slide uses it;
- its evidence/structural/style role;
- whether it was actually viewed;
- whether it is current and eligible.

## 3. Reference eligibility

### Eligible factual references

Real, traceable, inspected source images may be supplied when project policy allows it, including:

- experiment/apparatus images;
- measurement/result figures;
- paper figures;
- real site/object images;
- traceable numerical-result images.

They provide factual content, not an instruction to copy the source visual style.

### Not eligible as the next Imagegen reference by default

Do not upload these as reference images:

- old generated slide pages;
- Imagegen/AI outputs;
- rejected generations;
- Content PPT Pipeline-generated diagrams;
- project-script-generated presentation schematics;
- temporary defense/report redraws;
- internal relationship/layout calibration images.

These may be inspected internally for diagnosis or factual/logic comparison, but they do not enter the next generation input unless the user explicitly overrides the rule for the current task.

### Quantitative figures

Quantitative plots are evidence. When structured data or a reliable reconstruction path exists:

- generate them deterministically from data/code;
- preserve provenance;
- place them directly in the final PPT or composite them through an editable/native assembly path;
- do not ask Imagegen to redraw numeric axes, labels, legends, or values;
- do not use the quantitative plot as a style reference for unrelated generated illustration.

### Independent style/layout references

A style/layout reference may be used only when the user/project explicitly selects it and it is not a generated artifact from the current deck. Example files are non-authoritative.

## 4. Reference file format

Imagegen reference inputs must be actual images such as:

- PNG;
- JPG / JPEG;
- WebP.

Do not pass PDFs directly as image references.

When the authoritative source exists only in PDF:

1. locate the exact needed page/figure;
2. render/export it to an image;
3. inspect the converted image;
4. verify crop, readability, resolution, and scientific meaning;
5. use the converted image filename in the current prompt/reference mapping.

## 5. Canonical, prompt, and generation-input separation

Keep these roles distinct:

- canonical Markdown/spec: source of truth;
- current prompt TXT: derived generation instruction;
- eligible reference images: factual visual inputs;
- generated candidate: output awaiting review;
- approved current artifact: accepted output.

When canonical changes, overwrite/synchronize the one current prompt in the same work cycle. Avoid v2/final/revised forks unless the user explicitly requests version history.

## 6. Pre-generation production gate

Before submitting a page, check:

- canonical and current prompt are synchronized;
- the prompt is self-contained;
- no stale experiment/condition/title/conclusion/layout language remains;
- no "same as previous slide" or hidden cross-slide dependency remains;
- composition instructions do not materially conflict;
- the prompt does not ask Imagegen to fabricate project-specific evidence or quantitative plots;
- every referenced asset is current, inspected, eligible, and available;
- no stale/forbidden reference filename remains;
- PDF references have been converted to inspected image files;
- conceptual diagrams communicate relationships/facts rather than inheriting an old generated geometry;
- current output state is known so the new result will not overwrite an approved artifact ambiguously.

Structural package validation does not prove provenance or reference eligibility.

## 7. Prompt completeness

Include, as applicable:

- slide title and role;
- purpose/takeaway;
- facts, numbers, equations, and terminology that must be preserved;
- visual evidence roles;
- conceptual illustration role;
- reading order and density;
- layout/composition constraints;
- high-value prohibitions;
- prior reproducible failure that must not recur.

The prompt should specify the page to produce, not merely summarize the canonical spec.

## 8. Direct-generation loop

Default closed loop:

`select page -> pre-generation gate -> submit prompt/references -> receive local output -> mark unreviewed -> inspect -> approve or triage -> regenerate if needed -> archive approved current artifact`

The agent should absorb mechanical work that would otherwise require the user to copy prompts, upload files, download results, and resubmit failed pages.

Only interrupt the loop for:

- a real scientific/content decision requiring user judgment;
- a material design choice the user has not delegated;
- authorization/credential action;
- a persistent infrastructure failure.

## 9. Bounded parallel queue

Direct production may be asynchronous.

Use a small bounded queue when generation wait time would otherwise idle the workflow:

- multiple pages may be in flight;
- while one page is generating, prepare another eligible page;
- review returned outputs as they arrive;
- repair failed prompts while other jobs continue;
- archive approved pages immediately;
- keep page-state sets independent of return order.

The concurrency limit is provider/project specific. Do not hard-code a universal value in the skill.

If repeated pages show the same visual failure, stop expanding the queue and fix the common cause before producing more failures.

If the project explicitly requires serial review, use one-at-a-time production.

## 10. Generated-page review

Every returned page starts as rework/unreviewed.

Actually inspect it against:

- current canonical;
- current prompt;
- eligible real references and their declared roles;
- required numbers/equations/labels;
- visual hierarchy and page role;
- neighboring approved pages when whole-deck consistency is relevant.

Check for:

- wrong experiment/condition/data identity;
- invented apparatus/data/evidence;
- numeric/formula/label errors;
- evidence too small to read;
- decorative content replacing main evidence;
- stale page identity;
- layout/density/style failure;
- accidental cross-page contamination.

Decide approve vs rework directly when the available evidence supports that judgment.

## 11. Failure triage

Before editing canonical, classify the failure.

### Canonical/evidence/prompt defect

The owning source is wrong or underspecified.

Action: fix canonical/source mapping first, synchronize the current prompt, then regenerate.

### Generation execution/input mismatch

Examples:

- wrong page prompt used;
- wrong reference image selected;
- required reference omitted;
- page/job result associated with the wrong slide.

Action: regenerate with the correct inputs. Do **not** modify correct canonical content merely because the execution was wrong.

### Model rendering defect

Inputs are correct but the output violates them.

Action: regenerate; strengthen the prompt only when a reproducible ambiguity or missing constraint is identified. Do not automatically reinterpret a random generation failure as a content defect.

### Infrastructure/provider failure

Examples:

- auth failure;
- timeout;
- EOF/5xx;
- quota/rate limit;
- network failure;
- backend cannot accept references.

Action: retry/degrade according to backend capability. This is not a page-content rejection and does not justify canonical changes.

## 12. Regeneration

For a true content/prompt defect:

1. fix the owning source;
2. synchronize the complete current prompt;
3. reassess references;
4. submit the full current prompt/reference set again;
5. review the new output.

Do not provide only delta retry instructions as the durable fix.

Rejected generations may be inspected for diagnosis, but do not send them back as references by default.

## 13. Local output handling

Direct-generation output should remain local to the CCM project.

Use project-declared candidate and approved-current locations.

- fresh outputs -> candidate/rework;
- accepted outputs -> approved-current;
- failed outputs -> remove from current view; archive/delete per project policy;
- never infer approval from file presence.

ChatGPT Library is not part of the default generated-artifact path.

## 14. Manual handoff fallback

When direct generation is unavailable or explicitly declined:

Prepare only:

- one complete current prompt TXT per required slide;
- the eligible reference images required by those prompts.

Do not include canonical Markdown or source PDFs in the user generation package.

Before handoff:

1. inspect every reference;
2. verify prompt/reference filenames;
3. verify no PDF reference remains;
4. verify no generated/internal-ineligible image leaked into the package;
5. validate package structure.

The repository validator may confirm file structure and missing references, but it does not prove provenance eligibility.

ZIP/chat-file/Quark are fallback delivery surfaces, not the default direct-production architecture.

## 15. Provider secrets and configuration

Keep API keys, tokens, endpoint configuration, model discovery, and provider-specific setup outside canonical/prompt/plugin authority.

Use ignored local configuration or secure runtime mechanisms. Never commit secrets.
