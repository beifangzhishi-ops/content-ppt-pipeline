# Maintenance Guide

This file is for maintainers and agents working on the Content PPT Pipeline repository.

## Authority hierarchy

Keep one current workflow authority. When architecture changes, delete/rewrite obsolete rules instead of preserving deprecated compatibility language unless the user explicitly requests it.

- `plugin.json`: install metadata and version.
- `.agents/plugins/marketplace.json`: repository marketplace entry.
- `skills/content-ppt/SKILL.md`: top-level routing and global hard rules.
- `skills/content-ppt/references/ccm-runtime.md`: CCM-first persistent project runtime.
- `skills/content-ppt/references/workflow.md`: content/evidence/deck lifecycle.
- `skills/content-ppt/references/image-generation.md`: direct generation, CPA recommendation, reference eligibility, queue/review/regeneration, handoff fallback.
- `skills/content-ppt/references/ppt-authoring.md`: editable/native PowerPoint construction.
- `skills/content-ppt/references/examples/*`: optional non-authoritative examples.
- `README.md`: user-facing current product model and usage.

## Product scope

The skill is designed primarily for **ChatGPT Plus users**.

The preferred stack is:

`ChatGPT Plus + Content PPT Pipeline + CCM + CPA ImageGen`

Product assumptions:

- GPT is the interaction/reasoning/review/orchestration layer.
- CCM workspace is the preferred durable runtime for long-running projects.
- CPA ImageGen is the recommended direct-generation backend when configured and authorized.
- direct generation is the preferred Imagegen-assisted path;
- manual handoff is fallback;
- ChatGPT Library is not part of the default runtime/state/artifact architecture.

Provider-specific endpoint/model/quota/key details do not belong in generic skill authority.

## CCM-first runtime rules

For persistent projects:

1. enter the selected CCM workspace;
2. read project README/protocol;
3. read project AGENTS/AGENT;
4. inspect Git status;
5. use canonical/current project files and local artifacts as durable context;
6. update README/AGENTS in the same work cycle when current state or durable project rules change.

Do not rely on chat history as the primary project state.

Do not create a parallel cloud/local working copy merely for convenience.

ChatGPT Library may be used only as an explicitly selected external input source. Do not add default Library sync, Library artifact registry, device-switch Library reconciliation, or Library production-state rules.

## Production state

Do not use scalar durable progress such as:

- generated to Pxx;
- consecutive approved through Pxx;
- completion percentage.

Persist page-state sets:

- approved;
- rework/unreviewed;
- not-generated.

Pages may be generated and reviewed out of order. Earlier gaps never block later review.

New generation results always enter rework/unreviewed first.

Keep candidate output separate from approved-current artifacts. File existence is not approval.

If the project maintains a companion artifact index, synchronize it with README/protocol in the same work cycle; do not invent a second index by default.

## Canonical discipline

Maintain one canonical slide spec and, when used, one current derived prompt per page.

- change canonical first when the owning content/evidence rule changes;
- synchronize the current prompt in the same work cycle;
- do not keep `_v2`, `_final`, `_revised` forks unless explicitly requested;
- do not patch only generated output when a source/index/builder/QA script would recreate the error;
- remove obsolete scripts/rules that can restore superseded logic.

## Failure triage before canonical edits

Classify a failed generation:

1. canonical/evidence/prompt defect;
2. generation execution/input mismatch;
3. model rendering defect;
4. infrastructure/provider failure.

Only a true owning-source defect necessarily changes canonical.

Wrong prompt/reference selection, missing reference, page/result mismatch, or other execution error must be regenerated with correct inputs without rewriting valid scientific/domain content.

Provider/network/auth/rate-limit failures are execution infrastructure failures, not page-content failures.

## Material/evidence closure

Default review priority:

1. narrative continuity and scientific/domain correctness;
2. evidence source/identity/role/independence;
3. traceable workload/coverage;
4. whole-deck visual consistency;
5. single-slide decoration.

Each slide should have one primary question. Title, primary evidence, and takeaway must align.

Main talk carries the main narrative. Q&A/appendix carries advanced evidence for likely questions and must not upgrade exploratory results into main conclusions.

Evidence-strength guardrails:

- same-dataset comparison/selection is not independent validation;
- continuous events from one experiment chain are not automatically independent repeat experiments;
- parameter scans/sensitivity are not automatically independent calibration;
- provided input/boundary history is not a predicted-and-validated output;
- derived values are not direct measurements;
- verification, external validation, external reference, consistency check, numerical audit, sensitivity, and model discrimination remain distinct.

Run complete review passes. Material closure requires at least one pass with no new substantive issue.

Material closure does not mean the generated pages/deck are visually approved.

## Three production gates

Keep these separate:

1. Material closure.
2. Pre-generation prompt/reference gate.
3. Rendered-page/deck visual review.

Do not equate canonical/prompt QA or generation-package validation with rendered-artifact approval.

## Image reference discipline

Every final selected reference must be actually viewed.

Eligible factual references are traceable inspected real/project source images such as experiment, apparatus, measurement, paper, site/object, or numerical-result figures.

Do not use these as the next Imagegen reference by default:

- old generated slides;
- AI/Imagegen output;
- rejected output;
- Content PPT Pipeline-generated diagrams;
- presentation-specific script redraws;
- internal structure/layout calibration images.

User explicit current-task override takes priority.

Quantitative figures should be deterministically generated from source data/scripts when possible and should not be reinterpreted by Imagegen.

PDF is not a valid direct image reference. Convert the needed page/figure to PNG/JPG/WebP and inspect it first.

## Direct-generation production

When an authorized direct backend exists, use it as the preferred Imagegen-assisted path.

Recommended backend for Plus users: CPA ImageGen.

The loop is:

`pre-generation gate -> submit -> local output -> unreviewed -> inspect -> approve/rework -> regenerate -> approved-current`

The direct backend should write/return output into the local CCM project workflow; do not route results through Library for bookkeeping.

### Bounded parallel queue

Parallel generation is allowed and expected when it reduces idle time.

- keep a small bounded in-flight queue;
- prepare another page while a job waits;
- review returned pages asynchronously;
- repair failed prompts while other jobs run;
- stop queue expansion when repeated pages reveal a common failure.

Do not hard-code a universal concurrency count in the generic skill.

## Manual handoff fallback

Manual prompt/reference delivery is fallback only when:

- direct generation is unavailable/degraded;
- authorization is unavailable;
- the user explicitly chooses manual generation.

The user generation package contains only:

- current complete prompt TXT;
- eligible required PNG/JPG/JPEG/WebP references.

Do not include canonical MD, PDFs, generated/rejected pages, internal diagrams, or presentation-specific derived visuals.

`scripts/validate-generation-package.ps1` checks package structure; it does **not** prove provenance/reference eligibility.

ZIP/chat-file/Quark are fallback delivery surfaces, not the default product architecture.

## Secrets

API keys, tokens, endpoint config, model discovery, and provider-specific credentials:

- stay in ignored local configuration or secure runtime mechanisms;
- never enter Git;
- never enter README/project status;
- never enter canonical;
- never enter prompt TXT;
- never enter generation packages.

## Data figures

For reproducible quantitative figures:

- derive from source data/code;
- preserve provenance;
- actually inspect the rendered output;
- keep semantic color/axis/legend conventions consistent within a project;
- do not alter original paper/experimental imagery merely for style.

## Reuse / rebuild

Classify pages as reuse / rebuild / new / retire when useful.

Reuse requires:

- current role/content/evidence compatibility;
- an unambiguous approved-current artifact.

Renumbering alone is not a rebuild reason.

A failed file is not reusable because it exists.

Material/evidence changes invalidate prior approval until reassessed.

## Conceptual diagrams

Preserve scientific/domain relationships, not old generated geometry.

Prefer short horizontal/vertical/90-degree connectors. Avoid unnecessary long diagonal arrows, cross-module diagonals, and crossings.

Do not encode one project's palette/proportions as universal skill rules.

## Editable PowerPoint

Native-editable mode uses PowerPoint-native text, equations, shapes, connectors, charts, tables, and simple diagrams wherever practical.

Generated page screenshots are not a substitute for an editable deliverable.

An explicitly user-selected generated artifact may be used as a reconstruction visual target for editable authoring; this does not make it an eligible Imagegen reference.

## Change discipline

Keep README current, not append-only history.

When workflow architecture changes:

- update authority files in one change;
- remove obsolete naming/semantics;
- search the repository for stale references;
- do not preserve historical compatibility unless explicitly requested.

## Encoding

Text files are UTF-8.

After cross-tool/Windows writes with non-ASCII text, read back representative content and reject mojibake, replacement characters, or accidental control characters.

## Release checks

Before release:

1. `git diff --check`;
2. parse `plugin.json` and marketplace JSON;
3. confirm README and plugin version match;
4. search for obsolete references:
   - deleted/renamed reference-file paths;
   - consecutive/ordered scalar review progress;
   - default Library state/artifact workflow;
   - generated-page-as-reference permission;
   - cloud-workspace default conflicting with CCM-first;
5. check action routing for:
   - CCM start/resume/status;
   - material closure;
   - pre-generation gate;
   - direct generation;
   - manual handoff fallback;
   - generated-page review;
   - editable build;
   - whole-deck QA;
6. build ChatGPT ZIP with `scripts/build-chatgpt-zip.ps1`;
7. confirm ZIP root is only `plugin.json + skills/`;
8. test `scripts/validate-generation-package.ps1` with a temporary valid fixture;
9. confirm docs do not claim the validator proves provenance;
10. confirm secrets/provider config are absent from tracked files;
11. inspect final Git status for expected changes only.

## Mode names

Current production modes:

- Imagegen-assisted;
- Native-editable.

Do not add a third persistent workflow mode merely to represent a temporary action or backend.

## Versioning

Use semver.

0.5.0 establishes:

- ChatGPT Plus + CCM-first positioning;
- CPA ImageGen as recommended direct-generation backend;
- direct-generation-first production;
- local candidate / approved-current artifact lifecycle;
- discrete page-state sets;
- Library removal from default production state;
- material/pre-generation/rendered-review separation;
- evidence-strength and reference-eligibility guardrails.
