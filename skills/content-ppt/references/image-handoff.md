# Imagegen Handoff

This file owns reusable image inspection, reference selection, file delivery, and Imagegen handoff/regeneration mechanics.

In this skill, Imagegen / imggen means GPT / ChatGPT native image generation. It does not refer generically to Midjourney, Stable Diffusion, Flux, or other external image-generation providers.

## 1. Inspect before use

Any image recommended for a slide or sent to Imagegen as a reference must be actually viewed.

Do not infer visual content from:

- filename;
- folder name;
- search thumbnail text;
- metadata;
- another model's description alone.

When many assets exist, use previews/contact sheets or equivalent visual inspection to narrow candidates efficiently, but the final chosen references still need actual visual confirmation.

Track enough provenance to answer:

- which slide uses the asset;
- where the asset came from;
- whether it has actually been viewed;
- whether it has been selected, rejected, or delivered.

## 2. Separate inspection from formal handoff

Asset inspection/selection does not itself trigger file delivery.

Only enter the formal handoff gate when the current task is to give the user a complete page-generation package.

## 3. Atomic handoff gate

For a slide with no reference images:

- deliver one complete self-contained final prompt.

For a slide with reference images on **chat-file delivery**, the handoff is complete only when all of the following happen in the same response:

1. Every required reference image has been actually viewed.
2. Every required reference image has been actually transferred into the current chat using CCM send_file or an equivalent real file-transfer capability.
3. All required file transfers succeeded.
4. The complete self-contained final prompt is provided.
5. The response explicitly identifies which just-sent images the user should upload to the fresh Imagegen chat.

A path, filename, markdown mention, or workspace location does not count as chat-file delivery.

If any required send fails on chat-file delivery, the handoff is incomplete. Do not instruct the user to start generation yet.

On chat-file delivery, do not send a .md file as a substitute for the prompt. The full prompt must appear directly in the response so the user can copy it. On local-file delivery, the current prompt may live in the agreed project file as long as it is complete and directly usable.

### Delivery surface

Use the delivery surface explicitly chosen by the user or project:

- **Chat-file delivery**: put the complete prompt in one directly copyable block/message, and make every required reference image available as an actual downloadable/usable file in the current chat. A non-downloadable preview, pathname, or filename is not sufficient delivery.
- **Local-file delivery**: when the user explicitly works from a local project directory, the complete current prompt and required reference assets may be maintained there instead of redundantly retransferring the same assets through chat. The files must actually exist and be usable at the agreed location. The project protocol should identify the working location; do not invent a second delivery directory without need.

If a project keeps a per-slide prompt file derived from its canonical spec, keep one current prompt derivative per slide. When the canonical spec changes, overwrite/synchronize that current prompt in the same work cycle. Avoid parallel `v2`, `final`, `revised`, or similar prompt forks unless the user explicitly requests versioned history.

Local prompt text should be UTF-8 and should be read back on the target platform when non-ASCII content matters.

## 4. Prompt completeness

Each page prompt must be self-contained. Do not rely on “same style as previous page” or hidden context.

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
- explicit prohibitions;
- any prior error that must not recur.

The prompt should tell Imagegen what to produce, not merely describe the source spec abstractly.

For GPT ImageGen handoff, recommend placing `@图像生成` on the first line of the copy-ready prompt to make the intended GPT image-generation route explicit. This is a recommended default, not an unoverrideable gate: the user's explicit instruction, the project's protocol, or the target GPT surface may replace or omit it.

`@图像生成` is text for the target GPT ImageGen chat. It does not mean that the current PPT workflow assistant should itself invoke image generation. If the user asks only for the prompt or explicitly says not to generate the image here, remain at the preparation/handoff layer.

Self-contained is an internal quality requirement, not prompt filler. Do not clutter the generation prompt with pipeline meta-language such as “this is a revision,” “this prompt is self-contained,” or “do not rely on previous chat” unless that instruction materially changes the expected output.

Keep prohibitions focused on high-value failure prevention rather than accumulating defensive wording that competes with the actual slide task.

### Image-role boundary

Do not use “looks photorealistic” as the prohibition criterion.

Classify each requested visual:

- **Evidence / project-specific factual visual**: real experiment, apparatus, measurement, result, site, or specific factual object. Must use traceable real material or faithful reconstruction from real data; do not ask Imagegen to fabricate it.
- **Conceptual scientific illustration**: mechanism/process/structure explanation. May be generated, including realistic rendering, provided it is not presented as an actual project record or measurement.
- **Application / scene-setting illustration**: background/motivation/engineering application context. May be generated in a photorealistic style when it does not claim to show a specific real project/site or quantitative result.

Write the prompt according to the image's role, not according to a blanket ban on realistic appearance.

## 5. Fresh-chat workflow

For each slide generation:

1. Use a fresh GPT ImageGen chat unless the user explicitly chooses otherwise.
2. Upload only the reference images designated for that slide.
3. Paste the complete prompt.
4. Generate the page.
5. Return the generated page to the PPT workflow chat for review.

Fresh chats reduce accidental style/content leakage between slides.

## 6. Regeneration

When a returned page is rejected:

- identify the minimum material defects;
- update the canonical spec accordingly;
- keep accepted content stable;
- deliver a new complete copy-ready prompt for every regeneration; do not give only delta instructions or “common prompt + patch”;
- explicitly preserve already accepted formulas, relationships, layout constraints, and asset roles so fixing one defect does not regress another;
- reassess whether references are actually needed for the new generation rather than resending them mechanically;
- if references are required again, execute the full atomic handoff gate again.

The rejected generated page may be inspected for diagnosis, but do not automatically reuse a structurally or scientifically wrong rejected page as an Imagegen reference. Prefer inspected real scientific/data/experimental assets or another stable visual reference.

Reuse the rejected page as a reference only when preserving an already accepted visual property materially helps and the risk of propagating the defect is low.

Do not push an assessable accept/regenerate decision back to the user. The PPT workflow should make the decision and give the next executable package.

## 7. Capability failure

If the selected chat-file delivery requires real reference-image transfer and CCM/equivalent file transfer is unavailable, state that the handoff gate is not complete. If the user explicitly selected local-file delivery, satisfy that surface's file-presence gate instead.

Do not silently degrade to “the file is at this path” or “please find this image yourself.”
