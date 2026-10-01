# Maintenance Guide

This file is for maintainers and agents working on the Content PPT Pipeline repository.

## Authority

- `plugin.json`: install metadata and version.
- `skills/content-ppt/SKILL.md`: model-facing runtime/backend contract, core contract, and action routing.
- `skills/content-ppt/references/runtime.md`: host/runtime routing, persistent state, local artifacts, Git.
- `skills/content-ppt/references/workflow.md`: content/evidence/deck lifecycle.
- `skills/content-ppt/references/cpa-generation.md`: CPA production, fresh requests, reference eligibility, queue/review/regeneration.
- `skills/content-ppt/references/ppt-authoring.md`: editable/native PowerPoint construction.
- `README.md`: user-facing current product model.

Do not preserve obsolete workflow branches or aliases for compatibility unless the user explicitly requests it.

## Product scope and dependencies

Primary practice:

`ChatGPT Plus -> Content PPT Pipeline -> CCM -> project -> CPA when generation is required`

Secondary compatible host:

`Codex -> Content PPT Pipeline -> native Codex runtime -> CPA when generation is required`

Roles:

- the host model owns reasoning, research, review, and orchestration;
- CCM is the durable project runtime for the ChatGPT Plus practice;
- Codex uses its own native workspace/execution environment instead of CCM;
- CPA is an independent visual-generation backend, not a project runtime or bundled plugin dependency;
- Content PPT Pipeline owns orchestration policy.

Do not add a fake manifest dependency on CPA. Do not imply CCM is bundled into Content PPT Pipeline.

## Model-readable design

The skill is intentionally layered:

1. `SKILL.md` contains the small runtime/backend contract, core contract, and action routing that the model should rarely miss.
2. Each reference file owns one concern.
3. Detailed rules should not be duplicated across multiple reference files unless needed to prevent a known dangerous ambiguity.
4. When a lower-level rule conflicts with the core contract, the core contract wins unless the user explicitly overrides that rule for the current task.

Keep `SKILL.md` short enough to read in full. Move mechanics downward rather than adding incidental detail to the top level.

## Runtime

For persistent projects:

1. enter the active runtime/workspace;
2. read project README/protocol;
3. read project AGENTS/AGENT;
4. inspect Git status;
5. restore state from canonical/current project files and local artifacts;
6. update README/AGENTS when current state or durable project rules change.

Use CCM on ChatGPT Plus. Use native Codex execution in Codex.

Do not use chat history as the project database.

## CPA fresh-request invariant

**One slide = one fresh CPA HTTP request.**

For every page:

- create a new request;
- send that page's current prompt;
- attach only that page's selected eligible references;
- send no reference when the page has none;
- do not forward any previous page generation/session/conversation identifier or prior-page request context.

Parallel production is allowed only as multiple independent fresh requests.

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

- if canonical/prompt is still correct, regenerate with another fresh request;
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

## Evidence vs generated illustration

Do not let terminology cleanup weaken this boundary.

### Proof-chain/project/practice evidence

Actual project work, apparatus, experiments, measurements, simulation results, sites, or other factual records must use traceable real sources or faithful deterministic reconstruction from real data.

Do not use CPA to fabricate a realistic-looking substitute and present it as actual evidence.

If a named real facility/site/case is itself part of the factual claim, use a real source image rather than a generated lookalike.

### Conceptual illustration

CPA-generated visuals may explain mechanisms, relationships, processes, structures, or generic apparatus concepts when they are not presented as actual project records or measured results.

### Engineering application / scene-setting

CPA-generated visuals, including photorealistic scenes, are allowed for background, motivation, application context, or generic engineering environments when they do not carry the factual proof burden.

Titles/captions/copy must not misrepresent generated illustration as actual evidence.

## Three production gates

Keep separate:

1. material closure;
2. pre-generation prompt/reference/fresh-request gate;
3. rendered-page/deck review.

No text/package/build validation substitutes for actual visual review.

## CPA reference discipline

Every final selected reference must be actually viewed.

Eligible factual inputs are real, traceable, inspected source images that provide appropriate factual context.

If exact axes/values/legend/colorbar/uncertainty/series mapping matter, keep the figure out of CPA reinterpretation and place/rebuild it directly in the PPT assembly layer.

Do not use as CPA references by default:

- old generated slides;
- AI/generated output;
- rejected output;
- Pipeline-generated diagrams;
- presentation-specific script redraws;
- internal layout/relationship calibration images.

A generated page explicitly selected as an editable reconstruction target is still not automatically a CPA reference.

PDF is not a direct CPA image reference. Convert the exact needed page/figure to PNG/JPG/WebP and inspect it first.

## CPA production

Use CPA for generation/regeneration.

Loop:

`pre-generation gate -> fresh CPA request -> local candidate -> unreviewed -> visual review -> approved/rework -> regenerate -> approved-current`

Parallel production is allowed:

- bounded in-flight queue;
- each page remains an independent fresh request;
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
- retain the real source figure if faithful reconstruction is not appropriate;
- do not ask a generation model to reinterpret exact values.

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
4. search for retired workflow, authority-name, and routing residue;
5. confirm only current authority files and production-path names remain;
6. verify runtime routing: ChatGPT Plus -> CCM; Codex -> native runtime; CPA -> generation backend;
7. verify fresh-request wording in SKILL + cpa-generation + AGENTS;
8. verify evidence boundary still allows non-proof conceptual/application visuals but forbids generated lookalikes as actual project/practice evidence;
9. build ChatGPT ZIP;
10. confirm ZIP root is only `plugin.json + skills/`;
11. confirm retired authority files are absent from the ZIP;
12. confirm no secrets/provider config are tracked;
13. inspect final Git status.

After installation, inspect the installed skill in a fresh ChatGPT conversation. The installed release must match the repository contract and contain only current runtime and CPA routing.

## Versioning

Use semver.

0.6.0 establishes:

- ChatGPT Plus + CCM as the primary practice with native Codex runtime compatibility;
- explicit runtime vs CPA backend dependency roles;
- one-slide/one-fresh-CPA-request behavior;
- removal of retired workflow and authority-name residue;
- preserved evidence-vs-generated-illustration boundary;
- discrete page state and approved-current artifact semantics.
