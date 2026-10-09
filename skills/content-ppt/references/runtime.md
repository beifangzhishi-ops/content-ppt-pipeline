# Project Runtime

This file owns persistent project execution, durable state, local artifact lifecycle, Git, and host-specific runtime routing.

## 1. Runtime routing

The two supported project runtimes are peer execution routes. The generation backend is a separate role; neither host changes the business workflow.

### ChatGPT + CCM

Use CCM as the persistent project runtime:

`ChatGPT Plus -> Content PPT Pipeline -> CCM workspace -> project files/artifacts/Git`

CCM supplies the durable workspace, filesystem/process execution, image reads, and Git surface while the ChatGPT model remains the reasoning/review/orchestration layer.

### Codex native

When the skill runs in Codex, use the equally supported native Codex workspace/execution environment:

`Codex -> Content PPT Pipeline -> native Codex workspace -> project files/artifacts/Git`

Do not instantiate CCM merely for compatibility when Codex already supplies the required execution environment. The same canonical, CPA, evidence, editability, and review rules apply to both hosts.

### CPA

CPA is not the project runtime. It is invoked from the active runtime only for CPA generation/regeneration actions.

## 2. Enter or resume a project

When the user refers to an existing project:

1. enter the selected runtime/workspace;
2. read the project README/protocol;
3. read AGENTS.md / AGENT.md or equivalent project rules;
4. inspect current Git status when applicable;
5. inspect only the canonical/source/artifact files needed for the current action;
6. restore page state from project files and actual local artifacts;
7. continue from current state rather than reconstructing the project from chat history.

Before **each actual modification round**, not only on a fresh conversation, reread current README/protocol and AGENTS plus the specific canonical/source passages governing that revision. Reconfirm the current layout/master authority; every project needs one, and a local revision inherits it unless a deck-level change has been approved. Scope rereading to the relevant source portion, not the whole library.

For long material, split deep reading at natural source boundaries (paper, thesis chapter, method, experiment, or result chain), persist local findings, then perform a global narrative/evidence check. Experience with one model suggested roughly one paper or thesis chapter per deep-reading unit, but this is **not** a token limit or model specification.

Do not ask the user to repeat information already present in the project.

Do not create a parallel project directory merely to make the current task easier.

## 3. Durable authority

Use this default hierarchy unless the project declares another one:

1. current user instruction;
2. project README/protocol for current state and entry points;
3. AGENTS/AGENT for durable project rules;
4. canonical per-slide specs and source/evidence indexes;
5. current derived prompts;
6. local candidate and approved artifacts;
7. chat history as transient interaction context.

Conversation history is not the project database.

## 4. Page-state model

Do not maintain scalar durable progress such as:

- generated through Pxx;
- reviewed through Pxx;
- N% reviewed.

Persist page status as disjoint sets **within the named current production stage** (e.g., CPA visual production or editable delivery):

- **approved**: the current artifact has been reviewed and accepted **for this stage only**;
- **rework/unreviewed**: a generated artifact exists but is not currently accepted, including every fresh unreviewed output;
- **not-generated**: no current generation exists for that page.

Pages may advance out of order. An earlier missing/rework page never invalidates a later approved page.

For CPA, `approved-current` means an accepted **visual reconstruction source**, not a final defect-free editable PPTX. Local text, label, formula, or connector defects that can reliably be fixed downstream can be registered in the project's existing canonical/fix-list mechanism. Structural, scientific, or evidence failures still block CPA approval. The editable gate and final user whole-deck gate are separately checked; do not invent a parallel progress database.

Counts and percentages may be shown as temporary summaries but are not durable state.

## 5. Local artifact lifecycle

Projects should distinguish:

- **candidate outputs**: fresh, unreviewed, or failed generations;
- **approved-current artifacts**: the accepted current visual for each page **in its generation stage**.

Use project-declared directories when available. Otherwise establish clear local directories or indexes rather than mixing both classes.

Rules:

- file existence does not imply approval;
- failed/unreviewed images must not enter the approved-current view;
- one page should have an unambiguous current approved artifact;
- approved artifacts should use stable page-oriented names when practical;
- a materially changed canonical/evidence role invalidates reuse until the artifact is reassessed;
- a rejected candidate may be deleted or archived according to project policy, but must not be mistaken for current output.

If the project already maintains an artifact index, update it in the same work cycle as README/protocol status. Do not invent a second persistent index without need.

## 6. CPA output handling

When CPA returns a page:

1. write/receive the output inside the active project runtime or project-declared output directory;
2. associate it with the correct page/job;
3. classify it as rework/unreviewed;
4. inspect it;
5. on approval, place/rename/copy it into the approved-current artifact view and update project status;
6. on structural or non-delegable review failure, keep it out of approved-current and route it back to CPA regeneration; when a permitted local defect is deferred, record the precise downstream fix.

## 7. State checks

For requests such as status, progress, review what is done, or continue:

1. read current project status;
2. scan relevant candidate/approved artifact locations;
3. reconcile actual files with approved / rework / not-generated sets;
4. review newly appeared unreviewed artifacts when review was requested;
5. update project status in the same work cycle;
6. report page sets or the meaningful delta, not a consecutive progress number.

Do not assume that every image in an output directory is a valid slide artifact. Verify page identity and actual content when needed.

## 8. Regeneration and runtime failure

- if an actual returned page fails its stage's blocking visual criteria, keep it in rework/unreviewed and regenerate through CPA;
- change canonical or prompt only when review identifies a real source/instruction defect;
- CPA authorization, quota, timeout, network, or backend failures are runtime blockers, not page-review conclusions.

## 9. Git and tracked project maintenance

When the project uses Git:

- inspect status before tracked edits;
- update README and AGENTS when current state or durable project rules change;
- keep transient scripts, caches, API keys, tokens, and provider scratch output ignored;
- never commit secrets;
- validate expected tracked changes before commit;
- after a user-authorized implementation task, commit and push when the project protocol requires it.

Do not retain obsolete compatibility rules or stale workflow names unless the user explicitly requests historical compatibility.

## 10. Secrets and provider configuration

CPA API keys, tokens, endpoint configuration, model discovery, and local execution credentials belong to the active runtime.

They must not appear in:

- canonical slide specs;
- prompt TXT files;
- project README status;
- Git-tracked plugin authority.

Use ignored local files, environment variables, or secure provider/runtime mechanisms.

## 11. Fresh-conversation recovery

A healthy project should be recoverable in a fresh host conversation from:

`workspace -> README/AGENTS -> canonical/current prompts -> local artifacts -> current action`

Normal recovery must not require replaying prior chat history.
