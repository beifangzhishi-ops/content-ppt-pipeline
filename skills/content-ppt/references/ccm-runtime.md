# CCM Runtime

This file owns persistent project execution for Content PPT Pipeline.

The preferred architecture for long-running work is:

`ChatGPT Plus / GPT -> CCM workspace -> canonical/project state -> direct generation / PPT authoring`

CCM is not merely a file-access convenience. For persistent projects, it is the preferred durable runtime.

## 1. Enter or resume a project

When the user refers to an existing project:

1. enter the selected CCM workspace;
2. read the project README/protocol;
3. read AGENTS.md / AGENT.md or equivalent project rules;
4. inspect current Git status;
5. inspect only the canonical/source/artifact files needed for the current action;
6. restore page state from project files and actual local artifacts;
7. continue from current state rather than reconstructing the project from chat history.

Do not ask the user to repeat information that is already present in the workspace.

Do not create a parallel project directory merely to make the current task easier.

## 2. Durable authority

Use this default hierarchy unless the project declares another one:

1. current user instruction;
2. project README/protocol for current project state and entry points;
3. AGENTS/AGENT for durable project rules;
4. canonical per-slide specs and source/evidence indexes;
5. current derived prompts;
6. local candidate and approved artifacts;
7. chat history as transient interaction context.

Conversation memory is not the project database.

ChatGPT Library is not a project-state authority. A Library file is an ordinary external input only when the user explicitly provides or selects it.

## 3. Page-state model

Do not maintain scalar progress such as:

- generated through Pxx;
- reviewed through Pxx;
- N% reviewed.

Persist page status as disjoint sets:

- **approved**: the current generated artifact has been visually reviewed and accepted;
- **rework/unreviewed**: a generated artifact exists but is not currently accepted, including fresh unreviewed output;
- **not-generated**: no current generation exists for that page.

Pages may advance out of order. An earlier missing/rework page never invalidates a later approved page.

Counts and percentages may be shown as temporary summaries but are not durable state.

Whenever a new generation lands, place that page in rework/unreviewed first. Move it to approved only after actual review.

## 4. Local artifact lifecycle

Projects should distinguish:

- **candidate outputs**: fresh, unreviewed, or failed generations;
- **approved current artifacts**: the accepted current visual for each page.

Use project-declared directories when available. Otherwise establish clear local directories or indexes rather than mixing both classes.

Rules:

- file existence does not imply approval;
- failed/unreviewed images must not enter the approved-current view;
- one page should have an unambiguous current approved artifact;
- approved artifacts should use stable page-oriented names when practical;
- a materially changed canonical/evidence role invalidates reuse until the artifact is reassessed;
- a rejected candidate may be deleted or archived according to project policy, but must not be mistaken for current output.

If the project already maintains an artifact index, update it in the same work cycle as README/protocol status. Do not invent a second persistent index without need.

## 5. Direct-generation outputs

When the active Imagegen backend writes results locally:

1. write or receive the generated output inside the CCM project runtime or a project-declared local output directory;
2. associate it with the correct page/job before review;
3. classify it as rework/unreviewed;
4. inspect it;
5. on approval, place/rename/copy it into the approved-current artifact view and update project status;
6. on failure, keep it out of approved-current and route it through generation failure triage.

Do not route local direct-generation output through ChatGPT Library merely for bookkeeping.

## 6. State checks

For requests such as "status", "progress", "review what is done", or "continue":

1. read current project status;
2. scan relevant local candidate/approved artifact locations;
3. reconcile actual files with approved / rework / not-generated sets;
4. review newly appeared unreviewed artifacts when the user asked for review;
5. update project status in the same work cycle;
6. report page sets or the meaningful delta, not a consecutive progress number.

Do not assume that every image in an output directory is a valid slide artifact. Verify page identity and actual content when needed.

## 7. Failure and root-cause persistence

Page state stays simple; failure diagnosis may be richer.

Classify failures as:

- canonical/evidence/prompt defect;
- generation execution/input mismatch;
- model rendering defect;
- infrastructure/provider failure.

Only the first category necessarily requires correcting an owning source. Execution mismatch must not pollute correct canonical content. Infrastructure failure is not a content-review failure and should not change page status to rework unless an actual generated page needs rework.

## 8. Git and tracked project maintenance

When the project uses Git:

- inspect status before tracked edits;
- update README and AGENTS when current state or durable rules change;
- keep transient scripts, caches, API keys, tokens, and provider scratch output ignored;
- never commit secrets;
- validate expected tracked changes before commit;
- after a user-authorized implementation task, commit and push when the project protocol requires it.

Do not retain obsolete compatibility rules or stale workflow names unless the user explicitly requests historical compatibility.

## 9. Secrets and provider configuration

Image-generation API keys, tokens, endpoint configuration, provider model discovery, and local execution credentials belong to the local runtime.

They must not appear in:

- canonical slide specs;
- prompt TXT files;
- project README status;
- generation packages;
- Git-tracked plugin authority.

Use ignored local files, environment variables, or the provider's secure configuration mechanism.

## 10. New-chat recovery acceptance

A healthy persistent project should be resumable in a fresh ChatGPT conversation by using CCM alone:

`workspace -> README/AGENTS -> canonical/current prompts -> local artifacts -> current action`

No Library synchronization and no prior-chat replay should be required for normal recovery.
