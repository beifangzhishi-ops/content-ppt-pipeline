# Maintenance Guide

This file is for maintainers and agents working on the Content PPT Pipeline repository.

## Authority

- `plugin.json`: install metadata and version.
- `skills/content-ppt/SKILL.md`: model-facing core contract and action routing.
- `skills/content-ppt/references/ccm-runtime.md`: CCM persistent runtime.
- `skills/content-ppt/references/workflow.md`: content/evidence/deck lifecycle.
- `skills/content-ppt/references/image-generation.md`: CPA production, reference eligibility, queue/review/regeneration.
- `skills/content-ppt/references/ppt-authoring.md`: editable/native PowerPoint construction.
- `README.md`: user-facing current product model.

Do not preserve obsolete workflow branches for compatibility unless the user explicitly requests it.

## Product scope

The skill targets:

`ChatGPT Plus + Content PPT Pipeline + CCM + CPA ImageGen`

Product assumptions:

- GPT is the reasoning/review/orchestration layer.
- CCM is the durable runtime for long-running projects.
- CPA ImageGen is the Imagegen-assisted production backend.
- CPA output returns to the local CCM project.
- ChatGPT Library is not a runtime/state/artifact layer.
- there is no manual Imagegen handoff branch.

If CPA is unavailable, generation is blocked until the runtime is restored. Do not silently introduce a manual upload/download workflow.

## Model-readable design

The skill is intentionally layered:

1. `SKILL.md` contains the small core contract and action routing that the model should rarely miss.
2. Each reference file owns one concern.
3. Detailed rules should not be duplicated across multiple reference files unless needed to prevent a known dangerous ambiguity.
4. When a lower-level rule conflicts with the core contract, the core contract wins unless the user explicitly overrides that rule for the current task.

Keep `SKILL.md` short enough to read in full. Move mechanics downward rather than adding more top-level bullets.

## CCM runtime

For persistent projects:

1. enter the selected CCM workspace;
2. read project README/protocol;
3. read project AGENTS/AGENT;
4. inspect Git status;
5. restore state from canonical/current project files and local artifacts;
6. update README/AGENTS when current state or durable project rules change.

Do not use chat history as the project database.

Do not create a parallel cloud/local working copy.

Library may be used only when the user explicitly supplies/selects a Library file as an external source.

## Page state

Do not use scalar durable progress.

Maintain:

- approved;
- rework/unreviewed;
- not-generated.

Pages may advance out of order.

Every fresh CPA output enters rework/unreviewed first.

Candidate output and approved-current artifacts remain separate.

Page approved means pipeline-reviewed current artifact, not user final whole-deck approval.

## Canonical discipline

Maintain one current canonical spec and one current prompt per page.

- update owning source first when content/evidence rules change;
- synchronize prompt in the same work cycle;
- do not keep `_v2`, `_final`, `_revised` forks unless explicitly requested;
- remove obsolete scripts/rules that can restore superseded logic.

When a CPA render fails:

- if canonical/prompt is still correct, regenerate;
- if review identifies a real source/instruction defect, fix the owning source and synchronize prompt;
- CPA runtime failures do not justify canonical edits.

Do not maintain a general failure taxonomy.

## Material/evidence closure

Default review priority:

1. narrative continuity and scientific/domain correctness;
2. evidence source/identity/role/independence;
3. numeric/equation/statistical-definition consistency;
4. page duty and main-talk/Q&A boundary;
5. traceable workload/coverage;
6. prompt/reference readiness;
7. rendered evidence readability and whole-deck consistency;
8. decorative polish.

Each slide should have one primary question. Title, primary evidence, and takeaway align to that question.

Evidence-strength guardrails:

- same-dataset comparison/selection is not independent validation;
- continuous events from one experiment chain are not automatically independent repeats;
- parameter scans/sensitivity are not automatically independent calibration;
- supplied input/boundary history is not a predicted-and-validated output;
- derived values are not direct measurements;
- verification, external validation, external reference, consistency check, numerical audit, sensitivity, and model discrimination remain distinct.

Run complete review passes. Material closure requires at least one pass with no new substantive issue.

Material closure is not rendered approval.

## Three production gates

Keep separate:

1. material closure;
2. pre-generation prompt/reference gate;
3. rendered-page/deck review.

No text/package/build validation substitutes for actual visual review.

## CPA reference discipline

Every final selected reference must be actually viewed.

Eligible factual inputs are real, traceable, inspected source images that provide qualitative factual context.

If exact axes/values/legend/colorbar/uncertainty/series mapping matter, keep the figure out of CPA reinterpretation and place/rebuild it directly in the PPT assembly layer.

Do not use as CPA references by default:

- old generated slides;
- AI/ImageGen output;
- rejected output;
- Pipeline-generated diagrams;
- presentation-specific script redraws;
- internal layout/relationship calibration images.

A generated page explicitly selected as an editable reconstruction target is still not automatically a CPA reference.

PDF is not a direct CPA image reference. Convert the exact needed page/figure to PNG/JPG/WebP and inspect it first.

## CPA production

Use CPA ImageGen for Imagegen-assisted production.

Loop:

`pre-generation gate -> CPA submit -> local candidate -> unreviewed -> visual review -> approved/rework -> regenerate -> approved-current`

Parallel production is allowed:

- bounded in-flight queue;
- asynchronous review;
- page state independent of return order;
- stop queue expansion when a common visual failure appears.

Concurrency remains project/provider specific.

## Secrets

CPA API keys, tokens, endpoint/model config, and credentials:

- stay in ignored local config or secure runtime;
- never enter Git;
- never enter README/project state;
- never enter canonical;
- never enter prompt TXT.

## Data figures

For quantitative evidence:

- derive from source data/code when possible;
- preserve provenance;
- actually inspect rendered output;
- maintain semantic axis/color/legend consistency;
- retain real source figure if faithful reconstruction is not appropriate;
- do not ask ImageGen to reinterpret exact values.

## Reuse / rebuild

Reuse requires:

- current role/content/evidence compatibility;
- an unambiguous approved-current artifact.

Renumbering alone is not a rebuild reason.

Material/evidence changes invalidate prior approval until reassessed.

## Conceptual diagrams

Preserve relationships, not old generated geometry.

Prefer short horizontal/vertical/90-degree connectors. Avoid unnecessary long diagonals and crossings.

Do not encode one project's palette/proportions as universal rules.

## Editable PowerPoint

Native-editable mode uses PowerPoint-native text, equations, shapes, connectors, charts, tables, and simple diagrams wherever practical.

Generated screenshots are not a substitute for editable delivery.

An explicitly user-selected generated artifact may be an editable reconstruction target; this does not make it an eligible CPA reference.

## Change discipline

Keep README current, not append-only history.

When architecture changes:

- update authority files in one change;
- remove obsolete naming and branches;
- search repository for stale references;
- avoid compatibility residue unless explicitly requested.

## Release checks

Before release:

1. `git diff --check`;
2. parse `plugin.json` and marketplace JSON;
3. confirm README and plugin versions match;
4. search for retired generation branches, scalar review progress, Library state/artifact authority, generated-page-as-CPA-reference permission, or cloud-workspace defaults conflicting with CCM-first;
5. verify action routing for CCM resume, material audit, pre-generation, CPA production, generated-page review, editable build, whole-deck QA;
6. build ChatGPT ZIP;
7. confirm ZIP root is only `plugin.json + skills/`;
8. confirm no secrets/provider config are tracked;
9. inspect final Git status.

## Versioning

Use semver.

0.5.1 establishes:

- CPA-only Imagegen-assisted production;
- simplified regeneration semantics;
- model-readable core contract + action routing;
- clearer quantitative-reference boundary;
- clearer generated-page reconstruction vs CPA-reference boundary.
