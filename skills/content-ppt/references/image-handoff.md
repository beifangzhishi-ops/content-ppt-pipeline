# Imagegen Handoff

This file owns reusable image inspection, reference selection, generation-package delivery, and Imagegen regeneration mechanics.

In this skill, Imagegen / imggen means GPT / ChatGPT native image generation. It does not refer generically to Midjourney, Stable Diffusion, Flux, or other external image-generation providers.

## 1. Inspect before use

Any image recommended for a slide or supplied to Imagegen as a reference must be actually viewed.

Do not infer visual content from filenames, folder names, search snippets, metadata, or another model's description alone.

When many assets exist, previews/contact sheets or equivalent visual inspection may narrow candidates efficiently, but every final selected reference still needs actual visual confirmation.

Track enough provenance to know which slide uses the asset, where it came from, whether it was viewed, and whether it is selected/current.

## 2. Reference-file format

GPT ImageGen reference inputs must be image files. Use image formats such as:

- PNG;
- JPG / JPEG;
- WebP.

Do not deliver or instruct the user to upload a PDF as an Imagegen reference image.

When an authoritative source visual exists only in PDF:

1. identify the exact page/figure needed;
2. render or export that content to an image file;
3. actually view the converted image;
4. verify content, crop, resolution, readability, and scientific meaning;
5. update the canonical spec and derived prompt to reference the converted image filename;
6. use the converted image in the generation package.

The converted image is a delivery derivative; the source PDF may remain part of the internal source registry.

## 3. Separate authority from delivery

Keep these roles distinct:

- canonical Markdown: internal project/source-of-truth specification;
- prompt TXT: user-facing generation instruction derived from canonical;
- reference images: user-facing visual inputs.

Canonical Markdown is not part of the normal user generation package. Include it only when the user explicitly asks for project-source files.

If a project keeps a prompt derivative per slide, keep one current TXT prompt per slide. When canonical changes, overwrite/synchronize the current prompt in the same work cycle. Avoid parallel v2, final, revised, or similar forks unless the user explicitly requests versioned history.

Prompt text must be UTF-8 and should be read back on the target platform when non-ASCII content matters.

## 4. Batch delivery is the default production handoff

When the user is about to start Imagegen generation for a selected slide range, default to one complete batch delivery for that range.

For an existing deck with mixed page dispositions, the selected generation range means the pages currently marked new/rebuild. Do not repackage approved reusable pages merely because the deck was renumbered or neighboring pages changed.

The user-facing batch contains only:

- one complete current .txt prompt per slide;
- the image references actually required by those prompts.

Do not include canonical .md files or source PDFs in the normal generation package.

By default, materialize the complete selected-range package as one ZIP after validation. The package must actually be delivered to the user; merely creating it in a workspace does not complete the generation-start delivery.

Before delivery, verify package integrity:

1. every selected reference image was actually viewed;
2. every prompt is complete and current;
3. every image filename referenced by a prompt exists in the package;
4. no prompt references a PDF;
5. no .md or .pdf files are present in the user generation package;
6. no stale prompt/image filename remains.

Once this batch is usable on the selected delivery surface, later normal generation/status/review turns reuse it. Do not resend unchanged files merely because the workflow advances.

Re-deliver only when:

- a regeneration needs a changed prompt or reference set;
- canonical/material changes invalidate delivered content;
- a required package file is missing/corrupt;
- the delivery surface changes;
- the user explicitly requests another copy.

## 5. Delivery surfaces

Use the surface explicitly selected by the user/project.

### Chat-file delivery

For the normal start-of-generation batch, transfer the validated ZIP into the current chat as a real downloadable file, using CCM send_file or an equivalent file-transfer capability.

For a targeted single-slide package delivered in chat:

- put the complete copy-ready prompt directly in the response or provide the current TXT when the user requested file-based delivery;
- transfer every required reference image as a real usable file;
- do not treat a pathname, filename, or non-downloadable preview as delivery.

If a required file transfer fails, the package is incomplete.

### Local-file delivery

When the user explicitly works from a local project directory, current prompt TXT files and required reference images may be maintained there instead of redundantly retransferred through chat. They must actually exist and be usable at the agreed location.

### Optional Quark mobile workflow

When CCM and Quark upload are available, recommend this convenience path for mobile generation:

1. package the selected range as a ZIP containing prompt TXT files plus required images only;
2. upload that validated ZIP to Quark with CCM;
3. the user unzips it in Quark;
4. the user downloads required images directly from the extracted folder;
5. the user opens a prompt TXT in Quark, uses the top-right document-mode control, selects all text, and copies it;
6. the user pastes the prompt into a fresh GPT ImageGen chat and uploads the designated images.

This is optional, not a mandatory dependency. Another selected delivery surface remains valid.

## 6. Prompt completeness

Each page prompt must be self-contained. Do not rely on "same style as previous page" or hidden context.

Include, as applicable:

- slide title;
- purpose and takeaway;
- exact facts/numbers/equations that must be preserved;
- required labels and terminology;
- layout regions and reading order;
- information density;
- real/reference image role;
- generated illustration role;
- visual/formality constraints;
- high-value prohibitions;
- any prior error that must not recur.

The prompt should tell Imagegen what to produce, not merely describe the source spec abstractly.

For GPT ImageGen handoff, recommend placing @图像生成 on the first line of the copy-ready prompt to make the intended target route explicit. This is a recommended default, not an unoverrideable gate.

@图像生成 is text for the target GPT ImageGen chat. It does not mean that the current PPT workflow assistant should itself invoke image generation. If the user asks only for prompts/materials or explicitly says not to generate here, remain at the preparation/delivery layer.

Keep prohibitions focused on high-value failure prevention rather than accumulating defensive wording that competes with the actual slide task.

## 7. Image-role boundary

Classify each requested visual by role:

- **Evidence / project-specific factual visual**: real experiment, apparatus, measurement, result, site, or specific factual object. Use traceable real material or faithful reconstruction from real data; do not ask Imagegen to fabricate it.
- **Conceptual scientific illustration**: mechanism/process/structure explanation. It may be generated, including realistic rendering, provided it is not presented as an actual project record or measurement.
- **Application / scene-setting illustration**: background/motivation/engineering application context. It may be generated photorealistically when it does not claim to show a specific real project/site or quantitative result.

Quantitative plots are evidence, not decorative illustrations. When structured data or a reliable reconstruction path exists, redraw them reproducibly with code or an equivalent deterministic charting workflow instead of asking Imagegen to invent/re-render the data. Keep source-data and reconstruction provenance with the derived figure.

An authoritative conceptual/relationship diagram may constrain scientific relationships without constraining exact geometry. A generated or redrawn version may reorganize arrows, spacing, and layout as long as it preserves the intended relationships and does not add unsupported ones.

Photorealistic appearance alone is not the prohibition criterion. The evidence role is.

## 8. Fresh-chat workflow

For each slide generation:

1. Use a fresh GPT ImageGen chat unless the user explicitly chooses otherwise.
2. Take that slide's complete prompt TXT from the delivered batch.
3. Upload only the reference images designated for that slide.
4. Generate the page.
5. Return the generated page to the PPT workflow for review when review is requested.

Fresh chats reduce accidental style/content leakage between slides.

## 9. Regeneration

When a returned page is rejected:

- identify the minimum material defects;
- update the canonical spec first;
- synchronize a new complete copy-ready prompt;
- keep accepted content stable;
- explicitly preserve accepted formulas, relationships, layout constraints, and asset roles;
- reassess whether references are actually needed for the new generation;
- resend only the references required by the new generation when the previously delivered copy is no longer current/usable or the user needs them again.

If the rejection exposes a real content/evidence error, first correct the authoritative canonical/prompt/source mapping that caused it. Do not treat a chat-only retry instruction as the durable fix.

Do not give only delta instructions or "common prompt + patch".

The rejected generated page may be inspected for diagnosis, but do not automatically reuse a structurally or scientifically wrong rejected page as an Imagegen reference. Prefer inspected real scientific/data/experimental assets or another stable visual reference.

Reuse the rejected page as a reference only when preserving an already accepted visual property materially helps and the risk of propagating the defect is low.

Do not push an assessable accept/regenerate decision back to the user.

## 10. Capability failure

If the selected delivery surface requires real file transfer and that capability is unavailable, state that the delivery gate is incomplete.

Do not silently degrade to "the file is at this path" or "please find this image yourself".
